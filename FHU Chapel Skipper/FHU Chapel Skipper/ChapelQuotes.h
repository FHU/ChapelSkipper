//
//  ChapelQuotes.h
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 10/6/12.
//  Copyright (c) 2012 Richard Simpson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChapelQuotes : NSObject

@property (strong, nonatomic) NSMutableArray *quotes;

- (NSString *)generateRandomQuote;

@end
