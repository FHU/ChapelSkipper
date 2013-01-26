//
//  RootViewController.m
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 9/27/12.
//  Copyright (c) 2012 Richard Simpson. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"

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
    
    [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
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
        _scheduleViewController = [[ScheduleViewController alloc] initWithNibName:@"ScheduleViewController" bundle:nil];
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
        _scheduleViewController = [[ScheduleViewController alloc] initWithNibName:@"ScheduleViewController" bundle:nil];
    
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
    
    //Return to login screen
    LoginViewController *login;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        login = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPhone" bundle:nil];
    } else {
        login = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPad" bundle:nil];
    }
    
    [self.revealSideViewController popViewControllerWithNewCenterController:login animated:YES];
    
    //    [self presentViewController:login animated:NO completion:nil];
}

- (void)openSettings {
    
}

@end
