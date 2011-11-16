//
//  MapIconView.m
//  9PaoPao
//
//  Created by huangjj on 11-11-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MapIconView.h"


@implementation MapIconView
 
@synthesize delegate = mDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIImageView	*mapView = nil;
        UIImage		*mapImage = nil;
        
        mapImage = [UIImage imageNamed:@"bar-map-bg.png"];
        mapView = [[[UIImageView alloc] initWithImage:mapImage] autorelease];
        mapView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        [self addSubview:mapView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark -
#pragma mark Respons

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mDelegate mapIconViewDisplayDetailMap:self];
}

- (void)dealloc
{
    [super dealloc];
}

@end
