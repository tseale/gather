//
//  GatherEventViewController.m
//  Gather
//
//  Created by Taylor Seale on 7/24/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherEventViewController.h"
#import <QuartzCore/QuartzCore.h>

#define TOP_BAR_HEIGHT 64

@interface GatherEventViewController ()

@end

@implementation GatherEventViewController

-(id)initWithEvent:(GatherEventData *)event
{
	_eventData=event;
	_connection = [[GatherServerConnection alloc] init];
	return self;
}


-(void)updateResponse
{
	int userResponse = [_eventData userResponse];
	if (userResponse==1){
		[_acceptButton setBackgroundColor:GREEN_COLOR];
		[_rejectButton setUserInteractionEnabled:NO];
		[_rejectButton setBackgroundColor:[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f]];
		[_rejectButton setUserInteractionEnabled:YES];
	}else if (userResponse==-1){
		[_rejectButton setBackgroundColor:RED_COLOR];
		[_rejectButton setUserInteractionEnabled:NO];
		[_acceptButton setBackgroundColor:[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f]];
		[_acceptButton setUserInteractionEnabled:YES];
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	
	_topBar = [[GatherEventTopBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, TOP_BAR_HEIGHT)];
	[_topBar.eventName setText:_eventData.what];
	[self.view addSubview:_topBar];
	
	_suggestionScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT+10, self.view.frame.size.width, self.view.frame.size.height-TOP_BAR_HEIGHT-40)];
	[_suggestionScroller setBounces:YES];
	[_suggestionScroller setShowsHorizontalScrollIndicator:NO];
	[_suggestionScroller setPagingEnabled:YES];
	[_suggestionScroller setUserInteractionEnabled:YES];
	
	for (int i=0; i<5; i++){
		GatherEventCard* event = [[GatherEventCard alloc] initWithFrame:CGRectMake(10+(i*(20+self.view.frame.size.width-20)), 0, self.view.frame.size.width-20, self.view.frame.size.height-TOP_BAR_HEIGHT-40)];
		[_suggestionScroller addSubview:event];
	}
	_suggestionScroller.delegate=self;
	[_suggestionScroller setContentSize:CGSizeMake(5*(self.view.frame.size.width), self.view.frame.size.height-TOP_BAR_HEIGHT-40)];
	[self.view addSubview:_suggestionScroller];
	
	_pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height-TOP_BAR_HEIGHT-40), self.view.frame.size.width, self.view.frame.size.height-(self.view.frame.size.height-TOP_BAR_HEIGHT-40))];
	//[_pageControl setPageContro]
	[self.view addSubview:_pageControl];
	
																			   
	
	/*
	UIView *cardBackground = [[UIView alloc] initWithFrame:CGRectMake(10, TOP_BAR_HEIGHT+10, self.view.bounds.size.width-20, self.view.bounds.size.height-(2*TOP_BAR_HEIGHT)-10)];
	[cardBackground setBackgroundColor:[UIColor colorWithRed:0.99f green:0.99f blue:0.99f alpha:1.00f]];
	cardBackground.layer.borderColor = [UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f].CGColor;
	cardBackground.layer.borderWidth = 1.0f;
	[self.view addSubview:cardBackground];
	
	
	_eventDetails = [[UILabel alloc] initWithFrame:CGRectMake(10, TOP_BAR_HEIGHT, self.view.bounds.size.width-20, 1.618*(TOP_BAR_HEIGHT-20))];
	[_eventDetails setBackgroundColor:[UIColor clearColor]];
	NSString *eventDetailsString = [NSString stringWithFormat:@"%@ \n@ %@\nw/ %@",_eventData.when,_eventData.where,_eventData.group];
	[_eventDetails setText:eventDetailsString];
	_eventDetails.lineBreakMode = NSLineBreakByWordWrapping;
	_eventDetails.numberOfLines = 3;
	[_eventDetails setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
	[_eventDetails setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
	[_eventDetails setTextAlignment:NSTextAlignmentCenter];
	//[self.view addSubview:_eventDetails];
	
	UIView *separatorLine1 = [[UIView alloc] initWithFrame:CGRectMake(10, TOP_BAR_HEIGHT+1.618*(TOP_BAR_HEIGHT-20)-1, self.view.bounds.size.width-20, 1)];
	[separatorLine1 setBackgroundColor:[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f]];
	//[self.view addSubview:separatorLine1];
	
	UILabel *attending = [[UILabel alloc] initWithFrame:CGRectMake(20, TOP_BAR_HEIGHT+1.618*(TOP_BAR_HEIGHT-20)-1, (self.view.bounds.size.width-40)/2, 22)];
	[attending setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f]];
	[attending setTextColor:[UIColor colorWithRed:0.16f green:0.77f blue:0.09f alpha:0.5f]];
	[attending setTextAlignment:NSTextAlignmentLeft];
	[attending setText:@"Attending"];
	//[self.view addSubview:attending];
	
	UILabel *notAttending = [[UILabel alloc] initWithFrame:CGRectMake(20+(self.view.bounds.size.width-40)/2, TOP_BAR_HEIGHT+1.618*(TOP_BAR_HEIGHT-20)-1, (self.view.bounds.size.width-40)/2, 22)];
	[notAttending setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f]];
	[notAttending setTextColor:[UIColor colorWithRed:1.00f green:0.23f blue:0.19f alpha:0.5f]];
	[notAttending setTextAlignment:NSTextAlignmentRight];
	[notAttending setText:@"Not Attending"];
	//[self.view addSubview:notAttending];
	
	UIView *separatorLine2 = [[UIView alloc] initWithFrame:CGRectMake(10, TOP_BAR_HEIGHT+1.618*(TOP_BAR_HEIGHT-20)-1+22, self.view.bounds.size.width-20, 1)];
	[separatorLine2 setBackgroundColor:[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f]];
	//[self.view addSubview:separatorLine2];
	
	_acceptButton = [[UILabel alloc] initWithFrame:CGRectMake(10, self.view.bounds.size.height-(TOP_BAR_HEIGHT-20)-10, (self.view.bounds.size.width-30)/2, TOP_BAR_HEIGHT-20)];
	[_acceptButton setBackgroundColor:[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f]];
	[_acceptButton setText:@"\u2713"];
	[_acceptButton setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30.0f]];
	[_acceptButton setTextColor:[UIColor whiteColor]];
	[_acceptButton setTextAlignment:NSTextAlignmentCenter];
	[_acceptButton setUserInteractionEnabled:YES];
	UILongPressGestureRecognizer *acceptEvent = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(acceptEvent:)];
	[acceptEvent setMinimumPressDuration:0.0f];
	[_acceptButton addGestureRecognizer:acceptEvent];
	[self.view addSubview:_acceptButton];
	
	_rejectButton = [[UILabel alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-30)/2+20, self.view.bounds.size.height-(TOP_BAR_HEIGHT-20)-10, (self.view.bounds.size.width-30)/2, TOP_BAR_HEIGHT-20)];
	[_rejectButton setBackgroundColor:[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f]];
	[_rejectButton setText:@"x"];
	[_rejectButton setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30.0f]];
	[_rejectButton setTextColor:[UIColor whiteColor]];
	[_rejectButton setTextAlignment:NSTextAlignmentCenter];
	[_rejectButton setUserInteractionEnabled:YES];
	UILongPressGestureRecognizer *rejectEvent = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(rejectEvent:)];
	[rejectEvent setMinimumPressDuration:0.0f];
	[_rejectButton addGestureRecognizer:rejectEvent];
	[self.view addSubview:_rejectButton];
	
	[self updateResponse];
	 */
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(backToEvents)
												 name:@"backToEvents"
											   object:nil];
	
	

}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = _suggestionScroller.frame.size.width;
    int page = floor((_suggestionScroller.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageControl.currentPage = page;
}

-(void)acceptEvent:(UILongPressGestureRecognizer*)recognizer
{
	int userResponse = [_eventData userResponse];
	if (userResponse!=1){
		if (recognizer.state==UIGestureRecognizerStateBegan){
			[_acceptButton setBackgroundColor:[UIColor colorWithRed:0.75*0.83f green:0.75*0.83f blue:0.75*0.83f alpha:1.00f]];
		}else if (recognizer.state==UIGestureRecognizerStateEnded){
			[_connection respondToEvent:_eventData._id response:[NSNumber numberWithInt:1]];
			[_eventData accept];
			[self updateResponse];
		}
	}
}

-(void)rejectEvent:(UILongPressGestureRecognizer*)recognizer
{
	int userResponse = [_eventData userResponse];
	if (userResponse!=-1){
		if (recognizer.state==UIGestureRecognizerStateBegan){
			[_rejectButton setBackgroundColor:[UIColor colorWithRed:0.75*0.83f green:0.75*0.83f blue:0.75*0.83f alpha:1.00f]];
		}else if (recognizer.state==UIGestureRecognizerStateEnded){
			[_connection respondToEvent:_eventData._id response:[NSNumber numberWithInt:-1]];
			[_eventData reject];
			[self updateResponse];
		}
	}
}

-(void)backToEvents
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
