//
//  BarComment.h
//  9PaoPao
//
//  Created by  on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BarComment : NSObject
{
    NSString *barName;
    NSString *barLocation;
    NSString *barContact;
    NSString *barCommentTimes;
    NSString *barComment;
    NSString *barCommentScore;
}
@property(nonatomic,copy) NSString *barName;
@property(nonatomic,copy) NSString *barLocation;
@property(nonatomic,copy) NSString *barContact;
@property(nonatomic,copy) NSString *barCommentTimes;
@property(nonatomic,copy) NSString *barComment;
@property(nonatomic,copy) NSString *barCommentScore;
@end
