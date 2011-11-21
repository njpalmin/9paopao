//
//  BarDetail.m
//  9PaoPao
//
//  Created by quanhong ma on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BarDetail.h"


@implementation BarDetail
@synthesize barName;
@synthesize barAddress;
@synthesize barCommentMark;
@synthesize barCommentTime;
@synthesize barCommentNumber;
@synthesize barCommentContent;
@synthesize barContractMethod;
@synthesize userNickname;

- (id)init
{
    self = [super init];
    if (self) {
        barName = nil;
        barAddress = nil;
        barCommentMark = nil;
        barCommentTime = nil;
        barCommentNumber = nil;
        barCommentContent = nil;
        barContractMethod = nil;
        userNickname = nil;
    }
    return  self;
}

- (void)dealloc
{
    [barName release];
    [barAddress release];
    [barCommentMark release];
    [barCommentTime release];
    [barCommentNumber release];
    [barCommentContent release];
    [barContractMethod release];
    [userNickname release];
    [super dealloc];
}

@end
