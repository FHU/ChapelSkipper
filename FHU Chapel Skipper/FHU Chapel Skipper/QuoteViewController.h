//
//  QuoteViewController.h
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 1/25/13.
//  Copyright (c) 2013 Richard Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChapelQuotes.h"

@interface QuoteViewController : UIViewController

@property (strong, nonatomic) ChapelQuotes *chapelQuotes;
@property (strong, nonatomic) IBOutlet UITextView *quoteTextView;
@property (strong, nonatomic) IBOutlet UIImageView *portraitImageView;

- (IBAction)refreshQuote:(id)sender;

@end
