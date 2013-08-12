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
@property (nonatomic,strong) UITextField *loginPhoneNumber;
@property (nonatomic,strong) UIView *loginPhoneNumberBox;
@property (nonatomic,strong) UILabel* loginCorrectNumberFormat;
@property (nonatomic,strong) UITextField *loginPassword;
@property (nonatomic,strong) UILabel *attemptLoginButton;
@property (nonatomic,strong) UILabel *backButton;

@property (nonatomic,strong) UIScrollView *signupScroll;
@property (nonatomic,strong) UIView *signupForm;
@property (nonatomic,strong) UITextField *signupFirstName;
@property (nonatomic,strong) UITextField *signupLastName;
@property (nonatomic,strong) UITextField *signupPhoneNumber;
@property (nonatomic,strong) UIView *signupPhoneNumberBox;
@property (nonatomic,strong) UILabel* signupCorrectNumberFormat;
@property (nonatomic,strong) UITextField *signupPassword;
@property (nonatomic,strong) UITextField *signupConfirmPassword;

@property (nonatomic,strong) NSString *firstNameText;
@property (nonatomic,strong) NSString *lastNameText;
@property (nonatomic,strong) NSString *phoneNumberText;
@property (nonatomic,strong) NSString *passwordText;
@property (nonatomic,strong) NSString *confirmedPasswordText;

@property (nonatomic,strong) UILabel *loginButton;
@property (nonatomic,strong) UILabel *signupButton;

@property (nonatomic,strong) NSDictionary *loginAttemptResponse;
@property (nonatomic,strong) NSDictionary *signupAttemptResponse;

@property (nonatomic,strong) GatherServerConnection* connection;

@end
