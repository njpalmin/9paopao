//
//  MapAnnotation.m
//  9PaoPao
//
//  Created by  on 11/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation
@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
- (id)initWithCoordinate:(CLLocationCoordinate2D)coord
{
    self = [super init];
    if (self) {
        coordinate = coord;
        //title = @"我";
    }
    
    return self;
}

- (void)dealloc
{
    [title release];
    [subtitle release];
    [super dealloc];
}
@end
