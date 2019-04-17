    //
//  HowToViewController.m
//  FruityDigital
//
//  Created by Muhammad Zafar Iqbal on 12/28/10.
//  Copyright 2010 TechHelpSolutions. All rights reserved.
//

#import "HowToViewController.h"

static NSUInteger kNumberOfPages = 3;

@implementation HowToViewController

@synthesize arraytrip,section,row,isunsch;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	
	mapButton=[[UIBarButtonItem alloc] initWithTitle:@"map" style:UIBarButtonItemStylePlain target:self action:@selector(rightbtn_click)];

	
	NSUserDefaults *standUserDefaults=[NSUserDefaults standardUserDefaults];
	[standUserDefaults setValue:@"yes" forKey:@"isfirstnotecard"];
	
	UIImageView *bgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BG_Corkboard.png"]];
	[bgView setFrame:CGRectMake(0, 0, 320, 480)];
	[self.view addSubview:bgView];
	[bgView release];

	kNumberOfPages=0;
	viewControllers = [[NSMutableArray alloc] init];
	int selectedPage=0;	
	for (int i =0; i<[arraytrip count]; i++) {
		
		
		for(int j=0;j<[[arraytrip objectAtIndex:i] count];j++)
		{
			notecontroller* object = [[notecontroller alloc] initWithNibName:@"notecontroller" bundle:nil];
			object.arraytrip = arraytrip;
			object.isunschedule = isunsch;
			
			object.section = i;
			object.row = j;
			[viewControllers addObject:object];
			[object release];
			
			if(section==i &&row==j)
				selectedPage=kNumberOfPages;
			
			++kNumberOfPages;
		}

	}
	
	
    // a page is the width of the scroll view
	scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kNumberOfPages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;

	
	
	[self.view addSubview:scrollView];

//	activityBackgroundView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 300, 400)];
//	[activityBackgroundView setImage:[UIImage imageNamed:@"acbg.png"]];
//	activityBackgroundView.alpha=0;
	
	
	activityViewer=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(145, 200, 40, 40)];
	activityViewer.hidesWhenStopped=YES;
	activityViewer.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
	[self.view addSubview:activityViewer];
	[activityViewer release];
	
//	[self.view addSubview:activityBackgroundView];
//	[activityBackgroundView release];
	
	NSLog(@"%d   %d selected %d",section,row,selectedPage);
	pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(0, 480, 320, 20)];
	[pageControl setBackgroundColor:[UIColor lightGrayColor]];
    pageControl.numberOfPages = kNumberOfPages;
    pageControl.currentPage = selectedPage;
	[pageControl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
	
	
	[self.view addSubview:pageControl];
	
	
	
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling

	


    [self loadScrollViewWithPage:selectedPage];
	CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * selectedPage;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:NO];

	NSMutableArray* aamap = [arraytrip objectAtIndex:section];
	NSMutableDictionary* ddmap = [aamap objectAtIndex:row];
	
	double lat = [[ddmap valueForKey:@"lat"]doubleValue];
	if(lat>0)
		self.navigationItem.rightBarButtonItem=mapButton;
	else
		self.navigationItem.rightBarButtonItem=nil;
	
	
//    [self loadScrollViewWithPage:1];


}


-(void)StartAnimation
{
	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
//	activityBackgroundView.alpha=1;
	[activityViewer startAnimating];
	[pool release];
}

-(void)StopAnimation
{
//	activityBackgroundView.alpha=0;
	[activityViewer stopAnimating];
}





-(void)back
{
	[self dismissModalViewControllerAnimated:YES];
}
- (void)loadScrollViewWithPage:(int)page {
	
    if (page < 0) return;
    if (page >= kNumberOfPages) return;
	
    // replace the placeholder if necessary
    UIViewController *controller = [viewControllers objectAtIndex:page];
	
    // add the controller's view to the scroll view
    if (nil == controller.view.superview) {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
//		NSLog(@"%d ppp %d",page,[controller retainCount]);

    }
	

}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)

    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];

    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

//	[NSThread detachNewThreadSelector:@selector(StartAnimation) toTarget:self withObject:nil];
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	int page = pageControl.currentPage;
	notecontroller *controller = [viewControllers objectAtIndex:page];
	section=controller.section;
	row=controller.row;
    
	NSMutableArray* aamap = [arraytrip objectAtIndex:section];
	NSMutableDictionary* ddmap = [aamap objectAtIndex:row];
	
	double lat = [[ddmap valueForKey:@"lat"]doubleValue];
	if(lat>0)
		self.navigationItem.rightBarButtonItem=mapButton;
	else
		self.navigationItem.rightBarButtonItem=nil;


//	NSLog(@"page is %f",lat);
//	[self StopAnimation];
    pageControlUsed = NO;
	
}

- (void)changePage {
	
	
    int page = pageControl.currentPage;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;

}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	/*
	NSUserDefaults *standDefaults=[NSUserDefaults standardUserDefaults];
	
	 if([standDefaults valueForKey:@"isfirsttime"]==nil)
	 {
		 UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Tip: You can swipe the notes left & right to browse." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
		 [alert show];
		 [alert release];
		 
		 [standDefaults setValue:@"hello" forKey:@"isfirsttime"];
	 }
	 */
}



-(IBAction) rightbtn_click
{
	
	BOOL success = FALSE;
	//	NSMutableDictionary* dicstrip = (NSMutableDictionary *) [appDelegate.tripsData valueForKey:[NSString stringWithFormat:@"dics_%@_%@",appDelegate.paramlink,appDelegate.username]];
	
	NSMutableArray* aamap = [arraytrip objectAtIndex:section];
	mapcontroller* object = [[mapcontroller alloc] initWithNibName:@"mapcontroller" bundle:nil];
	object.isFromAll = FALSE;
	
	NSMutableDictionary* ddmap = [aamap objectAtIndex:row];
	
	object.lat = [[ddmap valueForKey:@"lat"]doubleValue];
	object.lng = [[ddmap valueForKey:@"lng"]doubleValue];
	object.title1 = [ddmap valueForKey:@"title"];
	
	if(object.lat != 0 && object.lng != 0)
	{
		success = TRUE;
	}
	else
	{
		
		for(int i=0; i<[aamap count]; i++)
		{
			NSMutableDictionary* ddmap = [aamap objectAtIndex:i];
			
			object.lat = [[ddmap valueForKey:@"lat"]doubleValue];
			object.lng = [[ddmap valueForKey:@"lng"]doubleValue];
			object.title1 = [ddmap valueForKey:@"title"];
			
			if(object.lat != 0 && object.lng != 0)
			{
				success = TRUE;
				break;
			}
		}
	}
	
	if(success)
	{
		[self.navigationController pushViewController:object animated:YES];
		//self.navigationItem.title = @"Back";
		[object release];
	}
	else
	{
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Location could not found!" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
		[alert show];
		[alert release];
	}
	 
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[mapButton release];
	[viewControllers release];
	[scrollView release];
	[pageControl release];
    [super dealloc];
}


@end
