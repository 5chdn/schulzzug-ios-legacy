//
//  GameScene.h
//  Schulzzug-iOS
//
//  Created by Frederik Riedel on 04.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BackgroundParallax.h"

typedef enum {
    DrivingDirectionForward,
    DrivingDirectionLeft,
    DrivingDirectionRight
} DrivingDirection;

@interface GameScene : SKScene

@property(nonatomic, strong) SKSpriteNode* railsNode;
@property(nonatomic, strong) SKSpriteNode* chulzTrainNode;
@property(nonatomic, strong) SKSpriteNode* skyNode;
@property(nonatomic, strong) BackgroundParallax* backgroundParallax;
@property DrivingDirection drivingDirecton;



-(void) jumpRight;
-(void) jumpLeft;
-(void) jump;

@end
