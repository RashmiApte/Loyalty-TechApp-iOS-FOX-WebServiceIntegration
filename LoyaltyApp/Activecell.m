//
//  Activecell.m
//  LoyaltyApp
//
//  Created by ankit on 2/28/14.
//
//

#import "Activecell.h"
#import "Constant.h"

@implementation Activecell
@synthesize lblActivecampaginname,lblActivecampaginstartdate,lblActivecampaginenddate,imgactivecampagin,imgArrow;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        lblActivecampaginname=[[UILabel alloc]initWithFrame:CGRectMake(96,5,140,28)];
        
        
        [lblActivecampaginname setBackgroundColor:[UIColor clearColor]];
        lblActivecampaginname.textColor=labelTransactionListTitle;
        lblActivecampaginname.font=[UIFont fontWithName:labelregularFont size:(18.0)];
	 	lblActivecampaginname.textAlignment = NSTextAlignmentLeft;
        
        
        lblActivecampaginstartdate=[[UILabel alloc]initWithFrame:CGRectMake(96,36,92,21)];
        lblActivecampaginstartdate.font=[UIFont fontWithName:labelregularFont size:15];
        [lblActivecampaginstartdate setBackgroundColor:[UIColor clearColor]];
        lblActivecampaginstartdate.textColor=labelTransactionListSubTitle;
        lblActivecampaginstartdate.textAlignment=NSTextAlignmentLeft;
        
        lblActivecampaginenddate=[[UILabel alloc]initWithFrame:CGRectMake(196,36,88, 21)];
        imgactivecampagin=[[UIImageView alloc]initWithFrame:CGRectMake(5,5,84,80)];
        
        lblActivecampaginenddate.font=[UIFont fontWithName:labelregularFont size:15];
        [lblActivecampaginenddate setBackgroundColor:[UIColor clearColor]];
        lblActivecampaginenddate.textColor=labelTransactionListSubTitle;
        lblActivecampaginenddate.textAlignment=NSTextAlignmentLeft;
        
        
        imgArrow=[[UIImageView alloc]initWithFrame:CGRectMake(296,32,30,30)];
        imgArrow.image=[UIImage imageNamed:@"arrow.png"];
        [self.contentView addSubview:lblActivecampaginname];
        [self.contentView addSubview:lblActivecampaginstartdate];
        [self.contentView addSubview:lblActivecampaginenddate];
        [self.contentView addSubview:imgactivecampagin];
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
