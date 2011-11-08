//
//  PaoPaoCommon.h
//  9PaoPao
//
//  Created by huangjj on 11-11-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaoPaoConstant.h"

@interface PaoPaoCommon : NSObject {
    
}

+ (CGRect)buttonFrameForText:(NSString *)text font:(UIFont *)font;
+ (UIButton *)getBarButtonWithTitle:(NSString *)title imageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName action:(SEL)action target:(id)target;

@end
