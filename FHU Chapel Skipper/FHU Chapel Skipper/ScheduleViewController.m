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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Maroon and Gold Day";
            cell.detailTextLabel.text = @"Admissions";
            break;
        case 1:
            cell.textLabel.text = @"Guest Speaker";
            cell.detailTextLabel.text = @"Larry Calendine";
            break;
        case 2:
            cell.textLabel.text = @"Heaven: Jesus' Description";
            cell.detailTextLabel.text = @"Rolland Pack";
            break;
        case 3:
            cell.textLabel.text = @"Heaven: The Home of the Faithful";
            cell.detailTextLabel.text = @"Ben Flatt";
            break;
        case 4:
            cell.textLabel.text = @"Singing Day";
            cell.detailTextLabel.text = @"Stephen Foster";
            break;
        case 5:
            cell.textLabel.text = @"Student Lectureship";
            cell.detailTextLabel.text = @"";
            break;
        case 6:
            cell.textLabel.text = @"Student Lectureship";
            cell.detailTextLabel.text = @"";
            break;
        case 7:
            cell.textLabel.text = @"Student Lectureship";
            cell.detailTextLabel.text = @"";
            break;
        case 8:
            cell.textLabel.text = @"Hell: Jesus' Description";
            cell.detailTextLabel.text = @"Jesse Robertson";
            break;
        case 9:
            cell.textLabel.text = @"Hell: A Place for the Unrighteous";
            cell.detailTextLabel.text = @"Rocco Pierce";
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate


@end
