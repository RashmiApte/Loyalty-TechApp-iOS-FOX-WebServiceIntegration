//
//  MyRetailerViewController.h
//  LoyaltyApp
//
//  Created by ankit on 2/27/14.
//
//

#import <UIKit/UIKit.h>

@interface MyRetailerViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *btndrawerleft;
    
}
@property(strong,nonatomic)IBOutlet UITableView *tableMyRetailer;
@property(strong,nonatomic)UIButton *btnSenderView;

-(IBAction)removeretailer:(id)sender;

@end
