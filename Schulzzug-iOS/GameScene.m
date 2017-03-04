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
    
    
    
    self.railsNode = [[RailsNode alloc] initWithColor:[UIColor colorWithRed:89.f/255.f green:115.f/255.f blue:49.f/255.f alpha:1.f] size:view.frame.size];
    self.railsNode.position = CGPointMake(CGRectGetMidX(view.frame), CGRectGetMidY(view.frame));
    
    
    
    [self addChild:self.railsNode];
}

@end
