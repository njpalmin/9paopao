//
//  ScoreView.m
//  9PaoPao
//
//  Created by yi xiaoluo on 11-11-9.
//  Copyright 2011年 MI2. All rights reserved.
//

#import "ScoreView.h"


@implementation ScoreView
@synthesize scoreDic;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        NSMutableArray *textArray = [NSMutableArray arrayWithObjects:@"1 外观",@"2 香味",@"3 味道",@"4 口感", nil];
        
        for (int i=0; i<4; i++) {
            UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(78, i*2*23, 80, 23)];
            label.text = [textArray objectAtIndex:i];
            label.backgroundColor = [UIColor clearColor];
            [self addSubview:label];
            [label release];
            label = nil;
        }
        
        int x = 0;
        int y = 23;
        int intervalWidth = 15;
        int intervalHeight = 23;
        int row  = 0;
        int buttonWidth = 20;
        int buttonHeight = 23;
        
        for (int i=0; i<24; i++) {
            if (i != 0 && i%6 == 0) {
                row++;
            }
            int num = i%6;
            UIButton *handBtn = [[UIButton alloc] initWithFrame:CGRectMake(x + num*(buttonWidth + intervalWidth), y + row * 2*intervalHeight, buttonWidth, buttonHeight)];
            [handBtn setImage:[UIImage imageNamed:@"bad.png"] forState:UIControlStateNormal];
            [handBtn addTarget:self action:@selector(changeStatus:) forControlEvents:UIControlEventTouchUpInside];
            handBtn.tag = i;
            [self addSubview:handBtn];
            [handBtn release];
        }
        NSNumber *num = [NSNumber numberWithInt:0];
        //0~3分别表示第一行分数~第四行分数
        self.scoreDic = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:num,num,num,num, nil] forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3", nil]];
    }
    return self;
}

-(void)changeStatus:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [btn setImage:[UIImage imageNamed:@"good.png"] forState:UIControlStateNormal];
    
    //记录点击的分数
    NSString *numStr = [NSString stringWithFormat:@"%d",btn.tag/6];
    NSNumber *number = [scoreDic objectForKey:numStr];
    int n = [number intValue];
    [scoreDic setValue:[NSNumber numberWithInt:(n+1)] forKey:numStr];
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
    [scoreDic release];
    [super dealloc];
}

@end
