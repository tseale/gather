//
//  GatherEventTopBar.m
//  Gather
//
//  Created by Taylor Seale on 7/24/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherEventTopBar.h"

@implementation GatherEventTopBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		_eventName= [[UILabel alloc] initWithFrame:CGRectMake(0, 20,self.frame.size.width, self.frame.size.height-20)];
		[_eventName setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:30.0f]];
		[_eventName setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
		[_eventName setTextAlignment:NSTextAlignmentCenter];
		[_eventName setBackgroundColor:[UIColor clearColor]];
		[self addSubview:_eventName];
		
		_backButton = [[UILabel alloc] initWithFrame:CGRectMake(10,15,50,self.frame.size.height-20)];
		[_backButton setText:@"<"];
		[_backButton setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30.0f]];
		[_backButton setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
		[_backButton setBackgroundColor:[UIColor clearColor]];
		[_backButton setUserInteractionEnabled:YES];
		UITapGestureRecognizer *backToEvents = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToEvents:)];
		[backToEvents setNumberOfTapsRequired:1];
		[_backButton addGestureRecognizer:backToEvents];
		[self addSubview:_backButton];
		
		_statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-60,20,50,self.frame.size.height-20)];
		[_statusLabel setText:@""];
		[_statusLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30.0f]];
		[_statusLabel setBackgroundColor:[UIColor clearColor]];
		[_statusLabel setTextAlignment:NSTextAlignmentRight];
		[_statusLabel setUserInteractionEnabled:YES];
		[self addSubview:_statusLabel];
		
		[self setBackgroundColor:[UIColor colorWithRed:0.99f green:0.99f blue:0.99f alpha:1.00f]];
		UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-2, self.frame.size.width, 1)];
		[line1 setBackgroundColor:[UIColor colorWithRed:0.91f green:0.91f blue:0.91f alpha:1.00f]];
		UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
		[line2 setBackgroundColor:[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f]];
		[self addSubview:line1];
		[self addSubview:line2];
    }
    return self;
}

-(void)backToEvents:(UITapGestureRecognizer*)recognizer
{
	if (recognizer.state==UIGestureRecognizerStateEnded)
	{
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"backToEvents"
		 object:self];
	}
}

@end
