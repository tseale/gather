//
//  GatherLoginViewController.h
//  Gather
//
//  Created by Taylor Seale on 7/14/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GatherViewController.h"
#import "SSKeychain.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import <AddressBook/AddressBook.h>
#import <Security/Security.h>

@interface GatherLoginViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic,strong) UIView *logo;
@property (nonatomic,strong) UIActivityIndicatorView *loadingView;

@property (nonatomic,strong) UIView *loginForm;

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

@end
