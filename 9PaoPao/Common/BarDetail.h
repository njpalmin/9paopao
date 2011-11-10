//
//  BarDetail.h
//  9PaoPao
//
//  Created by quanhong ma on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BarDetail : NSObject {
    
    NSString *barName;
    NSString *barAddress;
    NSString *barCommentTime;
    NSString *barCommentContent;
    NSString *barCommentNumber;
    NSString *barContractMethod;
    NSString *barCommentMark;
    NSString *userNickname;
}

@property(nonatomic,copy) NSString *barName;
@property(nonatomic,copy) NSString *barAddress;
@property(nonatomic,copy) NSString *barCommentTime;
@property(nonatomic,copy) NSString *barCommentContent;
@property(nonatomic,copy) NSString *barCommentNumber;
@property(nonatomic,copy) NSString *barContractMethod;
@property(nonatomic,copy) NSString *barCommentMark;
@property(nonatomic,copy) NSString *userNickname;

@end
