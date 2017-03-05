//
//  GameViewController.m
//  Schulzzug-iOS
//
//  Created by Frederik Riedel on 04.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

#import "GameViewController.h"
#import "AudioEngine.h"


@interface GameViewController ()

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AudioEngine startBackgroundMusic];
    
}

-(void)viewWillAppear:(BOOL)animated {
    self.gameScene = [[GameScene alloc] initWithSize:self.spriteKitView.frame.size];
    self.gameScene.gameSceneDelegate = self;
    
    [self.spriteKitView presentScene:self.gameScene];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [[DataProvider default] startGame:^(BOOL success) {
        
    }];
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.spriteKitView.showsDrawCount = YES;
    self.spriteKitView.showsNodeCount = YES;
    self.spriteKitView.showsFPS = YES;
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (IBAction)swipeRight:(id)sender {
    [self.gameScene jumpRight];
}

- (IBAction)swipeLeft:(id)sender {
    [self.gameScene jumpLeft];
}

- (IBAction)tap:(id)sender {
    [self.gameScene jump];
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)didCollectCoin {
    score += 5;
    self.scoreLabel.text = [NSString stringWithFormat:@"%i", (int)score];
}

-(void)didUpdateDistance {
    distance += 1;
    self.distanceLabel.text = [NSString stringWithFormat:@"%i", (int)distance];
}

-(void)didCrashTrumpWall {
    
}

-(void)didFinish {
    [[DataProvider default] updateScore:score :^(BOOL success) {
        
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
