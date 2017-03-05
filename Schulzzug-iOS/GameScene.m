//
//  GameScene.m
//  Schulzzug-iOS
//
//  Created by Frederik Riedel on 04.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

#import "GameScene.h"
#import "CoinNode.h"
#import "AudioEngine.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    [super didMoveToView: view];
    
    self.backgroundColor = [SKColor colorWithRed:89.f/255.f green:150.f/255.f blue:49.f/255.f alpha:1.0];
    
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    
    SKTexture* railsTexture = [SKTexture textureWithImageNamed:@"rails_1"];
    self.railsNode = [SKSpriteNode spriteNodeWithTexture:railsTexture];
    self.railsNode.position = CGPointMake(CGRectGetMidX(view.frame), CGRectGetMidY(view.frame));
    [self addChild:self.railsNode];
    
    NSArray <SKTexture*>* railTextures = @[[SKTexture textureWithImageNamed:@"rails_1"],
                                           [SKTexture textureWithImageNamed:@"rails_2"]];
    
    SKAction* railsAnimation = [SKAction animateWithTextures:railTextures timePerFrame:0.1];
    [self.railsNode runAction:[SKAction repeatActionForever:railsAnimation]];
    
    
    
    CoinNode* coinNode = [CoinNode new];
    coinNode.position = CGPointMake(view.frame.size.width/2, view.frame.size.height/2);
    [self addChild:coinNode];
    
    
    SKTexture* skyTexture = [SKTexture textureWithImageNamed:@"sky"];
    
    self.skyNode = [SKSpriteNode spriteNodeWithTexture:skyTexture];
    self.skyNode.anchorPoint = CGPointMake(0.5, 1);
    self.skyNode.position = CGPointMake(view.frame.size.width/2, view.frame.size.height);
    [self addChild:self.skyNode];
    
    
    SKTexture* zugTexture = [SKTexture textureWithImageNamed:@"Train01"];
    
    self.chulzTrainNode = [SKSpriteNode spriteNodeWithTexture:zugTexture];
    self.chulzTrainNode.position = CGPointMake(view.frame.size.width/2, 240);
    [self addChild:self.chulzTrainNode];
    
    NSArray <SKTexture*>* zugTextures = @[[SKTexture textureWithImageNamed:@"Train01"],
                                          [SKTexture textureWithImageNamed:@"Train02"],
                                          [SKTexture textureWithImageNamed:@"Train03"]];
    SKAction* trainAnimation = [SKAction animateWithTextures:zugTextures timePerFrame:0.15];
    [self.chulzTrainNode runAction:[SKAction repeatActionForever:trainAnimation]];
    
}

-(void) jumpRight {
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0, 0)];
    [bezierPath addQuadCurveToPoint:CGPointMake(140, 0) controlPoint:CGPointMake(70, 50)];
    SKAction *followSquare = [SKAction followPath:bezierPath.CGPath asOffset:YES orientToPath:NO duration:0.2];
    followSquare.timingMode = SKActionTimingEaseInEaseOut;
    [self.chulzTrainNode runAction:followSquare];
}

-(void) jumpLeft {
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0, 0)];
    [bezierPath addQuadCurveToPoint:CGPointMake(-140, 0) controlPoint:CGPointMake(-70, 50)];
    
    
    
    SKAction *followSquare = [SKAction followPath:bezierPath.CGPath asOffset:YES orientToPath:NO duration:0.2];
    followSquare.timingMode = SKActionTimingEaseInEaseOut;
    [self.chulzTrainNode runAction:followSquare];
}

-(void) jump {
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0, 0)];
    [bezierPath addQuadCurveToPoint:CGPointMake(0, 0) controlPoint:CGPointMake(0, 100)];
    SKAction *followSquare = [SKAction followPath:bezierPath.CGPath asOffset:YES orientToPath:NO duration:0.2];
    followSquare.timingMode = SKActionTimingEaseInEaseOut;
    [self.chulzTrainNode runAction:followSquare];
    
    [AudioEngine playWallSmashSound];
}

@end
