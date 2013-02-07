//
//  SettingsViewController.h
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 2/6/13.
//  Copyright (c) 2013 Richard Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsDelegate <NSObject>

- (void)celebrityMode:(BOOL)enabled;

@end

@interface SettingsViewController : UIViewController

@property (assign, nonatomic) id<SettingsDelegate> delegate;
@property (strong, nonatomic) IBOutlet UISwitch *celebritySwitch;

- (IBAction)close:(id)sender;
- (IBAction)celebritySwitch:(id)sender;

@end
