//
//  BarDetailCell.h
//  9PaoPao
//
//  Created by quanhong ma on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BarDetailCell : UITableViewCell {
    UIImageView *barImageView;
    UILabel *barNameLabel;
    UILabel *commentTimeLabel;
    UILabel *userNickNameLabel;
    UILabel *commentMarkLabel;
    UIView *markView;
}
@property(nonatomic,retain) UIImageView *barImageView;
@property(nonatomic,retain) UILabel *barNameLabel;
@property(nonatomic,retain) UILabel *commentTimeLabel;
@property(nonatomic,retain) UILabel *userNickNameLabel;
@property(nonatomic,retain) UILabel *commentMarkLabel;
@property(nonatomic,retain) UIView *markView;

@end
