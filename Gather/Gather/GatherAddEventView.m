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
		

		_formScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, 320, self.frame.size.height)];
		_formScroll.delegate=self;
		[_formScroll setShowsVerticalScrollIndicator:NO];
		[_formScroll setBounces:NO];
		
		_form = [[GatherAddEventForm alloc] init];
		[_formScroll addSubview:_form];
		[_formScroll setContentSize:CGSizeMake(320, 159.5+(GROUPS.count+1)*44+30)];
		[self addSubview:_formScroll];
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(showGroupPreview:)
													 name:@"showGroupPreview"
												   object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(hideGroupPreview)
													 name:@"hideGroupPreview"
												   object:nil];
		
    }
    return self;
}

-(void)showGroupPreview:(NSNotification*)notification
{
	GatherGroupCell* group = [[notification userInfo] objectForKey:@"expanded_cell"];
	[_formScroll setContentSize:CGSizeMake(320, 159.5+(GROUPS.count+1)*44+95+([[GROUPS objectForKey:group.groupName.text] count]+1)*44)];
	[_form showGroupPreview:group];
}

-(void)hideGroupPreview
{
	[_form hideGroupPreview];
	//[_formScroll setContentSize:CGSizeMake(320, 159.5+(GROUPS.count+1)*44+30)];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (_formScroll.contentOffset.y==0 && _form.expandedCell==nil){
		[_formScroll setContentSize:CGSizeMake(320, _form.frame.size.height+20)];
	}
}


@end
