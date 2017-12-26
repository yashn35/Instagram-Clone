//
//  PostHeaderCell.swift
//  Makestagram
//
//  Created by AMIT NARAYAN on 6/29/17.
//  Copyright © 2017 NarayanProduction. All rights reserved.
//

import UIKit

class PostHeaderCell: UITableViewCell {
   
    static let height: CGFloat = 54
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func optionsButtonTapped(_ sender: Any) {
   
        print("option button tapped!")
    }
 }
