//
//  mapcontroller.m
//  duffel
//
//  Created by Jay Vachhani on 4/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "mapcontroller.h"
#import "POL.h"

@implementation mapcontroller
@synthesize lat,lng;
@synthesize title1;
@synthesize isFromAll,arraytrip;
@synthesize isunscedule;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	appDelegate = [[UIApplication sharedApplication] delegate];
	mapview.delegate = self;
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated 
{
	self.navigationItem.title = @"Map View";

	if(!appDelegate)
		appDelegate = [[UIApplication sharedApplication] delegate];
	
	if(isFromAll)
	{

		for(int i=0; i<[appDelegate.arraypins count]; i++)
		{
			NSMutableDictionary* dics = [appDelegate.arraypins objectAtIndex:i];
			lat = [[dics valueForKey:@"lat"]doubleValue];
			lng = [[dics valueForKey:@"lng"] doubleValue];
			
			CLLocationCoordinate2D cord;
			cord.latitude = lat;
			cord.longitude = lng;

			MKCoordinateRegion region;
			region.center.latitude = lat;
			region.center.longitude = lng;
			
			// Setting the span to zoom level
			MKCoordinateSpan span;
			span.latitudeDelta=0.1;
			span.longitudeDelta=0.1;
			region.span=span;	
			
			NSString* s2 = [appDelegate removeUS:[dics valueForKey:@"title"]];
			
			NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"\n"];
			s2=[s2 stringByTrimmingCharactersInSet:set];
			set = [NSCharacterSet characterSetWithCharactersInString:@"\t"];
			s2=[s2 stringByTrimmingCharactersInSet:set];
			set = [NSCharacterSet characterSetWithCharactersInString:@" "];
			s2=[s2 stringByTrimmingCharactersInSet:set];
			set = [NSCharacterSet characterSetWithCharactersInString:@"  "];
			s2=[s2 stringByTrimmingCharactersInSet:set];
			
			POL* pin = [[POL alloc] initWithCoords:cord];
			pin.title = s2;
			pin.subtitle = @"";
			pin.tag = [[dics valueForKey:@"tag"] intValue];
		//	pin.row = [[dics valueForKey:@"row"] intValue];
			
			[mapview addAnnotation:pin];
			[mapview setRegion:region animated:TRUE];
		}
	}
	else
	{
		CLLocationCoordinate2D cord;
		cord.latitude = lat;
		cord.longitude = lng;
		
		MKCoordinateRegion region;
		region.center.latitude = lat;
		region.center.longitude = lng;
		
		// Setting the span to zoom level
		MKCoordinateSpan span;
		span.latitudeDelta=0.09;
		span.longitudeDelta=0.09;
		region.span=span;	
		
		NSString* s2 = [appDelegate removeUS:title1];
		
		NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"\n"];
		s2=[s2 stringByTrimmingCharactersInSet:set];
		set = [NSCharacterSet characterSetWithCharactersInString:@"\t"];
		s2=[s2 stringByTrimmingCharactersInSet:set];
		set = [NSCharacterSet characterSetWithCharactersInString:@" "];
		s2=[s2 stringByTrimmingCharactersInSet:set];
		set = [NSCharacterSet characterSetWithCharactersInString:@"  "];
		s2=[s2 stringByTrimmingCharactersInSet:set];
		
		POL* pin = [[POL alloc] initWithCoords:cord];
		pin.title = s2;
		pin.subtitle = @"";
		
		[mapview addAnnotation:pin];
		[mapview setRegion:region animated:TRUE];
	}
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	
	
}

#pragma mark -
#pragma mark MapKit Methods
/*
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
	//[actview startAnimating];
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
	//[actview stopAnimating];
}
*/

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	// If current location button(blue) then return nil	///////////////////////////////////////////////////////
	if(annotation == mapView.userLocation)
		return nil;
	
	ann = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"o"];
	ann.canShowCallout = YES;
	
	if(isFromAll == TRUE)	
	{
		POL *temppol = (POL*) annotation;
		UIButton *btn=[[UIButton buttonWithType:UIButtonTypeDetailDisclosure]retain];
		btn.tag = temppol.tag;
		[btn addTarget:self action:@selector(rightcallbtn_click:) forControlEvents:UIControlEventTouchUpInside];
		ann.rightCalloutAccessoryView = btn;
	}
	
	return ann;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
	// Set views for annotations
}

-(void) rightcallbtn_click:(id) sender
{
	
	[self.navigationController popViewControllerAnimated:YES];
	
	UIButton* b = (UIButton *) sender;
	int buttontag = b.tag;
	
	NSLog(@"===================== %d",b.tag);
	NSLog(@"%d",b.tag);
	
	
	NSMutableDictionary* d ;
	for(int i=0; i<[appDelegate.arraypins count]; i++)
	{
		d = [appDelegate.arraypins objectAtIndex:i];
		if(buttontag == [[d valueForKey:@"tag"] intValue])
		{
			break;
		}
	}
	
	notecontroller* object = [[notecontroller alloc] initWithNibName:@"notecontroller" bundle:nil];
	object.arraytrip = arraytrip;
	object.isunschedule = isunscedule;
	
	object.section = [[d valueForKey:@"section"] intValue];
	object.row = [[d valueForKey:@"row"] intValue];
	
	[self.navigationController pushViewController:object animated:YES];
	self.navigationItem.title = @"Back";
	[object release];
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

	[mapview release];
	mapview=nil;
    [super dealloc];
}


@end
