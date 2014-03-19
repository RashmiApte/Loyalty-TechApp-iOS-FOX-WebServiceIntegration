//
//  CustomCellRandom.m
//  iCouponz
//
//  Created by Goyal on 31/07/12.
//  Copyright (c) 2012 http://www.techvalens.com All rights reserved.
//

#import "CustomCellRandom.h"
#import "AsyncImageView.h"
#import "Constant.h"

@implementation CustomCellRandom

@synthesize imgRetailer,imgArrow,imgBackGround,lblSubtitle,lblTitle,lblLine;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor clearColor]];
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
		[self setAccessoryType:UITableViewCellAccessoryNone];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UIImage *img = [UIImage imageNamed:@"nearby_background.png"];
        UIImageView *imageBG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
        imageBG.image = img;
        
        imgRetailer = [[AsyncImageView alloc]initWithFrame:CGRectMake(15, 10, 56, 34)];
        imgBackGround=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 292, 59)];
        imgArrow=[[UIImageView alloc] initWithFrame:CGRectMake(265, 20, 20, 20)];
        lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(79 , 4, 220, 25)];
        lblSubtitle=[[UILabel alloc] initWithFrame:CGRectMake(79,25,220,18)];

        
        lblTitle.font=[UIFont fontWithName:labelmediumFont size:14];
        [lblTitle setBackgroundColor:[UIColor clearColor]];
        lblTitle.textColor=labelTransactionListTitle;
	 	lblTitle.textAlignment = NSTextAlignmentLeft;

        
        lblSubtitle.font=[UIFont fontWithName:labelregularFont size:15];
        [lblSubtitle setBackgroundColor:[UIColor clearColor]];
        lblSubtitle.textColor=labelTransactionListSubTitle;
        lblSubtitle.textAlignment=NSTextAlignmentLeft;
        
        //[imgRetailer setBackgroundImage:[UIImage imageNamed:@"no_pic.png"] forState:UIControlStateNormal];

        
        lblLine =[[UILabel alloc] initWithFrame:CGRectMake(15 , 53, 290, 1)];
        lblLine.backgroundColor=[UIColor lightGrayColor];
        lblLine.alpha=0.5;
        
       // [self.contentView addSubview:imgBackGround];
        [self.contentView addSubview:imgRetailer];
       // [self.contentView addSubview:imgArrow];
        [self.contentView addSubview:lblTitle];
        [self.contentView addSubview:lblSubtitle];
        [self.contentView addSubview:lblLine];

        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
