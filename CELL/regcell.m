//
//  regcell.m
//  ProRata
//
//  Created by Jay Vachhani on 3/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "regcell.h"

@implementation regcell
@synthesize lbl,image,lbl2,lbl3,actionTarget,onLoadFailure,onLoadSuccess;;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
		
		lbl=[[UILabel alloc]initWithFrame:CGRectMake(41, 8, 250, 27)];
		lbl.font=[UIFont boldSystemFontOfSize:13];
		lbl.backgroundColor=[UIColor clearColor];
		lbl.textAlignment=UITextAlignmentLeft;
		lbl.textColor = [UIColor blackColor];
		//lbl.enabled = FALSE;
		[self.contentView addSubview:lbl];
		
		lbl2=[[UILabel alloc]initWithFrame:CGRectMake(47, 35, 240, 27)];
		lbl2.font=[UIFont systemFontOfSize:13];
		lbl2.backgroundColor=[UIColor clearColor];
		lbl2.textAlignment=UITextAlignmentLeft;
		lbl2.textColor = [UIColor blackColor];
		lbl2.hidden = TRUE;
		[self.contentView addSubview:lbl2];
		
		lbl3=[[UILabel alloc]initWithFrame:CGRectMake(47, 35, 240, 27)];
		lbl3.font=[UIFont systemFontOfSize:13];
		lbl3.backgroundColor=[UIColor clearColor];
		lbl3.textAlignment=UITextAlignmentLeft;
		lbl3.textColor = [UIColor grayColor];
		lbl3.hidden = TRUE;
		[self.contentView addSubview:lbl3];
	
		image = [[UIImageView alloc] initWithFrame:CGRectMake(4, 9, 30, 22)];
		[self.contentView addSubview:image];
		
		[lbl release];
		[image release];
    }
    return self;
}

- (void) performAsyncLoadWithURL:(NSURL*)url
{
	NSAutoreleasePool * pool =[[NSAutoreleasePool alloc] init];
	
	NSError* loadError = nil;
	NSData* imageData = [NSData dataWithContentsOfURL:url options:NSMappedRead error:&loadError];
	
	if(imageData)
	{
		
		
		[self performSelectorOnMainThread:@selector(loadDidFinishWithData:)
							   withObject:imageData 
							waitUntilDone:YES];
		
	}
	else
	{
		[self performSelectorOnMainThread:@selector(loadDidFinishWithError:)
							   withObject:loadError 
							waitUntilDone:YES];
	}
	
	[pool release]; // imageData will be released here
}

- (void)loadDidFinishWithData:(NSData*)imageData
{	
	isLoading = NO;
	[urlString release]; // success hence no nead for url
	
	@try {
		UIImageView *bgView = [[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 75, 55)] retain];
		
		bgImage = [[UIImage imageWithData:imageData] retain];
		
		//	UIImage *tmpImage = [bgImage _imageScaledToSize:CGSizeMake(50.0f, 70.0f) interpolationQuality:1];
		
		[image setImage:bgImage];
//		[bgView setImage:bgImage];
//		[self.contentView addSubview:bgView];
//		[bgView release];		
		
	}
	@catch (NSException * e) {
		UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"Unable to get results. Please try again in a few moments" 
															message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
		[alterView show];
		[alterView release];
	}	
	@finally {
		/*if(indicView !=nil)
		 {
		 [indicView release];
		 }*/
		
	}
	
	
	
	if(actionTarget && [actionTarget respondsToSelector:onLoadSuccess])
	{
		[actionTarget performSelector:onLoadSuccess];
	}
}

- (void)loadDidFinishWithError:(NSError*)error
{
	isLoading = NO;
	[image setImage:[UIImage imageNamed:@"icon-duffel.png"]];
	
	NSLog(@"\nAPSWebImageView: Failed Image Load\n		[%@]\n		With Error - %@", 
		  urlString, [error localizedDescription]);
	[urlString release];
	
	if(actionTarget && [actionTarget respondsToSelector:onLoadFailure])
	{
		[actionTarget performSelector:onLoadFailure];
	}
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
