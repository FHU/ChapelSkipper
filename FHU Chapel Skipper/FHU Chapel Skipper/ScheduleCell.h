//
//  ScheduleCell.h
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 2/7/13.
//  Copyright (c) 2013 Richard Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *dateImageView;
@property (strong, nonatomic) IBOutlet UILabel *speakerLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

- (int)getSizedHeight;
- (void)sizeHeight;

@end
