//
//  GatherGroupMemberCell.m
//  Gather
//
//  Created by Taylor Seale on 8/1/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherGroupMemberCell.h"

@implementation GatherGroupMemberCell

- (id)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
		[self setBackgroundColor:[UIColor clearColor]];
		
		_nameSize = [name sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]
					 constrainedToSize:CGSizeMake(280, 44)
						 lineBreakMode:NSLineBreakByTruncatingTail];

		
		_name = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, _nameSize.width, 44)];
		[_name setText:name];
		[_name setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]];
		[self addSubview:_name];
		
		if (![name isEqualToString:@"+ Add Person to Event"]){
			_deleteButton = [[UILabel alloc] initWithFrame:CGRectMake(280-120, 0, 100, 44)];
			[_deleteButton setText:@"\u2713"];
			[_deleteButton setTextColor:GREEN_COLOR];
			[_deleteButton setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:22.0f]];
			[_deleteButton setTextAlignment:NSTextAlignmentRight];
			[_deleteButton setHidden:NO];
			[_deleteButton setUserInteractionEnabled:YES];
			[self addSubview:_deleteButton];
		}
		
		_removed=NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
