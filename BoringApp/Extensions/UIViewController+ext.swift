//
//  UIViewController+ext.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 26.09.2021.
//

import UIKit
import CDAlertView

extension UIViewController {
    func presentAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            alertController.addAction(cancelButton)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func presentCustomAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alertController = CDAlertView(title: title, message: message, type: .custom(image: SFSymbols.error!))
            let okButton = CDAlertViewAction(title: "Ok! 😒")
            
            alertController.add(action: okButton)
            alertController.show()
        }
    }
}
