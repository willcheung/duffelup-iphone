//
//  duffelAppDelegate.m
//  duffel
//
//  Created by Jay Vachhani on 4/1/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "duffelAppDelegate.h"
#import "RootViewController.h"
#import "JSON.h"
#import "sqlite3.h"

static sqlite3 *database = nil;

@implementation duffelAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize arr_fav, arr_plan, arr_nodate;
@synthesize username,password;
@synthesize paramlink;
@synthesize _isnodate;
@synthesize isFirstTime;
@synthesize arraypins,tripsData;

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
	isLoading=false;
	_isnodate = TRUE;
	isFirstTime = TRUE;
    // Override point for customization after app launch    
	
//	[self login:@"jayvachhani" :@"duffel"];
//	[self getuserdata:@"jayvachhani"];
//	[self gettrip:@"xyz"];
	
	[self loadPlannedArr];
	[self loadUnPlannedArr];
	[self loadFavArr];
	[self loadTripsInfo];
	[self createEditableCopyOfDatabaseIfNeeded];
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate

}


- (void)applicationWillResignActive:(UIApplication *)application
{
	[self saveTripsInfo];
	[self savePlannedArr];
	[self saveUnPlannedArr];
	[self saveFavArr];
}


-(void)saveTripsInfo
{
	NSArray *tmpPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *tmpDocumentsDirectory = [tmpPaths objectAtIndex:0];	
	NSString *patentFile = [tmpDocumentsDirectory stringByAppendingPathComponent:@"trips.txt"];
	[self.tripsData writeToFile:patentFile atomically:YES];
}

-(void)loadTripsInfo
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];	
	NSString *savedTripsFile = [documentsDirectory stringByAppendingPathComponent:@"trips.txt"];
	NSMutableDictionary *trips = [[NSMutableDictionary alloc] initWithContentsOfFile:savedTripsFile];
	self.tripsData=trips;
	[trips release];
	
}

-(void)savePlannedArr
{
	NSArray *tmpPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *tmpDocumentsDirectory = [tmpPaths objectAtIndex:0];	
	NSString *patentFile = [tmpDocumentsDirectory stringByAppendingPathComponent:@"planned.txt"];
	[self.arr_plan writeToFile:patentFile atomically:YES];
}

-(void)loadPlannedArr
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];	
	NSString *savedTripsFile = [documentsDirectory stringByAppendingPathComponent:@"planned.txt"];
	NSMutableArray *planned = [[NSMutableArray alloc] initWithContentsOfFile:savedTripsFile];
	self.arr_plan=planned;
	[planned release];
	
}

-(void)saveUnPlannedArr
{
	NSArray *tmpPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *tmpDocumentsDirectory = [tmpPaths objectAtIndex:0];	
	NSString *patentFile = [tmpDocumentsDirectory stringByAppendingPathComponent:@"unplanned.txt"];
	[self.arr_nodate writeToFile:patentFile atomically:YES];
}


-(void)loadUnPlannedArr
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];	
	NSString *savedTripsFile = [documentsDirectory stringByAppendingPathComponent:@"unplanned.txt"];
	NSMutableArray *unplanned = [[NSMutableArray alloc] initWithContentsOfFile:savedTripsFile];
	self.arr_nodate=unplanned;
	[unplanned release];
	
}
-(void)saveFavArr
{
	NSArray *tmpPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *tmpDocumentsDirectory = [tmpPaths objectAtIndex:0];	
	NSString *patentFile = [tmpDocumentsDirectory stringByAppendingPathComponent:@"Favorite.txt"];
	[self.arr_fav writeToFile:patentFile atomically:YES];
}

-(void)loadFavArr
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];	
	NSString *savedTripsFile = [documentsDirectory stringByAppendingPathComponent:@"Favorite.txt"];
	NSMutableArray *fav = [[NSMutableArray alloc] initWithContentsOfFile:savedTripsFile];
	self.arr_fav=fav;
	[fav release];
	
}

