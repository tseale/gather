//
//  GatherEventViewController.h
//  Gather
//
//  Created by Taylor Seale on 7/24/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GatherServerConnection.h"
#import "GatherEventTopBar.h"
#import "GatherEventData.h"

@interface GatherEventViewController : UIViewController

@property (nonatomic,strong) GatherServerConnection	*connection;

@property (nonatomic,strong) GatherEventTopBar *topBar;
@property (nonatomic,strong) GatherEventData *eventData;

@property (nonatomic,strong) UILabel* eventDetails;

@property (nonatomic,strong) UILabel* acceptButton;
@property (nonatomic,strong) UILabel* rejectButton;

-(id)initWithEvent:(GatherEventData*)event;

@end
