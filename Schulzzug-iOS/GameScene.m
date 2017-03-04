//
//  GameScene.m
//  Schulzzug-iOS
//
//  Created by Frederik Riedel on 04.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

#import "GameScene.h"
#import "CoinNode.h"


@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    [super didMoveToView: view];
    
    self.backgroundColor = [SKColor colorWithRed:245.f/255.f green:0.f blue:0.f alpha:1.0];
    
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    self.physicsWorld.gravity = CGVectorMake(0, -6);
    self.physicsBody.affectedByGravity = NO;
    
    
    
    SKPhysicsBody* borderBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody = borderBody;
    
    self.railsNode = [[RailsNode alloc] initWithColor:[UIColor colorWithRed:89.f/255.f green:115.f/255.f blue:49.f/255.f alpha:1.f] size:view.frame.size];
    self.railsNode.position = CGPointMake(CGRectGetMidX(view.frame), CGRectGetMidY(view.frame));
    [self addChild:self.railsNode];
    
    
    
    SKTexture* startTexture = [SKTexture textureWithImageNamed:@"chulzzug"];
    
    
    
    
    self.chulzTrainNode = [SKSpriteNode spriteNodeWithTexture:startTexture];
    self.chulzTrainNode.position = CGPointMake(view.frame.size.width/2, 150);
    [self addChild:self.chulzTrainNode];
    
    SKPhysicsBody* chulzTrainBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(startTexture.size.width, startTexture.size.height)];
    chulzTrainBody.dynamic = YES;
    chulzTrainBody.allowsRotation = NO;
    
    
    
    self.chulzTrainNode.physicsBody = chulzTrainBody;
    self.chulzTrainNode.physicsBody.affectedByGravity = YES;
    
    
    
    
    CoinNode* coinNode = [CoinNode new];
    coinNode.position = CGPointMake(view.frame.size.width/2, view.frame.size.height/2);
    [self addChild:coinNode];
    
}

-(void) jumpRight {
    
    [self.chulzTrainNode.physicsBody applyImpulse:CGVectorMake(400, 500)];
    
}

-(void) jumpLeft {
    [self.chulzTrainNode.physicsBody applyImpulse:CGVectorMake(-400, 500)];
}

@end
