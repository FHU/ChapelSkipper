//
//  Presentation.h
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 2/1/13.
//  Copyright (c) 2013 Richard Simpson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Presentation : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *speakerName;
@property (strong, nonatomic) NSDate *date;

- (id)initWithTitle:(NSString *)title SpeakerName:(NSString *)speakerName Date:(NSDate *)date;

@end
