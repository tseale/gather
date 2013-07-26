//
//  GatherEventTopBar.h
//  Gather
//
//  Created by Taylor Seale on 7/24/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GatherEventTopBar : UIView

@property (nonatomic,strong) UILabel *eventName;
@property (nonatomic,strong) UIView *separatorLine;
@property (nonatomic,strong) UILabel* backButton;
@property (nonatomic,strong) UILabel* statusLabel;

@end
