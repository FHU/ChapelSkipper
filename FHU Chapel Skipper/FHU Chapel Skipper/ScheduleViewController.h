//
//  ScheduleViewController.h
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 1/25/13.
//  Copyright (c) 2013 Richard Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Schedule.h"
#import "ScheduleCell.h"

@interface ScheduleViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) Schedule *schedule;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet ScheduleCell *scheduleCell;
@property (strong, nonatomic) NSMutableArray *sizes;

- (id)initWithSchedule:(Schedule *)schedule NibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

@end
