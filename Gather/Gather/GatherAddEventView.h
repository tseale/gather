//
//  GatherAddEventView.h
//  Gather
//
//  Created by Taylor Seale on 7/28/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GatherAddEventTopBar.h"
#import "GatherAddEventForm.h"

@interface GatherAddEventView : UIView <UIScrollViewDelegate>

@property (nonatomic,strong) GatherAddEventTopBar* topBar;
@property (nonatomic,strong) GatherAddEventForm* form;
@property (nonatomic,strong) UIScrollView* formScroll;

@end
