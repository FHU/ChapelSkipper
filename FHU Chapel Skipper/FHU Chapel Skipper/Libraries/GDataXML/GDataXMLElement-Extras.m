//
//  GDataXMLElement-Extras.m
//  FHU Chapel Skipper
//
//  Created by Richard Simpson on 9/16/12.
//  Copyright (c) 2012 Richard Simpson. All rights reserved.
//

#import "GDataXMLElement-Extras.h"

@implementation GDataXMLElement(Extras)

- (GDataXMLElement *)elementForChild:(NSString *)childName {
    NSArray *children = [self elementsForName:childName];
    if (children.count > 0) {
        GDataXMLElement *childElement = (GDataXMLElement *) [children objectAtIndex:0];
        return childElement;
    } else return nil;
}

- (NSString *)valueForChild:(NSString *)childName {
    return [[self elementForChild:childName] stringValue];
}

@end
