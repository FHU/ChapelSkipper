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

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize absencesLabel = _absencesLabel;
@synthesize tableView = _tableView;
@synthesize quoteView = _quoteView;
@synthesize quoteTextView = _quoteTextView;
@synthesize facebookButton = _facebookButton;
@synthesize tweetButton = _tweetButton;
@synthesize quoteViewIsShown = _quoteViewIsShown;


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
    
    _quoteViewIsShown = NO;
    
    //Border for iPad table
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        _tableView.layer.borderWidth = 1.0;
        _tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    //Generate a random chapel quote
    ChapelQuotes *chapelQuotes = [[ChapelQuotes alloc] init];
    
    _quoteTextView.text = [chapelQuotes generateRandomQuote];
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
    
    [self performSelector:@selector(toggleQuoteView) withObject:nil afterDelay:0.3];
}

#pragma mark - Custom methods

/* http://stackoverflow.com/questions/10329291/play-a-short-sound-in-ios */
- (void)playSound: (NSString*) fileName andExtension:(NSString*) extension {
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:fileName ofType:extension];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundPath], &soundID);
    AudioServicesPlaySystemSound (soundID);
}

- (IBAction)tappedQuoteView:(id)sender {
    [self toggleQuoteView];
}

- (void)toggleQuoteView {
    //Begin animation
    [UIView beginAnimations:nil context:NULL];
    
    if (_quoteViewIsShown) {
        [_quoteView setFrame:CGRectMake(_quoteView.frame.origin.x,
                                        _quoteView.frame.origin.y + 120,
                                        _quoteView.frame.size.width,
                                        _quoteView.frame.size.width)];
        _quoteViewIsShown = FALSE;
    }
    else {
        [_quoteView setFrame:CGRectMake(_quoteView.frame.origin.x,
                                        _quoteView.frame.origin.y - 120,
                                        _quoteView.frame.size.width,
                                        _quoteView.frame.size.width)];
        _quoteViewIsShown = TRUE;
    }
    
    //Commit animation
    [UIView setAnimationDuration:0.3];
    [UIView commitAnimations];
}

- (IBAction)sendTweet:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        NSString *tweetString = [NSString stringWithFormat:@"I have %@ chapel absences. #chapelSkipper", self.absencesLabel.text];
        
        [tweetSheet setInitialText: tweetString];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup."
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)shareFacebook:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        NSString *fbString = [NSString stringWithFormat:@"I have %@ chapel absences.", self.absencesLabel.text];
        
        [fbSheet setInitialText: fbString];
        [self presentViewController:fbSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't share on Facebook, make sure your device has an internet connection and you have a Facebook account setup."
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Presentation %i", indexPath.row + 1];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Speaker %i", indexPath.row + 1];
    
    return cell;
}

@end
