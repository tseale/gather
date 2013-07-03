//
//  GatherServerConnection.h
//  Gather
//
//  Created by Taylor Seale on 7/2/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GatherXMLParser.h"

@interface GatherServerConnection : NSObject

@property (nonatomic, retain) NSMutableData *xmlData;
@property (nonatomic, retain) NSURL *url;

@property (nonatomic,strong) GatherXMLParser *xmlParser;

-(id)init;
-(void)connectToURL:(NSString*)url;
-(NSString*)getXML;

@end
