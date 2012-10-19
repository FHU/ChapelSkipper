//
//  RootViewController.h
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 9/27/12.
//  Copyright (c) 2012 Richard Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

@property (strong, nonatomic) IBOutlet UINavigationController *navigationController;

- (IBAction)logout:(id)sender;
- (IBAction)openSettings:(id)sender;

@end
