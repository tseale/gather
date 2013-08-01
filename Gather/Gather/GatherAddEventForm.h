//
//  GatherAddEventForm.h
//  Gather
//
//  Created by Taylor Seale on 7/28/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GatherDatePickerLabel.h"
#import "GatherGroupCell.h"

@interface GatherAddEventForm : UIView <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView* eventNameBox;
@property (nonatomic,strong) UITextField* eventName;

@property (nonatomic,strong) UIView* eventLocationBox;
@property (nonatomic,strong) UITextField* eventLocation;

@property (nonatomic,strong) UIView* eventTimeDateBox;
@property (nonatomic,strong) GatherDatePickerLabel* eventTimeDate;
@property (nonatomic,strong) UIDatePicker* dateTimePicker;

@property (nonatomic,strong) NSDateFormatter* formatter;

@property (nonatomic,strong) UITableView* groupTable;

@property (nonatomic,strong) NSArray* groups;

@property (nonatomic,strong) UITapGestureRecognizer* tapHideKeyboard;

@end
