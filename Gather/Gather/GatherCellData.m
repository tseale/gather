//
//  GatherCellData.m
//  Gather
//
//  Created by Taylor Seale on 6/27/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherCellData.h"

@implementation GatherCellData

-(id)initWithName:(NSString*)name
		 location:(NSString*)location
			 time:(NSString*)time
			group:(NSString*)group
  numParticipants:(int)participants
		 response:(int)response
{
	self.eventName=name;
	self.eventLocation=location;
	self.eventTime=time;
	self.eventGroup=group;
	self.participants=participants;
	self.response=response;
	return self;
}


-(void)addAccept
{
	if ((_accepts+_rejects)<_participants){
		_accepts+=1;
	}else{
		if ((_accepts)<_participants){
			_accepts+=1;
			_rejects-=1;
		}
	}
	_response=1;
}

-(void)addReject
{
	if ((_accepts+_rejects)<_participants){
		_rejects+=1;
	}else{
		if ((_rejects)<_participants){
			_rejects+=1;
			_accepts-=1;
		}
	}
	_response=-1;
}

@end
