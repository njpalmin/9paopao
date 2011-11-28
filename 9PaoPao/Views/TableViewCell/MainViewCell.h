//
//  MainViewCell.h
//  9PaoPao
//
//  Created by yi xiaoluo on 11-11-8.
//  Copyright 2011年 MI2. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MainViewCellDelegate <NSObject>
-(void)clickButtonWithTag:(NSInteger)pos;
@end
 
@interface MainViewCell : UITableViewCell {
    UIButton *firstBtn;
    UIButton *secondBtn;
    UIButton *thirdBtn;
    
    id<MainViewCellDelegate>       delegate;
}
@property (nonatomic, retain) id<MainViewCellDelegate>  delegate; 
-(void)addButtonWithTitle:(NSString *)title andImageName:(NSString *)imageName andPosition:(NSInteger)position andButtonTag:(NSInteger)tag; 
@end