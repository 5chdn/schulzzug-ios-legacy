//
//  CoinNode.m
//  Schulzzug-iOS
//
//  Created by Niklas Riekenbrauck on 04.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

#import "CoinNode.h"

@implementation CoinNode

-(instancetype) init {
    SKTexture *startTexture = [SKTexture textureWithImageNamed:@"coin_1"];
    
    self = [super initWithTexture:startTexture];
    
    if(self) {
        NSArray <SKTexture*>* coinTextures = @[[SKTexture textureWithImageNamed:@"coin_1"],
                                               [SKTexture textureWithImageNamed:@"coin_2"],
                                               [SKTexture textureWithImageNamed:@"coin_3"],
                                               [SKTexture textureWithImageNamed:@"coin_2"]];
        
        SKAction* railsAnimation = [SKAction animateWithTextures:coinTextures timePerFrame:0.1];
        [self runAction:[SKAction repeatActionForever:railsAnimation]];
        
        
    }
    
    return self;
}

@end
