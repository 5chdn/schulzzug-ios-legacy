//
//  UIAlertControllerExtension.swift
//  Schulzzug-iOS
//
//  Created by Niklas Riekenbrauck on 04.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func showError(on viewController: UIViewController, with errorMessage: String) {
        let alert = UIAlertController(title: "Fehler", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
