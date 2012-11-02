//
//  Quote.h
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 10/23/12.
//  Copyright (c) 2012 Richard Simpson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quote : NSObject

@property (strong, nonatomic) NSString *quote;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) UIImageView *authorPicture;

- (id)initWithQuote:(NSString *)quote andAuthor:(NSString *)author;

@end
