//
//  duffelAppDelegate.h
//  duffel
//
//  Created by Jay Vachhani on 4/1/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.


#import "DDXMLDocument.h"

@interface duffelAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow *window;
    UINavigationController *navigationController;
	
	NSString* username;
	NSString* password;
	
	NSMutableString* currentElementValue;
	BOOL recordResults;
	
	NSMutableArray* arr_fav;
	NSMutableDictionary* dicfav;
	
	NSMutableArray* arr_plan;
	NSMutableDictionary* dicplan;
	
	NSMutableArray* arr_nodate;
	NSMutableDictionary* dicnodate;
	
	BOOL isfav;
	BOOL isplan;
	BOOL isnodate;
	
	BOOL is_parse_main;
	
	BOOL istrip;
	BOOL isnote;
	NSMutableDictionary* dics_trip;
	NSMutableDictionary* dicnote;
	NSMutableArray* array1;
	NSMutableArray* array2;
	
	NSString* paramlink;
	
	BOOL _isnodate;
	BOOL isFirstTime;
	
	NSMutableArray* arraypins;
	NSMutableDictionary *tripsData;
	
	bool isLoading;
	
	
}

@property(nonatomic, retain) NSMutableArray* arraypins;

@property (nonatomic, readwrite) BOOL isFirstTime;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, retain) NSString* paramlink;
@property (nonatomic, retain) NSString* username;
@property (nonatomic, retain) NSString* password;

@property (nonatomic, retain) NSMutableArray* arr_fav;
@property (nonatomic, retain) NSMutableArray* arr_plan;
@property (nonatomic, retain) NSMutableArray* arr_nodate;
@property (nonatomic, retain) NSMutableDictionary *tripsData;

@property (nonatomic,readwrite) BOOL _isnodate;

-(void)createEditableCopyOfDatabaseIfNeeded;

- (BOOL) connectedToNetwork;

-(void) getalldata;
-(void) gettrip :(NSString *) link;
-(void) getuserdata :(NSString *)user;
-(BOOL) login :(NSString *)user :(NSString *)psw;

- (NSString *) DayOfWeek :(int)month :(int) date :(int) year;
- (NSString *) shortDayOfWeek :(int)month :(int) date :(int) year;

-(NSString *) removeUS:(NSString *) add;

-(NSData *) getimagedata:(NSString *)id1 :(NSString *)name;
-(void) setlasttime;
-(void)getAllTripsAsync;
-(void)getAllTrips;
-(void)saveTripsInfo;
-(void)loadTripsInfo;
-(void)savePlannedArr;
-(void)loadPlannedArr;
-(void)saveUnPlannedArr;
-(void)loadUnPlannedArr;
-(void)saveFavArr;
-(void)loadFavArr;
-(void)getTripWithNewParser:(NSString *)link;


@end

