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
		
		_deleteButton = [[UILabel alloc] initWithFrame:CGRectMake(280-120, 0, 100, 44)];
		[_deleteButton setText:@"\u2713"];
		[_deleteButton setTextColor:GREEN_COLOR];
		[_deleteButton setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:22.0f]];
		[_deleteButton setTextAlignment:NSTextAlignmentRight];
		[_deleteButton setHidden:NO];
		[_deleteButton setUserInteractionEnabled:YES];
		UITapGestureRecognizer* removePerson = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removePerson)];
		[_deleteButton addGestureRecognizer:removePerson];
		[self addSubview:_deleteButton];
		
		_nameSize = [name sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]
										 constrainedToSize:CGSizeMake(280, 44)
											 lineBreakMode:NSLineBreakByTruncatingTail];
		
        _name = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, _nameSize.width, 44)];
		[_name setText:name];
		[_name setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]];
		[self addSubview:_name];
		
		_removed=NO;
    }
    return self;
}

-(void)removePerson
{
	if (!_removed){
		[_name setTextColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
		[_deleteButton setTextColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
		_removed=YES;
	}else{
		[_name setTextColor:[UIColor blackColor]];
		[_deleteButton setTextColor:GREEN_COLOR];
		_removed=NO;
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
