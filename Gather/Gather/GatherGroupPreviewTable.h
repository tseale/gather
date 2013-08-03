//
//  GatherGroupPreviewTable.h
//  Gather
//
//  Created by Taylor Seale on 8/1/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GatherGroupMemberCell.h"
#import "GatherGlobalData.h"

@interface GatherGroupPreviewTable : UITableView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray* group;
-(id)initWithGroup:(NSString*)group;

@end
