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
#import "GatherEventData.h"
#import "GatherServerConnection.h"
#import "GatherEventViewController.h"

@interface GatherViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) GatherTopBar *topBar;
@property (nonatomic,strong) GatherEventsTableView *eventsTable;
@property (nonatomic,strong) GatherServerConnection	*connection;

@property (nonatomic,strong) UIView *initialView;
@property (nonatomic,strong) UILabel *statusLabel;

@property (nonatomic,strong) UIActivityIndicatorView *loadingView;
@property (nonatomic,strong) UIRefreshControl *pullToRefresh;

@end
