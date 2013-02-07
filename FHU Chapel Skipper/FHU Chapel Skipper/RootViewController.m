//
//  RootViewController.m
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 9/27/12.
//  Copyright (c) 2012 Richard Simpson. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"
#import "SettingsViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController
@synthesize navigationController;
@synthesize homeViewController = _homeViewController;
@synthesize scheduleViewController = _scheduleViewController;
@synthesize quoteViewController = _quoteViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
#warning Placeholder schedule init
    _schedule = [[Schedule alloc] init];
    
    [self.navigationController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:navigationController.view];
    [_homeViewController setDelegate:self];
    
    /*
    //Swipe gestures (buggy)
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    */
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(preloadSideViews) object:nil];
    [self performSelector:@selector(preloadSideViews) withObject:nil afterDelay:0.3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

- (void)preloadSideViews {
    if (!_scheduleViewController)
        _scheduleViewController = [[ScheduleViewController alloc] initWithSchedule:_schedule NibName:@"ScheduleViewController" bundle:nil];
    if (!_quoteViewController)
        _quoteViewController = [[QuoteViewController alloc] initWithNibName:@"QuoteViewController" bundle:nil];
    
    [self.revealSideViewController preloadViewController:_scheduleViewController forSide:PPRevealSideDirectionLeft];
    [self.revealSideViewController preloadViewController:_quoteViewController forSide:PPRevealSideDirectionRight];
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        //Open Quotes
        [self openQuotes:self];
    }
    else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        //Open Schedule
        [self openSchedule:self];
    }
}

- (IBAction)openSchedule:(id)sender {
    if (!_scheduleViewController)
        _scheduleViewController = [[ScheduleViewController alloc] initWithSchedule:_schedule NibName:@"ScheduleViewController" bundle:nil];
    
    [self.revealSideViewController pushViewController:_scheduleViewController onDirection:PPRevealSideDirectionLeft animated:YES];
}

- (IBAction)openQuotes:(id)sender {
    if (!_quoteViewController)
        _quoteViewController = [[QuoteViewController alloc] initWithNibName:@"QuoteViewController" bundle:nil];
    
    [self.revealSideViewController pushViewController:_quoteViewController onDirection:PPRevealSideDirectionRight animated:YES];
}

#pragma mark - HomeViewDelegate

- (void)logout {
    //Ask user: Logout?
    UIActionSheet *confirmation = [[UIActionSheet alloc] initWithTitle:@"Are you sure you want to log out?" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [confirmation showInView:self.view];
    
    /*
    //Return to login screen
    LoginViewController *login;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        login = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPhone" bundle:nil];
    } else {
        login = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPad" bundle:nil];
    }
    
    [self.revealSideViewController popViewControllerWithNewCenterController:login animated:YES];
    
    //    [self presentViewController:login animated:NO completion:nil];*/
}

- (void)openSettings {
    if (!_settingsViewController) {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            _settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController_iPhone" bundle:nil];
        } else {
            _settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController_iPad" bundle:nil];
        }
    }
    
    [_settingsViewController setDelegate:self];
    
    [self presentViewController:_settingsViewController animated:YES completion:nil];
}

#pragma mark - SettingsDelegate

- (void)celebrityMode:(BOOL)enabled {
    if (enabled) {
        NSLog(@"Celebrity mode enabled.");
    }
    else {
        NSLog(@"Celebrity mode disabled.");
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        //Return to login screen
        LoginViewController *login;
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            login = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPhone" bundle:nil];
        } else {
            login = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPad" bundle:nil];
        }
        
        [self.revealSideViewController popViewControllerWithNewCenterController:login animated:YES];
    }
    //Else do nothing
}

@end
