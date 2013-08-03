//
//  GatherGroupPreviewTable.m
//  Gather
//
//  Created by Taylor Seale on 8/1/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherGroupPreviewTable.h"

@implementation GatherGroupPreviewTable

- (id)initWithGroup:(NSString*)group
{
	_group=[GROUPS objectForKey:group];
    self = [super initWithFrame:CGRectMake(0, 44, 280,_group.count*44)];
    if (self) {
		[self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		self.delegate=self;
		self.dataSource=self;
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
	GatherGroupMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	
	if (cell == nil)
	{
		cell = [[GatherGroupMemberCell alloc] initWithName:[_group objectAtIndex:indexPath.row]];
	}
	
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	[cell setUserInteractionEnabled:YES];
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
}

@end
