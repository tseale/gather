//
//  GatherLoginSignupViewController.m
//  Gather
//
//  Created by Taylor Seale on 8/8/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherLoginSignupViewController.h"

@implementation GatherLoginSignupViewController

- (NSString *)sha1:(NSString *)str{
	const char *cStr = [str UTF8String];
	unsigned char result[CC_SHA1_DIGEST_LENGTH];
	CC_SHA1(cStr, strlen(cStr), result);
	NSString *s = [NSString  stringWithFormat:
				   @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
				   result[0], result[1], result[2], result[3], result[4],
				   result[5], result[6], result[7], result[8], result[9],
				   result[10], result[11], result[12], result[13], result[14],
				   result[15], result[16], result[17], result[18], result[19]
				   ];
	
    return s;
}

-(void)viewDidLoad
{
	[super viewDidLoad];
	_connection = [[GatherServerConnection alloc] init];
	
	[self.view setBackgroundColor:[UIColor colorWithRed:0.99f green:0.99f blue:0.99f alpha:1.00f]];
	
	_logo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	[_logo setBackgroundColor:[UIColor colorWithRed:0.99f green:0.99f blue:0.99f alpha:1.00f]];
	UILabel *gatherText= [[UILabel alloc] init];
	[gatherText setBackgroundColor:[UIColor clearColor]];
	[gatherText setText:@"Gather"];
	[gatherText setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:50.0f]];
	[gatherText setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
	[gatherText setTextAlignment:NSTextAlignmentCenter];
	[gatherText sizeToFit];
	[_logo addSubview:gatherText];
	[_logo setFrame:gatherText.frame];
	
	UIView *greenLine = [[UIView alloc] initWithFrame:CGRectMake(0, _logo.frame.size.height-8, 3.0*_logo.frame.size.width/4.0, 1)];
	[greenLine setBackgroundColor:GREEN_COLOR];
	[_logo addSubview:greenLine];
	UIView *redLine = [[UIView alloc] initWithFrame:CGRectMake(3.0*_logo.frame.size.width/4.0, _logo.frame.size.height-8, _logo.frame.size.width/4.0, 1)];
	[redLine setBackgroundColor:RED_COLOR];
	[_logo addSubview:redLine];
	[self.view addSubview:_logo];
	
	CGRect logoFrame = _logo.frame;
	logoFrame.origin = CGPointMake(self.view.frame.size.width/2.0-(_logo.frame.size.width/2.0), self.view.frame.size.height/2.0-(_logo.frame.size.height/2.0)-70);
	_logo.frame=logoFrame;
	_initialLogoOrigin=_logo.frame.origin.y;
	
	float loadingHeight=self.view.frame.size.height/2.0-(_logo.frame.size.height/2.0)-70+_logo.frame.size.height;
	
	_loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	[_loadingView setBackgroundColor:[UIColor clearColor]];
	[_loadingView setFrame:CGRectMake(0, loadingHeight, self.view.bounds.size.width,50)];
	[_loadingView startAnimating];
	[self.view addSubview:_loadingView];
	
	_loginForm = [[UIView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-216-_logo.frame.size.height)];
	_loginForm.alpha=0;
	
	_loginPhoneNumberBox = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20, 36.5)];
	[_loginPhoneNumberBox setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	_loginPhoneNumberBox.layer.cornerRadius=CORNER_RADIUS;
	_loginPhoneNumberBox.layer.borderWidth=1.0f;
	_loginPhoneNumberBox.layer.borderColor=[UIColor colorWithRed:0.9*0.90f green:0.9*0.90f blue:0.9*0.90f alpha:1.00f].CGColor;
	[_loginForm addSubview:_loginPhoneNumberBox];
	
	UIView *passwordBox = [[UIView alloc] initWithFrame:CGRectMake(10, 46.5, self.view.frame.size.width-20, 36.5)];
	[passwordBox setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	passwordBox.layer.cornerRadius=CORNER_RADIUS;
	passwordBox.layer.borderWidth=1.0f;
	passwordBox.layer.borderColor=[UIColor colorWithRed:0.9*0.90f green:0.9*0.90f blue:0.9*0.90f alpha:1.00f].CGColor;
	[_loginForm addSubview:passwordBox];
	
	_loginPhoneNumber= [[UITextField alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-30, 36.5)];
	[_loginPhoneNumber setPlaceholder:@"Phone Number"];
	[_loginPhoneNumber setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
	[_loginPhoneNumber setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
	[_loginPhoneNumber setDelegate:self];
	[_loginPhoneNumber setTag:2];
	[_loginPhoneNumber setKeyboardType:UIKeyboardTypeNumberPad];
	[_loginPhoneNumber addTarget:self action:@selector(numberFormatAssist) forControlEvents:UIControlEventEditingChanged];
	[_loginPhoneNumberBox addSubview:_loginPhoneNumber];
	
	_loginCorrectNumberFormat = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-50, 0, 30, 36.5)];
	[_loginCorrectNumberFormat setText:@"\u2713"];
	[_loginCorrectNumberFormat setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]];
	[_loginCorrectNumberFormat setTextColor:[UIColor colorWithRed:0.8*0.90f green:0.8*0.90f blue:0.8*0.90f alpha:1.00f]];
	[_loginCorrectNumberFormat setHidden:YES];
	[_loginPhoneNumberBox addSubview:_loginCorrectNumberFormat];
	
	_loginPassword= [[UITextField alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-30, 36.5)];
	[_loginPassword setPlaceholder:@"Password"];
	[_loginPassword setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
	[_loginPassword setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
	[_loginPassword setDelegate:self];
	[_loginPassword setTag:3];
	[_loginPassword setSecureTextEntry:YES];
	[_loginPassword setReturnKeyType:UIReturnKeyGo];
	[passwordBox addSubview:_loginPassword];
	
	_backButton = [[UILabel alloc] initWithFrame:CGRectMake(10, 93, (self.view.frame.size.width-30)/2, 50)];
	[_backButton setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_backButton setText:@"back"];
	[_backButton setTextColor:RED_COLOR];
	[_backButton setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
	[_backButton setTextAlignment:NSTextAlignmentCenter];
	_backButton.layer.cornerRadius=CORNER_RADIUS;
	_backButton.layer.borderWidth=1.0f;
	_backButton.layer.borderColor=[UIColor colorWithRed:0.9*0.90f green:0.9*0.90f blue:0.9*0.90f alpha:1.00f].CGColor;
	[_backButton setUserInteractionEnabled:YES];
	UITapGestureRecognizer* leaveLogin = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leaveLoginForm)];
	[_backButton addGestureRecognizer:leaveLogin];
	[_loginForm addSubview:_backButton];
	
	_attemptLoginButton = [[UILabel alloc] initWithFrame:CGRectMake(20+(self.view.frame.size.width-30)/2, 93, (self.view.frame.size.width-30)/2, 50)];
	[_attemptLoginButton setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_attemptLoginButton setText:@"login"];
	[_attemptLoginButton setTextColor:GREEN_COLOR];
	[_attemptLoginButton setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
	[_attemptLoginButton setTextAlignment:NSTextAlignmentCenter];
	_attemptLoginButton.layer.cornerRadius=CORNER_RADIUS;
	_attemptLoginButton.layer.borderWidth=1.0f;
	_attemptLoginButton.layer.borderColor=[UIColor colorWithRed:0.9*0.90f green:0.9*0.90f blue:0.9*0.90f alpha:1.00f].CGColor;
	[_attemptLoginButton setUserInteractionEnabled:YES];
	UITapGestureRecognizer* attemptLogin = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(processLogin)];
	[_attemptLoginButton addGestureRecognizer:attemptLogin];
	[_loginForm addSubview:_attemptLoginButton];
	
	UILabel *forgotPassword = [[UILabel alloc] initWithFrame:CGRectMake(10, 139.5, self.view.frame.size.width-20, 36.5)];
	[forgotPassword setText:@"Forgot your password?"];
	[forgotPassword setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f]];
	[forgotPassword setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
	[forgotPassword setTextAlignment:NSTextAlignmentCenter];
	[_loginForm addSubview:forgotPassword];
	[self.view addSubview:_loginForm];
	
	/*
	_signupScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-216-_logo.frame.size.height)];
	[_signupScroll setShowsVerticalScrollIndicator:NO];
	_signupForm = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 256)];
	_signupForm.alpha=0;
	
	
	UIView *firstNameBox = [[UIView alloc] initWithFrame:CGRectMake(10, 0, (self.view.frame.size.width-30)/2, 36.5)];
	[firstNameBox setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_signupForm addSubview:firstNameBox];
	
	UIView *lastNameBox	= [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-30)/2+20, 0, (self.view.frame.size.width-30)/2, 36.5)];
	[lastNameBox setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_signupForm addSubview:lastNameBox];
	
	UIView *loginPhoneNumberBox = [[UITextField alloc] initWithFrame:CGRectMake(10, 46.5, self.view.frame.size.width-20, 36.5)];
	[loginPhoneNumberBox setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_signupForm addSubview:loginPhoneNumberBox];
	
	
	UIView *passwordBox = [[UIView alloc] initWithFrame:CGRectMake(0, 93, self.view.frame.size.width-20, 36.5)];
	[passwordBox setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_signupForm addSubview:passwordBox];
	
	
	UIView *confirmPasswordBox = [[UIView alloc] initWithFrame:CGRectMake(10, 139.5, self.view.frame.size.width-20, 36.5)];
	[confirmPasswordBox setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_signupForm addSubview:confirmPasswordBox];
	
	_firstName	= [[UITextField alloc] initWithFrame:CGRectMake(10, 0, (self.view.frame.size.width-30)/2-20, 36.5)];
	[_firstName setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_firstName setPlaceholder:@"First Name"];
	[_firstName setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
	[_firstName setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
	[_firstName setDelegate:self];
	[_firstName setTag:0];
	[_firstName setReturnKeyType:UIReturnKeyGo];
	[firstNameBox addSubview:_firstName];
	
	_lastName	= [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width-30)/2+20, 0, (self.view.frame.size.width-30)/2-20, 36.5)];
	[_lastName setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_lastName setPlaceholder:@"Last Name"];
	[_lastName setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
	[_lastName setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
	[_lastName setDelegate:self];
	[_lastName setTag:1];
	[_lastName setReturnKeyType:UIReturnKeyGo];
	[lastNameBox addSubview:_lastName];
	
	_loginPhoneNumber= [[UITextField alloc] initWithFrame:CGRectMake(10, 46.5, self.view.frame.size.width-30, 36.5)];
	[_loginPhoneNumber setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_loginPhoneNumber setPlaceholder:@"Phone Number"];
	[_loginPhoneNumber setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
	[_loginPhoneNumber setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
	[_loginPhoneNumber setDelegate:self];
	[_loginPhoneNumber setTag:2];
	[_loginPhoneNumber setKeyboardType:UIKeyboardTypeNumberPad];
	[_loginPhoneNumber setReturnKeyType:UIReturnKeyGo];
	[loginPhoneNumberBox addSubview:_loginPhoneNumber];
	
	_loginPassword= [[UITextField alloc] initWithFrame:CGRectMake(10, 93, self.view.frame.size.width-30, 36.5)];
	[_loginPassword setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_loginPassword setPlaceholder:@"Password"];
	[_loginPassword setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
	[_loginPassword setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
	[_loginPassword setDelegate:self];
	[_loginPassword setTag:3];
	[_loginPassword setSecureTextEntry:YES];
	[_loginPassword setReturnKeyType:UIReturnKeyGo];
	[_signupForm addSubview:_loginPassword];
	
	_confirmPassword= [[UITextField alloc] initWithFrame:CGRectMake(10, 139.5, self.view.frame.size.width-30, 36.5)];
	[_confirmPassword setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_confirmPassword setPlaceholder:@"Confirm Password"];
	[_confirmPassword setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
	[_confirmPassword setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
	[_confirmPassword setDelegate:self];
	[_confirmPassword setTag:4];
	[_confirmPassword setSecureTextEntry:YES];
	[_confirmPassword setReturnKeyType:UIReturnKeyGo];
	[confirmPasswordBox addSubview:_confirmPassword];

	
	
	[_signupScroll setContentSize:CGSizeMake(self.view.frame.size.width, 256)];
	[_signupScroll addSubview:_signupForm];
	[self.view addSubview:_signupScroll];
	*/
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(loginSuccess)
												 name:@"validLogin"
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(loginFailure)
												 name:@"invalidLogin"
											   object:nil];
	
	
	_passwordText = [self passwordInKeychain];
	if (_passwordText==nil){
		[self showLoginSignup];
	}else{
		[self attemptAutoLogin];
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField==_loginPassword){
		[self processLogin];
	}
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
	[self numberFormatAssist];
}

