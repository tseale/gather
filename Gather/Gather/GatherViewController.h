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

@end
