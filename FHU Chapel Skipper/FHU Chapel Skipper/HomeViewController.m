//
//  HomeViewController.m
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 9/28/12.
//  Copyright (c) 2012 Richard Simpson. All rights reserved.
// test change

#import "HomeViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>
#import "ChapelQuotes.h"
#import <Social/Social.h>
#import "LoginViewController.h"

// This is defined in Math.h
#define M_PI   3.14159265358979323846264338327950288   /* pi */

// Our conversion definition
#define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI)

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize chapelQuotes = _chapelQuotes;
@synthesize absencesLabel = _absencesLabel;
@synthesize tableView = _tableView;
@synthesize facebookButton = _facebookButton;
@synthesize tweetButton = _tweetButton;

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
    
    //Border for iPad table
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        _tableView.layer.borderWidth = 1.0;
        _tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    
    self.widget.layer.cornerRadius = 10.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    //Consider looping a single bell sound for each absence.
    /*
    int absences = [self.absencesLabel.text intValue];
    
    for (int count = 0; count < absences; count++) {
        //Play the sound
        [self playSound:@"oneBell" andExtension:@"mp3"];
        
        //Count the number along the way?
        //animate number change
    }
    */
    
    //Play bell sound
    [self playSound:@"two-bells" andExtension:@"mp3"];    
}

#pragma mark - Custom methods

/* http://stackoverflow.com/questions/10329291/play-a-short-sound-in-ios */
- (void)playSound:(NSString *)fileName andExtension:(NSString *)extension {
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:fileName ofType:extension];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundPath], &soundID);
    AudioServicesPlaySystemSound (soundID);
}

- (IBAction)sendTweet:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        int absences = _absencesLabel.text.intValue;
        
        NSString *tweetString = [NSString stringWithFormat:@"I have achieved %i chapel absences. #chapelskipper", absences];
        
        [tweetSheet setInitialText:tweetString];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                            message:@"You can't send a tweet. Make sure your device has an internet connection and you have a Twitter account set up."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)shareFacebook:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *fbSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        int absences = _absencesLabel.text.intValue;
        
        NSString *fbString = [NSString stringWithFormat:@"I have achieved %i chapel absences.", absences];
        
        [fbSheet setInitialText:fbString];
        [self presentViewController:fbSheet animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                            message:@"You can't share on Facebook. Make sure your device has an internet connection and you have a Facebook account set up."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)logout:(id)sender {
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

- (IBAction)openSettings:(id)sender {
    
}

@end
