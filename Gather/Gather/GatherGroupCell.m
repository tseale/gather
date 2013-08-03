//
//  GatherGroupCell.m
//  Gather
//
//  Created by Taylor Seale on 7/30/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherGroupCell.h"

@implementation GatherGroupCell

- (id)initWithGroupName:(NSString*)groupName
{
    self = [super init];
    if (self) {
		[self setBackgroundColor:[UIColor clearColor]];
		
		_preview = [[UILabel alloc] initWithFrame:CGRectMake(280-110, 0, 100, 44)];
		[_preview setText:@"preview"];
		[_preview setTextColor:[UIColor colorWithRed:0.00f green:0.48f blue:0.99f alpha:1.00f]];
		[_preview setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f]];
		[_preview setTextAlignment:NSTextAlignmentRight];
		[_preview setHidden:YES];
		[_preview setUserInteractionEnabled:YES];
		UITapGestureRecognizer* showGroupPreview = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGroupPreview)];
		[_preview addGestureRecognizer:showGroupPreview];
		[self addSubview:_preview];
		
		CGSize expectedLabelSize = [groupName sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]
											constrainedToSize:CGSizeMake(280, 44)
											  lineBreakMode:NSLineBreakByTruncatingTail];
		
        _groupName = [[UILabel alloc] initWithFrame:CGRectMake(280-expectedLabelSize.width-10, 0, expectedLabelSize.width, 44)];
		[_groupName setText:groupName];
		[_groupName setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]];
		[self addSubview:_groupName];
		
		_groupInfo = [[GatherGroupPreviewTable alloc] initWithGroup:groupName];
		[_groupInfo setBackgroundColor:[UIColor clearColor]];
		[_groupInfo setBounces:NO];
		[self addSubview:_groupInfo];
		
		[self setClipsToBounds:YES];
		
		_previewShown=NO;
		
    }
    return self;
}

-(void)showGroupPreview
{
	if (!_previewShown){
		NSDictionary* expanded_cell = [[NSDictionary alloc] initWithObjects:@[self,_groupName.text] forKeys:@[@"expanded_cell",@"group"]];
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"showGroupPreview"
		 object:self
		 userInfo:expanded_cell];
		[_preview setText:@"Hide"];
		_previewShown=YES;
	}else{
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"hideGroupPreview"
		 object:self
		 ];
		[_preview setText:@"preview"];
		_previewShown=NO;
	}
}

@end
