//
//  RailsNode.m
//  Schulzzug-iOS
//
//  Created by Frederik Riedel on 04.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

#import "RailsNode.h"

@implementation RailsNode

-(instancetype) init {
    self = [super init];
    
    if(self) {
        
        NSArray <SKTexture*>* railTextures = @[[SKTexture textureWithImage:[UIImage imageNamed:@"rails_1"]],
                                               [SKTexture textureWithImage:[UIImage imageNamed:@"rails_2"]]];
        
        
        
        
        
        self.rails = [[SKSpriteNode alloc] initWithColor:[UIColor greenColor] size:self.scene.frame.size];
        
        
        
        SKAction* railsAnimation = [SKAction animateWithTextures:railTextures timePerFrame:0.2];
        [self.rails runAction:[SKAction repeatActionForever:railsAnimation]];

        
        [self addChild:self.rails];
    }
    
    return self;
}

@end
