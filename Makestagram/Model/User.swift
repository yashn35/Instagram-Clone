//
//  User.swift
//  Makestagram
//
//  Created by AMIT NARAYAN on 6/26/17.
//  Copyright © 2017 NarayanProduction. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase.FIRDataSnapshot



class User: NSObject

{
    var isFollowed = false

    
    private static var _current: User?
    
    static var current: User {
        
        guard let currentUser = _current else {
            
            fatalError("Error: current user doesn't exsist")
        }
            return currentUser
    }
    
   
    
class func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
    
    if writeToUserDefaults {
        // 3
        let data = NSKeyedArchiver.archivedData(withRootObject: user)
        
        // 4
        UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
    }

          _current = user
    }
    let uid: String
    let username: String
    
    init(uid: String, username: String) {
        self.uid = uid
        self.username = username
    }
    
    init?(snapshot: DataSnapshot) {
        
        guard let dict = snapshot.value as? [String : Any],
            let username = dict["username"] as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.username = username
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let uid = aDecoder.decodeObject(forKey: Constants.UserDefaults.uid) as? String,
            let username = aDecoder.decodeObject(forKey: Constants.UserDefaults.username) as? String
            else { return nil }
        
        self.uid = uid
        self.username = username
        
        super.init()
    }
}

extension User: NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uid, forKey: Constants.UserDefaults.uid)
        aCoder.encode(username, forKey: Constants.UserDefaults.username)
    }
}

