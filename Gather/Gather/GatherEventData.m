//
//  GatherEventData.m
//  Gather
//
//  Created by Taylor Seale on 6/27/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherEventData.h"
#import "GatherUserResponseData.h"

#define CURRENT_USER [_who objectForKey:USER_ID]

@implementation GatherEventData

-(id)init
{
	_who=[[NSMutableDictionary alloc] init];
	return self;
}

-(void)accept
{
	GatherUserResponseData *user = CURRENT_USER;
	NSLog(@"%d",user.user_response);
	if (user.user_response==-1){
		NSLog(@"accept");
		_rejects-=1;
	}
	_accepts+=1;
	[user setUser_response:1];
	NSLog(@"%d",user.user_response);
}

-(void)reject
{
	GatherUserResponseData *user = CURRENT_USER;
	NSLog(@"%d",user.user_response);
	if(user.user_response==1){
		NSLog(@"reject");
		_accepts-=1;
	}
	_rejects+=1;
	[user setUser_response:-1];
	NSLog(@"%d",user.user_response);
}

@end