- (void)numberFormatAssist {
	if (_loginPhoneNumber.text.length==10){
		_loginPhoneNumberBox.layer.borderColor=[UIColor colorWithRed:0.00f green:0.48f blue:0.99f alpha:1.00f].CGColor;
		_loginCorrectNumberFormat.hidden=NO;
	}else{
		_loginPhoneNumberBox.layer.borderColor=[UIColor colorWithRed:0.9*0.90f green:0.9*0.90f blue:0.9*0.90f alpha:1.00f].CGColor;
		_loginCorrectNumberFormat.hidden=YES;
	}
}

-(NSString*)passwordInKeychain
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *passwordFromKeychain = [SSKeychain passwordForService:SERVICE_NAME account:[defaults objectForKey:@"user_id"]];
	return passwordFromKeychain;
}

-(void)attemptAutoLogin
{
	[_connection attemptLogin:[[NSDictionary alloc] initWithObjects:@[[self passwordInKeychain],[[NSUserDefaults standardUserDefaults] objectForKey:@"phone_number"]]
															forKeys:@[@"password",@"phone_number"]]
	 ];
}

-(void)showLoginSignup
{
	[_loadingView stopAnimating];
	_loginButton = [[UILabel alloc] initWithFrame:CGRectMake(60, 200, 200, 50)];
	[_loginButton setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_loginButton setText:@"login"];
	[_loginButton setTextAlignment:NSTextAlignmentCenter];
	[_loginButton setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
	[_loginButton setTextColor:[UIColor colorWithRed:0.7*0.90f green:0.7*0.90f blue:0.7*0.90f alpha:1.00f]];
	_loginButton.layer.cornerRadius=CORNER_RADIUS;
	_loginButton.layer.borderWidth=1.0f;
	_loginButton.layer.borderColor=[UIColor colorWithRed:0.9*0.90f green:0.9*0.90f blue:0.9*0.90f alpha:1.00f].CGColor;
	[_loginButton setUserInteractionEnabled:YES];
	UITapGestureRecognizer* showLoginForm = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLoginForm)];
	[_loginButton addGestureRecognizer:showLoginForm];
	[self.view addSubview:_loginButton];
	
	_signupButton = [[UILabel alloc] initWithFrame:CGRectMake(60, 260, 200, 50)];
	[_signupButton setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_signupButton setText:@"sign up"];
	[_signupButton setTextAlignment:NSTextAlignmentCenter];
	[_signupButton setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
	[_signupButton setTextColor:[UIColor colorWithRed:0.7*0.90f green:0.7*0.90f blue:0.7*0.90f alpha:1.00f]];
	_signupButton.layer.cornerRadius=CORNER_RADIUS;
	_signupButton.layer.borderWidth=1.0f;
	_signupButton.layer.borderColor=[UIColor colorWithRed:0.9*0.90f green:0.9*0.90f blue:0.9*0.90f alpha:1.00f].CGColor;
	[_signupButton setUserInteractionEnabled:YES];
	UITapGestureRecognizer* showSignupForm = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSignupForm)];
	[_signupButton addGestureRecognizer:showSignupForm];
	[self.view addSubview:_signupButton];
	
	[UIView beginAnimations:@"" context:nil];
	_loginButton.alpha = 1;
	
	_signupButton.alpha = 1;
	[UIView commitAnimations];
	
}

