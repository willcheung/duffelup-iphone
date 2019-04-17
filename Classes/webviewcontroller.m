//
//  webviewcontroller.m
//  duffel
//
//  Created by Jay Vachhani on 4/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "webviewcontroller.h"

@implementation webviewcontroller
@synthesize urlAddress;
@synthesize title1;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	
	webView.delegate = self;
	
	//Create a URL object.
	NSURL *url = [NSURL URLWithString:urlAddress];
	//URL Requst Object
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	
	//Load the request in the UIWebView.
	[webView loadRequest:requestObj];
	[actview startAnimating];
	
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	
	if(title1)
		self.navigationItem.title = title1;
	else
		self.navigationItem.title = @"Web View";
	
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[webView stopLoading];
}

- (void)webViewDidStartLoad:(UIWebView *)webView1
{
//	self.navigationItem.hidesBackButton = TRUE;
	[actview startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView1
{
//	self.navigationItem.hidesBackButton = FALSE;
	[actview stopAnimating];
	
//	[webView stringByEvaluatingJavaScriptFromString:@"document.body.style.zoom = 5.0;"];

}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark memory
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
