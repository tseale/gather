//
//  GatherAddEventForm.m
//  Gather
//
//  Created by Taylor Seale on 7/28/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherAddEventForm.h"
#import <QuartzCore/QuartzCore.h>

@implementation GatherAddEventForm

- (id)init
{
    self = [super initWithFrame:CGRectMake(10, 10, 300, 159.5+(GROUPS.count+1)*44+10)];
    if (self) {
		
        [self setBackgroundColor:[UIColor colorWithRed:0.99f green:0.99f blue:0.99f alpha:1.00f]];
		self.layer.borderColor = [UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f].CGColor;
		self.layer.borderWidth = 1.0f;
		_tapHideKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
		[self addGestureRecognizer:_tapHideKeyboard];
		
		_eventNameBox = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 280, 36.5)];
		[_eventNameBox setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
		[self addSubview:_eventNameBox];
		_eventName = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 260, 36.5)];
		[_eventName setBackgroundColor:[UIColor clearColor]];
		[_eventName setPlaceholder:@"What"];
		[_eventName setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
		[_eventName setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
		[_eventName setDelegate:self];
		[_eventName becomeFirstResponder];
		[_eventName setTag:0];
		[_eventName setReturnKeyType:UIReturnKeyNext];
		[_eventNameBox addSubview:_eventName];
		[_eventName addTarget:self action:@selector(enableKeyboardHide) forControlEvents:UIControlEventEditingDidBegin];
		
		_eventLocationBox = [[UIView alloc] initWithFrame:CGRectMake(10, 56.5, 280, 36.5)];
		[_eventLocationBox setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
		[self addSubview:_eventLocationBox];
		_eventLocation = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 260, 36.5)];
		[_eventLocation setBackgroundColor:[UIColor clearColor]];
		[_eventLocation setPlaceholder:@"Where"];
		[_eventLocation setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
		[_eventLocation setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
		[_eventLocation setDelegate:self];
		[_eventLocation setTag:1];
		[_eventLocation setReturnKeyType:UIReturnKeyNext];
		[_eventLocationBox addSubview:_eventLocation];
		[_eventLocation addTarget:self action:@selector(enableKeyboardHide) forControlEvents:UIControlEventEditingDidBegin];
		
		_eventTimeDateBox = [[UIView alloc] initWithFrame:CGRectMake(10, 103, 280, 36.5)];
		[_eventTimeDateBox setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
		_eventTimeDate = [[GatherDatePickerLabel alloc] initWithFrame:CGRectMake(10, 0, 260, 36.5)];
		[_eventTimeDate setBackgroundColor:[UIColor clearColor]];
		[_eventTimeDate setPlaceholder:@"When"];
		[_eventTimeDate setText:@""];
		[_eventTimeDate setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
		[_eventTimeDate setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
		[_eventTimeDate setDelegate:self];
		[_eventTimeDate setTag:2];
		_formatter = [[NSDateFormatter alloc] init];
		_formatter.dateFormat = @"EEEE, MMMM d - h:mm a";
		
		UIView* datePicker = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 226)];
		[datePicker setBackgroundColor:[UIColor whiteColor]];
		UIView* topline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
		[topline setBackgroundColor:[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f]];
		[datePicker addSubview:topline];

		UILabel* doneButton = [[UILabel alloc] initWithFrame:CGRectMake(0, 186, 320, 40)];
		[doneButton setBackgroundColor:[UIColor colorWithRed:1.15*0.83f green:1.15*0.83f blue:1.15*0.83f alpha:1.00f]];
		[doneButton setText:@"Next"];
		[doneButton setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]];
		[doneButton setTextColor:[UIColor colorWithRed:0.00f green:0.48f blue:0.99f alpha:1.00f]];
		[doneButton setTextAlignment:NSTextAlignmentCenter];
		[doneButton setUserInteractionEnabled:YES];
		UITapGestureRecognizer *donePickingDate = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(donePickingDate)];
		[doneButton addGestureRecognizer:donePickingDate];
		[datePicker addSubview:doneButton];
		
		UIView* bottomline = [[UIView alloc] initWithFrame:CGRectMake(0, 186, 320, 1)];
		[bottomline setBackgroundColor:[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f]];
		[datePicker addSubview:bottomline];
		
		_dateTimePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, -14, self.frame.size.width, 216)];
		[_eventTimeDate addTarget:self action:@selector(setToDate) forControlEvents:UIControlEventEditingDidBegin];
		[_dateTimePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
		
		[datePicker addSubview:_dateTimePicker];
		[_eventTimeDate setInputView:datePicker];
		[_eventTimeDateBox addSubview:_eventTimeDate];
		[self addSubview:_eventTimeDateBox];
		
		UIView* groupline = [[UIView alloc] initWithFrame:CGRectMake(10, 149.5, 280, 1)];
		[groupline setBackgroundColor:[UIColor colorWithRed:1.05*0.90f green:1.05*0.90f blue:1.05*0.90f alpha:1.00f]];
		[self addSubview:groupline];
		
		_groupTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 159.5, 280, (GROUPS.count+1)*44)];
		[_groupTable setBackgroundColor:[UIColor clearColor]];
		_groupTable.delegate=self;
		_groupTable.dataSource=self;
		[_groupTable setBounces:NO];
		[_groupTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		[self addSubview:_groupTable];
		
    }
    return self;
}

