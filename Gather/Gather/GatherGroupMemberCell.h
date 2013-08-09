//
//  GatherGroupMemberCell.h
//  Gather
//
//  Created by Taylor Seale on 8/1/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GatherGroupMemberCell : UITableViewCell

@property (nonatomic,strong) UILabel* name;
@property (nonatomic,strong) UILabel* deleteButton;

@property (nonatomic,assign) BOOL removed;

@property (nonatomic,assign) CGSize nameSize;

- (id)initWithName:(NSString*)name;

@end
