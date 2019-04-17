//
//  mapcontroller.h
//  duffel
//
//  Created by Jay Vachhani on 4/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "duffelAppDelegate.h"
#import "notecontroller.h"

@interface mapcontroller : UIViewController <MKMapViewDelegate>
{
	IBOutlet MKMapView* mapview;
	duffelAppDelegate* appDelegate;
	
	double lat;
	double lng;
	
	BOOL isFromAll;
	
	MKPinAnnotationView* ann;
	NSString* title1;
	
	IBOutlet UIButton* rightcallbtn;
	NSMutableArray* arraytrip;
	
	BOOL isunscedule;
}

-(void) rightcallbtn_click:(id) sender;

@property (nonatomic,retain) NSMutableArray* arraytrip;
@property(nonatomic,readwrite) BOOL isFromAll;
@property(nonatomic,readwrite) double lat;
@property(nonatomic,readwrite) double lng;
@property(nonatomic,retain) NSString* title1;
@property (nonatomic,readwrite) BOOL isunscedule;

@end