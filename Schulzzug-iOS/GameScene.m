//
//  GameScene.m
//  Schulzzug-iOS
//
//  Created by Frederik Riedel on 04.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    [super didMoveToView: view];
    
    self.backgroundColor = [SKColor colorWithRed:245.f/255.f green:0.f blue:0.f alpha:1.0];
    
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    
    
    self.railsNode = [RailsNode node];
    
    [self addChild:self.railsNode];
}

@end
