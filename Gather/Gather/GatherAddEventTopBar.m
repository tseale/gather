//
//  GatherAddEventTopBar.m
//  Gather
//
//  Created by Taylor Seale on 7/28/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherAddEventTopBar.h"

@implementation GatherAddEventTopBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setBackgroundColor:[UIColor colorWithRed:0.99f green:0.99f blue:0.99f alpha:1.00f]];
		
		_eventLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 320, self.frame.size.height-20)];
		[_eventLabel setText:@"New Event"];
		[_eventLabel setTextAlignment:NSTextAlignmentCenter];
		[self addSubview:_eventLabel];
		
		_cancelButton = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, self.frame.size.height-20)];
		[_cancelButton setText:@"cancel"];
		[_cancelButton setTextColor:RED_COLOR];
		[_cancelButton setUserInteractionEnabled:YES];
		UITapGestureRecognizer* cancelAddEvent = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAddEvent)];
		[_cancelButton addGestureRecognizer:cancelAddEvent];
		[self addSubview:_cancelButton];
		
		_doneButton = [[UILabel alloc] initWithFrame:CGRectMake(210, 20, 100, self.frame.size.height-20)];
		[_doneButton setText:@"done"];
		[_doneButton setTextColor:GREEN_COLOR];
		[_doneButton setTextAlignment:NSTextAlignmentRight];
		[_doneButton setUserInteractionEnabled:YES];
		[self addSubview:_doneButton];
		
		UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-2, self.frame.size.width, 1)];
		[line1 setBackgroundColor:[UIColor colorWithRed:0.91f green:0.91f blue:0.91f alpha:1.00f]];
		UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
		[line2 setBackgroundColor:[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f]];
		[self addSubview:line1];
		[self addSubview:line2];
    }
    return self;
}

-(void)cancelAddEvent
{
	[[NSNotificationCenter defaultCenter]
	 postNotificationName:@"cancelAddEvent"
	 object:self];
}

@end
