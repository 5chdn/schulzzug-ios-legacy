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
#import "CloudNode.h"

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
    
    [NSTimer scheduledTimerWithTimeInterval:2.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self spawnEntityWithName:@"coin" onSide:SpawnSideLane1];
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self spawnCloud];
    }];

}

-(void) spawnCloud {
        if (arc4random_uniform(100) > 20) {
            return;
        }
    
        NSInteger horizonPosition = 208;
        CGFloat yPosition = self.frame.size.height - arc4random_uniform(horizonPosition);
    
        CloudNode *cloudNode = [CloudNode new];
        cloudNode.position = CGPointMake(-50, yPosition);
        [self addChild:cloudNode];
    
        SKAction *moveAction = [SKAction moveToX:self.frame.size.width + 100 duration: arc4random_uniform(15)];
        [cloudNode runAction:moveAction];
}

-(void) spawnEntityWithName:(NSString*) name onSide:(SpawnSide) spawnSide {
    NSInteger horizonPosition = 208;
    SKTexture* texture = [SKTexture textureWithImageNamed:name];
    
    CGFloat spawnX, spawnY, targetX, targetY;
    spawnY = self.frame.size.height - horizonPosition;
    targetY = -200;
    spawnX = 0;
    targetX = 0;
    
    NSString* nodeName = @"";
    
    if(spawnSide == SpawnSideLeft) {
        spawnX = self.view.frame.size.width/2.5;
        targetX = -300;
    } else if(spawnSide == SpawnSideRight) {
        spawnX = self.view.frame.size.width-(self.view.frame.size.width/2.5);
        targetX = self.view.frame.size.width+300;
    } else if(spawnSide == SpawnSideLane1) {
        spawnX = self.view.frame.size.width/2;
        targetX = self.view.frame.size.width/2;
        nodeName = @"lane1";
    } else {
        return;
    }
    
    SKSpriteNode* node;
    if([name isEqualToString:@"coin"]) {
        node = [CoinNode new];
    } else {
        node = [SKSpriteNode spriteNodeWithTexture:texture];
    }
    
    
    node.position = CGPointMake(spawnX, spawnY);
    node.name = nodeName;
    
    __block SKAction* scaleX = [SKAction resizeToWidth:texture.size.width*0.1 duration:0];
    __block SKAction* scaleY = [SKAction resizeToHeight:texture.size.height*0.1 duration:0];
    
    [node runAction:scaleX];
    [node runAction:scaleY];
    
    
    [self addChild:node];
    
    
    int duration = 13;
    
    SKAction* speed = [SKAction customActionWithDuration:duration actionBlock:^(SKNode * _Nonnull node, CGFloat elapsedTime) {
        float t = duration - (elapsedTime+1);
        float s = ((1/t)/10);
        
        CGPoint newPosition = CGPointMake(spawnX + ((targetX-spawnX) * s), spawnY + ((targetY-spawnY) * s));
        node.position = newPosition;
        
        scaleX = [SKAction resizeToWidth:2*s*texture.size.width duration:0];
        scaleY = [SKAction resizeToHeight:2*s*texture.size.height duration:0];
        
        [node runAction:scaleX];
        [node runAction:scaleY];
    }];
    [node runAction:speed];
    
    //    SKAction* move = [SKAction moveTo:CGPointMake(targetX, targetY) duration:13];
    //    scaleX = [SKAction resizeToWidth:texture.size.width duration:13];
    //    scaleY = [SKAction resizeToHeight:texture.size.height duration:13];
    //
    //    move.timingMode = SKActionTimingEaseIn;
    //
    //    [node runAction:move];
    //    [node runAction:scaleX];
    //    [node runAction:scaleY];
    
}



-(void) jumpRight {
    
    if(self.drivingDirecton != DrivingDirectionRight) {
        
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0, 0)];
        [bezierPath addQuadCurveToPoint:CGPointMake(120, 0) controlPoint:CGPointMake(60, 50)];
        SKAction *followSquare = [SKAction followPath:bezierPath.CGPath asOffset:YES orientToPath:NO duration:0.2];
        followSquare.timingMode = SKActionTimingEaseInEaseOut;
        [self.chulzTrainNode runAction:followSquare];
        
        [AudioEngine playJumpSound];
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
        [bezierPath addQuadCurveToPoint:CGPointMake(-120, 0) controlPoint:CGPointMake(-60, 50)];
        
        
        
        SKAction *followSquare = [SKAction followPath:bezierPath.CGPath asOffset:YES orientToPath:NO duration:0.2];
        followSquare.timingMode = SKActionTimingEaseInEaseOut;
        [self.chulzTrainNode runAction:followSquare];
        
        [AudioEngine playJumpSound];
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
    
    [AudioEngine playJumpSound];
}

-(void)update:(NSTimeInterval)currentTime {
    [super update:currentTime];
    
    // Lane
    for(SKNode* node in self.children) {
        if([node.name isEqualToString:@"front"]) {
            
        } else if([node.name isEqualToString:@"lane1"]) {
            if(self.drivingDirecton == DrivingDirectionForward) {
                if(self.chulzTrainNode.position.y - 10 < node.position.y && self.chulzTrainNode.position.y + 10 > node.position.y) {
                    
                    if([node isKindOfClass:[CoinNode class]]) {
                        [AudioEngine playCoinCollectSound];
                        [self.gameSceneDelegate didCollectCoin];
                    } else {
                        [AudioEngine playWallSmashSound];
                        [self.gameSceneDelegate didCrashTrumpWall];
                    }
                    
                    [node removeFromParent];
                    
                }
            }
        } else {
            node.zPosition = self.frame.size.height - node.frame.origin.y;
            
        }
        
        if(node.frame.origin.y > self.frame.size.height || node.frame.origin.x > self.frame.size.width) {
            [node removeFromParent];
        }
        
    }
    
    
    
}

@end
