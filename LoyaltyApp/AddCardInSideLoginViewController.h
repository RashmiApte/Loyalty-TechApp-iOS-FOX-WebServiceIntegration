//
//  AddCardInSideLoginViewController.h
//  LoyaltyApp
//
//  Created by ankit on 3/13/14.
//
//

#import <UIKit/UIKit.h>
#import "CAppDelegate.h"
@class HudView;


@interface AddCardInSideLoginViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate>
{

 UIButton *btnBack;
 CAppDelegate *appdelegate;
 HudView *aHUD;
}
@property(strong,nonatomic)UIButton *btnSubmit;
@property(strong,nonatomic)IBOutlet UIScrollView *srollViewAddNewCard;
@property(strong,nonatomic)IBOutlet UITextField *txtCardname;
@property(strong,nonatomic)IBOutlet UITextField *txtCardnumber;

@property(strong,nonatomic)IBOutlet UIButton *btnAddanother;
@property(strong,nonatomic)UITextField *txtHolder;
@property(strong,nonatomic)NSString *strbtnidentifire;


-(void)submit:(id)sender;
-(void)calladdcardrequest;
-(IBAction)addAnother:(id)sender;
-(void)back;

@end
