//
//  myduffelcontroller.h
//  duffel
//
//  Created by Jay Vachhani on 4/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "regcell.h"
#import "tripcontroller.h"
#import "duffelAppDelegate.h"

@interface myduffelcontroller : UIViewController <UITableViewDelegate, UITableViewDataSource,UITabBarDelegate>
{
	duffelAppDelegate* appDelegate;
	IBOutlet UITableView* tblview;
	IBOutlet UIView* settingview;
	IBOutlet UIBarButtonItem* rightbtn;
	
	IBOutlet UITabBar* tbbar;
	IBOutlet UITabBarItem* myduffeltab;
	
	IBOutlet UIButton* btnsync;
	IBOutlet UIButton* btnlogout;
	
	int tab;
	
	IBOutlet UIImageView* bk_act;
	IBOutlet UILabel* bk_lbl;
	IBOutlet UIActivityIndicatorView* actview;
	
	IBOutlet UIImageView* bk_act1;
	IBOutlet UILabel* bk_lbl1;
	IBOutlet UIActivityIndicatorView* actview1;
	
	BOOL isdidfirst;
	IBOutlet UILabel* lbllasttime;
	
	//by mib
	int refreshCount;
	
	
}

-(IBAction) rightbtn_click;
-(void) move;
-(void) isitsfirsttime;
-(void) setallpins:(NSMutableArray *) arraytrip;

-(void) settingview_animate;
-(void) mainview_animate;

-(IBAction) btnsync_click;
-(IBAction) logout_click;
-(IBAction) urlclick;

@end
