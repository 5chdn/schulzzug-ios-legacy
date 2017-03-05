//
//  RegisterViewController.h
//  Schulzzug-iOS
//
//  Created by Niklas Riekenbrauck on 05.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;

- (IBAction)registerTapped:(UIButton *)sender;

@end