-(void)createEditableCopyOfDatabaseIfNeeded
{
	BOOL success;
	NSFileManager *fileManager=[NSFileManager defaultManager];
	NSError *error;
	NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory=[paths objectAtIndex:0];
	NSString *writablePath = [documentsDirectory stringByAppendingPathComponent:@"duffel.sqlite"];
	
	success = [fileManager fileExistsAtPath:writablePath];
	if(success)
	{
		if(sqlite3_open([writablePath UTF8String],&database)!=SQLITE_OK)
		{
			sqlite3_close(database);
		}
		return;
	}
	NSString *defaultPath=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"duffel.sqlite"];
	success=[fileManager copyItemAtPath:defaultPath toPath:writablePath error:&error];
	if(!success)
	{
		NSAssert1(0,@"Failed to create writable database file with message '%@' .",[error localizedDescription]);
	}
	else		//First Time Loaded Application....
	{
		if(sqlite3_open([writablePath UTF8String],&database)!=SQLITE_OK)
		{
			sqlite3_close(database);
		}
	}
}

- (BOOL) connectedToNetwork
{
	NSString *requestString =@"";
	NSData *requestData = [NSData dataWithBytes: [requestString UTF8String] length: [requestString length]];
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:@"http://www.google.com"]] autorelease];
	[request setHTTPMethod: @"POST"];
	[request setTimeoutInterval:10];
	[request setHTTPBody: requestData];
	return [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ]!=nil;
}

#pragma mark -
#pragma mark API

-(BOOL) login :(NSString *)user :(NSString *)psw
{
	
//	http://duffelup.com/session/create?username=blah&password=blah&iphone=c00l3stiPhoneApp-7c4465b3f951effdfa708a66300e9721dc637a53
	
	NSString *requestString = [NSString stringWithFormat:@"http://duffelup.com/session.xml?login=%@&password=%@&iphone=c00l3stiPhoneApp-7c4465b3f951effdfa708a66300e9721dc637a53",user,psw];
	//NSString *requestString = [NSString stringWithFormat:@"http://duffelup.com/sessions/create"];

	requestString= [requestString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: requestString]] autorelease];
	[request setHTTPMethod: @"POST"];
	[request addValue:@"Content-Type" forHTTPHeaderField:@"application/atom+xml"];
	
	NSData *returnData = [ NSURLConnection sendSynchronousRequest:request returningResponse: nil error: nil];
	NSString *returnString = [[[NSString alloc] initWithData:returnData encoding: NSUTF8StringEncoding]autorelease];

	NSRange rng=[returnString rangeOfString:@"error_login_info"];
	
	if(!rng.length==0)
		return FALSE;
	else
	{
		NSRange rangeFrom=[returnString rangeOfString:@"<username>"];
		NSRange rangeTo=[returnString rangeOfString:@"</username>"];
		NSRange rangeLoction;
		rangeLoction.location=rangeFrom.location+rangeFrom.length;
		rangeLoction.length=rangeTo.location -(rangeFrom.location+rangeFrom.length);
		user = [returnString substringWithRange:rangeLoction];
		
		username = user;
		password=psw;
		[password retain];
		[username retain];
		

		return TRUE;
	}
}

-(void)getUserDataWithNewParser:(NSString *)user
{

	is_parse_main=TRUE;
	NSError* error;
	
	NSString *xmlpath = [NSString stringWithFormat:@"http://duffelup.com/%@.xml",user];
	NSString *xmlStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:xmlpath]];
