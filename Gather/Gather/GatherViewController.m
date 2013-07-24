//
//  GatherViewController.m
//  Gather
//
//  Created by Taylor Seale on 6/17/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import "SSKeychain.h"

#define TOP_BAR_HEIGHT 64

@interface GatherViewController ()

@end

@implementation GatherViewController

-(void)viewWillAppear:(BOOL)animated
{
	_connection = [[GatherServerConnection alloc] init];
	[_connection getAllEventsForUser];
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
		[_statusLabel setText:@"Connection\nFailure :("];
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
	
	_statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2.0-self.view.bounds.size.width/4.0, self.view.bounds.size.height/2.0-150, self.view.bounds.size.width/2.0, 100)];
	[_statusLabel setBackgroundColor:[UIColor lightGrayColor]];
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
	[SSKeychain deletePasswordForService:SERVICE_NAME account:USER_ID];
	NSLog(@"Password removed from keychain");
	/*
	GatherEventData *data = [[GatherEventData alloc] init];
	//[[TABLE_DATA objectForKey:@"Attending"] insertObject:data atIndex:0];
	//[_eventsTable reloadData];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
	[[TABLE_DATA objectForKey:@"Attending"] insertObject:data atIndex:0];
	[_eventsTable numberOfRowsInSection:1];
	[_eventsTable insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
	 */
}


-(void)addEvent
{
	NSLog(@"Here");
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
	
	UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, 21, self.view.bounds.size.width, 1)];
	[separatorLine setBackgroundColor:[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f]];
	[sectionHeader addSubview:separatorLine];
	return sectionHeader;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return	[[TABLE_DATA objectForKey:[self returnKey:section]] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return 22;
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
		
		/*
		UILongPressGestureRecognizer *showEvent = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showEvent:)];
		[showEvent setMinimumPressDuration:0.0f];
		[cell addGestureRecognizer:showEvent];
		*/
		
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
	return cell;
	
}

-(void)showEvent:(UILongPressGestureRecognizer*)recognizer
{
	//GatherEventsTableViewCell *cell = (GatherEventsTableViewCell *)recognizer.view;
	if(recognizer.state==UIGestureRecognizerStateBegan){
		NSLog(@"Start");
		//[cell setBackgroundColor:[UIColor colorWithRed:0.91f green:0.91f blue:0.91f alpha:1.00f]];
	}else if(recognizer.state==UIGestureRecognizerStateEnded){
		NSLog(@"Ended");
		//[cell setBackgroundColor:[UIColor whiteColor]];
	}
}


-(void)shiftCellOverlayAccept:(UISwipeGestureRecognizer*)recognizer
{
	// cell information
	GatherEventsTableViewCell *cell = (GatherEventsTableViewCell *)recognizer.view;
	NSIndexPath *index = [_eventsTable indexPathForCell:cell];
	
	if (index.section!=1){
	// shift and delete original cell
	[cell.background setBackgroundColor:GREEN_COLOR];
	CGRect shiftCellFrame = cell.cellOverlay.frame;
	shiftCellFrame.origin.x=cell.frame.size.width;
	[UIView animateWithDuration:0.3f
						  delay:0.0
						options:UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 cell.cellOverlay.frame=shiftCellFrame;
					 }
					 completion:^(BOOL finished){}
	 ];
	[self performSelector:@selector(deleteCellAccept:) withObject:cell afterDelay:0.4];
	}
}

-(void)deleteCellAccept:(GatherEventsTableViewCell*)cell
{
	NSIndexPath *index = [_eventsTable indexPathForCell:cell];
	GatherEventData *data=[[TABLE_DATA objectForKey:[self returnKey:index.section]] objectAtIndex:index.row];
	[[TABLE_DATA objectForKey:[self returnKey:index.section]] removeObjectAtIndex:index.row];
	[_eventsTable numberOfRowsInSection:index.section];
	[_eventsTable deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
	
	usleep(1000);
	
	// add new cell
	[[TABLE_DATA objectForKey:@"Attending"] addObject:data];
	[_eventsTable numberOfRowsInSection:1];
	NSIndexPath *addIndex = [NSIndexPath indexPathForRow:[[TABLE_DATA objectForKey:@"Attending"] count]-1 inSection:1];
	[[[TABLE_DATA objectForKey:@"Attending"] objectAtIndex:[[TABLE_DATA objectForKey:@"Attending"] count]-1] accept];
	[_eventsTable insertRowsAtIndexPaths:@[addIndex] withRowAnimation:UITableViewRowAnimationBottom];
}

-(void)shiftCellOverlayReject:(UISwipeGestureRecognizer*)recognizer
{
	// cell information
	GatherEventsTableViewCell *cell = (GatherEventsTableViewCell *)recognizer.view;
	NSIndexPath *index = [_eventsTable indexPathForCell:cell];
	
	if(index.section!=2){
	// shift and delete original cell
	[cell.background setBackgroundColor:RED_COLOR];
	[cell.quickResponseLabel setText:@"x"];
	CGRect shiftCellFrame = cell.cellOverlay.frame;
	shiftCellFrame.origin.x=-1*cell.frame.size.width;
	[UIView animateWithDuration:0.3f
						  delay:0.0
						options:UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 cell.cellOverlay.frame=shiftCellFrame;
					 }
					 completion:^(BOOL finished){}
	 ];
	[self performSelector:@selector(deleteCellReject:) withObject:cell afterDelay:0.3];
	}
}

-(void)deleteCellReject:(GatherEventsTableViewCell*)cell
{
	NSIndexPath *index = [_eventsTable indexPathForCell:cell];
	GatherEventData *data=[[TABLE_DATA objectForKey:[self returnKey:index.section]] objectAtIndex:index.row];
	[[TABLE_DATA objectForKey:[self returnKey:index.section]] removeObjectAtIndex:index.row];
	[_eventsTable numberOfRowsInSection:index.section];
	[_eventsTable deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
	
	usleep(1000);
	
	// add new cell
	[[TABLE_DATA objectForKey:@"Not Attending"] addObject:data];
	[_eventsTable numberOfRowsInSection:2];
	NSIndexPath *addIndex = [NSIndexPath indexPathForRow:[[TABLE_DATA objectForKey:@"Not Attending"] count]-1 inSection:2];
	[[[TABLE_DATA objectForKey:@"Not Attending"] objectAtIndex:[[TABLE_DATA objectForKey:@"Not Attending"] count]-1] reject];
	[_eventsTable insertRowsAtIndexPaths:@[addIndex] withRowAnimation:UITableViewRowAnimationTop];
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
	[_connection getAllEventsForUser];
	[_pullToRefresh endRefreshing];
}

@end
