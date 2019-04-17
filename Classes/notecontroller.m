//
//  notecontroller.m
//  duffel
//
//  Created by Jay Vachhani on 4/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "notecontroller.h"
#import <QuartzCore/QuartzCore.h>

@implementation notecontroller
@synthesize section,row,lblstr,arraytrip,lbldate;
@synthesize isunschedule;


// image path // http://s3.amazonaws.com/duffelup_trip_production/photos/7543/thumb/img.jpg


-(void)StartAnimation
{
	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
	activityBackgroundView.alpha=1;
	[activityViewer startAnimating];
	[pool release];
}

-(void)StopAnimation
{
	activityBackgroundView.alpha=0;
	[activityViewer stopAnimating];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[self viewWillAppear:YES];
		[super viewDidLoad];
	NSLog(@"view did loaded called");
	
	appDelegate = [[UIApplication sharedApplication] delegate];
	
	activityBackgroundView=[[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 120, 120)];
	[activityBackgroundView setImage:[UIImage imageNamed:@"panel.png"]];
	activityBackgroundView.alpha=0;
	
	
	UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(30, 85, 100, 20)];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setText:@"Loading..."];
	[label setFont:[UIFont boldSystemFontOfSize:14]];
	[label setTextColor:[UIColor whiteColor]];
	[activityBackgroundView addSubview:label];
	[label release];
	
	activityViewer=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(40, 40, 40, 40)];
	activityViewer.hidesWhenStopped=YES;
	activityViewer.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
	[activityBackgroundView addSubview:activityViewer];
	[activityViewer release];
	
	[appDelegate.window addSubview:activityBackgroundView];
	[activityBackgroundView release];
	
	[NSThread detachNewThreadSelector:@selector(StartAnimation) toTarget:self withObject:nil];
	[self.view setHidden:YES];
	

	[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(demo) userInfo:nil repeats:NO];

	/*
	appDelegate = [[UIApplication sharedApplication] delegate];
	self.navigationItem.title = @"Duffel";
	self.navigationItem.rightBarButtonItem = rightbtn;
	
	txtview.font = [UIFont systemFontOfSize:16];
	//txtview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"note1.png"]];
	[self setdate];
	 
*/


}

-(void) setdate
{
	
	NSMutableArray* aa2 = [arraytrip objectAtIndex:section];
	
//	NSMutableDictionary* ddmap = [aa2 objectAtIndex:row];
//	
//	NSLog(@"fat is %f     %f",[[ddmap valueForKey:@"lat"]doubleValue],[[ddmap valueForKey:@"lng"]doubleValue]);
	
	
	NSMutableDictionary* dd2 = [aa2 objectAtIndex:0];
	
	NSString* s = [NSString stringWithFormat:@"dics_%@_%@",appDelegate.paramlink,appDelegate.username];
	NSMutableDictionary* dictrip = (NSMutableDictionary *) [appDelegate.tripsData valueForKey:s];
	tttt = [dictrip valueForKey:@"title"];
	
	
	if(appDelegate._isnodate == TRUE)
	{
		lbl_date.text = @"Unsheduled";
		return;
	}
	
	if(isunschedule)
	{
		if(section == 0)
		{
			lbl_date.text = @"Unsheduled";
			return;
		}
	}
	
	NSString* sd = [dictrip valueForKey:@"start-date"];
//	NSString* ed = [dictrip valueForKey:@"end-date"];
	NSString* temp;
	int days=[[dd2 valueForKey:@"list"] intValue]-1;
	 year1 = [[sd substringToIndex:4] intValue];
	
	temp = [sd substringFromIndex:5];
	 month1 = [[temp substringToIndex:2] intValue];
	
	temp = [sd substringFromIndex:8];
	 date1 = [[temp substringToIndex:2] intValue]+days;
	
	NSLog(@"year1 %d, month1 %d, date1 %d",year1,month1,date1);
/*	
	int year2 = [[ed substringToIndex:4] intValue];
	
	temp = [ed substringFromIndex:5];
	int month2 = [[temp substringToIndex:2] intValue];
	
	temp = [ed substringFromIndex:8];
	int date2 = [[temp substringToIndex:2] intValue];
	
	///////////////
	 
 */
	NSString* ss = [appDelegate DayOfWeek:month1 :date1 :year1];
	lbl_date.text = ss;
}

