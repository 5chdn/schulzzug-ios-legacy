//
//  GameViewController.m
//  Schulzzug-iOS
//
//  Created by Frederik Riedel on 04.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    self.gameScene = [[GameScene alloc] initWithSize:self.spriteKitView.frame.size];
    
    [self.spriteKitView presentScene:self.gameScene];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
