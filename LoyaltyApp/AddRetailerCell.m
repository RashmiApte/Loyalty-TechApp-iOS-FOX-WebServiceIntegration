//
//  AddRetailerCell.m
//  LoyaltyApp
//
//  Created by ankit on 3/3/14.
//
//

#import "AddRetailerCell.h"
#import "Constant.h"

@implementation AddRetailerCell
@synthesize btnAddRetailer,imgRetiler,lblRetailername;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        lblRetailername=[[UILabel alloc]initWithFrame:CGRectMake(96,29,128,28)];
        
        lblRetailername.font=[UIFont fontWithName:labelregularFont size:(18.0)];
        [lblRetailername setBackgroundColor:[UIColor clearColor]];
        lblRetailername.textColor=labelTransactionListTitle;
	 	lblRetailername.textAlignment = NSTextAlignmentLeft;
        
        
        
       
        
        imgRetiler=[[UIImageView alloc]initWithFrame:CGRectMake(5,5,84,80)];
        btnAddRetailer=[[UIButton alloc]initWithFrame:CGRectMake(250,28,63,30)];
        [btnAddRetailer setBackgroundImage:[UIImage imageNamed:@"button_home_60_29.png"] forState:UIControlStateNormal];
        btnAddRetailer.titleLabel.font=[UIFont fontWithName:labelregularFont size:15];
        // [btnAddRetailer setTitle:@"Add" forState:UIControlStateNormal];
        [self.contentView addSubview:lblRetailername];
        [self.contentView addSubview:imgRetiler];
        [self.contentView addSubview:btnAddRetailer];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