-(void) datechange
{
	if(appDelegate._isnodate == TRUE)
	{
		lbl_date.text = @"Unsheduled";
		return;
	}
	
	if(isunschedule)
	{
		if(section == 0)
		{
			lbl_date.text = @"Unsheduled";
			return;
		}
	}
	
	int date11;
	int month11;
	
	if(isunschedule)
		date11 = date1 + section -1;
	else
		date11 = date1 + section;
		
	if(date11 > [self daysofmonth:month1])
	{
		month11 = month1 + 1;
		date11 = date11 - [self daysofmonth:month1];
		if(date11 > [self daysofmonth:month11])
		{
			date11 = date11 - [self daysofmonth:month11];
			month11 = month11 + 1;
		}
	}
	else
		month11 = month1;
	
	NSString* ss = [appDelegate DayOfWeek:month11 :date11 :year1];
	lbl_date.text = ss;
}
-(int) daysofmonth:(int) d2
{
	int days_in_month;
	if(d2 < 8)
	{
		if(d2 == 2)
			days_in_month = 28;
		else if((d2 % 2) == 0)
			days_in_month = 30;
		else
			days_in_month = 31;
	}
	else
	{
		if((d2 % 2) == 0)
			days_in_month = 31;
		else
			days_in_month = 30;
		
	}
	return days_in_month;
	
}

- (void)viewWillAppear:(BOOL)animated 
{
	NSLog(@"view will appear called");
	
	/*
	appDelegate = [[UIApplication sharedApplication] delegate];
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-board.png"]];

	self.navigationItem.title = tttt;
	
	aa = [arraytrip objectAtIndex:section];
	dd = [aa objectAtIndex:row];
	

	[self setText];
	[self setarrows];
	*/

	
    [super viewWillAppear:animated];
}



-(void)demo
{
//	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
	

	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-board.png"]];
	
	self.navigationItem.title = tttt;
	
	aa = [arraytrip objectAtIndex:section];
	dd = [aa objectAtIndex:row];
	
	
	[self setText];
	[self setarrows];

	appDelegate = [[UIApplication sharedApplication] delegate];
//	self.navigationItem.title = @"Duffel";
//	self.navigationItem.rightBarButtonItem = rightbtn;


	
	txtview.font = [UIFont systemFontOfSize:16];
	//txtview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"note1.png"]];
	[self setdate];
	
//	[pool release];

	[self StopAnimation];	
	[self.view setHidden:NO];

}

