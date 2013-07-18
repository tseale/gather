//
//  GatherSuggestionData.h
//  Gather
//
//  Created by Taylor Seale on 7/9/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GatherSuggestionData : NSObject

@property (nonatomic,retain) NSString *what;
@property (nonatomic,retain) NSString *where;
@property (nonatomic,retain) NSString *when;
@property (nonatomic,retain) NSMutableArray *who;

@end
