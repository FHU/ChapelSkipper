//
//  LoginViewController.m
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 9/27/12.
//  Copyright (c) 2012 Richard Simpson. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import "SVProgressHUD.h"
#import "RootViewController.h"
#import "CAS.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize tableView = _tableView;
@synthesize loginButton = _loginButton;
@synthesize applyButton = _applyButton;
@synthesize logoImage = _logoImage;
@synthesize loginID = _loginID;
@synthesize password = _password;
@synthesize activeField = _activeField;

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
    [_loginButton.layer setCornerRadius:5.0];
    [_loginButton.layer setMasksToBounds:YES];
    [_applyButton.layer setCornerRadius:5.0];
    [_applyButton.layer setMasksToBounds:YES];
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
    /**
    NSString *errorMessage = @"";
    
    if (!_loginID.text)
        errorMessage = @"Please enter your username";
    if (!_password.text)
        errorMessage = [NSString stringWithFormat:@"%@ \nPlease enter your password", errorMessage];
    
    if (![errorMessage isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [SVProgressHUD show];
    //Logging in
    NSString *username = _loginID.text;
    NSString *password = _password.text;
    NSString *casServer = @"https://dc02.fhu.edu";
    NSString *casRestletPath = @"/cas/v1/tickets/";
    
    [[CAS client] initWithCasServer:casServer
                        restletPath:casRestletPath
                           username:username
                           password:password
                    authCallbackObj:self
               authCallbackSelector:@selector(authFinishedWithStatusCode:)];
    /**/
    //If successful, push home controller
    [self performSelector:@selector(push) withObject:nil afterDelay:1.0];
    /**/
    //Otherwise, notify failure
    //Foghorn
}

- (void)authFinishedWithStatusCode:(NSNumber *)statusNumber {
	int statusCode = [statusNumber intValue];
	
	NSLog(@"Authentication Results: %i", statusCode);
	
	// Handle authentication success/failures here
	switch (statusCode) {
		case 201:
			[self authSuccess];
			break;
		case 400:
			[self authFail:@"Invalid credentials"];
			break;
		case 0:
			[self authFail:@"No connection available"];
			break;
		default:
			[self authFail:@"Encountered unknown status code"];
			break;
	}
}

- (void)authSuccess {
    NSLog(@"Authentication succeeded.");
    
    //Service URL for testing data retrieval
	NSURL *casProtectedService = [NSURL URLWithString:@"http://host.example.com/service-request/"];
    
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:casProtectedService];
	[[CAS client] sendAsyncRequest:request callbackObj:self callbackSelector:@selector(requestFinishedWithDetails:)];
}

- (void)authFail:(NSString *)details {
    [SVProgressHUD dismiss];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Authentication Failed"
                                                    message:details
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)requestFinishedWithDetails:(NSMutableDictionary *)details {
    //Check for error
    if ([details objectForKey:@"error"]) {
        NSLog(@"Error found");
        return;
    }
    
    //Get response
    NSURLResponse *response = [details objectForKey:@"response"];
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        int responseCode = [(NSHTTPURLResponse *)response statusCode];
		switch (responseCode) {
			case 200: {
				NSLog(@"Request returned successful");
				NSString *responseBody = [[NSString alloc] initWithData:[details objectForKey:@"data"]
															   encoding:NSUTF8StringEncoding];
				NSLog(@"Response Headers: %@", [(NSHTTPURLResponse *)response allHeaderFields]);
				NSLog(@"Response Body: %@", responseBody);
				break;
            }
			case 404:
				NSLog(@"Error: 404 not found");
				break;
			default: {
				NSString *msg = [NSString stringWithFormat:@"Don't know what to do with status code: %d", responseCode];
				NSLog(@"%@", msg);
				break;
			}
        }
    }
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
    
    [self.revealSideViewController popViewControllerWithNewCenterController:main animated:YES];
    
//    [self presentViewController:main animated:NO completion:nil];
    [self playSound:@"two-bells" andExtension:@"mp3"];
}

/* http://stackoverflow.com/questions/10329291/play-a-short-sound-in-ios */
- (void)playSound:(NSString *)fileName andExtension:(NSString *)extension {
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:fileName ofType:extension];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundPath], &soundID);
    AudioServicesPlaySystemSound (soundID);
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
    _activeField = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, 260, 21)];
    [_activeField setReturnKeyType:UIReturnKeyGo];
    [_activeField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_activeField setClearButtonMode:UITextFieldViewModeWhileEditing];
    
    if (indexPath.row == 0) {
        _loginID = _activeField;
        [_loginID setPlaceholder:@"Username"];
        [_loginID setDelegate:self];
        [cell setAccessoryView:_loginID];
    }
    if (indexPath.row == 1) {
        _password = _activeField;
        [_password setPlaceholder:@"Password"];
        [_password setSecureTextEntry:YES];
        [_password setDelegate:self];
        [cell setAccessoryView:_password];
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
