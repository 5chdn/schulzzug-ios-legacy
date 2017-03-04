//
//  GameScene.h
//  Schulzzug-iOS
//
//  Created by Frederik Riedel on 04.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "RailsNode.h"
#import "BackgroundParallax.h"

@interface GameScene : SKScene

@property(nonatomic, strong) RailsNode* railsNode;
@property(nonatomic, strong) SKSpriteNode* chulzTrainNode;
@property(nonatomic, strong) BackgroundParallax* backgroundParallax;



-(void) jumpRight;
-(void) jumpLeft;

@end
