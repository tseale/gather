//
//  GatherGlobalData.h
//  Gather
//
//  Created by Taylor Seale on 7/2/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GatherGlobalData : NSObject

+(GatherGlobalData *)sharedInstance;

@property (nonatomic,strong) NSMutableDictionary *tableData;
@property (nonatomic,strong) NSMutableArray *acceptEvents;
@property (nonatomic,strong) NSMutableArray *rejectEvents;
@property (nonatomic,strong) NSMutableArray *noResponseEvents;
@property (nonatomic,strong) NSString *user_id;
@property (nonatomic,strong) NSString *user_password;

@property (nonatomic,strong) NSMutableDictionary *groups;

@end
