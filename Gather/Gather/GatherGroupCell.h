//
//  GatherGroupCell.h
//  Gather
//
//  Created by Taylor Seale on 7/30/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GatherGroupCell : UITableViewCell

@property (nonatomic,strong) UILabel* groupName;
@property (nonatomic,strong) UILabel* preview;

- (id)initWithGroupName:(NSString*)groupName;

@end
