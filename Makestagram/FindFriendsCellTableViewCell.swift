//
//  FindFriendsCellTableViewCell.swift
//  Makestagram
//
//  Created by AMIT NARAYAN on 7/3/17.
//  Copyright © 2017 NarayanProduction. All rights reserved.
//

import UIKit

protocol FindFriendsCellTableViewCellDelegate: class {
    func didTapFollowButton(_ followButton: UIButton, on cell: FindFriendsCellTableViewCell)
}

class FindFriendsCellTableViewCell: UITableViewCell {
    
    weak var delegate: FindFriendsCellTableViewCell?
    
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
       
        followButton.layer.borderColor = UIColor.lightGray.cgColor
        followButton.layer.borderWidth = 1
        followButton.layer.cornerRadius = 6
        followButton.clipsToBounds = true
        
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitle("Following", for: .selected)
        
    }

    @IBAction func followButtonTapped(_ sender: Any) {
            delegate?.didTapFollowButton(sender, on: self)
    }
}