#pragma mark -
#pragma mark Touch methods
/* commented for UIPageControl
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	UITouch *touch = [[event allTouches] anyObject];
	f_point = [touch locationInView:touch.view];
	

	NSLog(@"began");
} 

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{ 
	
	UITouch *touch = [[event allTouches] anyObject];
	s_point = [touch locationInView:touch.view];
	
	
	[self scroll];
	
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
	
	NSLog(@"x:%d , y:%d",f_point.x,f_point.y);
	
}
*/
-(void)scroll
{
	
	if(f_point.x == s_point.x)
		return;
	
	if(f_point.x < s_point.x)
	{
		/// go left , decrement in array
		if(row <= 0)
		{
			if(section > 0)
			{
				section--;
				aa = [arraytrip objectAtIndex:section];
				row = ([aa count] - 1);
				if(row >= 0)
					dd = [aa objectAtIndex:row];
			}
			else
			{
				NSLog(@"End left button");
				return;
			}
			
		}
		else
		{
		row--;
		dd = [aa objectAtIndex:row];
		}
	}
	else if(f_point.x > s_point.x)
	{
		/// go right , increment in array
		row++;
		if(row >= [aa count])
		{
			if(section < [arraytrip count] - 1)
			{
				section++;
				aa = [arraytrip objectAtIndex:section];
				row = 0;
				if([aa count] > 0)
					dd = [aa objectAtIndex:row];
			}
			else
			{
				NSLog(@"End right button");
				row--;
				return;
			}
			
		}
		else
		{
			dd = [aa objectAtIndex:row];
		}
	}
	
	CATransition *animation = [CATransition animation];
	[animation setDelegate:self];
	[animation setType:kCATransitionPush];
	
	if(f_point.x < s_point.x)
		[animation setSubtype:kCATransitionFromLeft];
	else if(f_point.x > s_point.x)
		[animation setSubtype:kCATransitionFromRight];
	
	[animation setDuration:0.3];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
	
	
	[[imagenote layer] addAnimation:animation forKey:@"transitionViewAnimation"];
	[[txtview layer] addAnimation:animation forKey:@"transitionViewAnimation1"];
	[[lbl layer] addAnimation:animation forKey:@"transitionViewAnimation2"];
	[[lbl_address layer] addAnimation:animation forKey:@"transitionViewAnimation3"];
	[[lbl_category layer] addAnimation:animation forKey:@"transitionViewAnimation4"];
	[[btnlink layer] addAnimation:animation forKey:@"transitionViewAnimation5"];
	[[lbl_date layer] addAnimation:animation forKey:@"transitionViewAnimation6"];
	[[btncall layer] addAnimation:animation forKey:@"transitionViewAnimation7"];
	
	
	txtview.text = [dd valueForKey:@"title"];
	
	[self setdate];//fixed invlaid date issue
	[self setText];

	//[[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",selected_note] forKey:@"stick"];

	[[imagenote layer] removeAnimationForKey:@"transitionViewAnimation"];
	[[txtview layer] removeAnimationForKey:@"transitionViewAnimation1"];
	[[lbl layer] removeAnimationForKey:@"transitionViewAnimation2"];
	[[lbl_address layer] removeAnimationForKey:@"transitionViewAnimation3"];
	[[lbl_category layer] removeAnimationForKey:@"transitionViewAnimation4"];
	[[btnlink layer] removeAnimationForKey:@"transitionViewAnimation5"];
	[[lbl_date layer] removeAnimationForKey:@"transitionViewAnimation6"];
	[[btncall layer] removeAnimationForKey:@"transitionViewAnimation7"];
	
	animation = nil;
	
	
	[self setarrows];
	
}

-(void) setarrows
{
	
	if(row <= 0)
	{
		if(section <= 0)
			btnleft.hidden = TRUE;
		else
			btnleft.hidden = FALSE;
	}
	else
		btnleft.hidden = FALSE;
	
	if(section >= [arraytrip count] - 1)
	{
		if(row >= [aa count] - 1)
		{
			btnright.hidden = TRUE;	
		}
			
		else
			btnright.hidden = FALSE;
	}
	else
		btnright.hidden = FALSE;
	
}

