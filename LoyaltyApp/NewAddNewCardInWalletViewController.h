//
//  NewAddNewCardInWalletViewController.h
//  LoyaltyApp
//
//  Created by ankit on 3/10/14.
//
//

#import <UIKit/UIKit.h>
#import "CAppDelegate.h"


@class JASidePanelController;
@class HudView;

@interface NewAddNewCardInWalletViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *srollViewAddNewCard;
    UITextField *txtCardname;
    UITextField *txtCardnumber;
    UIButton *btnSubmit;
    
    UIButton *btnBack;
    UIButton *btnSkip;
    CAppDelegate *appdelegate;
    HudView *aHUD;
    
}



@property(strong,nonatomic)IBOutlet UIScrollView *srollViewAddNewCard;
@property(strong,nonatomic)IBOutlet UITextField *txtCardname;
@property(strong,nonatomic)IBOutlet UITextField *txtCardnumber;
@property(strong,nonatomic)IBOutlet UIButton *btnSubmit;
@property(strong,nonatomic)IBOutlet UIButton *btnAddanother;

@property(strong,nonatomic)NSString *strUserid;
@property(strong,nonatomic)UITextField *txtHolder;
@property (strong, nonatomic)JASidePanelController* jaSidePanelobj;
@property(strong,nonatomic)NSString *strbtnidentifire;



-(IBAction)submit:(id)sender;
-(IBAction)addAnother:(id)sender;


-(void)back;
-(void)skip;



@end
