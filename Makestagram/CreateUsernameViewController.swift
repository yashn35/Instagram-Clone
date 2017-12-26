//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by AMIT NARAYAN on 6/26/17.
//  Copyright © 2017 NarayanProduction. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController

{
    @IBOutlet weak var usernameTextField: UITextField!

    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        nextButton.layer.conerRadius = 6
      
    }
    
  
    
    @IBAction func nextButtonTapped(_ sender: Any) {
   
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else { return }
        
        UserService.create(firUser, username: username) { (user) in
            guard let user = user else {
                // handle error
                return
            }
            
            User.setCurrent(user, writeToUserDefaults: true)
            
            let initialViewController = UIStoryboard.initialViewController(for: .main)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
   }
}