//	NSLog(xmlStr);
	DDXMLDocument* xmlDoc = [[DDXMLDocument alloc] initWithXMLString:xmlStr options:0 error:&error];
	NSArray* resultNodes = nil;
	resultNodes = [xmlDoc nodesForXPath:@"//planned | //no-date | //favorite" error:&error];

	
	if (xmlStr==nil || [resultNodes count]==0) {
		NSLog(@"no user data found");		
	}
	else
	{
		for(DDXMLElement* resultElement in resultNodes)
		{
			if([[resultElement name] isEqualToString:@"planned"] && [resultElement attributeForName:@"type"]!=nil)
			{
				arr_plan=[[NSMutableArray alloc] init];
				
			}
			else if([[resultElement name] isEqualToString:@"planned"] && [resultElement attributeForName:@"type"]==nil)
			{
				NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
				NSArray *childElements=[resultElement children];
				
				for(DDXMLElement* childElement in childElements)
					[dic setObject:[childElement stringValue] forKey:[childElement name]];
				
				[arr_plan addObject:dic];
				[dic release];
				
			}
			else if([[resultElement name] isEqualToString:@"no-date"] && [resultElement attributeForName:@"type"]!=nil)
			{
				
				arr_nodate=[[NSMutableArray alloc] init];
				
				
			}
			else if([[resultElement name] isEqualToString:@"no-date"] && [resultElement attributeForName:@"type"]==nil)
			{
				NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
	
				NSArray *childElements=[resultElement children];
				
				for(DDXMLElement* childElement in childElements)
					[dic setObject:[childElement stringValue] forKey:[childElement name]];
				
				[arr_nodate addObject:dic];
				[dic release];
				
			}
			else if([[resultElement name] isEqualToString:@"favorite"] && [resultElement attributeForName:@"type"]!=nil)
			{
				
				arr_fav=[[NSMutableArray alloc] init];
				
				
			}
			else if([[resultElement name] isEqualToString:@"favorite"] && [resultElement attributeForName:@"type"]==nil)
			{
				NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
				NSArray *childElements=[resultElement children];
				
				for(DDXMLElement* childElement in childElements)
					[dic setObject:[childElement stringValue] forKey:[childElement name]];
				
				[arr_fav addObject:dic];
				[dic release];
				
			}
			
			
			
			
				
		}
		
	}
/*
	if([arr_fav count] > 0)
	{
		[arr_fav retain];
		[[NSUserDefaults standardUserDefaults] setValue:arr_fav forKey:[NSString stringWithFormat:@"fav_%@",username]];
	}
*/	
	if([arr_nodate count]>0)
		[arr_plan addObjectsFromArray:arr_nodate];
/*	
	if([arr_plan count] > 0)
	{
		[arr_plan retain];
		[[NSUserDefaults standardUserDefaults] setValue:arr_plan forKey:[NSString stringWithFormat:@"plan_%@",username]];
	}
*/	
	
}

-(void) getuserdata :(NSString *)user
{
	is_parse_main = TRUE;
	
	NSString *xmlpath = [NSString stringWithFormat:@"http://duffelup.com/%@.xml",user];
	NSURL *url = [[NSURL alloc] initWithString:xmlpath];
	NSLog([NSString stringWithContentsOfURL:url]);
	NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
		
	//Set delegate
	[xmlParser setDelegate:self];
	
	[xmlParser parse];
	
	if([arr_fav count] > 0)
	{
		[arr_fav retain];
		[[NSUserDefaults standardUserDefaults] setValue:arr_fav forKey:[NSString stringWithFormat:@"fav_%@",username]];
	}
	
	if([arr_nodate count]>0)
		[arr_plan addObjectsFromArray:arr_nodate];
	
	if([arr_plan count] > 0)
	{
		[arr_plan retain];
		[[NSUserDefaults standardUserDefaults] setValue:arr_plan forKey:[NSString stringWithFormat:@"plan_%@",username]];
	}
	
	/*
	if([arr_nodate count] > 0)
	{
		[arr_nodate retain];
		[[NSUserDefaults standardUserDefaults] setValue:arr_nodate forKey:[NSString stringWithFormat:@"nodate_%@",username]];
	}
	*/

	
	return;
	
	NSString *requestString = [NSString stringWithFormat:@"http://duffelup.com/will.xml",user];
	requestString= [requestString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: requestString]];
	[request setHTTPMethod: @"POST"];
	NSData *returnData = [ NSURLConnection sendSynchronousRequest:request returningResponse: nil error: nil];
	
	if (returnData == nil)
	{
		NSLog(@"Data is nil");
		UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Connection could not be establised with yahoo" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else
	{
		NSString *returnString = [[[NSString alloc] initWithData:returnData encoding: NSUTF8StringEncoding]autorelease];
		NSRange rng=[returnString rangeOfString:@"<error>"];
	
		if(!rng.length==0)
		{
			UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"" message:@"Error! Please try later. " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
		else
		{	
			
		}
	}
}


-(void) gettrip :(NSString *) link
{
	
	is_parse_main = FALSE;
	
	// http://duffelup.com/trips/maui-chillaxing-vacation.xml
	NSString *xmlpath = [NSString stringWithFormat:@"http://duffelup.com/trips/%@.xml",link];
	NSURL *url = [[NSURL alloc] initWithString:xmlpath];
	NSLog([NSString stringWithContentsOfURL:url]);
	NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];

	//Set delegate
	[xmlParser setDelegate:self];
	[xmlParser parse];
	
	if([array1 count] > 0)
	{
		[array1 retain];
		[[NSUserDefaults standardUserDefaults] setObject:array1 forKey:[NSString stringWithFormat:@"%@_%@",link,username]];
		[array1 release];
		array1 = nil;
	}
	if([dics_trip allKeys] > 0)
	{
		[dics_trip retain];
		[[NSUserDefaults standardUserDefaults] setObject:dics_trip forKey:[NSString stringWithFormat:@"dics_%@_%@",link,username]];
		[dics_trip retain];
		dics_trip = nil;
	}
	
	NSLog(@"done parsing paramlink");
}

