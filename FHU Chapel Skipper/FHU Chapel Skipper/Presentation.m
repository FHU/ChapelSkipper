//
//  Presentation.m
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 2/1/13.
//  Copyright (c) 2013 Richard Simpson. All rights reserved.
//

#import "Presentation.h"

@implementation Presentation
@synthesize title = _title;
@synthesize speakerName = _speakerName;
@synthesize date = _date;

- (id)initWithTitle:(NSString *)title SpeakerName:(NSString *)speakerName Date:(NSDate *)date {
    self = [super init];
    if (self) {
        _title = title;
        _speakerName = speakerName;
        _date = date;
    }
    return self;
}

@end
