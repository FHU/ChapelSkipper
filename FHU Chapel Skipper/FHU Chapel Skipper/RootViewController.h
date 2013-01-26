//
//  RootViewController.h
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 9/27/12.
//  Copyright (c) 2012 Richard Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "ScheduleViewController.h"
#import "QuoteViewController.h"

@interface RootViewController : UIViewController <HomeViewDelegate>

@property (strong, nonatomic) IBOutlet UINavigationController *navigationController;
@property (strong, nonatomic) IBOutlet HomeViewController *homeViewController;
@property (strong, nonatomic) ScheduleViewController *scheduleViewController;
@property (strong, nonatomic) QuoteViewController *quoteViewController;

- (IBAction)openSchedule:(id)sender;
- (IBAction)openQuotes:(id)sender;

@end
