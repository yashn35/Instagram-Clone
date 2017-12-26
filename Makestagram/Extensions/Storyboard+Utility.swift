//
//  Storyboard+Utility.swift
//  Makestagram
//
//  Created by AMIT NARAYAN on 6/26/17.
//  Copyright © 2017 NarayanProduction. All rights reserved.
//

import UIKit

class Storyboard_Utility: UIStoryboard {

}

extension UIStoryboard {
    
    enum MGType: String {
        
        init(type: MGType, bundle: Bundle? = nil) {
           
            self.init(type: UIStoryboard.MGType(rawValue: type.filename)!, bundle: bundle)
        
        }
        case main
        case login
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(type: MGType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }

    
  static  func initialViewController(for type: MGType) -> UIViewController {
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't instantiate initial view controller for \(type.filename) storyboard.")
        }
        
        return initialViewController
    }
}
