//
//  GameScene.m
//  Schulzzug-iOS
//
//  Created by Frederik Riedel on 04.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

#import "GameScene.h"
#import "CoinNode.h"
#import "Schulzzug_iOS-Swift.h"
#import "AudioEngine.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    [super didMoveToView: view];
    
    self.backgroundColor = [SKColor colorWithRed:89.f/255.f green:150.f/255.f blue:49.f/255.f alpha:1.0];
    
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    self.drivingDirecton = DrivingDirectionForward;
    
    
    SKTexture* railsTexture = [SKTexture textureWithImageNamed:@"rails01"];

    self.railsNode = [SKSpriteNode spriteNodeWithTexture:railsTexture];
    self.railsNode.position = CGPointMake(CGRectGetMidX(view.frame), CGRectGetMidY(view.frame));
    [self addChild:self.railsNode];
    
    NSArray <SKTexture*>* railTextures = @[[SKTexture textureWithImageNamed:@"rails01"],
                                           [SKTexture textureWithImageNamed:@"rails02"]];
    
    SKAction* railsAnimation = [SKAction animateWithTextures:railTextures timePerFrame:0.1];
    [self.railsNode runAction:[SKAction repeatActionForever:railsAnimation]];
    
    
    
    coinNodes = [NSMutableArray new];
    
    CoinNode* coinNode = [CoinNode new];
    coinNode.position = CGPointMake(view.frame.size.width/2, view.frame.size.height/2);
    [self addChild:coinNode];
    
    
    SKTexture* skyTexture = [SKTexture textureWithImageNamed:@"sky"];
    
    self.skyNode = [SKSpriteNode spriteNodeWithTexture:skyTexture];
    self.skyNode.anchorPoint = CGPointMake(0.5, 1);
    self.skyNode.position = CGPointMake(view.frame.size.width/2, view.frame.size.height);
    [self addChild:self.skyNode];
    
    
    SKTexture* zugTexture = [SKTexture textureWithImageNamed:@"Train02"];
    
    self.chulzTrainNode = [SKSpriteNode spriteNodeWithTexture:zugTexture];
    self.chulzTrainNode.position = CGPointMake(view.frame.size.width/2, 240);
    [self addChild:self.chulzTrainNode];
    

    [self didUpdateDrivingdirection];
    
    [NSTimer scheduledTimerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self spawnTree];
    }];

}

-(void) spawnBush {
    
}

-(void) spawnTree {
    
    NSInteger horizonPosition = 208;
    
    
    
    SKTexture* tree = [SKTexture textureWithImageNamed:@"specialtree"];
    
    SKSpriteNode* treenode = [SKSpriteNode spriteNodeWithTexture:tree];
    treenode.position = CGPointMake(self.view.frame.size.width/3.5, self.frame.size.height - horizonPosition - 32 - 16);
    
    SKAction* scaleX = [SKAction resizeToWidth:0 duration:0];
    SKAction* scaleY = [SKAction resizeToHeight:0 duration:0];
    
    [treenode runAction:scaleX];
    [treenode runAction:scaleY];
    
    [self addChild:treenode];
    
    SKAction* move = [SKAction moveTo:CGPointMake(-100, -50) duration:13];
    scaleX = [SKAction resizeToWidth:130 duration:13];
    scaleY = [SKAction resizeToHeight:130 duration:13];
    
    move.timingMode = SKActionTimingEaseIn;
    
    [treenode runAction:move];
    [treenode runAction:scaleX];
    [treenode runAction:scaleY];
    
}

-(void) jumpRight {
    
    if(self.drivingDirecton != DrivingDirectionRight) {
        
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0, 0)];
        [bezierPath addQuadCurveToPoint:CGPointMake(140, 0) controlPoint:CGPointMake(70, 50)];
        SKAction *followSquare = [SKAction followPath:bezierPath.CGPath asOffset:YES orientToPath:NO duration:0.2];
        followSquare.timingMode = SKActionTimingEaseInEaseOut;
        [self.chulzTrainNode runAction:followSquare];
        
        [AudioEngine playWallSmashSound];
    }
    
    if(self.drivingDirecton == DrivingDirectionForward) {
        self.drivingDirecton = DrivingDirectionRight;
    } else if(self.drivingDirecton == DrivingDirectionLeft) {
        self.drivingDirecton = DrivingDirectionForward;
    }
    
    [self didUpdateDrivingdirection];
    
    
}

