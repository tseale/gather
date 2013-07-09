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
	_xmlParser=[[GatherXMLParser alloc] init];
	return self;
}

- (BOOL)isDataSourceAvailable
{
	BOOL dataSourceAvailable = NO;
		
        Boolean success;
        const char *host_name = "198.58.109.224"; // your data source host name
		
        SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host_name);
        SCNetworkReachabilityFlags flags;
        success = SCNetworkReachabilityGetFlags(reachability, &flags);
        dataSourceAvailable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
        CFRelease(reachability);
    return dataSourceAvailable;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[_xmlData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSArray *eventsJSON = [[NSArray alloc] init];
	GatherCellData *eventObject = [[GatherCellData alloc] init];
	eventsJSON = [NSJSONSerialization JSONObjectWithData:_xmlData options:0 error:nil];
	NSLog(@"events JSON: %@",eventsJSON);
	for (NSMutableDictionary* eventJSON in eventsJSON){
		NSLog(@"Here");
		for (NSString* key in eventJSON){
			if (![key isEqualToString:@"_id"]){
				NSLog(@"key: %@ value: %@",key,[eventJSON valueForKey:key]);
				[eventObject setValue:[eventJSON valueForKey:key] forKey:key];
			}
		}
		[NO_RESPONSE_EVENTS addObject:eventObject];
		eventObject=nil;
	}
	[TABLE_DATA setObject:NO_RESPONSE_EVENTS forKey:@"No Response"];
	
	[[NSNotificationCenter defaultCenter]
	 postNotificationName:@"dataLoadSuccess"
	 object:self];
	
	/*
	// create and init NSXMLParser object
	NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:_xmlData];
	
	// create and init our delegate
	GatherXMLParser *parser = [[GatherXMLParser alloc] init];
	
	// set delegate
	[xmlParser setDelegate:parser];
	
	// parsing...
	BOOL success = [xmlParser parse];
	 
	// test the result
	if (success) {
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"dataLoadSuccess"
		 object:self];
	} else {
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"dataLoadFailure"
		 object:self];
	}
	 */
}

-(void)connectToURL:(NSString*)url
{
	_url=[NSURL URLWithString:url];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (connection && [self isDataSourceAvailable]){
		[self flushGlobalData];
		_xmlData=[[NSMutableData alloc] init];
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
