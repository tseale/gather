//
//  GatherViewController.m
//  Gather
//
//  Created by Taylor Seale on 6/17/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherViewController.h"
#import <QuartzCore/QuartzCore.h>

#define TOP_BAR_HEIGHT 64

@interface GatherViewController ()

@end

@implementation GatherViewController

-(void)viewWillAppear:(BOOL)animated
{
	_connection = [[GatherServerConnection alloc] init];
	[_connection connectToURL:@"http://198.58.109.224:8002/events/"];
}

-(void)showTable:(NSNotification*)notification
{
	[_loadingView removeFromSuperview];
	if ([[notification name] isEqualToString:@"dataLoadSuccess"]) {
		if (TABLE_DATA.count!=0){
			[_eventsTable reloadData];
			[_statusLabel setHidden:YES];
		}else{
			[_statusLabel setText:@"No Events"];
			[_statusLabel setHidden:NO];
			[_eventsTable reloadData];
		}
	}else if ([[notification name] isEqualToString:@"dataLoadFailure"]){
		[_statusLabel setText:@"Data Retrieval Failure"];
		[_statusLabel setHidden:NO];
		[_eventsTable reloadData];
	}else if ([[notification name] isEqualToString:@"connectionFailure"]){
		[_statusLabel setText:@"Connection Failure :("];
		[_statusLabel setHidden:NO];
		[_eventsTable reloadData];
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	_topBar = [[GatherTopBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, TOP_BAR_HEIGHT)];
	[self.view addSubview:_topBar];
	
	_initialView = [[UIView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height-TOP_BAR_HEIGHT)];
	[_initialView setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[self.view addSubview:_initialView];
	
	_loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	[_loadingView setBackgroundColor:[UIColor clearColor]];
	[_loadingView setFrame:CGRectMake(0, TOP_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height-TOP_BAR_HEIGHT-30)];
	[_loadingView startAnimating];
	[self.view addSubview:_loadingView];
	
	_eventsTable = [[GatherEventsTableView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height-TOP_BAR_HEIGHT)];
	[_eventsTable setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_eventsTable setDelegate:self];
	[_eventsTable setDataSource:self];
	[_eventsTable setBounces:YES];
	[_eventsTable setShowsVerticalScrollIndicator:NO];
	_pullToRefresh = [[UIRefreshControl alloc] init];
	[_pullToRefresh addTarget:self action:@selector(refreshFromConnection) forControlEvents:UIControlEventValueChanged];
	[_eventsTable addSubview:_pullToRefresh];
	[self.view addSubview:_eventsTable];
	
	_statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2.0-100, self.view.bounds.size.width, 30)];
	[_statusLabel setBackgroundColor:[UIColor clearColor]];
	[_statusLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20.0f]];
	[_statusLabel setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
	[_statusLabel setTextAlignment:NSTextAlignmentCenter];
	[_statusLabel setHidden:YES];
	[_eventsTable addSubview:_statusLabel];
	
	_loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	[_loadingView setBackgroundColor:[UIColor clearColor]];
	[_loadingView setFrame:CGRectMake(0, TOP_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height-TOP_BAR_HEIGHT)];
	[_loadingView startAnimating];
	[self.view addSubview:_loadingView];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(addEventToTable:)
												 name:@"addEvent"
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(showTable:)
												 name:@"dataLoadSuccess"
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(showTable:)
												 name:@"dataLoadFailure"
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(showTable:)
												 name:@"connectionFailure"
											   object:nil];
}

- (void) addEventToTable:(NSNotification *) notification
{
	[_eventsTable reloadData];
	/*
	GatherEventData *data = [[GatherEventData alloc] initWithName:@"Beer & Bacon"
													   location:@"Wando's Bar"
														   time:@"Tuesday 9:00 PM"
														  group:@"Da Crew"
												numParticipants:10
													   response:0];
	[[TABLE_DATA	objectForKey:@"No Response"] insertObject:data atIndex:0];
	[_eventsTable reloadData];
	[_eventsTable setContentOffset:CGPointMake(0, 75) animated:NO];
	[_eventsTable setContentOffset:CGPointMake(0, 0) animated:YES];
	 */
	
}


-(void)addEvent
{
	//[_eventsTable insertRowsAtIndexPaths:@[@0] withRowAnimation:UITableViewRowAnimationNone];
}

