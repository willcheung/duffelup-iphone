//
//  regcell.h
//  ProRata
//
//  Created by Jay Vachhani on 3/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface regcell : UITableViewCell 
{
	UILabel* lbl;
	UILabel* lbl2;
	UILabel* lbl3;
	UIImageView* image;
	
	//custom asyn image loading
	UIImage * bgImage;
	NSString* urlString; // retained for load failures
	id actionTarget;
	SEL onLoadSuccess;
	SEL onLoadFailure;
	BOOL isLoading;
}

@property(nonatomic,retain) UILabel* lbl;
@property(nonatomic,retain) UILabel* lbl2;
@property(nonatomic,retain) UILabel* lbl3;

@property(nonatomic,retain) UIImageView* image;

// callbacks
@property (assign) id actionTarget;
@property (assign) SEL onLoadSuccess;
@property (assign) SEL onLoadFailure;


@end
