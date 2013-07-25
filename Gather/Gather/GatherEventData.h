//
//  GatherEventData.h
//  Gather
//
//  Created by Taylor Seale on 6/27/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GatherEventData : NSObject

@property (nonatomic,strong) NSString *what;
@property (nonatomic,strong) NSString *where;
@property (nonatomic,strong) NSString *when;
@property (nonatomic,strong) NSString *group;
@property (nonatomic,assign) int accepts;
@property (nonatomic,assign) int rejects;
@property (nonatomic,assign) int total;
@property (nonatomic,strong) NSMutableDictionary *who;
@property (nonatomic,strong) NSMutableArray *suggestions;
@property (nonatomic,assign) int _id;

-(void)accept;
-(void)reject;

@end
