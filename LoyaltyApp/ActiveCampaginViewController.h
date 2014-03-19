//
//  ActiveCampaginViewController.h
//  LoyaltyApp
//
//  Created by ankit on 2/28/14.
//
//

#import <UIKit/UIKit.h>

@interface ActiveCampaginViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *btndrawerleft;
    
}
@property(strong,nonatomic)IBOutlet UITableView *tableActivecampagin;
@property(strong,nonatomic)NSMutableArray *arryShowActiveCampagin;


@end
