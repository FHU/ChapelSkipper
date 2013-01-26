//
//  HomeViewController.h
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 9/28/12.
//  Copyright (c) 2012 Richard Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChapelQuotes.h"

@protocol HomeViewDelegate <NSObject>

- (void)logout;
- (void)openSettings;

@end

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) id<HomeViewDelegate> delegate;
@property (strong, nonatomic) ChapelQuotes *chapelQuotes;
@property (strong, nonatomic) IBOutlet UILabel *absencesLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *facebookButton;
@property (strong, nonatomic) IBOutlet UIButton *tweetButton;
@property (strong, nonatomic) IBOutlet UIView *widget;

- (IBAction)sendTweet:(id)sender;
- (IBAction)shareFacebook:(id)sender;
- (IBAction)logout:(id)sender;
- (IBAction)openSettings:(id)sender;

@end
