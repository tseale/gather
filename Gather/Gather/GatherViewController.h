//
//  GatherViewController.h
//  Gather
//
//  Created by Taylor Seale on 6/17/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GatherTopBar.h"
#import "GatherEventsTableView.h"
#import "GatherEventsTableViewCell.h"
#import "GatherCellData.h"
#import "GatherServerConnection.h"

@interface GatherViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>

@property (nonatomic,strong) GatherTopBar *topBar;
@property (nonatomic,strong) GatherEventsTableView *eventsTable;
@property (nonatomic,strong) GatherServerConnection	*connection;

// these will be made global with GCD
@property (nonatomic,retain) NSMutableDictionary *tableData;
@property (nonatomic,retain) NSMutableArray *acceptEvents;
@property (nonatomic,retain) NSMutableArray *rejectEvents;
@property (nonatomic,retain) NSMutableArray *noResponseEvents;

@end
