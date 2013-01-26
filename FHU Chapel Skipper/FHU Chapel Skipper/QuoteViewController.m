//
//  QuoteViewController.m
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 1/25/13.
//  Copyright (c) 2013 Richard Simpson. All rights reserved.
//

#import "QuoteViewController.h"

@interface QuoteViewController ()

@end

@implementation QuoteViewController

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
    
    _chapelQuotes = [[ChapelQuotes alloc] init];
    _quoteTextView.text = [_chapelQuotes generateRandomQuote];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

- (IBAction)refreshQuote:(id)sender {
    _quoteTextView.text = [_chapelQuotes generateRandomQuote];
}

@end
