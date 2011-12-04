//
//  LocationDetail.h
//  9PaoPao
//
//  Created by  on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationDetail : NSObject
{
    NSString *location;
    NSString *detailLocation;
}
@property(nonatomic,copy) NSString *location;
@property(nonatomic,copy) NSString *detailLocation;

@end
