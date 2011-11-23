//
//  ToolBarView.m
//  9PaoPao
//
//  Created by yi xiaoluo on 11-11-9.
//  Copyright 2011年 MI2. All rights reserved.
//

#import "ToolBarView.h"


@implementation ToolBarView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        locationButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 32, 30)];
        [locationButton setImage:[UIImage imageNamed:@"friends-button.png"] forState:UIControlStateNormal];
        [locationButton addTarget:self action:@selector(loacte:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:locationButton];
        
        photoButton = [[UIButton alloc]initWithFrame:CGRectMake(20+(32+30), 0, 32, 30)];
        [photoButton setImage:[UIImage imageNamed:@"friends-button.png"] forState:UIControlStateNormal];
        [photoButton addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:photoButton];
        
        poundSignButton = [[UIButton alloc]initWithFrame:CGRectMake(20+2*(32+30), 0, 32, 30)];
        [poundSignButton setImage:[UIImage imageNamed:@"friends-button.png"] forState:UIControlStateNormal];
        [poundSignButton addTarget:self action:@selector(inputPound:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:poundSignButton];
        
        followButton = [[UIButton alloc]initWithFrame:CGRectMake(20+3*(32+30), 0, 32, 30)];
        [followButton setImage:[UIImage imageNamed:@"friends-button.png"] forState:UIControlStateNormal];
        [followButton addTarget:self action:@selector(follow:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:followButton];
        
        emotionButton = [[UIButton alloc]initWithFrame:CGRectMake(20+4*(32+30), 0, 32, 30)];
        [emotionButton setImage:[UIImage imageNamed:@"friends-button.png"] forState:UIControlStateNormal];
        [emotionButton addTarget:self action:@selector(emoji:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:emotionButton];
        
    }
    return self;
}

-(void)loacte:(id)sender
{
    [self.delegate locateMySelf];
}
-(void)takePhoto:(id)sender
{
    [self.delegate takePhoto];
    
}
-(void)inputPound:(id)sender
{
    [self.delegate inputPoundSign];
    
}
-(void)follow:(id)sender
{
    [self.delegate follow];
    
}
-(void)emoji:(id)sender
{
    [self.delegate showEmotion];
    
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
    [locationButton release];
    [photoButton release];
    [poundSignButton release];
    [followButton release];
    [emotionButton release];
    
    [super dealloc];
}

@end
