//
//  RailsNode.m
//  Schulzzug-iOS
//
//  Created by Frederik Riedel on 04.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

#import "RailsNode.h"

@implementation RailsNode

-(instancetype) initWithColor:(UIColor *)color size:(CGSize)size {
    self = [super initWithColor:color size:size];
    
    if(self) {
        
        
        SKTexture* startTexture = [SKTexture textureWithImageNamed:@"rails_center_1"];
        
        int numberOfRails = 3;
        
        CGFloat spacing = (self.size.width - (startTexture.size.width*numberOfRails)) / (numberOfRails +1);
        
        
        for(int i=0; i<numberOfRails; i++) {
            
            NSArray <SKTexture*>* railTextures = @[];
            
            if(i==0) {
                railTextures = @[[SKTexture textureWithImageNamed:@"rails_left_1"],
                                 [SKTexture textureWithImageNamed:@"rails_left_2"]];
            } else if(i==1) {
                railTextures = @[[SKTexture textureWithImageNamed:@"rails_center_1"],
                                 [SKTexture textureWithImageNamed:@"rails_center_2"]];
            } else if(i==2) {
                railTextures = @[[SKTexture textureWithImageNamed:@"rails_right_1"],
                                 [SKTexture textureWithImageNamed:@"rails_right_2"]];
            }
            
            
            
            SKSpriteNode* rail = [[SKSpriteNode alloc] initWithTexture:startTexture];
            rail.anchorPoint = CGPointMake(0, 0);
            rail.position = CGPointMake(-self.size.width/2 + ((i+1)*spacing) + (i*startTexture.size.width), -self.size.height/2);
            
            
            SKAction* railsAnimation = [SKAction animateWithTextures:railTextures timePerFrame:0.1];
            [rail runAction:[SKAction repeatActionForever:railsAnimation]];
            
            
            [self addChild:rail];
        }
        
        
    }
    
    return self;
}



@end
