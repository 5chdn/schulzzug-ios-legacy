//
//  RegisterViewController.m
//  Schulzzug-iOS
//
//  Created by Niklas Riekenbrauck on 05.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

#import "RegisterViewController.h"
#import "Schulzzug_iOS-Swift.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)registerTapped:(UIButton *)sender {
    NSString *username = self.usernameTextField.text;
    [[DataProvider default] registerWithUsername:username];
}
@end
