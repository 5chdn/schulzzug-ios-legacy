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
    
    
    SKTexture* railsBackgroundDirt = [SKTexture textureWithImageNamed:@"dirt"];
    
    SKSpriteNode* railsBackgroundDirtNode = [SKSpriteNode spriteNodeWithTexture:railsBackgroundDirt];
    railsBackgroundDirtNode.position = CGPointMake(CGRectGetMidX(view.frame), CGRectGetMidY(view.frame));
    railsBackgroundDirtNode.name = @"front";
    [self addChild:railsBackgroundDirtNode];
    
    
    SKTexture* railsTexture = [SKTexture textureWithImageNamed:@"rails01"];
    
    self.railsNode = [SKSpriteNode spriteNodeWithTexture:railsTexture];
    self.railsNode.position = CGPointMake(CGRectGetMidX(view.frame), CGRectGetMidY(view.frame));
    self.railsNode.name = @"front";
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
    self.skyNode.name = @"front";
    self.skyNode.position = CGPointMake(view.frame.size.width/2, view.frame.size.height);
    [self addChild:self.skyNode];
    
    
    SKTexture* zugTexture = [SKTexture textureWithImageNamed:@"Train02"];
    
    self.chulzTrainNode = [SKSpriteNode spriteNodeWithTexture:zugTexture];
    self.chulzTrainNode.position = CGPointMake(view.frame.size.width/2, 240);
    self.chulzTrainNode.zPosition = 1000000;
    self.chulzTrainNode.name = @"front";
    [self addChild:self.chulzTrainNode];
    
    
    [self didUpdateDrivingdirection];
    
    [NSTimer scheduledTimerWithTimeInterval:1.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        [self spawnEntityWithName:@"specialtree" onSide:SpawnSideLeft];
        
        
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self spawnEntityWithName:@"bush" onSide:SpawnSideRight];
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:4 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self spawnEntityWithName:@"Trump-Wall" onSide:SpawnSideLane1];
    }];
    
}

-(void) spawnEntityWithName:(NSString*) name onSide:(SpawnSide) spawnSide {
    NSInteger horizonPosition = 208;
    SKTexture* texture = [SKTexture textureWithImageNamed:name];
    
    CGFloat spawnX, spawnY, targetX, targetY;
    spawnY = self.frame.size.height - horizonPosition - 32 - 16;
    targetY = -50;
    spawnX = 0;
    targetX = 0;
    
    if(spawnSide == SpawnSideLeft) {
        spawnX = self.view.frame.size.width/3.5;
        targetX = -150;
    } else if(spawnSide == SpawnSideRight) {
        spawnX = self.view.frame.size.width-(self.view.frame.size.width/3.5);
        targetX = self.view.frame.size.width+150;
    } else if(spawnSide == SpawnSideLane1) {
        spawnX = self.view.frame.size.width/2;
        targetX = self.view.frame.size.width/2;
    } else {
        return;
    }
    
    SKSpriteNode* node = [SKSpriteNode spriteNodeWithTexture:texture];
    node.position = CGPointMake(spawnX, spawnY);
    
    SKAction* scaleX = [SKAction resizeToWidth:0 duration:0];
    SKAction* scaleY = [SKAction resizeToHeight:0 duration:0];
    
    [node runAction:scaleX];
    [node runAction:scaleY];
    
    
    [self addChild:node];
    
    
    SKAction* move = [SKAction moveTo:CGPointMake(targetX, targetY) duration:13];
    scaleX = [SKAction resizeToWidth:texture.size.width duration:13];
    scaleY = [SKAction resizeToHeight:texture.size.height duration:13];
    
    move.timingMode = SKActionTimingEaseIn;
    
    [node runAction:move];
    [node runAction:scaleX];
    [node runAction:scaleY];
    
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
    SKAction *followSquare = [SKAction followPath:bezierPath.CGPath asOffset:YES orientToPath:NO duration:0.5];
    [self.chulzTrainNode runAction:followSquare];
    
    [AudioEngine playWallSmashSound];
}

-(void)update:(NSTimeInterval)currentTime {
    [super update:currentTime];
    
    /*NSInteger horizonPosition = 208;
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
    }*/
    
    for(SKNode* node in self.children) {
        if([node.name isEqualToString:@"front"]) {
            
        } else {
            node.zPosition = self.frame.size.height - node.frame.origin.y;
        }
        
    }
    
}

@end
