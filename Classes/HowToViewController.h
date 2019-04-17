//
//  HowToViewController.h
//  FruityDigital
//
//  Created by Muhammad Zafar Iqbal on 12/28/10.
//  Copyright 2010 TechHelpSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "notecontroller.h"
#import "duffelAppDelegate.h"

@interface HowToViewController : UIViewController<UIScrollViewDelegate> {
	int section;
	int row;
	NSMutableArray* arraytrip;
	BOOL isunsch;
	UIScrollView *scrollView;
	UIPageControl *pageControl;
    NSMutableArray *viewControllers;
	
    // To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
	UIActivityIndicatorView *activityViewer;
	UIImageView *activityBackgroundView;
	UIBarButtonItem *mapButton;
	
}

@property(nonatomic,retain) NSMutableArray *arraytrip;
@property(nonatomic,readwrite) BOOL isunsch;
@property(nonatomic,readwrite) int section;
@property(nonatomic,readwrite) int row;


- (void)changePage;
- (void)loadScrollViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;



@end