-(void) getalldata
{
	
	if(arr_fav)
	{
		[arr_fav removeAllObjects];
		[arr_fav release]; 
		arr_fav = nil;
	}
	if(arr_plan)
	{
		[arr_plan removeAllObjects];
		[arr_plan release]; 
		arr_plan = nil;
	}
	if(arr_nodate)
	{
		[arr_nodate removeAllObjects];
		[arr_nodate release]; 
		arr_nodate = nil;
	}
	if(tripsData)
	{
		[tripsData removeAllObjects];
		[tripsData release];
		tripsData=nil;
	}
	
	tripsData=[[NSMutableDictionary alloc] init];
	
	[self setlasttime];
	
	[tripsData setValue:username forKey:@"username"];
	[tripsData setValue:password forKey:@"password"];

	
//	username = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
//	[self getuserdata:username];
	[self getUserDataWithNewParser:username];
//	[self resetAllTrips]; //not required in new implementation
	[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(startAnimate) userInfo:nil repeats:NO];	
	#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
	[NSThread detachNewThreadSelector:@selector(getAllTrips) toTarget:self withObject:nil];
	//return statement to increase performance so that each trip is not laoded in advance
	NSLog(@"bhan yaki ho gye ha");
	return;
	#endif		

	

	[self getAllTripsAsync];
	
	
}

-(void)startAnimate
{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:TRUE];
}

-(void)resetAllTrips
{	
	
	NSMutableDictionary* dics;
	for(int i = 0 ; i<[arr_fav count]; i++)
	{
		dics = [arr_fav objectAtIndex:i];
		
		NSString* str = [NSString stringWithFormat:@"%@_",[dics valueForKey:@"permalink"]];
		str = [str stringByAppendingString:username];
		
		[[NSUserDefaults standardUserDefaults] removeObjectForKey:str];
	}
	
	NSLog(@"done for Favorite");
	NSLog(@"done for Favorite");
	
	for(int i = 0 ; i<[arr_plan count]; i++)
	{
		
		dics = [arr_plan objectAtIndex:i];
		
		NSString* str = [NSString stringWithFormat:@"%@_",[dics valueForKey:@"permalink"]];
		str = [str stringByAppendingString:username];
		
		[[NSUserDefaults standardUserDefaults] removeObjectForKey:str];
	}
	
	NSLog(@"done for plan");
	NSLog(@"done for plan");
	
	for(int i = 0 ; i<[arr_nodate count]; i++)
	{
		
		dics = [arr_nodate objectAtIndex:i];
		NSString* str = [NSString stringWithFormat:@"%@_",[dics valueForKey:@"permalink"]];
		str = [str stringByAppendingString:username];
		
		[[NSUserDefaults standardUserDefaults] removeObjectForKey:str];
	}
	
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	NSLog(@"done for nodate");
	NSLog(@"done for nodate");
	
		
}

