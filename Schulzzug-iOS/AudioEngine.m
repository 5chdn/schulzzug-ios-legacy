//
//  AudioEngine.m
//  Schulzzug-iOS
//
//  Created by Frederik Riedel on 05.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

#import "AudioEngine.h"

#import "AMGSoundManager.h"

@implementation AudioEngine

+(void) playJumpSound {
    AMGSoundManager* soundManager = [AMGSoundManager sharedManager];
    [soundManager playAudio:[[NSBundle mainBundle] pathForResource:@"jump" ofType:@"mp3"] withName:@"jump" inLine:@"jump" withVolume:1 andRepeatCount:0 fadeDuration:0 withCompletitionHandler:nil];
}

+(void) playWallSmashSound {
    AMGSoundManager* soundManager = [AMGSoundManager sharedManager];
    [soundManager playAudio:[[NSBundle mainBundle] pathForResource:@"wall_smash" ofType:@"wav"] withName:@"wall_smash" inLine:@"wall_smash" withVolume:1 andRepeatCount:0 fadeDuration:0 withCompletitionHandler:nil];
}

+(void) playCoinCollectSound {
    AMGSoundManager* soundManager = [AMGSoundManager sharedManager];
    [soundManager playAudio:[[NSBundle mainBundle] pathForResource:@"coin" ofType:@"wav"] withName:@"coin" inLine:@"coin" withVolume:1 andRepeatCount:0 fadeDuration:0 withCompletitionHandler:nil];
}

+(void) chootChoot {
    AMGSoundManager* soundManager = [AMGSoundManager sharedManager];
    [soundManager playAudio:[[NSBundle mainBundle] pathForResource:@"choot_choot" ofType:@"mp3"] withName:@"choot_choot" inLine:@"choot_choot" withVolume:1 andRepeatCount:0 fadeDuration:0 withCompletitionHandler:nil];
}

+(void) startBackgroundMusic {
    AMGSoundManager* soundManager = [AMGSoundManager sharedManager];
    [soundManager playAudio:[[NSBundle mainBundle] pathForResource:@"Europahymne" ofType:@"mp3"] withName:@"theme" inLine:@"music" withVolume:0.2 andRepeatCount:-1 fadeDuration:0 withCompletitionHandler:nil];
    
    [soundManager playAudio:[[NSBundle mainBundle] pathForResource:@"lokomotive" ofType:@"wav"] withName:@"lokomotive" inLine:@"music" withVolume:0.5 andRepeatCount:-1 fadeDuration:0 withCompletitionHandler:nil];
}

+(void) stopBackgroundMusic {
    AMGSoundManager* soundManager = [AMGSoundManager sharedManager];
    [soundManager stopAudioWithName:@"theme" withFadeDuration:1.f];
    [soundManager stopAudioWithName:@"lokomotive" withFadeDuration:1.f];
}



@end
