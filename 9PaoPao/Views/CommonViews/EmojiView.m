//
//  EmojiView.m
//  iosbrowser
//
//  Created by yi xiaoluo on 11-8-18.
//  Copyright 2011年 MI2. All rights reserved.
//

#import "EmojiView.h"
#import <QuartzCore/QuartzCore.h>

#define COUNT_OF_ROWS 6
#define EMOJI_COUNT_IN_A_ROW 8
#define BUTTOM_OF_A_EMOJI 4

@implementation EmojiView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //[self setFrame:CGRectMake(0, 0, 320, 216)];
        
        emojiText = [[NSMutableArray alloc] initWithObjects:@"[呵呵]",@"[睡觉]",@"[怒骂]",@"[嘻嘻]",@"[钱]",@"[太开心]",@"[哈哈]",@"[偷笑]",@"[懒的理你]",@"[爱你]",@"[酷]",@"[右哼哼]",@"[晕]",@"[衰]",@"[愤怒]",@"[泪]",@"[吃惊]",@"[嘘]",@"[馋嘴]",@"[闭嘴]",@"[委屈]",@"[抓狂]",@"[鄙视]",@"[吐]", nil];
        
        emojiImages = [[NSMutableArray alloc] initWithCapacity:48];
        for (int i = 0; i<24; i++) {
            UIImage *aImage = [UIImage imageNamed:[NSString stringWithFormat:@"weibo_%d.png",i+1]];
            [emojiImages addObject:aImage];
        }
        
        int i = 0;
        int k = 0;//record count of lines
        int tag = 0; //for button's tag
        for (NSString *text in emojiText) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:text forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor colorWithRed:228 green:228 blue:228 alpha:1.0];
            [btn setImage:[emojiImages objectAtIndex:tag] forState:UIControlStateNormal];
            
            CGRect rect;
            
            if (i%EMOJI_COUNT_IN_A_ROW == 0) {
                k = tag/EMOJI_COUNT_IN_A_ROW;
                i = 0;
            }
            rect.origin.x = 320/EMOJI_COUNT_IN_A_ROW*i;
            rect.origin.y = 216/COUNT_OF_ROWS * k;
            rect.size.width = 320/EMOJI_COUNT_IN_A_ROW;
            rect.size.height = 216/COUNT_OF_ROWS;
            
            [btn.layer setBorderWidth:0.5];
            [btn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
            //[btn.layer setBorderColor:[UIColor grayColor].CGColor];
            [btn setFrame:rect];
            //[btn setImage:[UIImage imageNamed:[imgName objectForKey:s]] forState:UIControlStateHighlighted];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, BUTTOM_OF_A_EMOJI)];
            btn.tag = tag++;
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            i++;
        }
    }
    return self;
}

- (id)initLeftWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //[self setFrame:CGRectMake(0, 0, 320, 216)];
        
        emojiText = [[NSMutableArray alloc] initWithObjects:@"[呵呵]",@"[睡觉]",@"[怒骂]",@"[嘻嘻]",@"[钱]",@"[太开心]",@"[哈哈]",@"[偷笑]",@"[懒的理你]",@"[爱你]",@"[酷]",@"[右哼哼]",@"[晕]",@"[衰]",@"[愤怒]",@"[泪]",@"[吃惊]",@"[嘘]",@"[馋嘴]",@"[闭嘴]",@"[委屈]",@"[抓狂]",@"[鄙视]",@"[吐]",@"[哼]",@"[挖鼻屎]",@"[可怜]",@"[打哈气]",@"[花心]",@"[抱抱]",@"[可爱]",@"[鼓掌]",@"[顶]",@"[怒]",@"[失望]",@"[疑问]",@"[汗]",@"[思考]",@"[握手]",@"[困]",@"[生病]",@"[耶]",@"[害羞]",@"[亲亲]",@"[good]",@"[弱]",@"[不要]",@"[ok]", nil];
        
        emojiImages = [[NSMutableArray alloc] initWithCapacity:48];
        for (int i = 0; i<48; i++) {
            UIImage *aImage = [UIImage imageNamed:[NSString stringWithFormat:@"weibo_%d.png",i+1]];
            [emojiImages addObject:aImage];
        }
        
        int i = 0;
        int k = 0;//record count of lines
        int tag = 0; //for button's tag
        for (NSString *text in emojiText) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:text forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor colorWithRed:228 green:228 blue:228 alpha:1.0];
            [btn setImage:[emojiImages objectAtIndex:tag] forState:UIControlStateNormal];
            
            CGRect rect;
            
            if (i%12 == 0) {
                k = tag/12;
                i = 0;
            }
            rect.origin.x = 480/12*i;
            rect.origin.y = 200/5 * k;
            rect.size.width = 480/12;
            rect.size.height = 200/5;
            
            [btn.layer setBorderWidth:0.5];
            [btn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
            //[btn.layer setBorderColor:[UIColor grayColor].CGColor];
            [btn setFrame:rect];
            //[btn setImage:[UIImage imageNamed:[imgName objectForKey:s]] forState:UIControlStateHighlighted];
            //[btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 150/4-32, 0)];
            btn.tag = tag++;
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            i++;
        }
    }
    return self;
}

- (void)click:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSString *text = [emojiText objectAtIndex:btn.tag];
    [self.delegate showEmojiInMessage:text];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [emojiText release];
    [emojiImages release];
    [super dealloc];
}

@end
