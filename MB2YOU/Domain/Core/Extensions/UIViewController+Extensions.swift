//
//  UIViewController+Extensions.swift
//  MB2YOU
//
//  Created by Vinicius Alencar on 9/21/21.
//

import UIKit

fileprivate var aView: UIView?

extension UIViewController {
    
    /// Creates and presents a UIAlertController on the screen
    ///
    /// - Parameters:
    ///   - title: title of the alert
    ///   - message: message of the alert
    ///   - okButtonText: ok button text
    func presentAlert(title: String, message: String, okButtonText: String = "OK", okCompletionHandler: ((UIAlertAction) -> Void)? = nil) {
        if ( self.viewIfLoaded?.window != nil ) {
            // create alert
            let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: okButtonText, style: UIAlertAction.Style.default, handler: okCompletionHandler) )
        
            // present it
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showLoadingIndicator(){
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        
        let ai = UIActivityIndicatorView(style: .large)
        ai.center = aView!.center
        ai.color = .white
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
    }
    
    func hideLoadingIndicator() {
        aView?.removeFromSuperview()
        aView = nil
    }
    
}
