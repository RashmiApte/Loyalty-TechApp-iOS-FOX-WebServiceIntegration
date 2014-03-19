//
//  CampainViewController.h
//  Loyalty
//
//  Created by ankit on 2/21/14.
//  Copyright (c) 2014 Ebot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CampainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *btndrawerleft;
}

@property(strong,nonatomic)IBOutlet UITableView *tableCampagin;



@end
