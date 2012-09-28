//
//  HomeViewController.m
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 9/28/12.
//  Copyright (c) 2012 Richard Simpson. All rights reserved.
// test change

#import "HomeViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

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
}

-(void) viewDidAppear:(BOOL)animated
{
    // Play bell sound on did appear
    [self playSound:@"two-bells" andExtension:@"mp3"];
}


/* http://stackoverflow.com/questions/10329291/play-a-short-sound-in-ios */
-(void) playSound: (NSString*) fileName andExtension:(NSString*) extension
{
    NSString *soundPath = [[NSBundle mainBundle] pathForResource: fileName ofType:extension];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
    AudioServicesPlaySystemSound (soundID);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
