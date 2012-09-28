//
//  RootViewController.m
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 9/27/12.
//  Copyright (c) 2012 Richard Simpson. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController
@synthesize navigationController;

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
    
    [self.view addSubview:navigationController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

- (IBAction)logout:(id)sender {
    //Ask user: Logout?
    
    //Return to login screen
    LoginViewController *login;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        login = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPhone" bundle:nil];
    } else {
        login = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPad" bundle:nil];
    }
    
    [self presentViewController:login animated:NO completion:nil];
}

@end
