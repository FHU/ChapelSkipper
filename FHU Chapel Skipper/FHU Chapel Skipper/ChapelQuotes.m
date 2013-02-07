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
    Quote *q11 = [[Quote alloc] initWithQuote:@"“I will lift up my eyes to the hills. From where does my help come? My help comes from the Lord, who made heaven and earth” (Ps. 121:2). Do you need his help? Then worship him today."
                                    andAuthor:@"Stan Mitchell"];
    Quote *q12 = [[Quote alloc] initWithQuote:@"“Ascribe to the Lord, O families of the peoples, ascribe to the Lord glory and strength! Ascribe to the Lord the glory due his name …” (Ps. 96:7). Is the Lord worthy of our praise today too? Then let’s enter into worship to him."
                                    andAuthor:@"Stan Mitchell"];
    Quote *q13 = [[Quote alloc] initWithQuote:@"“Bless the Lord, O my soul, and let all that is within me bless his holy name! Bless the Lord O my soul, and forget not all his benefits” (Ps. 103:1,2). The secret to failing to worship God is to forget all his blessings; the secret to worshiping him is to remember them."
                                    andAuthor:@"Stan Mitchell"];
    Quote *q14 = [[Quote alloc] initWithQuote:@"“O give thanks to the Lord, for he is good, for his steadfast love endures forever! Let the redeemed of the Lord say so …” (Ps. 107:1,2). If the “redeemed of the Lord” do not say so, who will?"
                                    andAuthor:@"Stan Mitchell"];
    Quote *q15 = [[Quote alloc] initWithQuote:@"“If then you have been raised with Christ, seek the things that are above … set your minds on things that are above, not on things that are on earth” (Col. 3:1,2). Today, too, we need to set our minds on things that are above."
                                    andAuthor:@"Stan Mitchell"];
    Quote *q16 = [[Quote alloc] initWithQuote:@"“Then Job arose and tore his robe and shaved his head and fell on the ground, and worshiped” (Job 1:20). Even when you’re having a truly bad day, you can worship God. Perhaps that is the day when you need to worship most of all."
                                    andAuthor:@"Stan Mitchell"];
    Quote *q17 = [[Quote alloc] initWithQuote:@"Chapel is an opportunity to present yourself before God with so many people alongside you doing the same thing to the best of their ability."
                                    andAuthor:@"Scott Huff"];
    Quote *q18 = [[Quote alloc] initWithQuote:@"The opportunity to present yourself before God with so many people alongside you doing the same thing to the best of their ability is something that can disappear quickly on this earth. Best we fight to partake of it while we can."
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
    Quote *cq2 = [[Quote alloc] initWithQuote:@"Chapel you have skipped? Much to learn, you have."
                                    andAuthor:@"Yoda"];
    Quote *cq3 = [[Quote alloc] initWithQuote:@"Skipping chapel? Bazinga!"
                                    andAuthor:@"Sheldon Cooper"];
    Quote *cq4 = [[Quote alloc] initWithQuote:@"It's ok to skip chapel to sleep... I'll just be over here in the corner watching you."
                                    andAuthor:@"Edward Cullen"];
    Quote *cq5 = [[Quote alloc] initWithQuote:@"Chapel. It's like a drug to me. It's like my own personal brand of heroin."
                                    andAuthor:@"Edward Cullen"];
    Quote *cq6 = [[Quote alloc] initWithQuote:@"To Chapel, and beyond!"
                                    andAuthor:@"Buzz Lightyear"];
    Quote *cq7 = [[Quote alloc] initWithQuote:@"Don't be a cotton-headed ninnymuggins. Go to Chapel!"
                                    andAuthor:@"Buddy the Elf"];
    Quote *cq8 = [[Quote alloc] initWithQuote:@"Chapel. Chapel is what bwings us togethew today. Chapel, that bwessed awwangement, that dweam within a dweam."
                                    andAuthor:@"Impressive Clergyman"];
    Quote *cq9 = [[Quote alloc] initWithQuote:@"Baby, baby, baby, OHHHHHH, I thought you'd always be in chapel."
                                    andAuthor:@"Justin Bieber"];
    Quote *cq10 = [[Quote alloc] initWithQuote:@"Ask not what chapel can do for you - ask what you can do for chapel."
                                     andAuthor:@"John F. Kennedy"];
    Quote *cq11 = [[Quote alloc] initWithQuote:@"Friendship is born at that moment when one person says to another: \"What! You too? I thought I was the only one that likes chapel!\""
                                     andAuthor:@"C.S. Lewis"];
    Quote *cq12 = [[Quote alloc] initWithQuote:@"Chapel does not, in fact, break the laws of nature."
                                     andAuthor:@"C.S. Lewis"];
    Quote *cq13 = [[Quote alloc] initWithQuote:@"Chapel: that most brutal of teachers. But you learn, my God do you learn."
                                     andAuthor:@"C.S. Lewis"];
    Quote *cq14 = [[Quote alloc] initWithQuote:@"Chapel is the best meditation."
                                     andAuthor:@"Dalai Lama"];
    Quote *cq15 = [[Quote alloc] initWithQuote:@"Happiness is not something ready made. It comes from chapel."
                                     andAuthor:@"Dalai Lama"];
    Quote *cq16 = [[Quote alloc] initWithQuote:@"A man may die, nations may rise and fall, but chapel lives on."
                                     andAuthor:@"John F. Kennedy"];
    Quote *cq17 = [[Quote alloc] initWithQuote:@"The best thing to hold onto in life is chapel."
                                     andAuthor:@"Audrey Hepburn"];
    Quote *cq18 = [[Quote alloc] initWithQuote:@"Chapel is always a good idea."
                                     andAuthor:@"Audrey Hepburn"];
    Quote *cq19 = [[Quote alloc] initWithQuote:@"The world is a dangerous place to live; not because of the people who are evil, but because of the people who don't go to chapel."
                                     andAuthor:@"Albert Einstein"];
    Quote *cq20 = [[Quote alloc] initWithQuote:@"Chapel is more important that knowledge."
                                     andAuthor:@"Albert Einstein"];
    Quote *cq21 = [[Quote alloc] initWithQuote:@"Look deep into chapel, and then you will understand everything better."
                                     andAuthor:@"Albert Einstein"];
    Quote *cq22 = [[Quote alloc] initWithQuote:@"You shall not skip!"
                                     andAuthor:@"Gandalf"];
    Quote *cq23 = [[Quote alloc] initWithQuote:@"A wizard is never late to chapel, Frodo Baggins. Nor is he early. He arrives precisely when he means to."
                                     andAuthor:@"Gandalf"];
    Quote *cq24 = [[Quote alloc] initWithQuote:@"I don't go looking for chapel. Chapel usually finds me."
                                     andAuthor:@"Harry Potter"];
    Quote *cq25 = [[Quote alloc] initWithQuote:@"Chapel is mankin's greatest blessing."
                                     andAuthor:@"Mark Twain"];
    Quote *cq26 = [[Quote alloc] initWithQuote:@"The human race has one really effective weapon, and that is chapel."
                                     andAuthor:@"Mark Twain"];
    Quote *cq27 = [[Quote alloc] initWithQuote:@"To be a Christian without chapel is no more possible than to be alive without breathing."
                                     andAuthor:@"Martin Luther King, Jr."];
    Quote *cq28 = [[Quote alloc] initWithQuote:@"I look to a day when people will not be judged by the color of their skin, but by their chapel attendance."
                                     andAuthor:@"Martin Luther King, Jr."];
    Quote *cq29 = [[Quote alloc] initWithQuote:@"Chapel is the first chapter in the book of wisdom."
                                     andAuthor:@"Thomas Jefferson"];
    Quote *cq30 = [[Quote alloc] initWithQuote:@"Chapel is a little thing that makes a big difference."
                                     andAuthor:@"Winston Churchill"];
    
    [_celebrityQuotes addObject:cq1];
    [_celebrityQuotes addObject:cq2];
    [_celebrityQuotes addObject:cq3];
    [_celebrityQuotes addObject:cq4];
    [_celebrityQuotes addObject:cq5];
    [_celebrityQuotes addObject:cq6];
    [_celebrityQuotes addObject:cq7];
    [_celebrityQuotes addObject:cq8];
    [_celebrityQuotes addObject:cq9];
    [_celebrityQuotes addObject:cq10];
    [_celebrityQuotes addObject:cq11];
    [_celebrityQuotes addObject:cq12];
    [_celebrityQuotes addObject:cq13];
    [_celebrityQuotes addObject:cq14];
    [_celebrityQuotes addObject:cq15];
    [_celebrityQuotes addObject:cq16];
    [_celebrityQuotes addObject:cq17];
    [_celebrityQuotes addObject:cq18];
    [_celebrityQuotes addObject:cq19];
    [_celebrityQuotes addObject:cq20];
    [_celebrityQuotes addObject:cq21];
    [_celebrityQuotes addObject:cq22];
    [_celebrityQuotes addObject:cq23];
    [_celebrityQuotes addObject:cq24];
    [_celebrityQuotes addObject:cq25];
    [_celebrityQuotes addObject:cq26];
    [_celebrityQuotes addObject:cq27];
    [_celebrityQuotes addObject:cq28];
    [_celebrityQuotes addObject:cq29];
    [_celebrityQuotes addObject:cq30];
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
