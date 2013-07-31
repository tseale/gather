//
//  GatherDatePickerLabel.m
//  Gather
//
//  Created by Taylor Seale on 7/29/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherDatePickerLabel.h"

@implementation GatherDatePickerLabel

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
	}
	return self;
}

- (CGRect)caretRectForPosition:(UITextPosition *)position {
    return CGRectZero;
}

@end
