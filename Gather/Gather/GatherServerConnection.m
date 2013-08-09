//
//  GatherServerConnection.m
//  Gather
//
//  Created by Taylor Seale on 7/2/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherServerConnection.h"

@implementation GatherServerConnection

- (BOOL)isDataSourceAvailable
{
	BOOL dataSourceAvailable = NO;
		
        Boolean success;
        const char *host_name = HOST_NAME;
		
        SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host_name);
        SCNetworkReachabilityFlags flags;
        success = SCNetworkReachabilityGetFlags(reachability, &flags);
        dataSourceAvailable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
        CFRelease(reachability);
    return dataSourceAvailable;
}

-(BOOL)connectionMade
{
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:BASE_URL]];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (connection && [self isDataSourceAvailable]){
		return YES;
	}else{
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"connectionFailure"
		 object:self];
		return NO;
	}
}

-(void)flushGlobalData
{
	[TABLE_DATA removeAllObjects];
	[NO_RESPONSE_EVENTS removeAllObjects];
	[ACCEPTED_EVENTS removeAllObjects];
	[REJECTED_EVENTS removeAllObjects];
}

-(BOOL)parseEventsJSON:(id)eventsJSON
{
	[self flushGlobalData];
	
	if ([eventsJSON isKindOfClass:NSDictionary.class]){
		NSDictionary* event = eventsJSON;
		if ([[event allKeys] containsObject:@"error"]){
			return NO;
		}
	}
	
	for (NSDictionary* event in eventsJSON){
		// new event data object
		GatherEventData *eventObject = [[GatherEventData alloc] init];
		// these are for each object
		int accepts=0;
		int rejects=0;
		int total=0;
		for (NSString* key in [event allKeys]){
			if ([key isEqualToString:@"who"]){
				for (NSMutableDictionary* user_dict in [event objectForKey:@"who"]){
					GatherUserResponseData *user = [[GatherUserResponseData alloc] init];
					[user setUser_id:[user_dict valueForKey:@"user_id"]];
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
			}
			else if ([key isEqualToString:@"suggestions"]){
				
			}
			else{
				// otherwise we can just go ahead and set the value for the key!
				// probs need to do some cleanup? idk we will see
				[eventObject setValue:[event valueForKey:key] forKey:key];
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
	return YES;
}

-(BOOL)getAllEventsForUser
{
	// ensure connection can be made before we do anything, leave if it cannot
	if (![self connectionMade]){
		return NO;
	}
	
	__block BOOL success=YES;
	AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
	[httpClient setParameterEncoding:AFJSONParameterEncoding];
	NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
															path:[BASE_URL stringByAppendingString:@"getevents/"]
													  parameters:USER_AUTHENTICATION];
	AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	[httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		// need to add code to handle login verification
		SBJsonParser *parser = [[SBJsonParser alloc] init];
		if (![self parseEventsJSON:[parser objectWithData:responseObject]]){success=NO;}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"Error: %@", error);
		success=NO;
	}];
	[operation start];
	return success;
}

-(void)respondToEvent:(NSString*)eventID
			 response:(NSNumber*)response
{
	// ensure connection can be made before we do anything, leave if it cannot
	if (![self connectionMade]){
		return;
	}
	
	AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
	[httpClient setParameterEncoding:AFJSONParameterEncoding];
	NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
															path:[BASE_URL stringByAppendingString:@"response/"]
													  parameters:@{@"_id": eventID,
																   @"user_id": USER_ID,
																   @"response": response
																   }];
	AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	[httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"Error: %@", error);
	}];
	[operation start];
}

-(void)parseLoginResponseInfo:(id)response
{
	if ([[response allKeys] containsObject:@"error"]){
		NSLog(@"invalid");
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"invalidLogin"
		 object:self];
	}else{
		USER_ID=[response objectForKey:@"_id"];
		USER_PASSWORD=[response objectForKey:@"password"];
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[defaults removePersistentDomainForName:SERVICE_NAME];
		[defaults setObject:USER_ID forKey:@"user_id"];
		[defaults setObject:USER_PASSWORD forKey:@"password"];
		[defaults setObject:[response objectForKey:@"phone_number"] forKey:@"phone_number"];
		[SSKeychain setPassword:USER_PASSWORD forService:SERVICE_NAME account:USER_ID];
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"validLogin"
		 object:self];
	}
}

-(void)attemptLogin:(NSDictionary*)loginInfo
{
	AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
	[httpClient setParameterEncoding:AFJSONParameterEncoding];
	NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
															path:[BASE_URL stringByAppendingString:@"login/"]
													  parameters:@{@"password":[loginInfo objectForKey:@"password"],
																   @"phone_number":[loginInfo objectForKey:@"phone_number"]}];
	AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	[httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		SBJsonParser *parser = [[SBJsonParser alloc] init];
		[self parseLoginResponseInfo:[parser objectWithData:responseObject]];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		//NSLog(@"Error: %@", error);
	}];
	[operation start];
}

-(BOOL)registerNewUser
{
	return YES;
}


@end
