//
//  PostService.swift
//  Makestagram
//
//  Created by AMIT NARAYAN on 6/27/17.
//  Copyright © 2017 NarayanProduction. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage

struct PostService {
    
    private static func create(forURLString urlString: String, aspectHeight: CGFloat) {
        let currentUser = User.current
        let post = Post(imageURL: urlString, imageHeight: aspectHeight)
        let dict = post.dictValue
        
        // 4
        let postRef = Database.database().reference().child("posts").child(currentUser.uid).childByAutoId()
        //5
        postRef.updateChildValues(dict)
    }
    
    static func create(for image: UIImage) {
        let imageRef = Storage.storage().reference().child("test_image.jpg")
        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }
            
            let urlString = downloadURL.absoluteString
            create(forURLString: urlString, aspectHeight: 320)
        }
    }
}
