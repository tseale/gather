//
//  GatherEventData.h
//  Gather
//
//  Created by Taylor Seale on 6/27/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GatherEventData : NSObject

@property (nonatomic,retain) NSString *what;
@property (nonatomic,retain) NSString *where;
@property (nonatomic,retain) NSString *when;
@property (nonatomic,retain) NSString *group;
@property (nonatomic,assign) int accepts;
@property (nonatomic,assign) int rejects;
@property (nonatomic,assign) int total;
@property (nonatomic,retain) NSMutableDictionary *who;
@property (nonatomic,retain) NSMutableArray *suggestions;
@property (nonatomic,assign) int _id;

-(void)accept;
-(void)reject;

@end