-(void) setText
{
	NSString* tnote = [dd valueForKey:@"content"];
	
	NSCharacterSet* set = [NSCharacterSet characterSetWithCharactersInString:@"\t"];
	tnote=[tnote stringByTrimmingCharactersInSet:set];
	set = [NSCharacterSet characterSetWithCharactersInString:@"  "];
	tnote=[tnote stringByTrimmingCharactersInSet:set];
	set = [NSCharacterSet characterSetWithCharactersInString:@" "];
	tnote=[tnote stringByTrimmingCharactersInSet:set];
	
	txtview.text = tnote;
	
	lbl_category.text = [dd valueForKey:@"eventable-type"];
	
	
	if([[dd valueForKey:@"eventable-type"] isEqualToString:@"Activity"])
		lbl_category.backgroundColor = [UIColor colorWithRed:0.75 green:0.8671 blue:0.4062 alpha:1.0];
	else if([[dd valueForKey:@"eventable-type"] isEqualToString:@"Transportation"])
		lbl_category.backgroundColor = [UIColor colorWithRed:0.9492 green:0.5 blue:0.6953 alpha:1.0];
	else if([[dd valueForKey:@"eventable-type"] isEqualToString:@"Notes"])
		lbl_category.backgroundColor = [UIColor colorWithRed:0.84705 green:0.8980 blue:0.69411 alpha:1.0];
	else if([[dd valueForKey:@"eventable-type"] isEqualToString:@"Hotel"])
	{
		lbl_category.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
		lbl_category.text = @"Lodging";
	}
	else if([[dd valueForKey:@"eventable-type"] isEqualToString:@"Foodanddrink"])
	{
		
		lbl_category.backgroundColor = [UIColor colorWithRed:0.25 green:0.7578 blue:0.9492 alpha:1];
		lbl_category.text = @"Food & Drink";
	}
	
	NSString* s = [[dd valueForKey:@"title"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@""];
	lbl.text = [s stringByReplacingOccurrencesOfString:@"&rarr;" withString:@"to"];
	
	
	NSString* spath = [NSString stringWithFormat:@"http://s3.amazonaws.com/duffelup_trip_production/photos/%@/thumb/%@",[dd valueForKey:@"id"],[dd valueForKey:@"photo-file-name"]];
	NSData* data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:spath]];
	if(data)
	{
		imagethumb.hidden = FALSE;
		imagethumb.image = [UIImage imageWithData:data];
	}
	imagethumb.hidden = TRUE;
	
	if([[dd valueForKey:@"eventable-type"] isEqualToString:@"Notes"])
	{
		lbl_category.hidden = TRUE;
		imagenote.image = [UIImage imageNamed:@"ynote3.png"];
		txtview.frame = CGRectMake(23, 138, 271, 199);
	}
	else
	{
//		txtview.frame = CGRectMake(23, 150, 271, 210);
		txtview.frame = CGRectMake(23, 138, 271, 199);
		lbl_category.hidden = FALSE;
		imagenote.image = [UIImage imageNamed:@"note5.png"];	
		txtview.text = [dd valueForKey:@"note"];
	}
	
//	[btnlink setTitle:[dd valueForKey:@"website"] forState:UIControlStateNormal];
	[btncall setTitle:[dd valueForKey:@"phone"] forState:UIControlStateNormal];

	if([dd valueForKey:@"website"] == nil || [[dd valueForKey:@"website"] isEqualToString:@""])
		btnlink.hidden = TRUE;
	else
		btnlink.hidden = FALSE;
	
//	[self datechange];
	
	
	////// address
	
	if([appDelegate removeUS:[dd valueForKey:@"address"]] == nil || [[appDelegate removeUS:[dd valueForKey:@"address"]] isEqualToString:@""] || [[appDelegate removeUS:[dd valueForKey:@"address"]] isEqualToString:@" "])
	{
		lbl_address.hidden = TRUE;
		//txtview.frame = CGRectMake(23, 110, 271, 199);
		txtview.frame = CGRectMake(23, 138, 271, 199);
	}
	else
	{
		lbl_address.hidden = FALSE;
		NSString* s2 = [appDelegate removeUS:[dd valueForKey:@"address"]];
		
		NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"\n"];
		s2=[s2 stringByTrimmingCharactersInSet:set];
		set = [NSCharacterSet characterSetWithCharactersInString:@"\t"];
		s2=[s2 stringByTrimmingCharactersInSet:set];
		set = [NSCharacterSet characterSetWithCharactersInString:@" "];
		s2=[s2 stringByTrimmingCharactersInSet:set];
		set = [NSCharacterSet characterSetWithCharactersInString:@"  "];
		s2=[s2 stringByTrimmingCharactersInSet:set];
		if(s2 == nil || [s2 isEqualToString:@""])
		{
			lbl_address.hidden = TRUE;
		}
		else
		{
			lbl_address.text = s2;
		}
	}
	
}

