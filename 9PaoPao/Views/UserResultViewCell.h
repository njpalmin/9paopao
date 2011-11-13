//
//  UserResultViewCell.h
//  9PaoPao
//
//  Created by huang jiejie on 11-11-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserResultViewCellDelegate<NSObject>

- (void)userResultViewCellSelectUser;

@end

@interface UserResultViewCell : UITableViewCell {
	
	id<UserResultViewCellDelegate>	mDelegate;
	NSArray							*mUserInfos;
}
@property (nonatomic, assign)id<UserResultViewCellDelegate> delegate;
@property (nonatomic, retain)NSArray						*userInfos;

#pragma mark -
#pragma mark Public

- (void)setUserInfos:(NSArray *)infoArray;

@end

