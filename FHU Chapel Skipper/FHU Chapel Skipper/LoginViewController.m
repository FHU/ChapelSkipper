//
//  LoginViewController.m
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 9/27/12.
//  Copyright (c) 2012 Richard Simpson. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SVProgressHUD.h"
#import "RootViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize tableView;
@synthesize loginButton;
@synthesize applyButton;
@synthesize logoImage;
@synthesize loginID, password;
@synthesize activeField;

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
    [self registerForKeyboardNotifications];

    //Style the buttons
    [loginButton.layer setCornerRadius:5.0];
    [loginButton.layer setMasksToBounds:YES];
    [applyButton.layer setCornerRadius:5.0];
    [applyButton.layer setMasksToBounds:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

- (IBAction)tappedBackground:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)login:(id)sender {
    [self.view endEditing:YES];
    
    [SVProgressHUD show];
    //Logging in
    
    //If successful, push home controller
    [self performSelector:@selector(push) withObject:nil afterDelay:1.0];
    
    //Otherwise, notify failure
    //Foghorn
}

- (IBAction)apply:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.fhu.edu/apply"]];
}

- (void)push {
    [SVProgressHUD dismiss];
    
    //Create and display the main controller
    RootViewController *main;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        main = [[RootViewController alloc] initWithNibName:@"RootViewController_iPhone" bundle:nil];
    } else {
        main = [[RootViewController alloc] initWithNibName:@"RootViewController_iPad" bundle:nil];
    }
    
    [self presentViewController:main animated:NO completion:nil];
}

- (void)unregisterForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillBeShown:(NSNotification *)notification {
    //If iPad, return; no need to make room for the keyboard
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return;
    }
    
    //Begin animation
    [UIView beginAnimations:nil context:NULL];
    
    [self.tableView setFrame:CGRectMake(self.tableView.frame.origin.x,
                                        self.tableView.frame.origin.y - 80,
                                        self.tableView.frame.size.width,
                                        self.tableView.frame.size.width)];
    [self.loginButton setFrame:CGRectMake(self.loginButton.frame.origin.x,
                                          self.loginButton.frame.origin.y - 80,
                                          self.loginButton.frame.size.width,
                                          self.loginButton.frame.size.height)];
    [self.logoImage setFrame:CGRectMake(self.logoImage.frame.origin.x,
                                        self.logoImage.frame.origin.y - 50,
                                        self.logoImage.frame.size.width,
                                        self.logoImage.frame.size.height)];
    [UIView setAnimationDuration:0.3];
    [UIView commitAnimations];
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    //If iPad, return; no need to make room for the keyboard
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return;
    }
    
    //Begin animation
    [UIView beginAnimations:nil context:NULL];
    
    [self.tableView setFrame:CGRectMake(self.tableView.frame.origin.x,
                                        self.tableView.frame.origin.y + 80,
                                        self.tableView.frame.size.width,
                                        self.tableView.frame.size.width)];
    [self.loginButton setFrame:CGRectMake(self.loginButton.frame.origin.x,
                                          self.loginButton.frame.origin.y + 80,
                                          self.loginButton.frame.size.width,
                                          self.loginButton.frame.size.height)];
    [self.logoImage setFrame:CGRectMake(self.logoImage.frame.origin.x,
                                        self.logoImage.frame.origin.y + 50,
                                        self.logoImage.frame.size.width,
                                        self.logoImage.frame.size.height)];
    [UIView setAnimationDuration:0.3];
    [UIView commitAnimations];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //Configure the cell
    activeField = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, 260, 21)];
    [activeField setReturnKeyType:UIReturnKeyGo];
    [activeField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [activeField setClearButtonMode:UITextFieldViewModeWhileEditing];
    
    if (indexPath.row == 0) {
        loginID = activeField;
        [loginID setPlaceholder:@"Username"];
        [loginID setDelegate:self];
        [cell setAccessoryView:loginID];
    }
    if (indexPath.row == 1) {
        password = activeField;
        [password setPlaceholder:@"Password"];
        [password setSecureTextEntry:YES];
        [password setDelegate:self];
        [cell setAccessoryView:password];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    NSLog(@"Begin editing");
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//    NSLog(@"End editing");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //Handle tap "Return"
    [self login:self.loginButton];
    
    return YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