-(void)lightenTextFields
{
	[_eventNameBox setBackgroundColor:[UIColor colorWithRed:1.05*0.90f green:1.05*0.90f blue:1.05*0.90f alpha:1.00f]];
	[_eventLocationBox setBackgroundColor:[UIColor colorWithRed:1.05*0.90f green:1.05*0.90f blue:1.05*0.90f alpha:1.00f]];
	[_eventTimeDateBox setBackgroundColor:[UIColor colorWithRed:1.05*0.90f green:1.05*0.90f blue:1.05*0.90f alpha:1.00f]];
}

-(void)darkenTextFields
{
	[_eventNameBox setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_eventLocationBox setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_eventTimeDateBox setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
    return GROUPS.count+1;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	GatherGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	
	if (cell == nil)
	{
		if (indexPath.row<GROUPS.count){
			cell = [[GatherGroupCell alloc] initWithGroupName:[[GROUPS allKeys] objectAtIndex:indexPath.row]];
		}else{
			cell = [[GatherGroupCell alloc] initWithGroupName:@"+ Create a New Group"];
		}
	}
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	[cell setUserInteractionEnabled:YES];
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GatherGroupCell *selectedCell = (GatherGroupCell*)[tableView cellForRowAtIndexPath:indexPath];
	[selectedCell.groupName setTextColor:[UIColor colorWithRed:0.00f green:0.48f blue:0.99f alpha:1.00f]];
	
		for (GatherGroupCell* cell in [tableView visibleCells]){
			if (![cell isEqual:selectedCell]){
				[cell.preview setHidden:YES];
				[cell.groupName setTextColor:[UIColor blackColor]];
				[cell.groupName setBackgroundColor:[UIColor clearColor]];
				CGRect cellLabelFrame = cell.groupName.frame;
				cellLabelFrame.origin.x=280-cell.groupName.frame.size.width-10;
				[UIView animateWithDuration:0.3f
									  delay:0.0
									options:UIViewAnimationOptionCurveEaseIn
								 animations:^{
									 cell.groupName.frame=cellLabelFrame;
								 }
								 completion:^(BOOL finished){}
				 ];
			}else{
				if (indexPath.row<GROUPS.count){
					[selectedCell.preview setHidden:NO];
					[selectedCell.groupName setBackgroundColor:[UIColor colorWithRed:0.99f green:0.99f blue:0.99f alpha:1.00f]];
					CGRect cellLabelFrame = selectedCell.groupName.frame;
					cellLabelFrame.origin.x=10;
					[UIView animateWithDuration:0.3f
										  delay:0.0
										options:UIViewAnimationOptionCurveEaseIn
									 animations:^{
										 selectedCell.groupName.frame=cellLabelFrame;
									 }
									 completion:^(BOOL finished){}
					 ];
				}
						
			}
		}
}

-(void)enableKeyboardHide
{
	[self darkenTextFields];
	[_groupTable setUserInteractionEnabled:NO];
	[_tapHideKeyboard setEnabled:YES];
}

-(void)hideKeyboard
{
	[_tapHideKeyboard setEnabled:NO];
	[_groupTable setUserInteractionEnabled:YES];
	[self lightenTextFields];
	[self endEditing:YES];
}

-(void)donePickingDate
{
	[self hideKeyboard];
}

-(void)setToDate
{
	[self enableKeyboardHide];
	if ([_eventTimeDate.text isEqualToString:@""]){
		[_eventTimeDate setText:[_formatter stringFromDate:[NSDate date]]];
	}else{
		NSDate* currentDate = [_formatter dateFromString:_eventTimeDate.text];
		[_dateTimePicker setDate:currentDate];
	}
}

- (void)dateChanged
{
	_eventTimeDate.text=@"";
	[_eventTimeDate setText:[_formatter stringFromDate:_dateTimePicker.date]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	switch (textField.tag) {
		case 0:
			[_eventLocation becomeFirstResponder];
			break;
		case 1:
			[_eventTimeDate becomeFirstResponder];
			break;
		default:
			break;
	}
	return YES;
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
