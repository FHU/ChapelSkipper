//
//  Schedule.m
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 2/1/13.
//  Copyright (c) 2013 Richard Simpson. All rights reserved.
//

#import "Schedule.h"

@implementation Schedule
@synthesize presentations = _presentations;

- (id)init {
    self = [super init];
    if (self) {
        [self getData];
    }
    return self;
}

- (void)getData {
    //Read the data source
    /*
    NSURL = [NSURL URLWithString:@""];
    
    */
    
    //Save presentations
    /*
    _presentations = [[NSMutableArray alloc] init];
    
    for ([object] in [feed.objects]) {
        [_presentations addObject:[object]];
    }
    */
    
#warning Placeholder data
    Presentation *p1 = [[Presentation alloc] initWithTitle:@"Maroon and Gold Day"
                                               SpeakerName:@"Admissions"
                                                      Date:nil];
    Presentation *p2 = [[Presentation alloc] initWithTitle:@"Guest Speaker"
                                               SpeakerName:@"Larry Calendine"
                                                      Date:nil];
    Presentation *p3 = [[Presentation alloc] initWithTitle:@"Heaven: Jesus' Description"
                                               SpeakerName:@"Rolland Pack"
                                                      Date:nil];
    Presentation *p4 = [[Presentation alloc] initWithTitle:@"Heaven: The Home of the Faithful"
                                               SpeakerName:@"Ben Flatt"
                                                      Date:nil];
    Presentation *p5 = [[Presentation alloc] initWithTitle:@"Singing Day"
                                               SpeakerName:@"Stephen Foster"
                                                      Date:nil];
    Presentation *p6 = [[Presentation alloc] initWithTitle:@"Student Lectureship"
                                               SpeakerName:@""
                                                      Date:nil];
    Presentation *p7 = [[Presentation alloc] initWithTitle:@"Student Lectureship"
                                               SpeakerName:@""
                                                      Date:nil];
    Presentation *p8 = [[Presentation alloc] initWithTitle:@"Student Lectureship"
                                               SpeakerName:@""
                                                      Date:nil];
    Presentation *p9 = [[Presentation alloc] initWithTitle:@"Hell: Jesus' Description"
                                               SpeakerName:@"Jesse Robertson"
                                                      Date:nil];
    Presentation *p10 = [[Presentation alloc] initWithTitle:@"Hell: A Place for the Unrighteous"
                                                SpeakerName:@"Rocco Pierce"
                                                       Date:nil];
    
    _presentations = [[NSMutableArray alloc] init];
    
    [_presentations addObject:p1];
    [_presentations addObject:p2];
    [_presentations addObject:p3];
    [_presentations addObject:p4];
    [_presentations addObject:p5];
    [_presentations addObject:p6];
    [_presentations addObject:p7];
    [_presentations addObject:p8];
    [_presentations addObject:p9];
    [_presentations addObject:p10];
}

/*
- (id)initWithPresentations:(NSMutableArray *)presentations {
    self = [super init];
    if (self) {
        _presentations = presentations;
        
        //
    }
    return self;
}
*/
@end
