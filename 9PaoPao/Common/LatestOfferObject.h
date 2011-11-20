//
//  LatestOfferObject.h
//  9PaoPao
//
//  Created by  on 11/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LatestOfferObject : NSObject
{
    NSString *latestOfferTitle;
    NSString *latestOfferLocation;
    NSString *latestOfferHost;
    NSString *latestOfferComment;
}
@property(nonatomic,copy) NSString *latestOfferTitle;
@property(nonatomic,copy) NSString *latestOfferLocation;
@property(nonatomic,copy) NSString *latestOfferHost;
@property(nonatomic,copy) NSString *latestOfferComment;
@end
