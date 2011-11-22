//
//  BarComment.m
//  9PaoPao
//
//  Created by  on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BarComment.h"

@implementation BarComment
@synthesize barName;
@synthesize barLocation;
@synthesize barContact;
@synthesize barCommentTimes;
@synthesize barComment;
@synthesize barCommentScore;

- (id)init
{
    self = [super init];
    if (self) {
        barName = nil;
        barLocation = nil;
        barContact = nil;
        barCommentTimes = nil;
        barComment = nil;
        barCommentScore = nil;
    }
    return self;
}

- (void)dealloc
{
    [barName release];
    [barLocation release];
    [barContact release];
    [barComment release];
    [barCommentTimes release];
    [barCommentScore release];
    [super dealloc];
}
@end
