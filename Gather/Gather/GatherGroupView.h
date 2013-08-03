//
//  GatherGroupView.h
//  Gather
//
//  Created by Taylor Seale on 7/31/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GatherGlobalData.h"
#import "GatherGroupMemberCell.h"

@interface GatherGroupView : UIView <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView* searchContactsBox;
@property (nonatomic,strong) UITextField* searchContacts;
@property (nonatomic,strong) UITableView* groupMembers;
@property (nonatomic,strong) NSArray* group;

-(id)initWithGroup:(NSString*)group;

@end
