//
//  GatherEventsTableViewCell.m
//  Gather
//
//  Created by Taylor Seale on 6/22/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherEventsTableViewCell.h"
#import "GatherUserResponseData.h"

@implementation GatherEventsTableViewCell

- (id)initWithData:(GatherEventData*)data
{
    self = [super init];
    if (self) {
        // Initialization code
		[self setBackgroundColor:[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]];
		[self setFrame:CGRectMake(0, 0, self.bounds.size.width, 75)];
		
		_background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
		[_background setBackgroundColor:[UIColor clearColor]];
		[self addSubview:_background];
		
		_yesLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/4.0, self.frame.size.height)];
		[_yesLabel setText:@"\u2713"];
		[_yesLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30.0f]];
		[_yesLabel setTextColor:[UIColor whiteColor]];
		[_yesLabel setTextAlignment:NSTextAlignmentCenter];
		[self addSubview:_yesLabel];
		
		_noLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-self.frame.size.width/4.0, 0, self.frame.size.width/4.0, self.frame.size.height)];
		[_noLabel setText:@"X"];
		[_noLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]];
		[_noLabel setTextColor:[UIColor whiteColor]];
		[_noLabel setTextAlignment:NSTextAlignmentCenter];
		[self addSubview:_noLabel];
		
		_eventName=data.what;
		_eventLocation=data.where;
		_eventTime=data.when;
		_eventGroup=data.group;
		
		_participants=data.total;
		_accepts=data.accepts;
		_rejects=data.rejects;
		
		GatherUserResponseData *user = [data.who objectForKey:USER_ID];
		_response=user.user_response;
		
		_increment = (self.frame.size.width-20)/_participants;

		NSString *title = _eventName;
		title = [title stringByAppendingString:@" @ "];
		title = [title stringByAppendingString:_eventLocation];
		
		NSString *subtitle = _eventTime;
		subtitle = [subtitle stringByAppendingString:@" w/ "];
		subtitle = [subtitle stringByAppendingString:_eventGroup];
		
		_cellOverlay = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width, self.frame.size.height)];
		[_cellOverlay setBackgroundColor:[UIColor whiteColor]];
				
		_eventTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, self.frame.size.width-15, 20)];
		[_eventTitle setText:title];
		[_eventTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
		[_eventTitle setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
		
		_eventSubtitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, self.frame.size.width-15, 20)];
		[_eventSubtitle setText:subtitle];
		[_eventSubtitle setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f]];
		[_eventSubtitle setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
		
		_responseLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-115,self.frame.size.height-22, 100, 20)];
		[_responseLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0f]];
		[_responseLabel setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
		[_responseLabel setTextAlignment:NSTextAlignmentRight];
		
		_responseTab = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-10,-10, 20, 20)];
		CGAffineTransform transform = CGAffineTransformMakeRotation(3*M_PI_4);
		_responseTab.transform = transform;
		if (_response==1){
			[_responseTab setBackgroundColor:GREEN_COLOR];
		}else if (_response==-1){
			[_responseTab setBackgroundColor:RED_COLOR];
		}else if (_response==0){
			[_responseTab setBackgroundColor:[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f]];
		}

		[_cellOverlay addSubview:_responseTab];
		
		[_cellOverlay setClipsToBounds:YES];
		[_cellOverlay addSubview:_eventTitle];
		[_cellOverlay addSubview:_eventSubtitle];
		//[_cellOverlay addSubview:_responseLabel];
		 
		
		_progressLine = [[UIView alloc] initWithFrame:CGRectMake(10, self.frame.size.height-8, self.frame.size.width-20, 2)];
		[_progressLine setBackgroundColor:[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f]];
		[_cellOverlay addSubview:_progressLine];
		_acceptLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _increment*_accepts, 2)];
		[_acceptLine setBackgroundColor:GREEN_COLOR];
		[_progressLine addSubview:_acceptLine];
		_rejectLine = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-(_increment*_rejects)-20, 0,_increment*_rejects, 2)];
		[_rejectLine setBackgroundColor:RED_COLOR];
		[_progressLine addSubview:_rejectLine];
		[_cellOverlay addSubview:_progressLine];
		[self addSubview:_cellOverlay];
		
    }
    return self;
}

-(void)addText
{
	UITextField *eventName = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, 50, 20)];
	[eventName setBackgroundColor:[UIColor colorWithRed:0.91f green:0.91f blue:0.91f alpha:1.00f]];
	[eventName setPlaceholder:@" Event Name "];
	/*
	CGSize newSize = [@" Event Name " sizeWithFont: [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
	CGRect textFrame = eventName.frame;
	textFrame.size.width  = newSize.width;
	eventName.frame = textFrame;
	 */
	[eventName setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
	[eventName setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
	[eventName setTextAlignment:NSTextAlignmentLeft];
	[_cellOverlay addSubview:eventName];
	[eventName becomeFirstResponder];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
