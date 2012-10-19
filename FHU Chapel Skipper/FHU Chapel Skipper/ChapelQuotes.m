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
               @"Too many people try to get something from worship without putting anything into it.",
               @"If we are going to fight for the liberty to worship, we may as well make use of that liberty.",
               @"“As a man worships, so is he” (So what does your attitude toward worship say about who you are?)",
               @"Worship does not bring God close to us; it brings us close to God.",
               @"You will not do anything more important today than worship God.",
               @"If a thousand people are doing something disrespectful, it is still disrespectful.",
               @"“I was glad when they said to me, ‘Let us go to the house of the Lord’” (Ps. 122:1).",
               @"“My help comes from the Lord, who made heaven and earth” (Ps. 121:2). Do you need his help? Then worship him today.",
               @"“Ascribe to the Lord the glory due his name...” (Ps. 96:8). Is the Lord worthy of our praise today too? Then let’s enter into worship to him.",
               @"The secret to failing to worship God is to forget all his blessings; the secret to worshiping him is to remember them.",
               @"“Let the redeemed of the Lord say so...” (Ps. 107:2). If the “redeemed of the Lord” do not say so, who will?",
               @"“Set your minds on things that are above, not on things that are on earth” (Col. 3:2).",
               @"Even when you’re having a truly bad day, you can worship God. Perhaps that is the day when you need to worship most of all. (Job 1:20)",
//               @"",
//               @"",
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
