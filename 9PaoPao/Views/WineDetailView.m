//
//  WineDetailView.m
//  9PaoPao
//
//  Created by huang jiejie on 11-11-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
 
#import "WineDetailView.h"
#import "StarMarkView.h"
#import "ThumbMarkView.h"
#import "PaoPaoCommon.h"

#define CellLeftImageTag            1000
#define CellStarMarkViewTag			1001
#define CellThumbMarkViewTag		1002

@implementation WineDetailView

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		self.selectionStyle = UITableViewCellSelectionStyleNone;
			
		CGFloat		yPos = 5;
		
		mWineName = [[UILabel alloc] initWithFrame:CGRectMake(RightContentXOrigin, yPos, WineDetailInfoLabelWidth, WineDetailInfoLabelHeight)];
        [mWineName setTextColor:[UIColor redColor]];
        [mWineName setFont:[UIFont systemFontOfSize:13.0]];
        [mWineName setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:mWineName];
		
		yPos += WineDetailInfoLabelHeight;
		
		mWineProductDay = [[UILabel alloc] initWithFrame:CGRectMake(RightContentXOrigin, yPos, WineDetailInfoLabelWidth, WineDetailInfoLabelHeight)];
        [mWineProductDay setTextColor:[UIColor blackColor]];
        [mWineProductDay setFont:[UIFont systemFontOfSize:13.0]];
        [mWineProductDay setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:mWineProductDay];
		
		yPos += WineDetailInfoLabelHeight;

		mWineProductPlace = [[UILabel alloc] initWithFrame:CGRectMake(RightContentXOrigin, yPos, WineDetailInfoLabelWidth, WineDetailInfoLabelHeight)];
        [mWineProductPlace setTextColor:[UIColor blackColor]];
        [mWineProductPlace setFont:[UIFont systemFontOfSize:13.0]];
        [mWineProductPlace setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:mWineProductPlace];
		
		yPos += WineDetailInfoLabelHeight;

		mWineKind = [[UILabel alloc] initWithFrame:CGRectMake(RightContentXOrigin, yPos, WineDetailInfoLabelWidth, WineDetailInfoLabelHeight)];
        [mWineKind setTextColor:[UIColor blackColor]];
        [mWineKind setFont:[UIFont systemFontOfSize:13.0]];
        [mWineKind setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:mWineKind];
		
		yPos += WineDetailInfoLabelHeight;

		mWinePrice = [[UILabel alloc] initWithFrame:CGRectMake(RightContentXOrigin, yPos, WineDetailInfoLabelWidth, WineDetailInfoLabelHeight)];
        [mWinePrice setTextColor:[UIColor blackColor]];
        [mWinePrice setFont:[UIFont systemFontOfSize:13.0]];
        [mWinePrice setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:mWinePrice];
		
		yPos += WineDetailInfoLabelHeight;
	}
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	
	if (mWineName) {
		[mWineName release];
		mWineName = nil;
	}
	if (mWineProductDay) {
		[mWineProductDay release];
		mWineProductDay = nil;
	}
	
	if (mWineProductPlace) {
		[mWineProductPlace release];
		mWineProductPlace = nil;
	}
	
	if (mWineKind) {
		[mWineKind release];
		mWineKind = nil;
	}
	if (mWinePrice) {
		[mWinePrice release];
		mWinePrice = nil;
	}
	
    [super dealloc];
}

#pragma mark -
#pragma mark Public

-(void)setWineDetailRecord
{
	[[self.contentView viewWithTag:CellLeftImageTag] removeFromSuperview];
	[[self.contentView viewWithTag:CellStarMarkViewTag] removeFromSuperview];
	[[self.contentView viewWithTag:CellThumbMarkViewTag] removeFromSuperview];

	UIImage     *image = nil;
	UIImageView *leftImageView = nil;
	
	image = [UIImage imageNamed:@"bar-icon-bg.png"];
	leftImageView = [[UIImageView alloc] initWithImage:image];
	leftImageView.frame = CGRectMake(8, 10, image.size.width, image.size.height);
	leftImageView.tag = CellLeftImageTag;
	
	[self.contentView addSubview:leftImageView];
	
	[leftImageView release];
	leftImageView = nil;
	
	StarMarkView *markView = [[StarMarkView alloc] initWithFrame:CGRectMake(RightContentXOrigin, 77, 0, 0) withStarNum:3];
	markView.tag = CellStarMarkViewTag;
	[self.contentView addSubview:markView];
	
	ThumbMarkView	*thumbView = [[ThumbMarkView alloc] initWithFrame:CGRectMake(180, 65, 0, 0) withGoodNum:10 withBadNum:0];
	thumbView.tag = CellThumbMarkViewTag;
	[self.contentView addSubview:thumbView];
	
	[markView release];
	markView = nil;
	
	[thumbView release];
	thumbView = nil;
	
	//------------label detail info-----------
	[mWineName setText:@"Regment"];
	[mWineProductDay setText:[NSString stringWithFormat:NSLocalizedString(@"Product Day", nil), @"2011年"]];
	[mWineProductPlace setText:[NSString stringWithFormat:NSLocalizedString(@"Product Place", nil), @"中国"]];
	[mWineKind setText:[NSString stringWithFormat:NSLocalizedString(@"Wine Kind", nil), @"红葡萄酒"]];
	[mWinePrice setText:[NSString stringWithFormat:NSLocalizedString(@"Price", nil), @"350元"]];
}


@end
