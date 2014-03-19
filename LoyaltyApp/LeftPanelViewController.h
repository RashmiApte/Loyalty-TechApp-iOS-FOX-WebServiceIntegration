//
//  LeftPanelViewController.h
//  LoyaltyApp
//
//  Created by ankit on 2/26/14.
//
//

#import <UIKit/UIKit.h>
#import "HudView.h"
#import "CAppDelegate.h"

@interface LeftPanelViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    HudView *aHUD;
    CAppDelegate *appdelegate;
}
@property(strong,nonatomic)IBOutlet UITableView *tabelDrawerview;
@property(strong,nonatomic)NSMutableArray *arryDrawerelement;

@end
