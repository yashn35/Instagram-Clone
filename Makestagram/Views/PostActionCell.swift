//
//  PostActionCell.swift
//  Makestagram
//
//  Created by AMIT NARAYAN on 6/29/17.
//  Copyright © 2017 NarayanProduction. All rights reserved.
//

import UIKit

protocol PostActionCellDelegate: class {
    func didTapLikeButton(_ likeButton: UIButton, on cell: PostActionCell)
}

class PostActionCell: UITableViewCell {

    weak var delegate: PostActionCellDelegate?
    
    static let height: CGFloat = 46

    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    
    @IBOutlet weak var timeAgoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
 
    
    }

    @IBAction func likeButtonTapped(_ sender: Any) {
        delegate?.didTapLikeButton(sender as! UIButton, on: self)
    
    }
}
  

