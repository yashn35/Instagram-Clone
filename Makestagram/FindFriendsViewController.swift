//
//  FindFriendsViewController.swift
//  Makestagram
//
//  Created by AMIT NARAYAN on 6/27/17.
//  Copyright © 2017 NarayanProduction. All rights reserved.
//

import UIKit

class FindFriendsViewController: UIViewController {

    var users = [User]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 71
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        UserService.usersExcludingCurrentUser { [unowned self] (users) in
            self.users = users
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension FindFriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindFriendsCellTableViewCell") as! FindFriendsCellTableViewCell
        cell.delegate = self
        configure(cell: cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func configure(cell: FindFriendsCellTableViewCell, atIndexPath indexPath: IndexPath) {
        let user = users[indexPath.row]
        
        cell.usernameLabel.text = user.username
        cell.followButton.isSelected = user.isFollowed
    }
}

extension FindFriendsViewController:
FindFriendsCellTableViewCellDelegate {
    func didTapFollowButton(_ followButton: UIButton, on cell: FindFriendsCellTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        followButton.isUserInteractionEnabled = false
        let followee = users[indexPath.row]
        
        FollowService.setIsFollowing(!followee.isFollowed, fromCurrentUserTo: followee) { (success) in
            defer {
                followButton.isUserInteractionEnabled = true
            }
            
            guard success else { return }
            
            followee.isFollowed = !followee.isFollowed
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}
