//
//  ReportCell.m
//  OurLocate
//
//  Created by Jay on 8/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "regcell2.h"

@implementation regcell2

@synthesize lbl,txt;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) 
	{
        // Initialization code
		lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 7, 110, 25)];
		lbl.font=[UIFont boldSystemFontOfSize:14];
		lbl.backgroundColor=[UIColor clearColor];
		lbl.textAlignment=UITextAlignmentLeft;
		lbl.textColor = [UIColor blackColor];
		[self.contentView addSubview:lbl];
		
		txt=[[UITextField alloc]initWithFrame:CGRectMake(120, 7, 186, 30)];
		txt.font=[UIFont systemFontOfSize:16];
		txt.returnKeyType = UIReturnKeyDone;
		txt.clearButtonMode=UITextFieldViewModeWhileEditing;
		txt.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		txt.clearButtonMode=UITextFieldViewModeWhileEditing;
		txt.borderStyle=UITextBorderStyleNone;
		txt.enabled = TRUE;
		[self.contentView addSubview:txt];		
		
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated 
{

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