-(void)getAllTripsAsync
{
	
	NSMutableDictionary* dics;
	for(int i = 0 ; i<[arr_fav count]; i++)
	{
		dics = [arr_fav objectAtIndex:i];
		
		NSString* str = [NSString stringWithFormat:@"%@_",[dics valueForKey:@"permalink"]];
		str = [str stringByAppendingString:username];
		
		[self getTripWithNewParser:[dics valueForKey:@"permalink"]];
	}
	
	NSLog(@"done for Favorite");
	NSLog(@"done for Favorite");
	
	for(int i = 0 ; i<[arr_plan count]; i++)
	{
		
		dics = [arr_plan objectAtIndex:i];
		
		NSString* str = [NSString stringWithFormat:@"%@_",[dics valueForKey:@"permalink"]];
		str = [str stringByAppendingString:username];
		
		[self getTripWithNewParser:[dics valueForKey:@"permalink"]];		
	}
	
	NSLog(@"done for plan");
	NSLog(@"done for plan");
	/*
	for(int i = 0 ; i<[arr_nodate count]; i++)
	{
		
		dics = [arr_nodate objectAtIndex:i];
		NSString* str = [NSString stringWithFormat:@"%@_",[dics valueForKey:@"permalink"]];
		str = [str stringByAppendingString:username];
		
		[self getTripWithNewParser:[dics valueForKey:@"permalink"]];
	}
	
	NSLog(@"done for nodate");
	NSLog(@"done for nodate");
	*/
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
	
	
}

-(void)getAllTrips
{
	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
	
	
	
	NSMutableDictionary* dics;
	for(int i = 0 ; i<[arr_fav count]; i++)
	{
		dics = [arr_fav objectAtIndex:i];
		
		NSString* str = [NSString stringWithFormat:@"%@_",[dics valueForKey:@"permalink"]];
		str = [str stringByAppendingString:username];
		
		[self getTripWithNewParser:[dics valueForKey:@"permalink"]];

		
	}
	
	NSLog(@"done for Favorite");
	NSLog(@"done for Favorite");
	
	for(int i = 0 ; i<[arr_plan count]; i++)
	{
		
		dics = [arr_plan objectAtIndex:i];
		
		NSString* str = [NSString stringWithFormat:@"%@_",[dics valueForKey:@"permalink"]];
		str = [str stringByAppendingString:username];
		
//		[self gettrip:[dics valueForKey:@"permalink"]];		
		[self getTripWithNewParser:[dics valueForKey:@"permalink"]];
	}

	NSLog(@"done for plan");
	NSLog(@"done for plan");
	/*
	for(int i = 0 ; i<[arr_nodate count]; i++)
	{
		
		dics = [arr_nodate objectAtIndex:i];
		NSString* str = [NSString stringWithFormat:@"%@_",[dics valueForKey:@"permalink"]];
		str = [str stringByAppendingString:username];
		
		[self getTripWithNewParser:[dics valueForKey:@"permalink"]];
	}
	
	NSLog(@"done for nodate");
	NSLog(@"done for nodate");
	*/
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
	
	[pool release];
	
}


