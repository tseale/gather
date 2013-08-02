//
//  GatherGroupView.m
//  Gather
//
//  Created by Taylor Seale on 7/31/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherGroupView.h"

@implementation GatherGroupView

- (id)initWithGroup:(NSString *)group
{
	_group=[GROUPS objectForKey:group];
    self = [super initWithFrame:CGRectMake(10, 0, 300,_group.count*44+76.5)];
    if (self) {
		
		[self setBackgroundColor:[UIColor colorWithRed:0.99f green:0.99f blue:0.99f alpha:1.00f]];
		self.layer.borderColor = [UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f].CGColor;
		self.layer.borderWidth = 1.0f;
		
		_searchContactsBox = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 280, 36.5)];
		[_searchContactsBox setBackgroundColor:[UIColor colorWithRed:1.05*0.90f green:1.05*0.90f blue:1.05*0.90f alpha:1.00f]];
		[self addSubview:_searchContactsBox];
		_searchContacts = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 260, 36.5)];
		[_searchContacts setBackgroundColor:[UIColor clearColor]];
		[_searchContacts setPlaceholder:@"Add to group"];
		[_searchContacts setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
		[_searchContacts setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
		[_searchContacts setDelegate:self];
		[_searchContacts setReturnKeyType:UIReturnKeyJoin];
		[_searchContactsBox addSubview:_searchContacts];
		//[_eventName addTarget:self action:@selector(enableKeyboardHide) forControlEvents:UIControlEventEditingDidBegin];
		
		UIView* groupline = [[UIView alloc] initWithFrame:CGRectMake(10, 56.5, 280, 1)];
		[groupline setBackgroundColor:[UIColor colorWithRed:1.05*0.90f green:1.05*0.90f blue:1.05*0.90f alpha:1.00f]];
		[self addSubview:groupline];
		
		_groupMembers = [[UITableView alloc] initWithFrame:CGRectMake(10, 66.5, 280, _group.count*44)];
		[_groupMembers setBackgroundColor:[UIColor clearColor]];
		_groupMembers.delegate=self;
		_groupMembers.dataSource=self;
		[_groupMembers setBounces:NO];
		[_groupMembers setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		[self addSubview:_groupMembers];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
    return _group.count;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:MyIdentifier];
	}
	
	// Here we use the provided setImageWithURL: method to load the web image
	// Ensure you use a placeholder image otherwise cells will be initialized with no image
	cell.textLabel.text = [_group objectAtIndex:indexPath.row];
	return cell;
}

@end