-(void)showLoginForm
{
	[UIView beginAnimations:@"" context:nil];
	_loginButton.alpha = 0;
	
	_signupButton.alpha = 0;
	[UIView commitAnimations];
	
	[_loginPhoneNumber becomeFirstResponder];
	
	CGRect shiftLogoFrame = _logo.frame;
	shiftLogoFrame.origin.y=20;
	[UIView animateWithDuration:0.3f
						  delay:0.0
						options:UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 _logo.frame=shiftLogoFrame;
					 }
					 completion:^(BOOL finished){}
	 ];
	
	[UIView animateWithDuration:0.1f
						  delay:0.2
						options:UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 _loginForm.alpha=1;
					 }
					 completion:^(BOOL finished){}
	 ];
}

-(void)leaveLoginForm
{
	[UIView beginAnimations:@"" context:nil];
	_loginForm.alpha=0;
	[UIView commitAnimations];
	if (_loginPhoneNumber.editing==YES){
		[_loginPhoneNumber resignFirstResponder];
	}else{
		[_loginPassword resignFirstResponder];
	}
	_loginPhoneNumber.text=@"";
	_loginPassword.text=@"";
	[self.view endEditing:YES];
	
	CGRect shiftLogoFrame = _logo.frame;
	shiftLogoFrame.origin.y=_initialLogoOrigin;
	[UIView animateWithDuration:0.3f
						  delay:0.0
						options:UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 _logo.frame=shiftLogoFrame;
					 }
					 completion:^(BOOL finished){}
	 ];
	
	[self performSelector:@selector(showLoginSignup) withObject:self afterDelay:0.3];
}