-(void)getTripWithNewParser:(NSString *)link
{
	/*
	if(isLoading==true)
		return;
	else
		isLoading=true;
	*/
	
	@synchronized(self)
	{
	
	NSError* error;
	array1=[[NSMutableArray alloc] init];
	NSString *xmlpath = [NSString stringWithFormat:@"http://duffelup.com/trips/%@.xml",link];	
	NSString *xmlStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:xmlpath]];
	
	DDXMLDocument* xmlDoc = [[DDXMLDocument alloc] initWithXMLString:xmlStr options:0 error:&error];
	NSArray* resultNodes = nil;
	resultNodes = [xmlDoc nodesForXPath:@"//trip" error:&error];
	
	
	if (xmlStr==nil || [resultNodes count]==0) {
		NSLog(@"no trip data found");
		
	}
	else
	{
		dics_trip = [[NSMutableDictionary alloc] init];
		
		for(DDXMLElement* resultElement in resultNodes)
		{
			NSArray *tripElements=[resultElement children];
			for(DDXMLElement* tripElement in tripElements)
			[dics_trip setObject:[tripElement stringValue] forKey:[tripElement name]];
						
		}
		
	}
	
	
	resultNodes=[xmlDoc nodesForXPath:@"//itinerary//itinerary[@type='array']" error:&error];
	
	for(DDXMLElement* resultElement in resultNodes)
	{
		NSMutableArray *arr2=[[NSMutableArray alloc] init];
		NSArray *notesElements=[resultElement children];
		for(DDXMLElement* noteElement in notesElements)
		{
			NSArray *noteDataElements=[noteElement children];
			NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
			for(DDXMLElement* notedic in noteDataElements)
				[dic setObject:[notedic stringValue] forKey:[notedic name]];
			[arr2 addObject:dic];
			[dic release];
			dic=nil;
			
		}
		if([arr2 count]>0)
		[array1 addObject:arr2];
		[arr2 release];
		arr2=nil;
		
	}
	
	
	if([array1 count] > 0)
	{
		//[array1 retain];
		NSLog(@"WWW %@",[tripsData objectForKey:[NSString stringWithFormat:@"%@_%@",link,username]]);
		[tripsData setObject:array1 forKey:[NSString stringWithFormat:@"%@_%@",link,username]];
		//[array1 removeAllObjects];
		[array1 release];
		//array1 = nil;
	}
	if([dics_trip allKeys] > 0)
	{
	//	[dics_trip retain];
		NSLog(@"WWW222 %@",[tripsData objectForKey:[NSString stringWithFormat:@"dics_%@_%@",link,username]]);
		[tripsData setObject:dics_trip forKey:[NSString stringWithFormat:@"dics_%@_%@",link,username]];
	//	[dics_trip removeAllObjects];
		[dics_trip release];
	//	dics_trip = nil;
	}
	isLoading=false;
	NSLog(@"done parsing paramlink");
		
	}
	
}

#pragma mark -
#pragma mark Day From Date

