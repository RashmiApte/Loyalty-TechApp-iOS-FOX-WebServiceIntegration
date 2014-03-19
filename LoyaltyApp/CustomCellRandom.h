//
//  CustomCellRandom.h
//  iCouponz
//
//  Created by Goyal on 31/07/12.
//  Copyright (c) 2012 http://www.techvalens.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface CustomCellRandom : UITableViewCell{
    AsyncImageView *imgRetailer;//To Show MainPhoto
    UIImageView *imgBackGround;
    UIImageView *imgArrow;
    UILabel *lblTitle;
    UILabel *lblSubtitle;
    UILabel *lblLine;
    

}

@property(strong, nonatomic) AsyncImageView *imgRetailer;
@property(strong, nonatomic) UIImageView *imgBackGround;
@property(strong, nonatomic) UIImageView *imgArrow;
@property(strong, nonatomic) UILabel *lblTitle;
@property(strong, nonatomic) UILabel *lblSubtitle;
@property(strong, nonatomic) UILabel *lblLine;

@end
