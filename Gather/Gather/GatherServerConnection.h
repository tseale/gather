//
//  GatherServerConnection.h
//  Gather
//
//  Created by Taylor Seale on 7/2/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "SBJson.h"

#import "GatherEventData.h"
#import "GatherUserResponseData.h"
#import "GatherSuggestionData.h"
#import "GatherGlobalData.h"

@interface GatherServerConnection : NSObject

-(id)init;
-(BOOL)getAllEventsForUser;

@end