-(IBAction) btnlink_click
{
	webviewcontroller* object = [[webviewcontroller alloc] initWithNibName:@"webviewcontroller" bundle:nil];
	object.urlAddress = [dd valueForKey:@"website"];
	object.title1 = [dd valueForKey:@"title"];
	[appDelegate.navigationController pushViewController:object animated:YES];
//	self.navigationItem.title = @"Back";
	[object release];
	
}

-(IBAction) btncall_click
{
	if([dd valueForKey:@"phone"] == nil || [[dd valueForKey:@"phone"] isEqualToString:@""])
		return;
	
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"Are you sure you want to dial %@?",[dd valueForKey:@"phone"]] delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
	alert.tag = -1;
	[alert show];
	[alert release];
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertView.tag == -1)
	{
		if(buttonIndex == 0)
		{
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:+1%@",[dd valueForKey:@"phone"]]]];
		}
	}
}

-(IBAction) left_click
{
		
//	selected_note--;
//	if(selected_note < 0)
//	{
//		selected_note = 0;
//		return;
//	}
	
	row--;
	if(row < 0)
	{
		if(section > 0)
		{
			section--;
			aa = [arraytrip objectAtIndex:section];
			row = ([aa count] - 1);
			if(row >= 0)
				dd = [aa objectAtIndex:row];
		}
		else
		{
			NSLog(@"End left button");
		}
		
	}
	else
	{
		dd = [aa objectAtIndex:row];
	}
	
	CATransition *animation = [CATransition animation];
	[animation setDelegate:self];
	[animation setType:kCATransitionPush];
	
		[animation setSubtype:kCATransitionFromLeft];
	//	[animation setSubtype:kCATransitionFromRight];
	
	[animation setDuration:0.3];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
	
	[[txtview layer] addAnimation:animation forKey:@"transitionViewAnimation"];
	
	NSString* spath = [NSString stringWithFormat:@"http://s3.amazonaws.com/duffelup_trip_production/photos/%@/thumb/%@",[dd valueForKey:@"id"],[dd valueForKey:@"photo-file-name"]];
	NSData* data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:spath]];
	if(data)
		imagenote.image = [UIImage imageWithData:data];
	
	txtview.text = [dd valueForKey:@"title"];
	
	[self setdate];//fixed invlaid date issue on right arrow click
	[self setText];
	
	//[[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",selected_note] forKey:@"stick"];
	
	[[txtview layer] removeAnimationForKey:@"transitionViewAnimation"];
	animation = nil;

	if(row == 0)
	{
		if(section > 0)
		{
			section--;
			aa = [arraytrip objectAtIndex:section];
			row = ([aa count] - 1);
			if(row >= 0)
				dd = [aa objectAtIndex:row];
		}
		else
		{
			NSLog(@"End left button");
			btnleft.hidden = TRUE;
		}
		
	}
	
	[self setarrows];
	
	
}
-(IBAction) right_click
{
	
	row++;
	if(row >= [aa count])
	{
		if(section < [arraytrip count] - 1)
		{
			section++;
			aa = [arraytrip objectAtIndex:section];
			row = 0;
			if([aa count] > 0)
				dd = [aa objectAtIndex:row];
		}
		else
		{
			NSLog(@"End right button");
			row--;
			return;
		}
		
	}
	else
	{
		dd = [aa objectAtIndex:row];
	}
	
	CATransition *animation = [CATransition animation];
	[animation setDelegate:self];
	[animation setType:kCATransitionPush];
	
	//	[animation setSubtype:kCATransitionFromLeft];
		[animation setSubtype:kCATransitionFromRight];
	
	[animation setDuration:0.3];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
	
	[[txtview layer] addAnimation:animation forKey:@"transitionViewAnimation"];
	
	[self setdate];
	[self setText];  //fixed invlaid date issue on right arrow click
	
	//[[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",selected_note] forKey:@"stick"];
	
	[[txtview layer] removeAnimationForKey:@"transitionViewAnimation"];
	animation = nil;
	
	[self setarrows];
	
}

