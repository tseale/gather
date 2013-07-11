//
//  GatherEventsTableViewCell.h
//  Gather
//
//  Created by Taylor Seale on 6/22/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GatherEventData.h"

@interface GatherEventsTableViewCell : UITableViewCell

@property (nonatomic,strong) UIView *cellOverlay;

@property (nonatomic,retain) NSString *eventName;
@property (nonatomic,retain) NSString *eventLocation;
@property (nonatomic,retain) NSString *eventTime;
@property (nonatomic,retain) NSString *eventGroup;
@property (nonatomic,assign) int accepts;
@property (nonatomic,assign) int rejects;
@property (nonatomic,assign) int participants;
@property (nonatomic,assign) int increment;
@property (nonatomic,assign) int response;


@property (nonatomic,strong) UILabel *eventTitle;
@property (nonatomic,strong) UILabel *eventSubtitle;
@property (nonatomic,strong) UILabel *responseLabel;

@property (nonatomic,strong) UIView *acceptLine;
@property (nonatomic,strong) UIView *rejectLine;
@property (nonatomic,strong) UIView *progressLine;

@property (nonatomic,strong) UIView *responseTab;

@property (nonatomic,strong) UIView *background;
@property (nonatomic,strong) UILabel *quickResponseLabel;

-(id)initWithData:(GatherEventData*)data;

-(void)addText;

@end
