//
//  GatherXMLParser.h
//  Gather
//
//  Created by Taylor Seale on 7/2/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GatherXMLParser : NSXMLParser

-(id)init;
@property(nonatomic, retain) NSMutableData *xmlData;

@end
