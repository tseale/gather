//
//  GatherEventsTableView.m
//  Gather
//
//  Created by Taylor Seale on 6/22/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherEventsTableView.h"

@implementation GatherEventsTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		[self setRowHeight:75];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
