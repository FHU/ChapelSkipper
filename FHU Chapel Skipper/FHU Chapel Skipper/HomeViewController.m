//
//  HomeViewController.m
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 9/28/12.
//  Copyright (c) 2012 Richard Simpson. All rights reserved.
// test change

#import "HomeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ChapelQuotes.h"
#import <Social/Social.h>
#import "LoginViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize delegate = _delegate;
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
    
    NSString *fullName = @"Richard Simpson";
    //fullName = user.name;
    
    _userLabel.text = [NSString stringWithFormat:@"Logged in as %@", fullName];
    
    //Border for iPad table
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        _tableView.layer.borderWidth = 1.0;
        _tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    
    self.widget.layer.cornerRadius = 10.0;
    
    _absenceModeAchieved = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

- (IBAction)sendTweet:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        int absences = _absencesLabel.text.intValue;
        
        NSString *tweetString = [NSString stringWithFormat:@"I have achieved %i chapel absences. #chapelskipper", absences];
        
        if (!_absenceModeAchieved)
            tweetString = [NSString stringWithFormat:@"I have %i chapel absences remaining. #chapelskipper", absences];
        
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
        
        if (!_absenceModeAchieved)
            fbString = [NSString stringWithFormat:@"I have %i chapel absences remaining.", absences];
        
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
    [_delegate logout];
}

- (IBAction)openSettings:(id)sender {
    [_delegate openSettings];
}

- (IBAction)toggleAbsenceMode:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    
    [_absencesLabel setAlpha:0];
    [_absenceModeLabel setAlpha:0];
    
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    [UIView commitAnimations];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [UIView beginAnimations:nil context:NULL];
    
    [_absencesLabel setAlpha:1.0];
    [_absenceModeLabel setAlpha:1.0];
    
    [UIView setAnimationDuration:0.1];
    [UIView commitAnimations];
    
    int maxAbsences = 12;
    int absencesAchieved = _absencesLabel.text.intValue;
    UIColor *color;
    
    if (_absenceModeAchieved) {
        //Show remaining absences
        _absenceModeAchieved = NO;
        _absenceModeLabel.text = @"ABSENCES REMAINING";
        color = [UIColor colorWithRed:0.855 green:0.78 blue:0.624 alpha:1]; /*#dac79f*/
        
    } else {
        //Show acquired absences
        _absenceModeAchieved = YES;
        _absenceModeLabel.text = @"ABSENCES ACHIEVED";
        color = [UIColor whiteColor];
    }
    
    _absencesLabel.text = [NSString stringWithFormat:@"%i", maxAbsences - absencesAchieved];
    _absencesLabel.textColor = color;
    _absenceModeLabel.textColor = color;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor whiteColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    /*ScheduleCell *cell = (ScheduleCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     
     if (!cell) {
     [[NSBundle mainBundle] loadNibNamed:@"ScheduleCell" owner:self options:nil];
     cell = [[ScheduleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
     
     cell = [self scheduleCell];
     }
     
     Presentation *p = [_schedule.presentations objectAtIndex:indexPath.row];
     cell.speakerLabel.text = p.speakerName;
     cell.titleLabel.text = p.title;
     
     [cell sizeHeight];
     
     return cell;*/
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *height = [_sizes objectAtIndex:indexPath.row];
    
    return height.intValue;
}
*/

#pragma mark - UITableViewDelegate

@end
