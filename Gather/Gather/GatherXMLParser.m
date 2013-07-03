//
//  GatherXMLParser.m
//  Gather
//
//  Created by Taylor Seale on 7/2/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherXMLParser.h"

@implementation GatherXMLParser

-(id)init{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseXML:) name:@"xmlDownloaded" object:nil];
	return self;
}

-(void)parseXML:(NSNotification *)notification
{
	_xmlData=[[notification userInfo] valueForKey:@"xmlData"];
	NSLog(@"xml response: %@",[[NSString alloc] initWithBytes: [_xmlData mutableBytes] length:[_xmlData length] encoding:NSUTF8StringEncoding]);
}

@end
