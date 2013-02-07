//
//  ScheduleCell.m
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 2/7/13.
//  Copyright (c) 2013 Richard Simpson. All rights reserved.
//

#import "ScheduleCell.h"

@implementation ScheduleCell
@synthesize speakerLabel = _speakerLabel, titleLabel = _titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Custom methods

- (int)getSizedHeight {
    [_titleLabel sizeToFit];
    
    return _titleLabel.frame.size.height + 55;
    
    if (_titleLabel.frame.size.height < 30)
        return 96;
    else
        return _titleLabel.frame.size.height + 50;
}

- (void)sizeHeight {
    [_titleLabel sizeToFit];
}

@end
