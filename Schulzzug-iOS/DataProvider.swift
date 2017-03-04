//
//  DataProvider.swift
//  Schulzzug-iOS
//
//  Created by Niklas Riekenbrauck on 04.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

import Foundation
import Alamofire
import KeychainAccess


class DataProvider {
    fileprivate let keychain = Keychain(service: "Schulzzug")
    
    func register() {
        Alamofire.request(Router.register).responseJSON { [weak self] (response) in
            guard let `self` = self,
                let json = response.result.value as? [String: Any],
                let token = json["token"] as? String else { return }
            
            self.keychain["token"] = token
        }
    }
}
