//
//  CampaignCell.m
//  Loyalty
//
//  Created by ankit on 2/21/14.
//  Copyright (c) 2014 Ebot. All rights reserved.
//

#import "CampaignCell.h"
#import "Constant.h"

@implementation CampaignCell
@synthesize lblCampaginName,lblStartDate,lblEndDate,imgArrow,imgBackGround,imgCampagin;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        /*[self setBackgroundColor:[UIColor clearColor]];
         self.selectionStyle = UITableViewCellSelectionStyleBlue;
         [self setAccessoryType:UITableViewCellAccessoryNone];
         self.selectionStyle = UITableViewCellSelectionStyleNone;
         self.selectionStyle = UITableViewCellSelectionStyleNone;*/
        lblCampaginName=[[UILabel alloc]initWithFrame:CGRectMake(96,5,128,28)];
        lblStartDate=[[UILabel alloc]initWithFrame:CGRectMake(96,36,110,21)];
        lblEndDate=[[UILabel alloc]initWithFrame:CGRectMake(196,36,88, 21)];
        imgCampagin=[[UIImageView alloc]initWithFrame:CGRectMake(5,5,84,80)];
        imgArrow=[[UIImageView alloc]initWithFrame:CGRectMake(296,32,30,30)];
        imgArrow.image=[UIImage imageNamed:@"arrow.png"];
        lblCampaginName.font=[UIFont fontWithName:labelregularFont size:(18.0)];
        [lblCampaginName setBackgroundColor:[UIColor clearColor]];
        lblCampaginName.textColor=labelTransactionListTitle;
	 	lblCampaginName.textAlignment = NSTextAlignmentLeft;
        
        
        lblStartDate.font=[UIFont fontWithName:labelregularFont size:15];
        [lblStartDate setBackgroundColor:[UIColor clearColor]];
        lblStartDate.textColor=labelTransactionListSubTitle;
        lblStartDate.textAlignment=NSTextAlignmentLeft;
        
        
        lblEndDate.font=[UIFont fontWithName:labelregularFont size:15];
        [lblEndDate setBackgroundColor:[UIColor clearColor]];
        lblEndDate.textColor=labelTransactionListSubTitle;
        lblEndDate.textAlignment=NSTextAlignmentLeft;
        
        
        [self.contentView addSubview:lblCampaginName];
        [self.contentView addSubview:lblStartDate];
        [self.contentView addSubview:lblEndDate];
        [self.contentView addSubview:imgCampagin];
        [self.contentView addSubview:imgArrow];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
