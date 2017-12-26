//
//  Post.swift
//  Makestagram
//
//  Created by AMIT NARAYAN on 6/27/17.
//  Copyright © 2017 NarayanProduction. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase.FIRDataSnapshot
import FirebaseStorage

class Post {
    
    static func isPostLiked(_ post: Post, byCurrentUserWithCompletion completion: @escaping (Bool) -> Void) {
        guard let postKey = post.key else {
            assertionFailure("Error: post must have key.")
            return completion(false)
        }
        
        let likesRef = Database.database().reference().child("postLikes").child(postKey)
        likesRef.queryEqual(toValue: nil, childKey: User.current.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? [String : Bool] {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    var key: String?
    var isLiked: Bool?
    var likeCount: Int
    let poster: User
    let imageURL: String
    let imageHeight: CGFloat
    let creationDate: Date
    
    init(imageURL: String, imageHeight: CGFloat) {
        self.imageURL = imageURL
        self.imageHeight = imageHeight
        self.creationDate = Date()
        self.likeCount = 0
        self.poster = User.current
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
            let imageURL = dict["image_url"] as? String,
            let imageHeight = dict["image_height"] as? CGFloat,
            let createdAgo = dict["created_at"] as? TimeInterval,
            let likeCount = dict["like_count"] as? Int,
            let userDict = dict["poster"] as? [String: Any],
            let uid = userDict["uid"] as? String,
            let username = userDict["username"] as? String
            else {return nil}
        
        self.likeCount = likeCount
        self.poster = User(uid: uid, username: username)
        self.key = snapshot.key
        self.imageURL = imageURL
        self.imageHeight = imageHeight
        self.creationDate = Date(timeIntervalSince1970: createdAgo)
        
        
        
        
    }
  
    var dictValue: [String : Any] {
        let createdAgo = creationDate.timeIntervalSince1970
        let userDict = ["uid" : poster.uid,
                        "username" : poster.username]
        
        
        return ["image_url" : imageURL,
                "image_height" : imageHeight,
                "created_at" : createdAgo,
                "like_count" : likeCount,
                "poster" : userDict]
    }
  }

