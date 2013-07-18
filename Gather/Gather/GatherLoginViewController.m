//
//  GatherLoginViewController.m
//  Gather
//
//  Created by Taylor Seale on 7/14/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherLoginViewController.h"
#import <CommonCrypto/CommonDigest.h>

@interface GatherLoginViewController ()

@end

@implementation GatherLoginViewController

- (NSString *)sha1:(NSString *)str{
	const char *cStr = [str UTF8String];
	unsigned char result[CC_SHA1_DIGEST_LENGTH];
	CC_SHA1(cStr, strlen(cStr), result);
	NSString *s = [NSString  stringWithFormat:
				   @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
				   result[0], result[1], result[2], result[3], result[4],
				   result[5], result[6], result[7],
				   result[8], result[9], result[10], result[11], result[12],
				   result[13], result[14], result[15],
				   result[16], result[17], result[18], result[19]
				   ];
	
    return s;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
	
	float loadingHeight=self.view.frame.size.height/2.0-(_logo.frame.size.height/2.0)-70+_logo.frame.size.height;
	
	_loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	[_loadingView setBackgroundColor:[UIColor clearColor]];
	[_loadingView setFrame:CGRectMake(0, loadingHeight, self.view.bounds.size.width,50)];
	[_loadingView startAnimating];
	[self.view addSubview:_loadingView];
	
	
	BOOL hasAccount=[self confirmUserLogin];
	
	if (hasAccount){
		[self performSelector:@selector(loginSuccess) withObject:nil afterDelay:1.0];
	}else{
		[self performSelector:@selector(showLoginInfo) withObject:nil afterDelay:1.0];
	}	 

	
	// Do any additional setup after loading the view.
}

