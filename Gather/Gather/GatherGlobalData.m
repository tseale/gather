//
//  GatherGlobalData.m
//  Gather
//
//  Created by Taylor Seale on 7/2/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherGlobalData.h"

@implementation GatherGlobalData

+ (GatherGlobalData *)sharedInstance
{
    static GatherGlobalData *sharedInstance = nil;
    @synchronized(self) {
        if (sharedInstance == nil)
		{
			sharedInstance.addressBook=ABAddressBookCreateWithOptions(NULL, NULL);
			
			sharedInstance = [[GatherGlobalData alloc] init];
			sharedInstance.user_id=@"";
			sharedInstance.user_password=@"";
			sharedInstance.acceptEvents = [[NSMutableArray alloc] init];
			sharedInstance.rejectEvents = [[NSMutableArray alloc] init];
			sharedInstance.noResponseEvents = [[NSMutableArray alloc] init];
			sharedInstance.tableData = [[NSMutableDictionary alloc] initWithObjects:@[sharedInstance.noResponseEvents,
																					  sharedInstance.acceptEvents,
																					  sharedInstance.rejectEvents]
																			forKeys:@[@"No Response",
																					  @"Attending",
																					  @"Not Attending"]];
			sharedInstance.groups=[[NSMutableDictionary alloc] initWithObjects:@[@[@"Mom",@"Dad",@"Aimee Seale",@"Nathan Seale"],
																				 @[@"Jimmy Antoniotti",@"Dan Bettencourt",@"Mike O'Connor",@"Ka Hin Lee",@"Ryan Shea"],
																				 @[@"Akum Gill",@"Brendan Ryan",@"Chas Jhin",@"Jeremy Vercillo"],
																				 @[@"Chas Jhin",@"Ryan Shea",@"Ashley Taylor",@"Pat Raycroft",@"Justin Bartlett"]]
																	   forKeys:@[@"Family",
																				 @"Sorin Bros",
																				 @"Twerk Team",
																				 @"CS Study Group"]];
		}
    }
    return sharedInstance;
}

@end
