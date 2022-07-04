//
//  AlertUtil.swift
//  Plugin
//
//  Created by Appentus Technologies on 23/06/22.
//  Copyright © 2022 Max Lynch. All rights reserved.
//

import Foundation
import UIKit

typealias NumberCompletionHandler = (_ result: Int) -> Void

class UIAlertUtil {
    
    /// Show alert using title, message, viewcontroller and return NumberCompletionHandler
    class func alertWith(title: String, message: String, viewController: UIViewController, With completion:@escaping NumberCompletionHandler) {
        self.alertWith(title: title, message: message, okTitle: "Ok", viewController: viewController, With: completion)
    }
    
    /// Show alert using title, message, OkTitle, viewcontroller and return NumberCompletionHandler
    class func alertWith(title: String, message: String, okTitle: String, viewController: UIViewController, With completion:@escaping NumberCompletionHandler) {
        self.alertWith(title: title, message: message, okTitle: okTitle, cancelTitle: "", viewController: viewController, With: completion)
    }
    
    /// Show alert using title, message, OkTitle, CancelTitle, viewcontroller and return NumberCompletionHandler
    // swiftlint:disable:next function_parameter_count
    class func alertWith(title: String, message: String, okTitle: String, cancelTitle: String, viewController: UIViewController, With completion:@escaping NumberCompletionHandler) {
        // Number Completion ok = 1, cancel = 0
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .destructive) { (_) in
            completion(1)
        }
        alertController.addAction(okAction)
        
        if !cancelTitle.isEmpty {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { (_) in
                completion(0)
            }
            alertController.addAction(cancelAction)
        }
        DispatchQueue.main.async {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
    
    class func show(error: Error?, viewController: UIViewController, With completion:@escaping NumberCompletionHandler) {
        if let errorMessage = error?.localizedDescription {
            self.alertWith(title: "Error!", message: errorMessage, viewController: viewController, With: completion)
        }
    }
}

