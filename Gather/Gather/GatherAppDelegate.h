//
//  GatherAppDelegate.h
//  Gather
//
//  Created by Taylor Seale on 6/17/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GatherLoginSignupViewController.h"
#import "GatherViewController.h"
#import "GatherGlobalData.h"
#import "IIViewDeckController.h"

@interface GatherAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) IIViewDeckController *sidePanelController;
@property (strong, nonatomic) GatherLoginSignupViewController *loginController;

@property (strong, nonatomic) UIViewController *sidePanel;

@end
