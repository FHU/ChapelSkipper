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
@synthesize chapelQuotes = _chapelQuotes;
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
    
    //Instantiate quotes
    _chapelQuotes = [[ChapelQuotes alloc] init];
    
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
    _quoteTextView.text = [_chapelQuotes generateRandomQuote];
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
- (void)playSound:(NSString *)fileName andExtension:(NSString *)extension {
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
                                        _quoteView.frame.origin.y + 130,
                                        _quoteView.frame.size.width,
                                        _quoteView.frame.size.width)];
        _quoteViewIsShown = FALSE;
        
        self.arrowImageView.image = [UIImage imageNamed:@"circle_arrow_up"];
    }
    else {
        [_quoteView setFrame:CGRectMake(_quoteView.frame.origin.x,
                                        _quoteView.frame.origin.y - 130,
                                        _quoteView.frame.size.width,
                                        _quoteView.frame.size.width)];
        _quoteViewIsShown = TRUE;
        
        self.arrowImageView.image = [UIImage imageNamed:@"circle_arrow_down"];
    }
    
    
    //Commit animation
    [UIView setAnimationDuration:0.3];
    [UIView commitAnimations];
}

- (IBAction)sendTweet:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        int absences = _absencesLabel.text.intValue;
        
        NSString *tweetString = [NSString stringWithFormat:@"I have %i chapel absences. #chapelskipper", absences];
        
        [tweetSheet setInitialText:tweetString];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                            message:@"You can't send a tweet right now. Make sure your device has an internet connection and you have at least one Twitter account set up."
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
        
        NSString *fbString = [NSString stringWithFormat:@"I have %i chapel absences.", absences];
        
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

- (IBAction)refreshQuote:(id)sender {
    _quoteTextView.text = [_chapelQuotes generateRandomQuote];
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
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Maroon and Gold Day";
            cell.detailTextLabel.text = @"Admissions";
            break;
        case 1:
            cell.textLabel.text = @"Guest Speaker";
            cell.detailTextLabel.text = @"Larry Calendine";
            break;
        case 2:
            cell.textLabel.text = @"Heaven: Jesus' Description";
            cell.detailTextLabel.text = @"Rolland Pack";
            break;
        case 3:
            cell.textLabel.text = @"Heaven: The Home of the Faithful";
            cell.detailTextLabel.text = @"Ben Flatt";
            break;
        case 4:
            cell.textLabel.text = @"Singing Day";
            cell.detailTextLabel.text = @"Stephen Foster";
            break;
        case 5:
            cell.textLabel.text = @"Student Lectureship";
            cell.detailTextLabel.text = @"";
            break;
        case 6:
            cell.textLabel.text = @"Student Lectureship";
            cell.detailTextLabel.text = @"";
            break;
        case 7:
            cell.textLabel.text = @"Student Lectureship";
            cell.detailTextLabel.text = @"";
            break;
        case 8:
            cell.textLabel.text = @"Hell: Jesus' Description";
            cell.detailTextLabel.text = @"Jesse Robertson";
            break;
        case 9:
            cell.textLabel.text = @"Hell: A Place for the Unrighteous";
            cell.detailTextLabel.text = @"Rocco Pierce";
            break;
        default:
            break;
    }
    
    return cell;
}

@end
