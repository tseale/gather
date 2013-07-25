//
//  GatherSuggestionData.h
//  Gather
//
//  Created by Taylor Seale on 7/9/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GatherSuggestionData : NSObject

@property (nonatomic,strong) NSString *what;
@property (nonatomic,strong) NSString *where;
@property (nonatomic,strong) NSString *when;
@property (nonatomic,strong) NSMutableArray *who;

@end
