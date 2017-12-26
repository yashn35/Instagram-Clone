//
//  LoginViewController.swift
//  Makestagram
//
//  Created by AMIT NARAYAN on 6/23/17.
//  Copyright © 2017 NarayanProduction. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {


    @IBOutlet weak var loginButton: UIButton!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        print("login button has been tapped!!!")
    
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
         authUI.delegate = self
        
        
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    
        
    }
}



extension LoginViewController: FUIAuthDelegate {
        func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
            if let error = error {
                assertionFailure("Error signing in: \(error.localizedDescription)")
            }
            
            // 1
           
            
            guard let user = user
                else { return }
            
            // 2
            let userRef = Database.database().reference().child("users").child(user.uid)
            UserService.show(forUID: user.uid) { (user) in
                if let user = user {
                    // handle existing user
                    User.setCurrent(user, writeToUserDefaults: true)
                    
                    let initialViewController = UIStoryboard.initialViewController(for: .main)
                    self.view.window?.rootViewController = initialViewController
                    self.view.window?.makeKeyAndVisible()
                } else {
                    // handle new user
                    self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
                }
            }
        }
    }


