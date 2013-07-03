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
	// Notify the XML parser that data is downloaded and ready to be parsed
	NSDictionary* xmlDataDict = [NSDictionary dictionaryWithObject:_xmlData
													 forKey:@"xmlData"];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"xmlDownloaded" object:self userInfo:xmlDataDict];
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

-(NSString*)getXML
{
	return [[NSString alloc] initWithBytes: [_xmlData mutableBytes] length:[_xmlData length] encoding:NSUTF8StringEncoding];
}


@end
