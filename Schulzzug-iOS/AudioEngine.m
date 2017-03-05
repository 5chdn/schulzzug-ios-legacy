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
    [soundManager playAudio:[[NSBundle mainBundle] pathForResource:@"wall_smash" ofType:@"mp3"] withName:@"wall_smash" inLine:@"wall_smash" withVolume:1 andRepeatCount:0 fadeDuration:0 withCompletitionHandler:nil];
}

+(void) playCoinCollectSound {
    AMGSoundManager* soundManager = [AMGSoundManager sharedManager];
    [soundManager playAudio:[[NSBundle mainBundle] pathForResource:@"coin" ofType:@"mp3"] withName:@"coin" inLine:@"coin" withVolume:1 andRepeatCount:0 fadeDuration:0 withCompletitionHandler:nil];
}

+(void) chootChoot {
    AMGSoundManager* soundManager = [AMGSoundManager sharedManager];
    [soundManager playAudio:[[NSBundle mainBundle] pathForResource:@"choot_choot" ofType:@"mp3"] withName:@"choot_choot" inLine:@"choot_choot" withVolume:1 andRepeatCount:0 fadeDuration:0 withCompletitionHandler:nil];
}

+(void) startBackgroundMusic {
    AMGSoundManager* soundManager = [AMGSoundManager sharedManager];
    [soundManager playAudio:[[NSBundle mainBundle] pathForResource:@"theme" ofType:@"mp3"] withName:@"themetheme" inLine:@"music" withVolume:0.8 andRepeatCount:-1 fadeDuration:0 withCompletitionHandler:nil];
}

+(void) stopBackgroundMusic {
    AMGSoundManager* soundManager = [AMGSoundManager sharedManager];
    [soundManager stopAudioWithName:@"theme" withFadeDuration:1.f];
}



@end
