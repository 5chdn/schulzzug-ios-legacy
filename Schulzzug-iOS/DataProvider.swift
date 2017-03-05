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


struct LeaderboardItem: ResponseObjectSerializable, ResponseCollectionSerializable {
    let username: String
    let score: Int
    
    init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation = representation as? [String: Any],
            let username = representation["user"] as? String,
            let score = representation["score"] as? Int
        else { return nil }
        self.username = username
        self.score = score
    }
}


class DataProvider {
    static let `default` = DataProvider()
    
    fileprivate let keychain = Keychain(service: "Schulzzug")
    
    init() {
        Router.token = keychain["token"] ?? ""
    }
    
    func register(username: String) {
        let parameters = [
            "user": username
        ]
        let route = Router.register(parameters)
        Alamofire.request(route).responseJSON { [weak self] (response) in
            guard let `self` = self,
                let json = response.result.value as? [String: Any],
                let token = json["token"] as? String else { return }
            
            // Update token in keychain and router
            self.keychain["token"] = token
            Router.token = token
        }
    }
    
    func fetchScores(_ completion: @escaping (Result<[LeaderboardItem]>) -> ()) {
        let route = Router.fetchScores
        Alamofire.request(route).responseCollection { (response: DataResponse<[LeaderboardItem]>) in
            completion(response.result)
        }
    }
}
