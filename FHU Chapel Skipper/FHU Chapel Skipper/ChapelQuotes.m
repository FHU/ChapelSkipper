//
//  ChapelQuotes.m
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 10/6/12.
//  Copyright (c) 2012 Richard Simpson. All rights reserved.
//

#import "ChapelQuotes.h"

@implementation ChapelQuotes
@synthesize quotes = _quotes;

- (id)init {
    self = [super init];
    if (self) {
        [self initQuotesArray];
    }
    return self;
}

- (void)initQuotesArray {
    _quotes = [[NSMutableArray alloc] initWithObjects:
               @"Chapel is like an outhouse: you just have to keep going.",
               @"One does not simply skip chapel. Its glass doors are guarded by more than just Roy Sharp. The Great Eye is ever watchful.",
               @"Half the time I miss chapel, something awesome or memorable happens.",
               /*@"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",*/
               nil];
}

- (NSString *)generateRandomQuote {
    if (!_quotes) {
        [self initQuotesArray];
    }
    
    //Pick a quote at random from the quotes in the array
    int index = [self randomIntBetween:0 And:_quotes.count - 1];
    NSString *quote = [_quotes objectAtIndex:index];
    
    return quote;
}

- (int)randomIntBetween:(int)low And:(int)high {
    //Return a random integer number between low and high. Inclusive.
    return (arc4random() % (high - low + 1)) + low;
}

@end
