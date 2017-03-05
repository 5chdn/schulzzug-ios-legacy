//
//  Game.swift
//  Schulzzug-iOS
//
//  Created by Niklas Riekenbrauck on 04.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

import Foundation


@objc protocol GameDelegate {
    func didStart(game: Game)
    func didStop(game: Game)
    func didFinish(game: Game)
}


@objc class Game: NSObject {
    fileprivate var score: Int = 0
    fileprivate var schulzCoins: Int = 0
    
    fileprivate let gameSpeed: Int = 3
    fileprivate let updateInterval: Float = 0.1
    
    weak var gameDelegate: GameDelegate?
    
    func start() {
        gameDelegate?.didStart(game: self)
    }
    
    func stop() {
        gameDelegate?.didStop(game: self)
    }
    
    func blockSpawning() {
        
    }
    
    static func random(from lower: NSInteger, to upper: NSInteger) -> NSInteger {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
}