#pragma mark mapcontroller
-(IBAction) rightbtn_click
{
	BOOL success = FALSE;
//	NSMutableDictionary* dicstrip = (NSMutableDictionary *) [appDelegate.tripsData valueForKey:[NSString stringWithFormat:@"dics_%@_%@",appDelegate.paramlink,appDelegate.username]];

	NSMutableArray* aamap = [arraytrip objectAtIndex:section];
	mapcontroller* object = [[mapcontroller alloc] initWithNibName:@"mapcontroller" bundle:nil];
	object.isFromAll = FALSE;

	NSMutableDictionary* ddmap = [aamap objectAtIndex:row];
	
	object.lat = [[ddmap valueForKey:@"lat"]doubleValue];
	object.lng = [[ddmap valueForKey:@"lng"]doubleValue];
	object.title1 = [ddmap valueForKey:@"title"];
	
	if(object.lat != 0 && object.lng != 0)
	{
		success = TRUE;
	}
	else
	{
		
		for(int i=0; i<[aamap count]; i++)
		{
			NSMutableDictionary* ddmap = [aamap objectAtIndex:i];
			
			object.lat = [[ddmap valueForKey:@"lat"]doubleValue];
			object.lng = [[ddmap valueForKey:@"lng"]doubleValue];
			object.title1 = [ddmap valueForKey:@"title"];
			
			if(object.lat != 0 && object.lng != 0)
			{
				success = TRUE;
				break;
			}
		}
	}
	
	if(success)
	{
		[appDelegate.navigationController pushViewController:object animated:YES];
		//self.navigationItem.title = @"Back";
		[object release];
	}
	else
	{
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Location could not found!" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
		[alert show];
		[alert release];
	}
}

#pragma mark Memory
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[arraytrip release];	
	[lblstr release];
	[lbldate release];
    [super dealloc];
rightbtn=nil;	
txtview=nil;
imagenote=nil;
imagethumb=nil;
lbl=nil;
lbl_date=nil;
lbl_category=nil;
btnlink=nil;
btncall=nil;
btnleft=nil;
btnright=nil;
lbl_address=nil;
	
	NSLog(@"dealloc calleeeeeeeeeeeeeeee");
}

//old colors
/*
 
 if([[dd valueForKey:@"eventable-type"] isEqualToString:@"Activity"])
 lbl_category.backgroundColor = [UIColor colorWithRed:0.84705 green:0.8980 blue:0.69411 alpha:1.0];
 else if([[dd valueForKey:@"eventable-type"] isEqualToString:@"Transportation"])
 lbl_category.backgroundColor = [UIColor colorWithRed:0.92156 green:0.65098 blue:0.7843 alpha:1.0];
 else if([[dd valueForKey:@"eventable-type"] isEqualToString:@"Notes"])
 lbl_category.backgroundColor = [UIColor colorWithRed:0.84705 green:0.8980 blue:0.69411 alpha:1.0];
 else if([[dd valueForKey:@"eventable-type"] isEqualToString:@"Hotel"])
 lbl_category.backgroundColor = [UIColor colorWithRed:0.6039 green:0.8470 blue:0.94901 alpha:1.0];
 else if([[dd valueForKey:@"eventable-type"] isEqualToString:@"Foodanddrink"])
 {
 
 lbl_category.backgroundColor = [UIColor colorWithRed:0.25 green:0.7578 blue:0.9492 alpha:1];
 lbl_category.text = @"Food & Drink";
 }
*/ 

@end



@implementation SwipeableTextView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
	
    [self.superview touchesBegan:touches withEvent:event];
	
	
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
	
    [self.superview touchesMoved:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
	
    [self.superview touchesEnded:touches withEvent:event];
} 

@end

