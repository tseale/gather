//
//  GatherViewController.m
//  Gather
//
//  Created by Taylor Seale on 6/17/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherViewController.h"
#import <QuartzCore/QuartzCore.h>

#define TOP_BAR_HEIGHT 66

@interface GatherViewController ()

@end

@implementation GatherViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	_topBar = [[GatherTopBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, TOP_BAR_HEIGHT)];
	[self.view addSubview:_topBar];
	
	_tableData = [[NSMutableArray alloc] init];
	GatherCellData *data = [[GatherCellData alloc] initWithName:@"Wing Night"
													   location:@"Brother's Bar & Grill"
														   time:@"Wednesday 9:00 PM"
														  group:@"Sorin Bros"
												numParticipants:10
													   response:0];
	[_tableData addObject:data];
	
	_eventsTable = [[GatherEventsTableView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height-TOP_BAR_HEIGHT)];
	[_eventsTable setDelegate:self];
	[_eventsTable setDataSource:self];
	[_eventsTable setBounces:NO];
	[_eventsTable reloadData];
	[self.view addSubview:_eventsTable];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(addEventToTable:)
												 name:@"addEvent"
											   object:nil];
}

- (void) addEventToTable:(NSNotification *) notification
{
	GatherCellData *data = [[GatherCellData alloc] initWithName:@"Wing Night"
													   location:@"Brother's Bar & Grill"
														   time:@"Wednesday 9:00 PM"
														  group:@"Sorin Bros"
												numParticipants:10
													   response:YES];
	[_tableData	insertObject:data atIndex:0];
	[_eventsTable reloadData];
	[_eventsTable setContentOffset:CGPointMake(0, 75) animated:NO];
	[_eventsTable setContentOffset:CGPointMake(0, 0) animated:YES];
	//[[_events objectAtIndex:0] addText];
	
}


-(void)addEvent
{
	//[_eventsTable insertRowsAtIndexPaths:@[@0] withRowAnimation:UITableViewRowAnimationNone];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    GatherEventsTableViewCell *cell = [_eventsTable dequeueReusableCellWithIdentifier:@"Cell"];
	
    if (cell == nil) {
        cell = [[GatherEventsTableViewCell alloc] initWithData:[_tableData objectAtIndex:indexPath.row]];
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
	[[_tableData objectAtIndex:index.row] addAccept];
}

-(void)shiftCellOverlayReject:(UILongPressGestureRecognizer*)recognizer
{
	GatherEventsTableViewCell *cell = (GatherEventsTableViewCell *)recognizer.view;
	NSIndexPath *index = [_eventsTable indexPathForCell:cell];
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
	[[_tableData objectAtIndex:index.row] addReject];
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
	[self performSelector:@selector(refresh) withObject:cell afterDelay:0.4];
}

-(void)refresh
{
	[_eventsTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
