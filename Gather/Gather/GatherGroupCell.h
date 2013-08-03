//
//  GatherGroupCell.h
//  Gather
//
//  Created by Taylor Seale on 7/30/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GatherGroupPreviewTable.h"

@interface GatherGroupCell : UITableViewCell

@property (nonatomic,strong) UILabel* groupName;
@property (nonatomic,strong) UILabel* preview;
@property (nonatomic,strong) GatherGroupPreviewTable* groupInfo;

@property (nonatomic,assign) BOOL previewShown;

- (id)initWithGroupName:(NSString*)groupName;
-(void)showGroupPreview;

@end
