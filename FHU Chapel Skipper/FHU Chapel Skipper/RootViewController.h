//
//  RootViewController.h
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 9/27/12.
//  Copyright (c) 2012 Richard Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Schedule.h"
#import "HomeViewController.h"
#import "ScheduleViewController.h"
#import "QuoteViewController.h"
#import "SettingsViewController.h"

@interface RootViewController : UIViewController <HomeViewDelegate, SettingsDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) Schedule *schedule;
@property (strong, nonatomic) IBOutlet UINavigationController *navigationController;
@property (strong, nonatomic) IBOutlet HomeViewController *homeViewController;
@property (strong, nonatomic) ScheduleViewController *scheduleViewController;
@property (strong, nonatomic) QuoteViewController *quoteViewController;
@property (strong, nonatomic) SettingsViewController *settingsViewController;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *quoteButton;

- (IBAction)openSchedule:(id)sender;
- (IBAction)openQuotes:(id)sender;

@end
