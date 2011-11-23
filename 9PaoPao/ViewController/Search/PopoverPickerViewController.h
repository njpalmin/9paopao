//
//  PopoverPickerViewController.h
//  9PaoPao
//
//  Created by huangjj on 11-11-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopoverPickerViewControllerDelegate;

@interface PopoverPickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate>{
    
    id<PopoverPickerViewControllerDelegate>     mDelegate;
    UIPickerView                                *mPicker;
    NSArray                                     *mPickerContents;
    NSInteger                                   mChooseIndex;
    
}

@property(nonatomic, assign)id<PopoverPickerViewControllerDelegate>     delegate;
@property(nonatomic, assign)NSInteger                                   chooseIndex;
@property(nonatomic, retain)NSArray                                     *pickerContent;

@end

@protocol PopoverPickerViewControllerDelegate <NSObject>

- (void)popoverPickerViewControllerDidSelect:(PopoverPickerViewController *)controller;
- (void)popoverPickerViewControllerDismiss:(PopoverPickerViewController *)controller;

@end