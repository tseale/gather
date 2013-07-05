//
//  GatherXMLParser.h
//  Gather
//
//  Created by Taylor Seale on 7/2/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GatherCellData.h"

@interface GatherXMLParser : NSObject <NSXMLParserDelegate>

@property (nonatomic,retain) NSMutableString *currentElementValue;

@property (nonatomic,strong) GatherCellData *eventData;

@end
