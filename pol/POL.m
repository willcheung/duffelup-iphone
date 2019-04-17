//
//  POL.m
//  Map
//
//  Created by MAC08 on 4/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "POL.h"


@implementation POL

@synthesize coordinate;
@synthesize subtitle;
@synthesize title;
@synthesize tag;
@synthesize row;

- (id) initWithCoords:(CLLocationCoordinate2D) coords
{
	self = [super init];
	
	if (self != nil)
	{
		coordinate = coords; 
	}
	
	return self;
}

- (void) dealloc
{
	[title release];
	[subtitle release];
	[super dealloc];
}
@end