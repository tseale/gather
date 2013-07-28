//
//  GatherEventCard.m
//  Gather
//
//  Created by Taylor Seale on 7/26/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherEventCard.h"
#import <QuartzCore/QuartzCore.h>

@implementation GatherEventCard

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setBackgroundColor:[UIColor colorWithRed:0.99f green:0.99f blue:0.99f alpha:1.00f]];
		self.layer.borderColor = [UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f].CGColor;
		self.layer.borderWidth = 1.0f;
		
		_acceptButton = [[UILabel alloc] initWithFrame:CGRectMake(10, self.bounds.size.height-(44)-10, (self.bounds.size.width-30)/2, 44)];
		[_acceptButton setBackgroundColor:[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f]];
		[_acceptButton setText:@"\u2713"];
		[_acceptButton setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30.0f]];
		[_acceptButton setTextColor:[UIColor whiteColor]];
		[_acceptButton setTextAlignment:NSTextAlignmentCenter];
		[_acceptButton setUserInteractionEnabled:YES];
		/*
		UILongPressGestureRecognizer *acceptEvent = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(acceptEvent:)];
		[acceptEvent setMinimumPressDuration:0.0f];
		[_acceptButton addGestureRecognizer:acceptEvent];
		 */
		[self addSubview:_acceptButton];
		
		_rejectButton = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width-30)/2+20, self.bounds.size.height-(44)-10, (self.bounds.size.width-30)/2, 44)];
		[_rejectButton setBackgroundColor:[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f]];
		[_rejectButton setText:@"x"];
		[_rejectButton setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30.0f]];
		[_rejectButton setTextColor:[UIColor whiteColor]];
		[_rejectButton setTextAlignment:NSTextAlignmentCenter];
		[_rejectButton setUserInteractionEnabled:YES];
		/*
		UILongPressGestureRecognizer *rejectEvent = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(rejectEvent:)];
		[rejectEvent setMinimumPressDuration:0.0f];
		[_rejectButton addGestureRecognizer:rejectEvent];
		 */
		[self addSubview:_rejectButton];
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

@end
