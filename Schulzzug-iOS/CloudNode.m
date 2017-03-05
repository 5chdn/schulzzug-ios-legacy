//
//  CloudNode.m
//  Schulzzug-iOS
//
//  Created by Niklas Riekenbrauck on 05.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

#import "CloudNode.h"

@implementation CloudNode

-(instancetype) init {
    
    SKTexture *cloudTexture;
    
    NSInteger cloudIndex = arc4random_uniform(3);

    if (cloudIndex == 0) {
        cloudTexture = [SKTexture textureWithImageNamed:@"cloud_1"];
    } else if (cloudIndex == 1) {
        cloudTexture = [SKTexture textureWithImageNamed:@"cloud_2"];
    } else {
        cloudTexture = [SKTexture textureWithImageNamed:@"cloud_3"];
    }
    
    self = [super initWithTexture:cloudTexture];
    
    return self;
}


@end
