//
//  Quote.m
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 10/23/12.
//  Copyright (c) 2012 Richard Simpson. All rights reserved.
//

#import "Quote.h"

@implementation Quote
@synthesize quote = _quote;
@synthesize author = _author;
@synthesize authorPicture = _authorPicture;

- (id)initWithQuote:(NSString *)quote andAuthor:(NSString *)author {
    self = [super init];
    if (self) {
        _quote = quote;
        _author = author;
        [self initializeAuthorPicture];
    }
    return self;
}

- (void)initializeAuthorPicture {
    _authorPicture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", _author]]];
}

@end
