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

@interface GameScene : SKScene {
    NSMutableArray<CoinNode*>* coinNodes;
}

@property(nonatomic, strong) SKSpriteNode* railsNode;
@property(nonatomic, strong) SKSpriteNode* chulzTrainNode;
@property(nonatomic, strong) SKSpriteNode* skyNode;
@property(nonatomic, strong) BackgroundParallax* backgroundParallax;


-(void) jumpRight;
-(void) jumpLeft;
-(void) jump;

@end
