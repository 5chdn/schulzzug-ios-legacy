//
//  AudioEngine.h
//  Schulzzug-iOS
//
//  Created by Frederik Riedel on 05.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioEngine : NSObject

+(void) playJumpSound;
+(void) playWallSmashSound;
+(void) playCoinCollectSound;+(void) startBackgroundMusic;
+(void) stopBackgroundMusic;
+(void) chootChoot;

@end
