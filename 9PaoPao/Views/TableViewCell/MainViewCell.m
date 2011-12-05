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

#define BUTTON_WIDTH 70
#define BUTTON_HEIGHT 60

#import "MainViewCell.h"
#import "PaoPaoConstant.h"

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
    CGFloat x = 0.0;
    switch (tag) {
        case FIRST:
            x = 18;
            break;
        case SECOND:
            x = 18 + BUTTON_WIDTH + 37;
            break;
        case THIRD:
            x = 18 + 2*(BUTTON_WIDTH + 37);
            break;
        default:
            break;
    }
    UIButton *tempBtn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    [tempBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [tempBtn setFrame:CGRectMake(x, 13, BUTTON_WIDTH, BUTTON_HEIGHT)];
    tempBtn.showsTouchWhenHighlighted = YES;
    tempBtn.tag = position;
    [tempBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tempBtn];
    [tempBtn release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 82, 80, 16)];
    label.font = [UIFont fontWithName:PaoPaoFont size:14.0];
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
