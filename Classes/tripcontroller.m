//
//  tripcontroller.m
//  duffel
//
//  Created by Jay Vachhani on 4/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.

#import "tripcontroller.h"

@implementation tripcontroller
@synthesize arraytrip,dictrip;
@synthesize paramlink;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	tblview.delegate = self;
	tblview.dataSource = self;
	
	activityBackgroundView=[[UIImageView alloc] initWithFrame:CGRectMake(100, 135, 120, 120)];
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
	
	[self.view addSubview:activityBackgroundView];
	[activityBackgroundView release];
	
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	
	appDelegate = [[UIApplication sharedApplication] delegate];
	self.navigationItem.title = [dictrip valueForKey:@"title"];
	self.navigationItem.rightBarButtonItem = rightbtn;	
	
	[self _getdate];
	
	[self checkforunschedule];
	
	[super viewWillAppear:animated];
}

-(void) checkforunschedule
{
	NSMutableArray* a = [arraytrip objectAtIndex:0];
	NSMutableDictionary* d = [a objectAtIndex:0];
	if(![d valueForKey:@"start-date"] || [[d valueForKey:@"start-date"] isEqualToString:@""] || [[d valueForKey:@"start-date"] isEqualToString:@" "])
	{
		isunscedule = TRUE;
		NSLog(@"Blank date in trip");
	}
	else
		isunscedule = FALSE;
}