-(void) setlasttime
{
	NSDate* date;
	date = [NSDate new];
	NSDateFormatter* dateformatter = [[NSDateFormatter alloc] init];
	[dateformatter setDateFormat:@"yyyy/MM/dd hh:mma"];
	NSString* strdate = [dateformatter stringFromDate:date];
	NSLog(strdate);
	
	
	NSString* temp;
	
	int year1 = [[strdate substringToIndex:4] intValue];
	
	temp = [strdate substringFromIndex:5];
	int month1 = [[temp substringToIndex:2] intValue];
	
	temp = [strdate substringFromIndex:8];
	int date1 = [[temp substringToIndex:2] intValue];
	
	temp = [strdate substringFromIndex:10];
	NSString* temp2 = @"Last synced on ";
	temp2 = [temp2 stringByAppendingString:[self DayOfWeek:month1 :date1 :year1]];
	temp =[temp2 stringByAppendingString:temp];
	
	[[NSUserDefaults standardUserDefaults] setValue:temp forKey:@"lasttime"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	[dateformatter release];
}

static int mkeys[12] = { 1, 4, 4, 0, 2, 5, 0, 3, 6, 1, 4, 6 };


- (NSString *) DayOfWeek :(int)month :(int) date :(int) year
{
    int day;
	month--;
	
	NSString* s = @"Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday";
	NSArray* dayName = [s componentsSeparatedByString:@","];
	
	NSString* m = @"January,February,March,April,May,June,July,August,September,October,November,December";
	NSArray* monthName = [m componentsSeparatedByString:@","];
	
    day = ( year - 1900 ) + ( year - 1900 ) / 4 + mkeys[month] + date - 1;
    /* The above counts the leap day even if it occurs later in the year */
    if(( year > 1900 ) && ( year % 4 == 0 ) && ( month < 2 ) )
		day--;
    day %= 7;
	
	if(day < 0)
		day = 0;
	if(month < 0)
		month = 0;
	
	if(day >= 7)
		day = 6;		
	
	if(month >= 12)
		month = 11;
	
	return [NSString stringWithFormat:@"%@ - %@ %d, %d", [dayName objectAtIndex:day], [monthName objectAtIndex:month], date, year];
}

- (NSString *) shortDayOfWeek :(int)month :(int) date :(int) year
{
    int day;
	month--;
	
	NSString* s = @"Sun,Mon,Tue,Wed,Thu,Fri,Sat";
	NSArray* dayName = [s componentsSeparatedByString:@","];
	
	NSString* m = @"Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec";
	NSArray* monthName = [m componentsSeparatedByString:@","];
	
    day = ( year - 1900 ) + ( year - 1900 ) / 4 + mkeys[month] + date - 1;
    /* The above counts the leap day even if it occurs later in the year */
    if(( year > 1900 ) && ( year % 4 == 0 ) && ( month < 2 ) )
		day--;
    day %= 7;
	
	if(day < 0)
		day = 0;
	if(month < 0)
		month = 0;
	
	if(day >= 7)
		day = 6;		
		 
	if(month >= 12)
		month = 11;
	return [NSString stringWithFormat:@"%@ - %@ %d, %d", [dayName objectAtIndex:day], [monthName objectAtIndex:month], date, year];
}

-(NSString *) removeUS:(NSString *) add
{
	//NSArray* aa = [add componentsSeparatedByString:@","];
	NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"\n"];
	add=[add stringByTrimmingCharactersInSet:set];
	set = [NSCharacterSet characterSetWithCharactersInString:@"\t"];
	add=[add stringByTrimmingCharactersInSet:set];
	set = [NSCharacterSet characterSetWithCharactersInString:@" "];
	add=[add stringByTrimmingCharactersInSet:set];
	set = [NSCharacterSet characterSetWithCharactersInString:@"  "];
	add=[add stringByTrimmingCharactersInSet:set];


	add = [add stringByReplacingOccurrencesOfString:@", United States" withString:@""];
	
	NSArray* aa = [add componentsSeparatedByString:@";"];
	if([aa count] > 1)
	{
		if([aa count] == 2)
			return [NSString stringWithFormat:@"%@ and 1 more city",[aa objectAtIndex:0],([aa count] - 1)];
		else
			return [NSString stringWithFormat:@"%@ and %d more cities",[aa objectAtIndex:0],([aa count] - 1)];
	}
	else
		return add;
	
//	NSString* s = [aa objectAtIndex:([aa count] -1)];
//	if([s isEqualToString:@"United States"])
		
}

-(NSString *) removeUScity:(NSString *) add
{
	
	NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"\n"];
	add=[add stringByTrimmingCharactersInSet:set];
	set = [NSCharacterSet characterSetWithCharactersInString:@"\t"];
	add=[add stringByTrimmingCharactersInSet:set];
	set = [NSCharacterSet characterSetWithCharactersInString:@" "];
	add=[add stringByTrimmingCharactersInSet:set];
	set = [NSCharacterSet characterSetWithCharactersInString:@"  "];
	add=[add stringByTrimmingCharactersInSet:set];
	
	add = [add stringByReplacingOccurrencesOfString:@", United States" withString:@""];
	
	NSArray* aa = [add componentsSeparatedByString:@";"];
	if([aa count] > 1)
	{
		if([aa count] == 2)
			return [NSString stringWithFormat:@"%@ and 1 more city",[aa objectAtIndex:0],([aa count] - 1)];
		else
			return [NSString stringWithFormat:@"%@ and %d more cities",[aa objectAtIndex:0],([aa count] - 1)];
	}
	else
		return add;
	//	NSString* s = [aa objectAtIndex:([aa count] -1)];
	//	if([s isEqualToString:@"United States"])
	
}

-(NSData *) getimagedata:(NSString *)id1 :(NSString *)name
{
	/*
	if([name length] > 5 && [[name substringToIndex:5] isEqualToString:@"http:"])
	{
		NSLog(@"%@ is url image name",name);
		NSData* data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:name]];
		return data;
	}
	else
	{
		NSLog(@"%@ is nourl image name",name);
		NSString* url = [NSString stringWithFormat:@"http://s3.amazonaws.com/duffelup_trip_production/photos/%@/thumb/%@",id1,name];
		NSData* data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
		return data;
	}
	 */
	return nil;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

