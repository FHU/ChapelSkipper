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

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize delegate = _delegate;
@synthesize chapelQuotes = _chapelQuotes;
@synthesize absencesLabel = _absencesLabel;
@synthesize tableView = _tableView;
@synthesize facebookButton = _facebookButton;
@synthesize tweetButton = _tweetButton;
@synthesize absenceModeButton = _absenceModeButton;
@synthesize absenceModeLabel = _absenceModeLabel;
@synthesize isShowingAbsencesAchieved = _isShowingAbsencesAchieved;


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
    
    NSString *fullName = @"";
    //fullName = user.name;
    
    self.isShowingAbsencesAchieved = YES;
    
    _userLabel.text = [NSString stringWithFormat:@"Logged in as %@", fullName];
    
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
    [_delegate logout];
}

- (IBAction)openSettings:(id)sender {
    [_delegate openSettings];
}

- (IBAction)absenceModeButton:(id)sender {
    
    [self toggleAbsenceMode];
    
}

-(void) toggleAbsenceMode {
    int MAX_ALLOWED_ABSENCES = 12;
    
    if(self.isShowingAbsencesAchieved) {
        // Toggle to show absences remaining.
        self.isShowingAbsencesAchieved = NO;
        int absencesAchieved = _absencesLabel.text.intValue;
        
        int absencesRemaining = MAX_ALLOWED_ABSENCES - absencesAchieved;
        
        self.absencesLabel.text = [NSString stringWithFormat:@"%i", absencesRemaining];
        self.absenceModeLabel.text = @"ABSENCES LEFT";
        self.absenceModeLabel.textColor = [UIColor yellowColor];
        
    }
    else {
        // Toggle to show absences acheived.
        self.isShowingAbsencesAchieved = YES;
        
        int absencesRemaining = _absencesLabel.text.intValue;
        
        int absencesAchieved = MAX_ALLOWED_ABSENCES - absencesRemaining;
        
        self.absencesLabel.text = [NSString stringWithFormat:@"%i", absencesAchieved];
        self.absenceModeLabel.text = @"ABSENCES ACHIEVED";
        self.absenceModeLabel.textColor = [UIColor whiteColor];
        
    }
    
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
