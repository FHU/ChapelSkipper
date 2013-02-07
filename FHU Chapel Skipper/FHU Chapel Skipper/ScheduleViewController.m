//
//  ScheduleViewController.m
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 1/25/13.
//  Copyright (c) 2013 Richard Simpson. All rights reserved.
//

#import "ScheduleViewController.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController
@synthesize schedule = _schedule;
@synthesize sizes = _sizes;

- (id)initWithSchedule:(Schedule *)schedule NibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _schedule = schedule;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Set sizes
    _sizes = [[NSMutableArray alloc] init];
    
    for (Presentation *p in _schedule.presentations) {
        int height = [self sizeForText:p.title];
        [_sizes addObject:[NSNumber numberWithInt:height]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

- (int)sizeForText:(NSString *)text {
    static NSString *CellIdentifier = @"Cell";
    
    ScheduleCell *cell = (ScheduleCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        [[NSBundle mainBundle] loadNibNamed:@"ScheduleCell" owner:self options:nil];
        cell = [[ScheduleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell = [self scheduleCell];
    }
    
    cell.titleLabel.text = text;
    
    return cell.getSizedHeight;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor whiteColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    ScheduleCell *cell = (ScheduleCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        [[NSBundle mainBundle] loadNibNamed:@"ScheduleCell" owner:self options:nil];
        cell = [[ScheduleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell = [self scheduleCell];
    }
        
    Presentation *p = [_schedule.presentations objectAtIndex:indexPath.row];    
    cell.speakerLabel.text = p.speakerName;
    cell.titleLabel.text = p.title;
    
    [cell sizeHeight];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *height = [_sizes objectAtIndex:indexPath.row];
    
    return height.intValue;
}

#pragma mark - UITableViewDelegate


@end
