//
//  LoginViewController.h
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 9/27/12.
//  Copyright (c) 2012 Richard Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *applyButton;
@property (strong, nonatomic) IBOutlet UIImageView *logoImage;
@property (strong, nonatomic) UITextField *loginID;
@property (strong, nonatomic) UITextField *password;
@property (strong, nonatomic) UITextField *activeField;

- (IBAction)tappedBackground:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)apply:(id)sender;

@end