-(void)processLogin
{
	_phoneNumberText=_loginPhoneNumber.text;
	_passwordText=_loginPassword.text;
	BOOL formFillSuccess = YES;
	BOOL wrongNumLength = NO;
	if (_phoneNumberText.length==0){
		_loginPhoneNumber.text=@"";
		formFillSuccess=NO;
	}else if (_phoneNumberText.length!=10){
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Pro-Tip"
															message:@"phone number format\n(XXX) XXX-XXXX"
														   delegate:self
												  cancelButtonTitle:@"OK"
												  otherButtonTitles:nil];
		[alertView show];
		_loginPhoneNumber.text=@"";
		wrongNumLength=YES;
		formFillSuccess=NO;
		[_loginPhoneNumber becomeFirstResponder];
	}
	
	if (_passwordText.length==0){
		_loginPassword.text=@"";
		formFillSuccess=NO;
	}
	
	
	
	if (formFillSuccess){
		[_connection attemptLogin:[[NSDictionary alloc] initWithObjects:@[[self sha1:_passwordText],_phoneNumberText]
																forKeys:@[@"password",@"phone_number"]]
		 ];
		_attemptLoginButton.hidden=YES;
		_backButton.hidden=YES;
		[_loginPhoneNumber setUserInteractionEnabled:NO];
		[_loginPassword setUserInteractionEnabled:NO];
		[_loadingView setFrame:CGRectMake(0, 173, self.view.bounds.size.width,50)];
		[_loadingView startAnimating];
	}else{
		if (!wrongNumLength){
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Incomplete Fields"
																message:@"Phone Number/Password left incomplete"
															   delegate:self
													  cancelButtonTitle:@"OK"
													  otherButtonTitles:nil];
			[alertView show];
		}
	}
}

