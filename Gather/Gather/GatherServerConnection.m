//
//  GatherServerConnection.m
//  Gather
//
//  Created by Taylor Seale on 7/2/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherServerConnection.h"

@implementation GatherServerConnection

-(id)init
{
	return self;
}

- (BOOL)isDataSourceAvailable
{
	BOOL dataSourceAvailable = NO;
		
        Boolean success;
        const char *host_name = HOST_NAME; // your data source host name
		
        SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host_name);
        SCNetworkReachabilityFlags flags;
        success = SCNetworkReachabilityGetFlags(reachability, &flags);
        dataSourceAvailable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
        CFRelease(reachability);
    return dataSourceAvailable;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[_jsonData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	// this is an array to hold dictionaries
	NSArray *eventsJSON = [NSJSONSerialization JSONObjectWithData:_jsonData options:0 error:nil];
	for (NSMutableDictionary* eventJSON in eventsJSON){
		// new event data object
		GatherEventData *eventObject = [[GatherEventData alloc] init];
		// these are for each object
		int accepts=0;
		int rejects=0;
		int total=0;
		// loop through and store information based on the keys
		for (NSString* event_key in eventJSON){
			// who and suggestions are arrays so we need to handle them accordingly
			if ([event_key isEqualToString:@"who"]){
				for (NSMutableDictionary* user_dict in [eventJSON objectForKey:@"who"]){
					GatherUserResponseData *user = [[GatherUserResponseData alloc] init];
					[user setUser_name:[user_dict valueForKey:@"user_name"]];
					[user setUser_response:[[user_dict valueForKey:@"response"] intValue]];
					
					[eventObject.who setObject:user forKey:[user_dict valueForKey:@"user_id"]];
					// increment the accepts and rejects accordingly
					if([[user_dict valueForKey:@"response"] intValue]==1){
						accepts+=1;
					}else if([[user_dict valueForKey:@"response"] intValue]==-1){
						rejects+=1;
					}
					total+=1;
				}
			}else if([event_key isEqualToString:@"suggestions"]){
				// take the json just from the suggestions
				NSMutableData* suggestionData=[[NSMutableData alloc] init];
				NSArray *suggestionJSON = [NSJSONSerialization JSONObjectWithData:suggestionData options:0 error:nil];
				// loop through all suggestions
				for (NSMutableDictionary* sugg in [eventJSON objectForKey:@"suggestions"]){
					GatherSuggestionData *suggestion = [[GatherSuggestionData alloc] init];
					for (NSString* sugg_key in sugg){
						if ([sugg_key isEqualToString:@"who"]){
							// take the json just from the who array
							NSMutableData* whoData=[[NSMutableData alloc] init];
							NSArray *whoJSON = [NSJSONSerialization JSONObjectWithData:whoData options:0 error:nil];
							// loop through all these peeps
							for (NSMutableDictionary* who in whoJSON){
								// object to store user responses
								GatherUserResponseData *user = [[GatherUserResponseData alloc] init];
								for (NSString* who_key in who){
									// map all these values
									[user setValue:[who valueForKey:who_key] forKey:who_key];
								}
								[suggestion.who addObject:user];
							}
						}else{
							[suggestion setValue:[suggestionJSON valueForKey:sugg_key] forKey:sugg_key];
						}
					}
					[eventObject.suggestions addObject:suggestion];
				}
			}else{
				// otherwise we can just go ahead and set the value for the key!
				// probs need to do some cleanup? idk we will see
				[eventObject setValue:[eventJSON valueForKey:event_key] forKey:event_key];
			}
		}
		[eventObject setAccepts:accepts];
		[eventObject setRejects:rejects];
		[eventObject setTotal:total];
		
		switch ([[eventObject.who objectForKey:USER_ID] user_response]) {
			case 1:
				[ACCEPTED_EVENTS addObject:eventObject];
				break;
			case -1:
				[REJECTED_EVENTS addObject:eventObject];
				break;
			case 0:
				[NO_RESPONSE_EVENTS addObject:eventObject];
				break;
			default:
				break;
		}
	}
	
	[TABLE_DATA setObject:ACCEPTED_EVENTS forKey:@"Attending"];
	[TABLE_DATA setObject:REJECTED_EVENTS forKey:@"Not Attending"];
	[TABLE_DATA setObject:NO_RESPONSE_EVENTS forKey:@"No Response"];
	
	[[NSNotificationCenter defaultCenter]
	 postNotificationName:@"dataLoadSuccess"
	 object:self];
}

-(void)getUserEventsDataFromURL:(NSString*)url
{
	_url=[NSURL URLWithString:url];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (connection && [self isDataSourceAvailable]){
		[self flushGlobalData];
		_jsonData=[[NSMutableData alloc] init];
	}else{
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"connectionFailure"
		 object:self];
	}
}

-(void)flushGlobalData
{
	[TABLE_DATA removeAllObjects];
	[NO_RESPONSE_EVENTS removeAllObjects];
	[ACCEPTED_EVENTS removeAllObjects];
	[REJECTED_EVENTS removeAllObjects];
}


@end