-(void) jumpLeft {

    
    if(self.drivingDirecton != DrivingDirectionLeft) {
        
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0, 0)];
        [bezierPath addQuadCurveToPoint:CGPointMake(-140, 0) controlPoint:CGPointMake(-70, 50)];
        
        
        
        SKAction *followSquare = [SKAction followPath:bezierPath.CGPath asOffset:YES orientToPath:NO duration:0.2];
        followSquare.timingMode = SKActionTimingEaseInEaseOut;
        [self.chulzTrainNode runAction:followSquare];
        
        [AudioEngine playWallSmashSound];
    }
    
    if(self.drivingDirecton == DrivingDirectionForward) {
        self.drivingDirecton = DrivingDirectionLeft;
    } else if(self.drivingDirecton == DrivingDirectionRight) {
        self.drivingDirecton = DrivingDirectionForward;
    }

    [self didUpdateDrivingdirection];
    
}

-(void) didUpdateDrivingdirection {
    
    [self.chulzTrainNode removeActionForKey:@"texture-animation"];
    
    
    if(self.drivingDirecton == DrivingDirectionForward) {
        NSArray <SKTexture*>* zugTextures = @[[SKTexture textureWithImageNamed:@"Train02"],
                                              [SKTexture textureWithImageNamed:@"Train03"]];
        SKAction* trainAnimation = [SKAction animateWithTextures:zugTextures timePerFrame:0.15];
        
        [self.chulzTrainNode runAction:[SKAction repeatActionForever:trainAnimation] withKey:@"texture-animation"];

    } else if(self.drivingDirecton == DrivingDirectionLeft) {
        NSArray <SKTexture*>* zugTextures = @[[SKTexture textureWithImageNamed:@"Train_Left_02"],
                                              [SKTexture textureWithImageNamed:@"Train_Left_03"]];
        SKAction* trainAnimation = [SKAction animateWithTextures:zugTextures timePerFrame:0.15];
        [self.chulzTrainNode runAction:[SKAction repeatActionForever:trainAnimation] withKey:@"texture-animation"];

    } else if(self.drivingDirecton == DrivingDirectionRight) {
        NSArray <SKTexture*>* zugTextures = @[[SKTexture textureWithImageNamed:@"Train_Right_02"],
                                              [SKTexture textureWithImageNamed:@"Train_Right_03"]];
        SKAction* trainAnimation = [SKAction animateWithTextures:zugTextures timePerFrame:0.15];
        [self.chulzTrainNode runAction:[SKAction repeatActionForever:trainAnimation] withKey:@"texture-animation"];

    }
    
}

-(void) jump {
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0, 0)];
    [bezierPath addQuadCurveToPoint:CGPointMake(0, 0) controlPoint:CGPointMake(0, 140)];
    SKAction *followSquare = [SKAction followPath:bezierPath.CGPath asOffset:YES orientToPath:NO duration:0.2];
    followSquare.timingMode = SKActionTimingEaseInEaseOut;
    [self.chulzTrainNode runAction:followSquare];
    
    [AudioEngine playWallSmashSound];
}

-(void)update:(NSTimeInterval)currentTime {
    [super update:currentTime];
    
    NSInteger horizonPosition = 208;
    NSInteger railsWidth = 10;
    NSInteger railsSpacing = 6;
    
    // Only spawn new object every X steps
    NSInteger coinSpawnInterval = 5;
    if ((NSInteger)currentTime % coinSpawnInterval == 0) {
        NSInteger railIndex = [Game randomFrom:0 to:2];
        
        CoinNode *newCoinNode = [CoinNode new];
        
        // Calculate initial position and size
        NSInteger initialXPosition = self.frame.size.width/2 - railsWidth - railsSpacing + railIndex * (railsWidth + railsSpacing);
        newCoinNode.position = CGPointMake(initialXPosition, self.frame.size.height - horizonPosition - 32 - 16);
        newCoinNode.size = CGSizeMake(railsWidth, railsWidth);
        
        // Add to index
        [self addChild:newCoinNode];
        [coinNodes addObject:newCoinNode];
    }
    
    // Update position or remove hidden
    for (CoinNode* coinNode in coinNodes) {
        if (coinNode.position.y < 0) {
            [coinNodes removeObject:coinNode];
            [coinNode removeFromParent];
        }
    }
    
}

@end
