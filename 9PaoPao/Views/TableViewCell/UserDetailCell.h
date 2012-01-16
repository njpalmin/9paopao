//
//  UserDetailCell.h
//  9PaoPao
//
//  Created by jj huang on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailCell : UITableViewCell
{
    UILabel     *mNameLabel;
    UILabel     *mCommentLabel;
}

#pragma mark -
#pragma mark Public

- (void)setUserDetailRecord;

@end
