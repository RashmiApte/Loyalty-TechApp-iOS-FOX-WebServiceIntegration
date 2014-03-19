//
//  LeftPanelcell.m
//  LoyaltyApp
//
//  Created by ankit on 2/27/14.
//
//

#import "LeftPanelcell.h"

@implementation LeftPanelcell
@synthesize imgeleftpanellogo,lblleftpaneltitle,imgbackgroundimg;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        lblleftpaneltitle=[[UILabel alloc]initWithFrame:CGRectMake(70,12,201,26)];
        lblleftpaneltitle.backgroundColor=[UIColor clearColor];
        imgeleftpanellogo=[[UIImageView alloc]initWithFrame:CGRectMake(6,10,32,32)];
        imgbackgroundimg=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,320,51)];
        [self.contentView addSubview:lblleftpaneltitle];
        [self.contentView addSubview:imgeleftpanellogo];
        //imgbackgroundimg.image=[UIImage imageNamed:@"campagin.png"];
        [self.contentView addSubview:imgbackgroundimg];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
