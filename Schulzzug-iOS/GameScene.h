//
//  GameScene.h
//  Schulzzug-iOS
//
//  Created by Frederik Riedel on 04.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BackgroundParallax.h"
#import "CoinNode.h"

@protocol GameSceneDelegate <NSObject>
- (void)didCollectCoin;
- (void)didCrashTrumpWall;
- (void)didUpdateDistance;
- (void)didFinish;
@end

typedef enum {
    DrivingDirectionForward,
    DrivingDirectionLeft,
    DrivingDirectionRight
} DrivingDirection;

typedef enum {
    SpawnSideLeft,
    SpawnSideRight,
    SpawnSideLane0,
    SpawnSideLane1,
    SpawnSideLane2
    
} SpawnSide;

@interface GameScene : SKScene 

@property(nonatomic, strong) SKSpriteNode* railsNode;
@property(nonatomic, strong) SKSpriteNode* chulzTrainNode;
@property(nonatomic, strong) SKSpriteNode* skyNode;
@property(nonatomic, strong) BackgroundParallax* backgroundParallax;
@property DrivingDirection drivingDirecton;
@property(weak, nonatomic) id <GameSceneDelegate> gameSceneDelegate;

-(void) jumpRight;
-(void) jumpLeft;
-(void) jump;

@end
