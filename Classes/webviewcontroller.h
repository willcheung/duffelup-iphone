//
//  webviewcontroller.h
//  duffel
//
//  Created by Jay Vachhani on 4/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface webviewcontroller : UIViewController <UIWebViewDelegate>
{

	IBOutlet UIWebView *webView;
	IBOutlet UIActivityIndicatorView* actview;

	NSString* title1;
	NSString *urlAddress;
	

}

@property (nonatomic,retain) NSString* title1;
@property (nonatomic,retain) NSString *urlAddress;

@end
