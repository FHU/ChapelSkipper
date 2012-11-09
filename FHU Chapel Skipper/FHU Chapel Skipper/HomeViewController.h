//
//  HomeViewController.h
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 9/28/12.
//  Copyright (c) 2012 Richard Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChapelQuotes.h"

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) ChapelQuotes *chapelQuotes;
@property (strong, nonatomic) IBOutlet UILabel *absencesLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *quoteView;
@property (strong, nonatomic) IBOutlet UIImageView *paperclip;
@property (strong, nonatomic) IBOutlet UITextView *quoteTextView;
@property (strong, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (strong, nonatomic) IBOutlet UIButton *facebookButton;
@property (strong, nonatomic) IBOutlet UIButton *tweetButton;
@property BOOL quoteViewIsShown;

- (IBAction)tappedQuoteView:(id)sender;
- (IBAction)sendTweet:(id)sender;
- (IBAction)shareFacebook:(id)sender;
- (IBAction)refreshQuote:(id)sender;

@end
