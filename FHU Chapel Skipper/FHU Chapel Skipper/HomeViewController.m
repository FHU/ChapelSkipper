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
#import <QuartzCore/QuartzCore.h>

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize chapelQuotes = _chapelQuotes;
@synthesize absencesLabel = _absencesLabel;
@synthesize tableView = _tableView;
@synthesize quoteView = _quoteView;
@synthesize paperclip = _paperclip;
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
        [_paperclip setFrame:CGRectMake(_paperclip.frame.origin.x,
                                        _paperclip.frame.origin.y + 130,
                                        _paperclip.frame.size.width,
                                        _paperclip.frame.size.height)];
        _quoteViewIsShown = FALSE;
        
        self.arrowImageView.image = [UIImage imageNamed:@"circle_arrow_up"];
    }
    else {
        [_quoteView setFrame:CGRectMake(_quoteView.frame.origin.x,
                                        _quoteView.frame.origin.y - 130,
                                        _quoteView.frame.size.width,
                                        _quoteView.frame.size.width)];
        [_paperclip setFrame:CGRectMake(_paperclip.frame.origin.x,
                                        _paperclip.frame.origin.y - 130,
                                        _paperclip.frame.size.width,
                                        _paperclip.frame.size.height)];
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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Chapel Schedule";
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    int sectionHeaderHeight = 30;
    
    // Create the view for the header
    CGRect aFrame =CGRectMake(0, 0, tableView.contentSize.width, sectionHeaderHeight);
    UIView * aView = [[UIView alloc] initWithFrame:aFrame];
    aView.backgroundColor = UIColor.clearColor;
    
    // Create a stretchable image for the background that emulates the default gradient, only in green
    UIImage *viewBackgroundImage = [[UIImage imageNamed:@"applyButtonBackground.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    
    // Cannot set this image directly as the background of the cell because
    // the background needs to be offset by 1pix at the top to cover the previous cell border (Alex Deplov's requirement ^_^)
    CALayer *backgroungLayer = [CALayer layer];
    
    backgroungLayer.frame = CGRectMake(0, -1, tableView.contentSize.width, sectionHeaderHeight+1);
    backgroungLayer.contents = (id) viewBackgroundImage.CGImage;
    backgroungLayer.masksToBounds = NO;
    backgroungLayer.opacity = 0.9;
    [aView.layer addSublayer:backgroungLayer];
    
    // Take care of the section title now
    UILabel *aTitle = [[UILabel alloc] initWithFrame: CGRectMake(10, 0, aView.bounds.size.width-10, aView.bounds.size.height)];
    aTitle.text = @"Chapel Schedule"; //[self tableView:tableView titleForHeaderInSection:section];
    aTitle.textAlignment = NSTextAlignmentLeft;
    aTitle.backgroundColor = UIColor.clearColor;
    aTitle.font = [UIFont boldSystemFontOfSize:20];
    aTitle.textColor = UIColor.whiteColor;
    
    
    //UIColor * color = [UIColor whiteColor];
    UIColor * color = [UIColor blackColor];
    
    // Text shadow
    aTitle.layer.shadowOffset = CGSizeMake(0, 1);
    aTitle.layer.shadowRadius = .2;
    aTitle.layer.masksToBounds = NO;
    aTitle.layer.shadowOpacity = 0.5;
    aTitle.layer.shadowColor = (__bridge CGColorRef)(color);
    [aView addSubview:aTitle];
    
    return aView;
}

/*-(NSInteger) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 30;
}*/

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor whiteColor];
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

#pragma mark - UITableViewDelegate



@end