-(void)showLoginInfo
{
	[_loadingView removeFromSuperview];
	
	UIView *logoPane = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, _logo.frame.origin.y+_logo.frame.size.height)];
	[logoPane setBackgroundColor:[UIColor colorWithRed:0.99f green:0.99f blue:0.99f alpha:1.00f]];
	[self.view addSubview:logoPane];
	[self.view sendSubviewToBack:logoPane];
	
	float formOrigin = 20+_logo.frame.size.height;
	
	_loginForm = [[UIView alloc] initWithFrame:CGRectMake(10, formOrigin, self.view.frame.size.width-20, self.view.frame.size.height-formOrigin-10)];
	[_loginForm setBackgroundColor:[UIColor clearColor]];
	[_loginForm setAlpha:0.0];
	
	UIView *firstNameBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (self.view.frame.size.width-30)/2, 36.5)];
	[firstNameBox setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_loginForm addSubview:firstNameBox];
	
	UIView *lastNameBox	= [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-30)/2+10, 0, (self.view.frame.size.width-30)/2, 36.5)];
	[lastNameBox setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_loginForm addSubview:lastNameBox];
	
	UIView *phoneNumberBox = [[UITextField alloc] initWithFrame:CGRectMake(0, 46.5, self.view.frame.size.width-20, 36.5)];
	[phoneNumberBox setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_loginForm addSubview:phoneNumberBox];
	
	UIView *passwordBox = [[UIView alloc] initWithFrame:CGRectMake(0, 93, self.view.frame.size.width-20, 36.5)];
	[passwordBox setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_loginForm addSubview:passwordBox];
	
	UIView *confirmPasswordBox = [[UIView alloc] initWithFrame:CGRectMake(0, 139.5, self.view.frame.size.width-20, 36.5)];
	[confirmPasswordBox setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_loginForm addSubview:confirmPasswordBox];
	
	_firstName	= [[UITextField alloc] initWithFrame:CGRectMake(10, 0, (self.view.frame.size.width-30)/2-20, 36.5)];
	[_firstName setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_firstName setPlaceholder:@"First Name"];
	[_firstName setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
	[_firstName setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
	[_firstName setDelegate:self];
	[_firstName becomeFirstResponder];
	[_firstName setTag:0];
	[_firstName setReturnKeyType:UIReturnKeyGo];
	[_loginForm addSubview:_firstName];
	
	_lastName	= [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width-30)/2+20, 0, (self.view.frame.size.width-30)/2-20, 36.5)];
	[_lastName setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_lastName setPlaceholder:@"Last Name"];
	[_lastName setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
	[_lastName setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
	[_lastName setDelegate:self];
	[_lastName setTag:1];
	[_lastName setReturnKeyType:UIReturnKeyGo];
	[_loginForm addSubview:_lastName];
	
	_phoneNumber= [[UITextField alloc] initWithFrame:CGRectMake(10, 46.5, self.view.frame.size.width-30, 36.5)];
	[_phoneNumber setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_phoneNumber setPlaceholder:@"Phone Number"];
	[_phoneNumber setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
	[_phoneNumber setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
	[_phoneNumber setDelegate:self];
	[_phoneNumber setTag:2];
	[_phoneNumber setKeyboardType:UIKeyboardTypeNumberPad];
	[_phoneNumber setReturnKeyType:UIReturnKeyGo];
	[_loginForm addSubview:_phoneNumber];
	
	_password= [[UITextField alloc] initWithFrame:CGRectMake(10, 93, self.view.frame.size.width-30, 36.5)];
	[_password setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_password setPlaceholder:@"Password"];
	[_password setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
	[_password setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
	[_password setDelegate:self];
	[_password setTag:3];
	[_password setSecureTextEntry:YES];
	[_password setReturnKeyType:UIReturnKeyGo];
	[_loginForm addSubview:_password];
	
	_confirmPassword= [[UITextField alloc] initWithFrame:CGRectMake(10, 139.5, self.view.frame.size.width-30, 36.5)];
	[_confirmPassword setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
	[_confirmPassword setPlaceholder:@"Confirm Password"];
	[_confirmPassword setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
	[_confirmPassword setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
	[_confirmPassword setDelegate:self];
	[_confirmPassword setTag:4];
	[_confirmPassword setSecureTextEntry:YES];
	[_confirmPassword setReturnKeyType:UIReturnKeyGo];
	[_loginForm addSubview:_confirmPassword];
	
	[self.view addSubview:_loginForm];
	[self.view sendSubviewToBack:_loginForm];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[_loginForm setAlpha:1.0];
	[UIView commitAnimations];
	
	CGRect shiftLogoFrame = _logo.frame;
	shiftLogoFrame.origin.y=20;
	[UIView animateWithDuration:0.5f
						  delay:0.0
						options:UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 _logo.frame=shiftLogoFrame;
					 }
					 completion:^(BOOL finished){}
	 ];
	
	CGRect shiftLogoPaneFrame = logoPane.frame;
	shiftLogoPaneFrame.origin.y=20-(logoPane.frame.size.height)+_logo.frame.size.height;
	[UIView animateWithDuration:0.5f
						  delay:0.0
						options:UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 logoPane.frame=shiftLogoPaneFrame;
					 }
					 completion:^(BOOL finished){}
	 ];

}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
	[self processLogin];
	return NO;
}

-(void)processLogin
{
	_firstNameText=[_firstName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	_lastNameText=[_lastName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	_phoneNumberText=[_phoneNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	_passwordText=[_password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	_confirmedPasswordText=[_confirmPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	BOOL loginSuccess=YES;
	
	if ([_firstNameText isEqualToString:@""]) {
		[_firstName setValue:RED_COLOR
				 forKeyPath:@"_placeholderLabel.textColor"];
		loginSuccess=NO;
	}
	
	if ([_lastNameText isEqualToString:@""]) {
		[_lastName setValue:RED_COLOR
				 forKeyPath:@"_placeholderLabel.textColor"];
		loginSuccess=NO;
	}
	
	if ([_phoneNumberText isEqualToString:@""]){
		[_phoneNumber setValue:RED_COLOR
				 forKeyPath:@"_placeholderLabel.textColor"];
		loginSuccess=NO;
	}else if ([_phoneNumberText length]!=10){
		loginSuccess=NO;
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Bro, gimme ur full number"
															message:@"dat's 10 digits"
														   delegate:self
												  cancelButtonTitle:@"will do brah"
												  otherButtonTitles:nil];
		[alertView show];
		_phoneNumber.text=@"";
		[_phoneNumber setValue:RED_COLOR
					forKeyPath:@"_placeholderLabel.textColor"];
		loginSuccess=NO;
	}
	
	if ([_passwordText isEqualToString:@""]){
		[_password setValue:RED_COLOR
				 forKeyPath:@"_placeholderLabel.textColor"];
		loginSuccess=NO;
	}
	
	if ([_confirmedPasswordText isEqualToString:@""]) {
		[_confirmPassword setValue:RED_COLOR
				 forKeyPath:@"_placeholderLabel.textColor"];
		loginSuccess=NO;
	}
	
	if ([_passwordText isEqualToString:_confirmedPasswordText] && loginSuccess){
		_confirmedPasswordText=nil;
		_passwordText = [[self sha1:_passwordText] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	}else{
		_password.text=@"";
		[_password setValue:RED_COLOR
						forKeyPath:@"_placeholderLabel.textColor"];
		_confirmPassword.text=@"";
		[_confirmPassword setValue:RED_COLOR
				 forKeyPath:@"_placeholderLabel.textColor"];
		loginSuccess=NO;
	}
	
	if (loginSuccess){
		[self postLoginInfo];
	}
}

-(void)postLoginInfo
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *name = [_firstNameText stringByAppendingString:[NSString stringWithFormat:@" %@",_lastNameText]];
	[defaults setObject:name forKey:@"name"];
	[defaults setObject:_phoneNumberText forKey:@"phoneNumber"];
	[defaults setObject:_passwordText forKey:@"password"];
	
	[SSKeychain setPassword:_passwordText forService:SERVICE_NAME account:name];
	[self loginSuccess];
}

-(BOOL)confirmUserLogin
{
	NSError *error = nil;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *username = [defaults objectForKey:@"name"];
	NSString *passwordFromKeychain = [SSKeychain passwordForService:SERVICE_NAME account:username error:&error];
	if (passwordFromKeychain!=nil){
		//NSLog(@"User Name: %@\nPhone Number: %@\nKeychain Password: %@",username,phone,passwordFromKeychain);
		return YES;
	}
	return NO;
}

-(void)loginSuccess
{
	GatherViewController *viewController = [[GatherViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
