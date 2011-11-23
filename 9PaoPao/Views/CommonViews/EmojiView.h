//
//  EmojiView.h
//  iosbrowser
//
//  Created by yi xiaoluo on 11-8-18.
//  Copyright 2011年 MI2. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EmojiViewDelegate
- (void)showEmojiInMessage:(NSString *)text;

@end

@interface EmojiView : UIView {
    NSMutableArray *emojiText;
    NSMutableArray *emojiImages;
    
    id<EmojiViewDelegate> delegate;
}
@property (assign) id<EmojiViewDelegate> delegate;

//inited when turn left to adapt the acreen
- (id)initLeftWithFrame:(CGRect)frame;
@end
