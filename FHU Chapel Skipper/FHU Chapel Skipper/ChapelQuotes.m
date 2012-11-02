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
@synthesize celebrityQuotes = _celebrityQuotes;
@synthesize celebrityEnabled = _celebrityEnabled;

- (id)init {
    self = [super init];
    if (self) {
        [self initQuotesArrays];
    }
    return self;
}

- (void)initQuotesArrays {
    _quotes = [[NSMutableArray alloc] init];
    _celebrityQuotes = [[NSMutableArray alloc] init];

    //Standard quotes
    Quote *q1 = [[Quote alloc] initWithQuote:@"Chapel is like an outhouse: you just have to keep going."
                                   andAuthor:@"Paul Fader"];
    Quote *q2 = [[Quote alloc] initWithQuote:@"One does not simply skip chapel. Its glass doors are guarded by more than just Roy Sharp. The Great Eye is ever watchful."
                                   andAuthor:@"Kenan Casey"];
    Quote *q3 = [[Quote alloc] initWithQuote:@"Half the time I miss chapel, something awesome or memorable happens."
                                   andAuthor:@"Wayne Scott"];
    Quote *q4 = [[Quote alloc] initWithQuote:@"Too many people try to get something from worship without putting anything into it."
                                   andAuthor:@"Stan Mitchell"];
    Quote *q5 = [[Quote alloc] initWithQuote:@"If we are going to fight for the liberty to worship, we may as well make use of that liberty."
                                   andAuthor:@"Stan Mitchell"];
    Quote *q6 = [[Quote alloc] initWithQuote:@"“As a man worships, so is he” (So what does your attitude toward worship say about who you are?)"
                                   andAuthor:@"Stan Mitchell"];
    Quote *q7 = [[Quote alloc] initWithQuote:@"Worship does not bring God close to us; it brings us close to God."
                                   andAuthor:@"Stan Mitchell"];
    Quote *q8 = [[Quote alloc] initWithQuote:@"You will not do anything more important today than worship God."
                                   andAuthor:@"Stan Mitchell"];
    Quote *q9 = [[Quote alloc] initWithQuote:@"If a thousand people are doing something disrespectful, it is still disrespectful."
                                   andAuthor:@"Stan Mitchell"];
    Quote *q10 = [[Quote alloc] initWithQuote:@"“I was glad when they said to me, ‘Let us go to the house of the Lord’” (Ps. 122:1)."
                                    andAuthor:@"Stan Mitchell"];
    Quote *q11 = [[Quote alloc] initWithQuote:@"“My help comes from the Lord, who made heaven and earth” (Ps. 121:2). Do you need his help? Then worship him today."
                                    andAuthor:@"Stan Mitchell"];
    Quote *q12 = [[Quote alloc] initWithQuote:@"“Ascribe to the Lord the glory due his name...” (Ps. 96:8). Is the Lord worthy of our praise today too? Then let’s enter into worship to him."
                                    andAuthor:@"Stan Mitchell"];
    Quote *q13 = [[Quote alloc] initWithQuote:@"The secret to failing to worship God is to forget all his blessings; the secret to worshiping him is to remember them."
                                    andAuthor:@"Stan Mitchell"];
    Quote *q14 = [[Quote alloc] initWithQuote:@"“Let the redeemed of the Lord say so...” (Ps. 107:2). If the “redeemed of the Lord” do not say so, who will?"
                                    andAuthor:@"Stan Mitchell"];
    Quote *q15 = [[Quote alloc] initWithQuote:@"“Set your minds on things that are above, not on things that are on earth” (Col. 3:2)."
                                    andAuthor:@"Stan Mitchell"];
    Quote *q16 = [[Quote alloc] initWithQuote:@"Even when you’re having a truly bad day, you can worship God. Perhaps that is the day when you need to worship most of all. (Job 1:20)"
                                    andAuthor:@"Stan Mitchell"];
    Quote *q17 = [[Quote alloc] initWithQuote:@"Chapel is an opportunity to present yourself before God with so many people alongside you doing the same thing to the best of their ability."
                                    andAuthor:@"Scott Huff"];
    Quote *q18 = [[Quote alloc] initWithQuote:@"Fellowship is something that can disappear quickly on this earth. Best we fight to partake of it while we can."
                                    andAuthor:@"Scott Huff"];
    
    
    [_quotes addObject:q1];
    [_quotes addObject:q2];
    [_quotes addObject:q3];
    [_quotes addObject:q4];
    [_quotes addObject:q5];
    [_quotes addObject:q6];
    [_quotes addObject:q7];
    [_quotes addObject:q8];
    [_quotes addObject:q9];
    [_quotes addObject:q10];
    [_quotes addObject:q11];
    [_quotes addObject:q12];
    [_quotes addObject:q13];
    [_quotes addObject:q14];
    [_quotes addObject:q15];
    [_quotes addObject:q16];
    [_quotes addObject:q17];
    [_quotes addObject:q18];
    
    //Celebrity Quotes
    Quote *cq1 = [[Quote alloc] initWithQuote:@"Go to chapel, you must."
                                    andAuthor:@"Yoda"];
    Quote *cq2 = [[Quote alloc] initWithQuote:@"Skipping chapel? Bazinga!"
                                    andAuthor:@"Sheldon Cooper"];
    Quote *cq3 = [[Quote alloc] initWithQuote:@"It's ok to skip chapel to sleep... I'll just be over here in the corner watching you."
                                    andAuthor:@"Edward Cullen"];
    Quote *cq4 = [[Quote alloc] initWithQuote:@"Chapel. It's like a drug to me. It's like my own personal brand of heroin."
                                    andAuthor:@"Edward Cullen"];
    Quote *cq5 = [[Quote alloc] initWithQuote:@"To Chapel, and beyond!"
                                    andAuthor:@"Buzz Lightyear"];
    Quote *cq6 = [[Quote alloc] initWithQuote:@"Don't be a cotton-headed ninnymuggins. Go to Chapel!"
                                    andAuthor:@"Buddy the Elf"];
    Quote *cq7 = [[Quote alloc] initWithQuote:@"Chapel. Chapel is what bwings us togethew today. Chapel, that bwessed awwangement, that dweam within a dweam."
                                    andAuthor:@"Impressive Clergyman"];
    Quote *cq8 = [[Quote alloc] initWithQuote:@"Baby, baby, baby, OHHHHHH, I thought you'd always be in chapel."
                                    andAuthor:@"Justin Bieber"];
    
    [_celebrityQuotes addObject:cq1];
    [_celebrityQuotes addObject:cq2];
    [_celebrityQuotes addObject:cq3];
    [_celebrityQuotes addObject:cq4];
    [_celebrityQuotes addObject:cq5];
    [_celebrityQuotes addObject:cq6];
    [_celebrityQuotes addObject:cq7];
    [_celebrityQuotes addObject:cq8];
}

- (NSString *)generateRandomQuote {
    if (!_quotes || !_celebrityQuotes) {
        [self initQuotesArrays];
    }
    
    Quote *q;
    
    if (!_celebrityEnabled) {
        //Pick a quote at random from the quotes in the array
        int index = [self randomIntBetween:0 And:_quotes.count - 1];
        q = [_quotes objectAtIndex:index];
    }
    else {
        //Pick a quote at random from the celebrity quotes in the array
        int index = [self randomIntBetween:0 And:_celebrityQuotes.count - 1];
        q = [_celebrityQuotes objectAtIndex:index];
    }
    
    return q.quote;
}

- (int)randomIntBetween:(int)low And:(int)high {
    //Return a random integer number between low and high. Inclusive.
    return (arc4random() % (high - low + 1)) + low;
}

@end