-(void)loginFailure
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid Login"
														message:@"Please try again"
													   delegate:self
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
	[alertView show];
	_loginPhoneNumber.text=@"";
	[self numberFormatAssist];
	_loginPassword.text=@"";
	[_loginPhoneNumber setUserInteractionEnabled:YES];
	[_loginPassword setUserInteractionEnabled:YES];
	_attemptLoginButton.hidden=NO;
	_backButton.hidden=NO;
	[_loadingView stopAnimating];
	[_loginPhoneNumber becomeFirstResponder];
}

-(void)loginSuccess
{
	GatherViewController *viewController = [[GatherViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)showSignupForm
{
	[UIView beginAnimations:@"" context:nil];
	_loginButton.alpha = 0;
	
	_signupButton.alpha = 0;
	[UIView commitAnimations];
	
	CGRect shiftLogoFrame = _logo.frame;
	shiftLogoFrame.origin.y=20;
	[UIView animateWithDuration:0.3f
						  delay:0.0
						options:UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 _logo.frame=shiftLogoFrame;
					 }
					 completion:^(BOOL finished){}
	 ];
	
	[UIView animateWithDuration:0.1f
						  delay:0.2
						options:UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 _signupForm.alpha=1;
					 }
					 completion:^(BOOL finished){}
	 ];
}

@end
