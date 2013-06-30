//
//  GatherCellData.h
//  Gather
//
//  Created by Taylor Seale on 6/27/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GatherCellData : NSObject

@property (nonatomic,retain) NSString *eventName;
@property (nonatomic,retain) NSString *eventLocation;
@property (nonatomic,retain) NSString *eventTime;
@property (nonatomic,retain) NSString *eventGroup;
@property (nonatomic,assign) int accepts;
@property (nonatomic,assign) int rejects;
@property (nonatomic,assign) int participants;
@property (nonatomic,assign) int response;

-(id)initWithName:(NSString*)name
		 location:(NSString*)location
			 time:(NSString*)time
			group:(NSString*)group
  numParticipants:(int)participants
		 response:(int)response;

-(void)addAccept;
-(void)addReject;

@end
