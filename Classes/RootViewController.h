//
//  RootViewController.h
//  duffel
//
//  Created by Jay Vachhani on 4/1/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "webviewcontroller.h"
#import "myduffelcontroller.h"
#import "duffelAppDelegate.h"
#import "createcontroller.h"

@interface RootViewController : UIViewController <UITextFieldDelegate>
{
	
	duffelAppDelegate* appDelegate;
	IBOutlet UITableView* tblview;
	
	IBOutlet UIView* footerview;
	IBOutlet UIButton* btn1;
	IBOutlet UIButton* btn2;
	
	IBOutlet UITextField* txt1;
	IBOutlet UITextField* txt2;
	UITextField* sTxt;
		
	NSString* username;
	NSString* password;
	
	IBOutlet UIImageView* bk_act;
	IBOutlet UILabel* bk_lbl;
	IBOutlet UIActivityIndicatorView* actview;
}

-(IBAction) btn1_click;
-(IBAction) btn2_click;

-(IBAction) urlclick;

@end
