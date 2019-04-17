//
//  createcontroller.h
//  duffel
//
//  Created by Jay Vachhani on 4/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "duffelAppDelegate.h"
#import "myduffelcontroller.h"
#import "regcell2.h"

@interface createcontroller : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
	duffelAppDelegate* appDelegate;
	
	IBOutlet UITableView* tblview;
	IBOutlet UIBarButtonItem* rightbtn;
	IBOutlet UIView* headerview;
	
	IBOutlet UILabel* lbl_act;
	IBOutlet UIImageView* bk_act;
	IBOutlet UIActivityIndicatorView* actview;

	NSString* username;
	NSString* password;
	NSString* confirm;
	NSString* email;
	
}

-(BOOL) checkvalidation;
-(IBAction) btn1_click;

@end