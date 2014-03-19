//
//  MyRetailerCell.m
//  LoyaltyApp
//
//  Created by ankit on 2/27/14.
//
//

#import "MyRetailerCell.h"
#import "Constant.h"


@implementation MyRetailerCell
@synthesize btnremoveretailer,lblretailername,imgretailerlogo;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        lblretailername=[[UILabel alloc]initWithFrame:CGRectMake(100,30,128,28)];
        lblretailername.backgroundColor=[UIColor clearColor];
        //lblretailername.font=[UIFont fontWithName:labelregularFont size:(18.0)];
        lblretailername.font=[UIFont fontWithName:labelregularFont size:(18.0)];
        [lblretailername setBackgroundColor:[UIColor clearColor]];
        lblretailername.textColor=labelTransactionListTitle;
	 	lblretailername.textAlignment = NSTextAlignmentLeft;
        
        
        imgretailerlogo=[[UIImageView alloc]initWithFrame:CGRectMake(5,5,84,80)];
        
        //button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnremoveretailer=[[UIButton alloc]initWithFrame:CGRectMake(240,33,63,30)];
        [btnremoveretailer setBackgroundImage:[UIImage imageNamed:@"button_home_60_29.png"] forState:UIControlStateNormal];
        [btnremoveretailer setTitle:@"Remove" forState:UIControlStateNormal];
        btnremoveretailer.titleLabel.font=[UIFont fontWithName:labelregularFont size:15];
        [self.contentView addSubview:lblretailername];
        [self.contentView addSubview:imgretailerlogo];
        [self.contentView addSubview:btnremoveretailer];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
