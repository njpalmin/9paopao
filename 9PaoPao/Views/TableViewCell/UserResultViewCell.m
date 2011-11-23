//
//  UserResultViewCell.m
//  9PaoPao
//
//  Created by huang jiejie on 11-11-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserResultViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "PaoPaoConstant.h"

@implementation UserResultViewCell

@synthesize delegate = mDelegate;
@synthesize userInfos = mUserInfos;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

- (void)dealloc {
	
	mDelegate = nil;
	
	if (mUserInfos) {
		[mUserInfos release];
		mUserInfos = nil;
	}
	
    [super dealloc];
}

#pragma mark -
#pragma mark Public

- (void)setUserInfos:(NSArray *)infoArray
{
	if (mUserInfos) {
		[mUserInfos release];
		mUserInfos = nil;
	}
	mUserInfos = [infoArray retain];
	
	[[self.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
	
	CGFloat		xPos = 7;
	for (int i = 0; i < [infoArray count]; i++) {
		
		UIButton		*wholeInfoButton = nil;
		UIImageView		*picture = nil;
		UILabel			*nameLabel = nil;
		UILabel			*distanceLabel = nil;
		CGFloat			yPos = 3;

		wholeInfoButton = [[UIButton alloc] initWithFrame:CGRectMake(xPos, 0, 60, (yPos+60+WineDetailInfoLabelHeight*2))];
		[wholeInfoButton addTarget:self action:@selector(procUserBtn:) forControlEvents:UIControlEventTouchUpInside];
		wholeInfoButton.backgroundColor = [UIColor clearColor];
		wholeInfoButton.tag = i;
		
		picture = [[UIImageView alloc] initWithFrame:CGRectMake(0, yPos, 66, 67)];
        [picture setImage:[UIImage imageNamed:@"people-offline.png"]];
		picture.backgroundColor = [UIColor lightGrayColor];
		picture.layer.cornerRadius = 6;
		
		yPos += 66;
		
		nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, yPos, 60, WineDetailInfoLabelHeight)];
        [nameLabel setTextColor:[UIColor blackColor]];
		[nameLabel setTextAlignment:UITextAlignmentCenter];
        [nameLabel setFont:[UIFont systemFontOfSize:13.0]];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
		[nameLabel setText:@"张三"];
		
		yPos += WineDetailInfoLabelHeight;

		distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, yPos, 60, WineDetailInfoLabelHeight)];
        [distanceLabel setTextColor:[UIColor blackColor]];
		[distanceLabel setTextAlignment:UITextAlignmentCenter];
        [distanceLabel setFont:[UIFont systemFontOfSize:13.0]];
        [distanceLabel setBackgroundColor:[UIColor clearColor]];
		[distanceLabel setText:@"0.1公里"];
		
		[wholeInfoButton addSubview:picture];
		[wholeInfoButton addSubview:nameLabel];
		[wholeInfoButton addSubview:distanceLabel];
		[self.contentView addSubview:wholeInfoButton];
		
		[picture release];
		picture = nil;
		
		[nameLabel release];
		nameLabel = nil;
		
		[distanceLabel release];
		distanceLabel = nil;
		
		[wholeInfoButton release];
		wholeInfoButton = nil;
		
		xPos += 66+7;
	}
}

#pragma mark -
#pragma mark action

- (void)procUserBtn:(id)sender
{
	UIButton	*button = nil;
	
	button = (UIButton *)sender;
	
	if ((button.tag < [mUserInfos count]) && (button.tag > 0)) {
		[mDelegate userResultViewCellSelectUser];
	}
}

@end
