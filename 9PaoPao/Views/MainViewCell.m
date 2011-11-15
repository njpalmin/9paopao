//
//  MainViewCell.m
//  9PaoPao
//
//  Created by yi xiaoluo on 11-11-8.
//  Copyright 2011年 MI2. All rights reserved.
//
#define FIRST 1
#define SECOND 2
#define THIRD 3

#import "MainViewCell.h"

@implementation MainViewCell
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)addButtonWithTitle:(NSString *)title andImageName:(NSString *)imageName andPosition:(NSInteger)position andButtonTag:(NSInteger)tag
{
    CGFloat x;
    switch (tag) {
        case FIRST:
            x = 22.5;
            break;
        case SECOND:
            x = 22.5 + 55 + 50;
            break;
        case THIRD:
            x = 22.5 + 2*(55 + 50);
            break;
        default:
            break;
    }
    UIButton *tempBtn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    [tempBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [tempBtn setFrame:CGRectMake(x, 16, 55, 55)];
    tempBtn.tag = position;
    [tempBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tempBtn];
    [tempBtn release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 86, 80, 16)];
    label.font = [UIFont systemFontOfSize:14.0];
    label.text = title;
    label.textAlignment = UITextAlignmentCenter;
    [self addSubview:label];
    [label release];
}

-(void)action:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [self.delegate clickButtonWithTag:btn.tag];
}

- (void)dealloc
{
    [super dealloc];
}

@end
