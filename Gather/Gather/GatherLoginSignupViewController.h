//
//  GatherLoginSignupViewController.h
//  Gather
//
//  Created by Taylor Seale on 8/8/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Security/Security.h>
#import <CommonCrypto/CommonDigest.h>
#import <QuartzCore/QuartzCore.h>

#import "SSKeychain.h"
#import "GatherViewController.h"
#import "GatherServerConnection.h"
#import "GatherGlobalData.h"

@interface GatherLoginSignupViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic,assign) int initialLogoOrigin;
@property (nonatomic,strong) UIView *logo;
@property (nonatomic,strong) UIActivityIndicatorView *loadingView;

@property (nonatomic,strong) UIView *loginForm;
@property (nonatomic,strong) UIView *signupForm;

@property (nonatomic,strong) UITextField *firstName;
@property (nonatomic,strong) UITextField *lastName;
@property (nonatomic,strong) UITextField *phoneNumber;
@property (nonatomic,strong) UITextField *password;
@property (nonatomic,strong) UITextField *confirmPassword;

@property (nonatomic,strong) NSString *firstNameText;
@property (nonatomic,strong) NSString *lastNameText;
@property (nonatomic,strong) NSString *phoneNumberText;
@property (nonatomic,strong) NSString *passwordText;
@property (nonatomic,strong) NSString *confirmedPasswordText;

@property (nonatomic,strong) UILabel *loginButton;
@property (nonatomic,strong) UILabel *signupButton;

@property (nonatomic,strong) NSDictionary *loginAttemptResponse;

@property (nonatomic,strong) GatherServerConnection* connection;

@end
