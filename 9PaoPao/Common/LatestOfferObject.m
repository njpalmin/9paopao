//
//  LatestOfferObject.m
//  9PaoPao
//
//  Created by  on 11/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LatestOfferObject.h"

@implementation LatestOfferObject
@synthesize latestOfferTitle;
@synthesize latestOfferLocation;
@synthesize latestOfferHost;
@synthesize latestOfferComment;

-(id)init
{
    self = [super init];
    if (self) {
        latestOfferComment = nil;
        latestOfferHost = nil;
        latestOfferLocation = nil;
        latestOfferTitle = nil;
    }
    return self;
}

- (void)dealloc
{
    [latestOfferComment release];
    [latestOfferTitle release];
    [latestOfferHost release];
    [latestOfferLocation release];
    [super dealloc];
}

@end
