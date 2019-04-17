//
//  tripcontroller.h
//  duffel
//
//  Created by Jay Vachhani on 4/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "regcell.h"
#import "mapcontroller.h"
#import "notecontroller.h"
#import "duffelAppDelegate.h"
#import "HowToViewController.h"

@interface tripcontroller : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
	duffelAppDelegate* appDelegate;
	
	IBOutlet UITableView* tblview;
	IBOutlet UIView* secheader;
	IBOutlet UIBarButtonItem* rightbtn;
	
	NSMutableDictionary* dics1;
	NSMutableDictionary* dics2;
	
	NSMutableArray* arraytrip;
	NSMutableDictionary* dictrip;
	NSString* paramlink;
	
	int totaldays;
	int year1;
	int month1; 
	int date1; 
	
	BOOL isunscedule;
	
	
	UIActivityIndicatorView *activityViewer;
	UIImageView *activityBackgroundView;
	
}

@property (nonatomic,retain) NSMutableArray* arraytrip;
@property (nonatomic,retain) NSMutableDictionary* dictrip;
@property (nonatomic,retain) NSString* paramlink;

-(void) checkforunschedule;
-(void) _getdate;
-(int) daysofmonth:(int) d2;

-(IBAction) rightbtn_click;

-(NSMutableDictionary *) get_dics;
-(IBAction) map_click:(id) sender;

@end