-(NSString*)returnKey:(NSInteger)section
{
	NSString *key;
	switch (section) {
		case 0:
			key=@"No Response";
			break;
		case 1:
			key=@"Attending";
			break;
		case 2:
			key=@"Not Attending";
			break;
			
		default:
			break;
	}
	return key;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return TABLE_DATA.count;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 22)];
	[sectionHeader setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	UILabel *sectionTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 22)];
	[sectionTitle setText:[self returnKey:section]];
	[sectionTitle setBackgroundColor:[UIColor clearColor]];
	[sectionTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f]];
	if (section==0){
		[sectionTitle setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:0.5f]];
	}else if (section==1){
		[sectionTitle setTextColor:[UIColor colorWithRed:0.16f green:0.77f blue:0.09f alpha:0.5f]];
	}else if (section==2){
		[sectionTitle setTextColor:[UIColor colorWithRed:1.00f green:0.23f blue:0.19f alpha:0.5f]];
	}
	[sectionTitle setTextAlignment:NSTextAlignmentCenter];
	[sectionHeader addSubview:sectionTitle];
	return sectionHeader;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return	[[TABLE_DATA objectForKey:[self returnKey:section]] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	if ([[TABLE_DATA objectForKey:[self returnKey:section]] count]==0){
		return 0;
	}else{
		return 22;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row==([[TABLE_DATA objectForKey:[self returnKey:indexPath.section]] count]-1)){
		return 75.0f;
	}else{
		return 76.0f;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    GatherEventsTableViewCell *cell = [_eventsTable dequeueReusableCellWithIdentifier:@"Cell"];
	
    if (cell == nil) {
        cell = [[GatherEventsTableViewCell alloc] initWithData:[[TABLE_DATA objectForKey:[self returnKey:indexPath.section]] objectAtIndex:indexPath.row]];
		UISwipeGestureRecognizer *shiftCellOverlayAccept = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(shiftCellOverlayAccept:)];
		[shiftCellOverlayAccept setNumberOfTouchesRequired:1];
		[shiftCellOverlayAccept setDirection:UISwipeGestureRecognizerDirectionRight];
		[cell addGestureRecognizer:shiftCellOverlayAccept];
		UISwipeGestureRecognizer *shiftCellOverlayReject = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(shiftCellOverlayReject:)];
		[shiftCellOverlayReject setNumberOfTouchesRequired:1];
		[shiftCellOverlayReject setDirection:UISwipeGestureRecognizerDirectionLeft];
		[cell addGestureRecognizer:shiftCellOverlayReject];
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
	return cell;
	
}


-(void)shiftCellOverlayAccept:(UILongPressGestureRecognizer*)recognizer
{
	GatherEventsTableViewCell *cell = (GatherEventsTableViewCell *)recognizer.view;
	NSIndexPath *index = [_eventsTable indexPathForCell:cell];
	if (index.section!=1){
		CGRect shiftCellFrame = cell.cellOverlay.frame;
		shiftCellFrame.origin.x=cell.frame.size.width/4.0;
		[UIView animateWithDuration:0.3f
							  delay:0.0
							options:UIViewAnimationOptionCurveEaseIn
						 animations:^{
							 cell.cellOverlay.frame=shiftCellFrame;
						 }
						 completion:^(BOOL finished){}
		 ];
		[self performSelector:@selector(returnCell:) withObject:cell afterDelay:0.3];
		[[[TABLE_DATA objectForKey:[self returnKey:index.section]] objectAtIndex:index.row] accept];
		[[TABLE_DATA objectForKey:@"Attending"] insertObject:[[TABLE_DATA objectForKey:[self returnKey:index.section]] objectAtIndex:index.row]
													 atIndex:0];
		[[TABLE_DATA objectForKey:[self returnKey:index.section]] removeObjectAtIndex:index.row];
	}
}

-(void)shiftCellOverlayReject:(UILongPressGestureRecognizer*)recognizer
{
	GatherEventsTableViewCell *cell = (GatherEventsTableViewCell *)recognizer.view;
	NSIndexPath *index = [_eventsTable indexPathForCell:cell];
	if (index.section!=2){
		CGRect shiftCellFrame = cell.cellOverlay.frame;
		shiftCellFrame.origin.x=-1*(cell.frame.size.width/4.0);
		[UIView animateWithDuration:0.3f
							  delay:0.0
							options:UIViewAnimationOptionCurveEaseIn
						 animations:^{
							 cell.cellOverlay.frame=shiftCellFrame;
						 }
						 completion:^(BOOL finished){}
		 ];
		[self performSelector:@selector(returnCell:) withObject:cell afterDelay:0.3];
		[[[TABLE_DATA objectForKey:[self returnKey:index.section]] objectAtIndex:index.row] reject];
		[[TABLE_DATA objectForKey:@"Not Attending"] insertObject:[[TABLE_DATA objectForKey:[self returnKey:index.section]] objectAtIndex:index.row]
														 atIndex:0];
		[[TABLE_DATA objectForKey:[self returnKey:index.section]] removeObjectAtIndex:index.row];
	}
}

-(void)returnCell:(GatherEventsTableViewCell*)cell
{
	CGRect shiftCellFrame = cell.cellOverlay.frame;
	shiftCellFrame.origin.x=0;
	[UIView animateWithDuration:0.3f
						  delay:0.1
						options:UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 cell.cellOverlay.frame=shiftCellFrame;
					 }
					 completion:^(BOOL finished){}
	 ];
	[self performSelector:@selector(refreshFromData) withObject:nil afterDelay:0.4];
}

-(void)refreshFromData
{
	[_eventsTable reloadData];
}

-(void)refreshFromConnection
{
	[_pullToRefresh beginRefreshing];
	[_connection connectToURL:@"http://198.58.109.224:8002/events/"];
	[_pullToRefresh endRefreshing];
}

@end
