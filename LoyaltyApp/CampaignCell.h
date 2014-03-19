//
//  CampaignCell.h
//  Loyalty
//
//  Created by ankit on 2/21/14.
//  Copyright (c) 2014 Ebot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CampaignCell : UITableViewCell

@property(strong,nonatomic)IBOutlet UILabel *lblCampaginName;
@property(strong,nonatomic)IBOutlet UILabel *lblStartDate;
@property(strong,nonatomic)IBOutlet UILabel *lblEndDate;
@property(strong,nonatomic)IBOutlet UIImageView *imgArrow;
@property(strong,nonatomic)IBOutlet UIImageView *imgBackGround;
@property(strong,nonatomic)IBOutlet UIImageView *imgCampagin;





@end
