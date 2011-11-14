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
        UILabel *firstLabel  = [[UILabel alloc] initWithFrame:CGRectMake(78, 0, 80, 23)];
        UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(78, 2*23, 80, 23)];
        UILabel *thirdlabel  = [[UILabel alloc] initWithFrame:CGRectMake(78, 4*23, 80, 23)];
        UILabel *fourthLabel = [[UILabel alloc] initWithFrame:CGRectMake(78, 6*23, 80, 23)];
        
        firstLabel.text = @"1 外观";
        secondLabel.text = @"2 香味";
        thirdlabel.text = @"3 味道";
        fourthLabel.text = @"4 口感";
        
        [self addSubview:firstLabel];
        [self addSubview:secondLabel];
        [self addSubview:thirdlabel];
        [self addSubview:fourthLabel];
        
        [firstLabel release];
        [secondLabel release];
        [thirdlabel release];
        [fourthLabel release];
        
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
