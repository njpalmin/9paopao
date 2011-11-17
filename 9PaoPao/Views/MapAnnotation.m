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

- (id)initWithCoordinate:(CLLocationCoordinate2D)coord
{
    self = [super init];
    if (self) {
        coordinate = coord;
        //title = @"我";
    }
    
    return self;
}


- (NSString *)title
{
    return @"我";
}

- (NSString *)subtitle
{
    return @"当前位置";
}


- (void)dealloc
{
    [super dealloc];
}
@end
