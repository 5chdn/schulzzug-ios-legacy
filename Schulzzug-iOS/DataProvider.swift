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
            let username = representation["username"] as? String,
            let score = representation["score"] as? Int
        else { return nil }
        self.username = username
        self.score = score
    }
}


class Config: NSObject, ResponseObjectSerializable {
    var kanzleramtIsAFreeElf: Bool = false
    
    required init?(response: HTTPURLResponse, representation: Any) {
        guard
        let representation = representation as? [String: Any],
            let kanzleramtIsAFreeElf = representation["user"] as? Bool
        else { return nil }
        self.kanzleramtIsAFreeElf = kanzleramtIsAFreeElf
    }
}




@objc class DataProvider: NSObject {
    static let `default` = DataProvider()
    
    fileprivate let keychain = Keychain(service: "Schulzzug")
    
    override init() {
        super.init()
        Router.token = keychain["token"] ?? ""
    }
    
    @objc func hasToken() -> Bool {
        return keychain["token"] != nil
    }
    
    @objc func register(username: String) {
        guard keychain["token"] == nil else { return }
        
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
    
    @objc func startGame(_ completion: @escaping (Bool) -> ()) {
        let route = Router.startGame
        Alamofire.request(route).responseJSON { (response: DataResponse<Any>) in
            completion(response.result.isSuccess)
        }
    }
    
    @objc func updateScore(_ score: Int, _ completion: @escaping (Bool) -> ()) {
        let parameters = [
            "score": score
        ]
        let route = Router.updateScore(parameters)
        Alamofire.request(route).responseJSON { (response: DataResponse<Any>) in
            completion(response.result.isSuccess)
        }
    }
    
    @objc func fetchConfig(_ completion: @escaping (Bool, Config?) -> ()) {
        let route = Router.fetchConfig
        Alamofire.request(route).responseObject { (response: DataResponse<Config>) in
            completion(response.result.isSuccess, response.result.value)
        }
    }
}
