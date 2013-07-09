//
//  GatherCellData.h
//  Gather
//
//  Created by Taylor Seale on 6/27/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GatherCellData : NSObject

@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *location;
@property (nonatomic,retain) NSString *time;
@property (nonatomic,retain) NSString *group;
@property (nonatomic,assign) int accepts;
@property (nonatomic,assign) int rejects;
@property (nonatomic,assign) int participants;
@property (nonatomic,assign) int response;

-(id)initWithName:(NSString*)name
		 location:(NSString*)location
			 time:(NSString*)time
			group:(NSString*)group
  numParticipants:(int)participants
		  accepts:(int)accepts
		  rejects:(int)rejects
		 response:(int)response;

-(void)addAccept;
-(void)addReject;

@end
