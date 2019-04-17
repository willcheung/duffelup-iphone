//
//  POL.h
//  Map
//
//  Created by MAC08 on 4/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface POL: NSObject <MKAnnotation,MKMapViewDelegate>
{
	CLLocationCoordinate2D coordinate;
	NSString *subtitle; 
	NSString *title; 
	int tag;
	int row;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,retain) NSString *subtitle;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,readwrite) int tag;
@property (nonatomic,readwrite) int row;

- (id) initWithCoords:(CLLocationCoordinate2D) coords;

@end