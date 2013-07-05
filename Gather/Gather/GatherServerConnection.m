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

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[_xmlData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
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
		//NSLog(@"No errors - user count : %i", [parser [users count]]);
		// get array of users here
		//  NSMutableArray *users = [parser users];
	} else {
		NSLog(@"Error parsing document!");
	}
}

-(void)connectToURL:(NSString*)url
{
	_url=[NSURL URLWithString:url];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (connection){
		_xmlData=[[NSMutableData alloc] init];
	}else{
		NSLog(@"Connection is NULL");
	}
	//return [[NSString alloc] initWithBytes: [_xmlData mutableBytes] length:[_xmlData length] encoding:NSUTF8StringEncoding];
}


@end
