//
//  GatherEventsTableViewCell.m
//  Gather
//
//  Created by Taylor Seale on 6/22/13.
//  Copyright (c) 2013 tseale. All rights reserved.
//

#import "GatherEventsTableViewCell.h"

@implementation GatherEventsTableViewCell

- (id)initWithData:(GatherCellData*)data
{
    self = [super init];
    if (self) {
        // Initialization code
		[self setBackgroundColor:[UIColor whiteColor]];
		[self setFrame:CGRectMake(0, 0, self.bounds.size.width, 75)];
		
		UIView *greenBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/2.0, self.frame.size.height)];
		[greenBackground setBackgroundColor:[UIColor greenColor]];
		[self addSubview:greenBackground];
		UILabel *yesLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/4.0, self.frame.size.height)];
		[yesLabel setText:@"Yes"];
		[yesLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]];
		[yesLabel setTextColor:[UIColor whiteColor]];
		[yesLabel setTextAlignment:NSTextAlignmentCenter];
		[self addSubview:yesLabel];
		
		UIView *redBackground = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0, 0, self.frame.size.width/2.0, self.frame.size.height)];
		[redBackground setBackgroundColor:[UIColor redColor]];
		[self addSubview:redBackground];
		UILabel *noLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-self.frame.size.width/4.0, 0, self.frame.size.width/4.0, self.frame.size.height)];
		[noLabel setText:@"No"];
		[noLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]];
		[noLabel setTextColor:[UIColor whiteColor]];
		[noLabel setTextAlignment:NSTextAlignmentCenter];
		[self addSubview:noLabel];
		
		_eventName=data.eventName;
		_eventLocation=data.eventLocation;
		_eventTime=data.eventTime;
		_eventGroup=data.eventGroup;
		
		_participants=data.participants;
		_accepts=data.accepts;
		_rejects=data.rejects;
		
		_response=data.response;
		
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
		if (_response==1){
			[_responseLabel setText:@"Attending"];
		}else if (_response==-1){
			[_responseLabel setText:@"Not Attending"];
		}else if (_response==0){
			[_responseLabel setText:@"N/A"];
		}
		[_responseLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0f]];
		[_responseLabel setTextColor:[UIColor colorWithRed:0.10f green:0.10f blue:0.10f alpha:1.00f]];
		[_responseLabel setTextAlignment:NSTextAlignmentRight];
		
		
		[_cellOverlay addSubview:_eventTitle];
		[_cellOverlay addSubview:_eventSubtitle];
		[_cellOverlay addSubview:_responseLabel];
		 
		
		_progressLine = [[UIView alloc] initWithFrame:CGRectMake(10, self.frame.size.height-3, self.frame.size.width-20, 2)];
		[_progressLine setBackgroundColor:[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f]];
		[_cellOverlay addSubview:_progressLine];
		_acceptLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _increment*_accepts, 2)];
		[_acceptLine setBackgroundColor:[UIColor greenColor]];
		[_progressLine addSubview:_acceptLine];
		_rejectLine = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-(_increment*_rejects)-20, 0,_increment*_rejects, 2)];
		[_rejectLine setBackgroundColor:[UIColor redColor]];
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
	CGSize newSize = [@" Event Name " sizeWithFont: [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
	CGRect textFrame = eventName.frame;
	textFrame.size.width  = newSize.width;
	eventName.frame = textFrame;
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
