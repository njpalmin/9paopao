//
//  LocationDetail.m
//  9PaoPao
//
//  Created by  on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationDetail.h"

@implementation LocationDetail
@synthesize location;
@synthesize detailLocation;

- (id)init
{
    self = [super init];
    if (self) {
        location = nil;
        detailLocation = nil;
    }
    return self;
}

- (void)dealloc
{
    [detailLocation release];
    [location release];
    [super dealloc];
}


@end
