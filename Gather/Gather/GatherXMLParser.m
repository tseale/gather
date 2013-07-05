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
		[TABLE_DATA setObject:ACCEPTED_EVENTS forKey:@"Attending"];
		return;
	}
	
	if ([elementName isEqualToString:@"event"]) {
		[ACCEPTED_EVENTS addObject:_eventData];
		_eventData=nil;
	} else {
		if ([elementName isEqualToString:@"eventName"]){
			[_eventData setEventName:_currentElementValue];
		}else if ([elementName isEqualToString:@"eventLocation"]){
			[_eventData setEventLocation:_currentElementValue];
		}else if ([elementName isEqualToString:@"eventTime"]){
			[_eventData setEventTime:_currentElementValue];
		}else if ([elementName isEqualToString:@"eventGroup"]){
			[_eventData setEventGroup:_currentElementValue];
		}else if ([elementName isEqualToString:@"accepts"]){
			[_eventData setAccepts:(int)_currentElementValue];
		}else if ([elementName isEqualToString:@"rejects"]){
			[_eventData setRejects:(int)_currentElementValue];
		}else if ([elementName isEqualToString:@"participants"]){
			[_eventData setParticipants:(int)_currentElementValue];
		}
	}
	
	_currentElementValue = nil;
}


@end
