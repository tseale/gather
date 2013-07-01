//
//  GatherTopBar.m
//  Gather
//
//  Created by Taylor Seale on 6/17/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherTopBar.h"

@implementation GatherTopBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setBackgroundColor:[UIColor colorWithRed:0.99f green:0.99f blue:0.99f alpha:1.00f]];
		_gatherLogo = [[UIView alloc] initWithFrame:CGRectMake(10,30,82,24)];
		[_gatherLogo setBackgroundColor:[UIColor clearColor]];
		UILabel *gatherText= [[UILabel alloc] initWithFrame:CGRectMake(0, 0,82, 23)];
        [gatherText setText:@"Gather"];
		[gatherText setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:30.0f]];
		[gatherText setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
		[gatherText setBackgroundColor:[UIColor clearColor]];
		[_gatherLogo addSubview:gatherText];
		UIView *greenLine = [[UIView alloc] initWithFrame:CGRectMake(0, 24, 60, 1)];
		[greenLine setBackgroundColor:[UIColor greenColor]];
		[_gatherLogo addSubview:greenLine];
		UIView *redLine = [[UIView alloc] initWithFrame:CGRectMake(60, 24, 22, 1)];
		[redLine setBackgroundColor:[UIColor redColor]];
		[_gatherLogo addSubview:redLine];
		UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-2, self.frame.size.width, 1)];
		[line1 setBackgroundColor:[UIColor colorWithRed:0.91f green:0.91f blue:0.91f alpha:1.00f]];
		UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
		[line2 setBackgroundColor:[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f]];
		[self addSubview:line1];
		[self addSubview:line2];
		[self addSubview:_gatherLogo];
		_addEventButton = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-34,30,50,24)];
		[_addEventButton setText:@"+"];
		[_addEventButton setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:40.0f]];
		[_addEventButton setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
		[_addEventButton setBackgroundColor:[UIColor clearColor]];
		[_addEventButton setUserInteractionEnabled:YES];
		UITapGestureRecognizer *addEvent = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addEvent:)];
		[_addEventButton addGestureRecognizer:addEvent];
		[self addSubview:_addEventButton];
		//[self addSubview:_separatorLine];
    }
    return self;
}

-(void)addEvent:(UIGestureRecognizer*)recognizer
{
	if (recognizer.state==UIGestureRecognizerStateEnded)
	{
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"addEvent"
		 object:self];
	}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
