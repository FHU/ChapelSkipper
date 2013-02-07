//
//  LoadViewController.m
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 2/1/13.
//  Copyright (c) 2013 Richard Simpson. All rights reserved.
//

#import "LoadViewController.h"
#import "SVProgressHUD.h"

@interface LoadViewController ()

@end

@implementation LoadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        /*
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(scheduleUpdated)
                                                     name:SCHEDULE_UPDATED_NOTIFICATION
                                                   object:nil];
        */
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

- (void)scheduleUpdated {
    //Go to home.
}

- (void)goToHome {
    
}

@end
