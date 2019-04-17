//
//  createcontroller.m
//  duffel
//
//  Created by Jay Vachhani on 4/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "createcontroller.h"

@implementation createcontroller

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	self.navigationItem.title = @"Join Duffel";
	
	[actview stopAnimating];
	bk_act.hidden = TRUE;
	lbl_act.hidden = TRUE;
	
	tblview.delegate = self;
	tblview.dataSource = self;
	tblview.tableHeaderView = headerview;
	
	[headerview setBackgroundColor:[UIColor clearColor]];
	
	self.navigationItem.rightBarButtonItem = rightbtn;	
    [super viewDidLoad];
}

-(void) move
{	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:TRUE];
	[actview startAnimating];
	bk_act.hidden = FALSE;
	lbl_act.hidden = FALSE;
}

-(BOOL) checkvalidation
{
	BOOL result = TRUE;
	
	NSString* err;
	err = @"Please fill in all the fields";
	
	if(username == nil || password == nil || confirm == nil || email == nil)
	{
		result = FALSE;
	}
	else if([username isEqualToString:@""] || [password isEqualToString:@""] || [confirm isEqualToString:@""] || [email isEqualToString:@""])
	{
		result = FALSE;
	}
	else if(![password isEqualToString:confirm])
	{
		result = FALSE;
		err = @"Password and confirm is not matched";
	}
	
	if(result == FALSE)
	{
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:err delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		
		return FALSE;
	}
	
	return TRUE;
}

-(IBAction) btn1_click
{
	
	if(![self checkvalidation])
	{
		return;
	}
	
	
	[self performSelectorInBackground:@selector(move) withObject:nil];
	
	
	
	
	//http://duffelup.com/user.xml?username=%@&password=%@&email=%@

	NSString *requestString = [NSString stringWithFormat:@"http://duffelup.com/user.xml?username=%@&password=%@&email=%@&iphone=c00l3stiPhoneApp-7c4465b3f951effdfa708a66300e9721dc637a53",username,password,email];
	
	requestString= [requestString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: requestString]];
	[request setHTTPMethod: @"POST"];
	[request addValue:@"Content-Type" forHTTPHeaderField:@"application/atom+xml"];
	
	NSData *returnData = [ NSURLConnection sendSynchronousRequest:request returningResponse: nil error: nil];
	NSString *returnString = [[[NSString alloc] initWithData:returnData encoding: NSUTF8StringEncoding]autorelease];
	
	if(!returnString)
	{
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Registration Failed!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		
		[actview stopAnimating];
		bk_act.hidden = TRUE;
		lbl_act.hidden = TRUE;
		
		return;
	}
	
	NSRange rng=[returnString rangeOfString:@"<error>"];
	
	if(!rng.length==0)
	{
		NSRange rangeFrom=[returnString rangeOfString:@"<error>"];
		NSRange rangeTo=[returnString rangeOfString:@"</error>"];
		NSRange rangeLoction;
		rangeLoction.location=rangeFrom.location+rangeFrom.length;
		rangeLoction.length=rangeTo.location -(rangeFrom.location+rangeFrom.length);
		NSString* ssss = [returnString substringWithRange:rangeLoction];
		
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:ssss message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}	
	else
	{
//		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Registration was successful!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		[alert show];
//		[alert release];
		
		appDelegate.isFirstTime = TRUE;
		[[NSUserDefaults standardUserDefaults] setValue:username forKey:@"username"];
		
		myduffelcontroller* object = [[myduffelcontroller alloc] initWithNibName:@"myduffelcontroller" bundle:nil];
		[self.navigationController pushViewController:object animated:NO];
		self.navigationItem.title = @"Back";
		[object release];
	}
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
	[actview stopAnimating];
	bk_act.hidden = TRUE;
	lbl_act.hidden = TRUE;
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    regcell2 *cell = (regcell2 *) [tblview dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[regcell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	cell.txt.delegate = self;
	cell.txt.tag = indexPath.row;
	cell.txt.secureTextEntry = FALSE;
	cell.txt.keyboardType = UIKeyboardTypeDefault;
	
	if(indexPath.row == 0)
	{
		cell.lbl.text = @"Username";
		if(username)
			cell.txt.text = username;
	}
	else if(indexPath.row == 1)
	{
		cell.lbl.text = @"Password";
		if(password)
			cell.txt.text = username;
		cell.txt.secureTextEntry = TRUE;
	}
	else if(indexPath.row == 2)
	{
		cell.lbl.text = @"Confirm";
		if(confirm)
			cell.txt.text = username;
		cell.txt.secureTextEntry = TRUE;
	}

	else if(indexPath.row == 3)
	{
		cell.lbl.text = @"Email";
		cell.txt.keyboardType = UIKeyboardTypeEmailAddress;
		if(email)
			cell.txt.text = username;
	}

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
	else if(textField.tag == 2)
	{
		confirm = textField.text;
		[confirm retain];
	}
	else if(textField.tag == 3)
	{
		email = textField.text;
		[email retain];
	}
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{			
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
    [super dealloc];
}

@end
