//
//  GatherAddEventView.m
//  Gather
//
//  Created by Taylor Seale on 7/28/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherAddEventView.h"

#define TOP_BAR_HEIGHT 64

@implementation GatherAddEventView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
		_topBar = [[GatherAddEventTopBar alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, TOP_BAR_HEIGHT)];
		[self addSubview:_topBar];
		
		_formScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, 320, self.frame.size.height-TOP_BAR_HEIGHT)];
		_formScroll.delegate=self;
		[_formScroll setShowsVerticalScrollIndicator:NO];
		[_formScroll setBounces:NO];
		
		NSArray* groups = [[NSArray alloc] initWithObjects:@"Epic Interns",
															@"Sorin Bros",
																@"CS Strudy Group",
															@"Twerk Team",
															nil];
		
		_form = [[GatherAddEventForm alloc] initWithFrame:CGRectMake(10, 10, 300, 159.5+([groups count]+1)*44+10)];
		[_formScroll addSubview:_form];
		[_formScroll setContentSize:CGSizeMake(320, 159.5+([groups count]+1)*44+30)];
		[self addSubview:_formScroll];
    }
    return self;
}


@end
