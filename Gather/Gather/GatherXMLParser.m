//
//  GatherXMLParser.m
//  Gather
//
//  Created by Taylor Seale on 7/2/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherXMLParser.h"

@implementation GatherXMLParser

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
	attributes:(NSDictionary *)attributeDict {
	
	if ([elementName isEqualToString:@"event"]) {
		_eventData = [[GatherCellData alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (!_currentElementValue) {
		// init the ad hoc string with the value
		_currentElementValue = [[NSMutableString alloc] initWithString:string];
	} else {
		// append value to the ad hoc string
		[_currentElementValue appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"events"]) {
		// We reached the end of the XML document
		[TABLE_DATA setObject:NO_RESPONSE_EVENTS forKey:@"No Response"];
		[TABLE_DATA setObject:ACCEPTED_EVENTS forKey:@"Attending"];
		[TABLE_DATA setObject:REJECTED_EVENTS forKey:@"Not Attending"];
		return;
	}
	
	if ([elementName isEqualToString:@"event"]) {
		[NO_RESPONSE_EVENTS addObject:_eventData];
		_eventData=nil;
	} else {
		//NSString *element =[_currentElementValue stringByReplacingOccurrencesOfString:@" " withString:@""];
		NSString *element = [_currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		if ([elementName isEqualToString:@"eventName"]){
			[_eventData setName:element];
		}else if ([elementName isEqualToString:@"eventLocation"]){
			[_eventData setLocation:element];
		}else if ([elementName isEqualToString:@"eventTime"]){
			[_eventData setTime:element];
		}else if ([elementName isEqualToString:@"eventGroup"]){
			[_eventData setGroup:element];
		}else if ([elementName isEqualToString:@"accepts"]){
			[_eventData setAccepts:[element intValue]];
		}else if ([elementName isEqualToString:@"rejects"]){
			[_eventData setRejects:[element intValue]];
		}else if ([elementName isEqualToString:@"participants"]){
			[_eventData setParticipants:[element intValue]];
		}
	}
	_currentElementValue = nil;
}


@end
