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
		
		_horizScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, 640, self.frame.size.height-TOP_BAR_HEIGHT)];
		_horizScroll.delegate=self;
		[_horizScroll setPagingEnabled:YES];
		[_horizScroll setBounces:NO];
		[_horizScroll setContentSize:CGSizeMake(640, self.frame.size.height-TOP_BAR_HEIGHT)];
		
		
		_formScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.frame.size.height)];
		_formScroll.delegate=self;
		[_formScroll setShowsVerticalScrollIndicator:NO];
		[_formScroll setBounces:NO];
		
		_form = [[GatherAddEventForm alloc] initWithFrame:CGRectMake(10, 10, 300, 159.5+(1+1)*44+10)];
		[_formScroll addSubview:_form];
		[_formScroll setContentSize:CGSizeMake(320, 159.5+(1+1)*44+30)];
		[_horizScroll addSubview:_formScroll];
		
		_groupScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(320, 0, 320, self.frame.size.height)];
		_groupScroll.delegate=self;
		[_groupScroll setShowsVerticalScrollIndicator:NO];
		[_groupScroll setBounces:NO];
		
		_groupView = [[GatherGroupView alloc] initWithFrame:CGRectMake(10, 10, 300, 159.5+(1+1)*44+10)];
		[_groupScroll addSubview:_groupView];
		[_groupScroll setContentSize:CGSizeMake(320, 159.5+(1+1)*44+30)];
		
		[_horizScroll addSubview:_groupScroll];
		
		[self addSubview:_horizScroll];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(showGroupPreview)
													 name:@"showGroupPreview"
												   object:nil];
    }
    return self;
}

-(void)showGroupPreview
{
	_horizScroll.frame=CGRectMake(0, TOP_BAR_HEIGHT, 320, self.frame.size.height-TOP_BAR_HEIGHT);
	[_horizScroll setContentOffset:CGPointMake(320, 0) animated:YES];
	[_horizScroll setBounces:YES];
	
}


@end
