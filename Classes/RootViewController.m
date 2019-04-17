//
//  RootViewController.m
//  duffel
//
//  Created by Jay Vachhani on 4/1/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.


#import "RootViewController.h"

@implementation RootViewController

- (void)viewDidLoad
{
  
	txt1.delegate = self;
	txt2.delegate = self;
	appDelegate = [[UIApplication sharedApplication] delegate];
	
	//[self performSelectorInBackground:@selector(move) withObject:nil];
	
	
	NSLog(@"hello %@",[appDelegate.tripsData valueForKey:@"username"]);
	if([appDelegate.tripsData valueForKey:@"username"] && ![[appDelegate.tripsData valueForKey:@"username"] isEqualToString:@""])
	{
		appDelegate.isFirstTime = FALSE;
		
		appDelegate.username = [appDelegate.tripsData valueForKey:@"username"];
		appDelegate.password = [appDelegate.tripsData valueForKey:@"password"];
	
		myduffelcontroller* object = [[myduffelcontroller alloc] initWithNibName:@"myduffelcontroller" bundle:nil];
		[self.navigationController pushViewController:object animated:NO];
		self.navigationItem.title = @"Back";
		[object release];
	}
	else
	{
		appDelegate.isFirstTime = TRUE;
	}
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];			
	[super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
	
	
	[actview stopAnimating];
	bk_act.hidden = TRUE;
	bk_lbl.hidden = TRUE;
	
	appDelegate = [[UIApplication sharedApplication] delegate];
	self.navigationItem.title = @"Duffel Login";
	
//	NSString* d = [appDelegate DayOfWeek:04 :10 :2010];
//	NSLog(d);
	
    [super viewWillAppear:animated];
}


/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.

    return cell;
}


// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	[tblview deselectRowAtIndexPath:indexPath animated:YES];
	
    // Navigation logic may go here -- for example, create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController animated:YES];
	// [anotherViewController release];
}

*/
#pragma mark Btn events

-(IBAction) btn1_click
{
	if(![appDelegate connectedToNetwork])
	{
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Internet connection is not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	
	if(sTxt)
		[sTxt resignFirstResponder];
	
	if(username == nil || password == nil || [username isEqualToString:@""] || [password isEqualToString:@""])
	{
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please fill all the fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else
	{
		[self performSelectorInBackground:@selector(move) withObject:nil];
		if([appDelegate login:username :password])
		{
//			[[NSUserDefaults standardUserDefaults] setValue:appDelegate.username forKey:@"username"];
//			[[NSUserDefaults standardUserDefaults] setValue:password forKey:@"password"];
				
			myduffelcontroller* object = [[myduffelcontroller alloc] initWithNibName:@"myduffelcontroller" bundle:nil];
			[self.navigationController pushViewController:object animated:YES];
			self.navigationItem.title = @"Back";
			[object release];
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];			
		}
		else
		{
			UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Login Failed!" message:@"Username/Password does not match" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
		}
	}
	
	[actview stopAnimating];
	bk_act.hidden = TRUE;
	bk_lbl.hidden = TRUE;
	
}

-(void) move
{	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:TRUE];
	[actview startAnimating];
	bk_act.hidden = FALSE;
	bk_lbl.hidden = FALSE;
}

-(IBAction) btn2_click
{
	createcontroller* object = [[createcontroller alloc] initWithNibName:@"createcontroller" bundle:nil];
	[self.navigationController pushViewController:object animated:YES];
	self.navigationItem.title = @"Back";
	[object release];
}

-(IBAction) urlclick
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://duffelup.com"]];
}

#pragma mark Memory
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}
#pragma mark TextField methods

- (void)textFieldDidEndEditing:(UITextField *)textField         
{
	if(textField.tag == 0)
	{
		username = textField.text;
		[username retain];
	}
	else if(textField.tag == 1)
	{
		password = textField.text;
		[password retain];
	}
	
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{			
	sTxt = textField;
	
	//tblview.frame = CGRectMake(0,-100, 320, 460);
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	//tblview.frame=CGRectMake(0,0, 320, 460);
	return YES;
}

#pragma mark Memory
- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}


@end

