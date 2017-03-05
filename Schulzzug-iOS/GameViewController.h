//
//  GameViewController.h
//  Schulzzug-iOS
//
//  Created by Frederik Riedel on 04.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameScene.h"
#import "Schulzzug_iOS-Swift.h"

@import SceneKit;
@import SpriteKit;

@interface GameViewController : UIViewController

@property(strong) GameScene* gameScene;
@property (strong, nonatomic) IBOutlet SKView *spriteKitView;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;

@end