-(void) _getdate
{
	dictrip = (NSMutableDictionary *) [appDelegate.tripsData valueForKey:[NSString stringWithFormat:@"dics_%@_%@",appDelegate.paramlink,appDelegate.username]];
	NSLog([NSString stringWithFormat:@"dics_%@_%@",appDelegate.paramlink,appDelegate.username]);
	
	NSString* sd = [dictrip valueForKey:@"start-date"];
	NSString* ed = [dictrip valueForKey:@"end-date"];
	NSString* temp;
	if(!sd || [sd isEqualToString:@""])
	{
		appDelegate._isnodate = TRUE;
		return;
	}
	else
		appDelegate._isnodate = FALSE;
	
	 year1 = [[sd substringToIndex:4] intValue];
	
	temp = [sd substringFromIndex:5];
	 month1 = [[temp substringToIndex:2] intValue];
	
	temp = [sd substringFromIndex:8];
	 date1 = [[temp substringToIndex:2] intValue];
	
	NSLog(@"year1 %d, month1 %d, date1 %d",year1,month1,date1);
	
	int year2 = [[ed substringToIndex:4] intValue];
	
	temp = [ed substringFromIndex:5];
	int month2 = [[temp substringToIndex:2] intValue];
	
	temp = [ed substringFromIndex:8];
	int date2 = [[temp substringToIndex:2] intValue];
	
	NSLog(@"year2 %d, month2 %d, date2 %d",year2,month2,date2);
	
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//	NSLog(@"sections are %d",[arraytrip count]);
	
	return [arraytrip count];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{

//	NSLog(@"ccc is %d",[[arraytrip objectAtIndex:section] count]);
	return [[arraytrip objectAtIndex:section] count];
	
	return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if(appDelegate._isnodate == TRUE)
		return @"Unscheduled";
	else
	{
		if(isunscedule)
		{
			if(section == 0)
				return @"Unscheduled";
			
		}
		

		
		NSMutableArray* aa = [arraytrip objectAtIndex:section];
		NSMutableDictionary* dd = [aa objectAtIndex:0];
//		NSLog(@"section is %d",section);
//		NSLog(@"list is %@     -  %d",[dd valueForKey:@"list"],date1);	
		int days=[[dd valueForKey:@"list"] intValue]-1;
		int year=year1;
		
		if(isunscedule)
			section--;
			
		int date11;
		int month11;
		
		date11 = date1 + days;
//		date11 = date1 + section; commented by mib for days fix
		if(date11 > [self daysofmonth:month1])
		{
			month11 = month1 + 1;
			date11 = date11 - [self daysofmonth:month1];
			if(date11 > [self daysofmonth:month11])
			{
				date11 = date11 - [self daysofmonth:month11];
				month11 = month11 + 1;
			}
			if(month11>12)
				year++;
			
			month11=month11%12;
		}
		else
			month11 = month1;
			

		
		NSString* s3 = @"";
		NSLog([s3 stringByAppendingString:[appDelegate shortDayOfWeek:month11 :date11 :year]]);
		return [s3 stringByAppendingString:[appDelegate shortDayOfWeek:month11 :date11 :year]];

	}	
	
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
}

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView* hh = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
	hh.backgroundColor = [UIColor lightGrayColor];
	
	UILabel* lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, 200, 20)];
	lbl.font = [UIFont boldSystemFontOfSize:13];
	lbl.backgroundColor = [UIColor clearColor];
	lbl.textColor = [UIColor blackColor];
	
	if(appDelegate._isnodate == TRUE)
		lbl.text = @"Unschedule";
	else
	{
		date1 = date1 + section;
		if(date1 > [self daysofmonth:month1])
		{
			month1++;
			date1 = 1;
		}
		lbl.text = [appDelegate DayOfWeek:month1 :date1 :year1];
	}	
		
	[hh addSubview:lbl];
	[lbl release];
	
	UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(255, 1, 50, 20)];
	btn.tag = section;
	[btn setTitle:@"Map" forState:UIControlStateNormal];
	[btn addTarget:self action:@selector(map_click:) forControlEvents:UIControlEventTouchUpInside];
	[btn setBackgroundImage:[UIImage imageNamed:@"btnblue.png"] forState:UIControlStateNormal];
	[hh addSubview:btn];
	[btn release];
	
	return hh;
}
 */

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
		
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"tripCell";
	
	regcell *cell = (regcell *) [tblview dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[regcell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
	// Configure the cell.
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	cell.image.frame = CGRectMake(3, 10, 31, 25);
	cell.lbl.frame = CGRectMake(48, 3, 250, 24);
	cell.lbl2.frame = CGRectMake(48, 23, 240, 24);
	
	cell.lbl.font=[UIFont boldSystemFontOfSize:14];
	cell.lbl2.textColor = [UIColor grayColor];
	
	NSMutableArray* aa = [arraytrip objectAtIndex:indexPath.section];
	NSMutableDictionary* dd = [aa objectAtIndex:indexPath.row];
	
	NSString* from;
	
	 if([[dd valueForKey:@"eventable-type"] isEqualToString:@"Activity"])
		 cell.image.image = [UIImage imageNamed:@"activity.png"];
	else if([[dd valueForKey:@"eventable-type"] isEqualToString:@"Transportation"])
	{
		cell.image.image = [UIImage imageNamed:@"transportation.png"];
		from = [dd valueForKey:@"from"];
	}
	else if([[dd valueForKey:@"eventable-type"] isEqualToString:@"Notes"])
		cell.image.image = [UIImage imageNamed:@"note.png"];
	else if([[dd valueForKey:@"eventable-type"] isEqualToString:@"Foodanddrink"])
		cell.image.image = [UIImage imageNamed:@"food.png"];
	else if([[dd valueForKey:@"eventable-type"] isEqualToString:@"Hotel"])
		cell.image.image = [UIImage imageNamed:@"lodging.png"];
	else
		cell.image.image = [UIImage imageNamed:@"icon.png"];
	
	
	NSString* s = [[dd valueForKey:@"title"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@""];
	
	if([[dd valueForKey:@"eventable-type"] isEqualToString:@"Transportation"])
	{
		cell.lbl.text = [s stringByReplacingOccurrencesOfString:@"&rarr;" withString:@"to"];
	}
	else
		cell.lbl.text = s;
		
	
	if([appDelegate removeUS:[dd valueForKey:@"address"]] == nil || [[appDelegate removeUS:[dd valueForKey:@"address"]] isEqualToString:@""] || [[appDelegate removeUS:[dd valueForKey:@"address"]] isEqualToString:@" "])
	{
		cell.lbl.frame = CGRectMake(48, 9, 250, 27);
		cell.lbl2.hidden = TRUE;
	}
	else
	{
		cell.lbl2.hidden = FALSE;
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
			cell.lbl.frame = CGRectMake(48, 9, 250, 27);
			cell.lbl2.hidden = TRUE;
		}
		else
		{
			cell.lbl2.text = s2;
		}
	}
	
	//cell.image.image = 
	
	return cell;
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[NSThread detachNewThreadSelector:@selector(StartAnimation) toTarget:self withObject:nil];
	
	[tblview deselectRowAtIndexPath:indexPath animated:YES];
	
//	notecontroller* object = [[notecontroller alloc] initWithNibName:@"notecontroller" bundle:nil];
	HowToViewController* object = [[HowToViewController alloc] init];
	
//	NSMutableDictionary* dics = [self get_dics];

	object.arraytrip = arraytrip;
	object.isunsch = isunscedule;
	
//	if(isunscedule)
//	{
//		if(indexPath.section > 0)
//		{
//			object.section = indexPath.section -1;
//			object.row = indexPath.row;
//		}
//	}
//	else
	{
		object.section = indexPath.section;
		object.row = indexPath.row;
	}

/*	
	if(indexPath.section == 0)
	{
		object.selected_note = indexPath.row;
		object.lbldate = @"Monday - March 1st, 2010";
	}
	else
	{
		object.selected_note = 4 + indexPath.row;
		object.lbldate = @"Monday - March 2nd, 2010";
	}
*/
	
	[self.navigationController pushViewController:object animated:YES];
	self.navigationItem.title = @"Back";
	[object release];
	
	[self StopAnimation];
	
	// Navigation logic may go here -- for example, create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController animated:YES];
	// [anotherViewController release];
}

#pragma mark Btn evens

-(IBAction) rightbtn_click
{
	NSLog(@"arrat is %d",arraytrip.count);
	
	mapcontroller* object = [[mapcontroller alloc] initWithNibName:@"mapcontroller" bundle:nil];
	
	object.isFromAll = TRUE;
	object.arraytrip = arraytrip;
	object.isunscedule = isunscedule;

	[self.navigationController pushViewController:object animated:YES];
	self.navigationItem.title = @"Back";
	[object release];
	
}

-(IBAction) map_click:(id) sender
{
	NSMutableDictionary* dicstrip = (NSMutableDictionary *) [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"dics_%@_%@",appDelegate.paramlink,appDelegate.username]];
	
	UIButton* b = (UIButton *) sender;
	NSMutableArray* aa = [arraytrip objectAtIndex:b.tag];
	
	NSMutableDictionary* dd = [aa objectAtIndex:0];
	
	mapcontroller* object = [[mapcontroller alloc] initWithNibName:@"mapcontroller" bundle:nil];
	object.lat = [[dd valueForKey:@"lat"]doubleValue];
	object.lng = [[dd valueForKey:@"lng"]doubleValue];
	object.title1 = [dicstrip valueForKey:@"destination"];
	
	
	if(object.lat == 0 && object.lng == 0)
	{
		if([aa count] > 1)
		{
			NSMutableDictionary* dd2 = [aa objectAtIndex:1];
			object.lat = [[dd2 valueForKey:@"lat"]doubleValue];
			object.lng = [[dd2 valueForKey:@"lng"]doubleValue];
		}	
		if(object.lat == 0 && object.lng == 0)
		{
			if([aa count] > 2)
			{
				NSMutableDictionary* dd2 = [aa objectAtIndex:2];
				object.lat = [[dd2 valueForKey:@"lat"]doubleValue];
				object.lng = [[dd2 valueForKey:@"lng"]doubleValue];
			}			
		}
	}
	
	[self.navigationController pushViewController:object animated:YES];
	self.navigationItem.title = @"Back";
	[object release];
}

-(NSMutableDictionary *) get_dics
{
	NSMutableDictionary* dics = [[NSMutableDictionary alloc] init];
	[dics setValue:@"Golden Gate Bridge" forKey:@"0"];
	[dics setValue:@"Alcatraz" forKey:@"1"];
	[dics setValue:@"Ferry Building" forKey:@"2"];
	[dics setValue:@"Best Restaurant in SF!" forKey:@"3"];
	[dics setValue:@"SFO -> LAX 3PM" forKey:@"4"];
	[dics setValue:@"Getty Museum" forKey:@"5"];
	[dics setValue:@"Santa Monica" forKey:@"6"];
	[dics setValue:@"Note here" forKey:@"7"];
	return dics;
}

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
	NSLog(@"dd called");
	
    [super dealloc];
}

@end
