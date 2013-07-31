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
		[self addSubview:_preview];
		
		CGSize expectedLabelSize = [groupName sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]
											constrainedToSize:CGSizeMake(280, 44)
											  lineBreakMode:NSLineBreakByTruncatingTail];
		
        _groupName = [[UILabel alloc] initWithFrame:CGRectMake(280-expectedLabelSize.width-10, 0, expectedLabelSize.width, 44)];
		[_groupName setText:groupName];
		[_groupName setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]];
		[self addSubview:_groupName];
    }
    return self;
}

@end
