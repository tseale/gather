//
//  GatherGlobalData.h
//  Gather
//
//  Created by Taylor Seale on 7/2/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GatherGlobalData : NSObject

@property (nonatomic,retain) NSMutableDictionary *tableData;
@property (nonatomic,retain) NSMutableArray *acceptEvents;
@property (nonatomic,retain) NSMutableArray *rejectEvents;
@property (nonatomic,retain) NSMutableArray *noResponseEvents;

@end
