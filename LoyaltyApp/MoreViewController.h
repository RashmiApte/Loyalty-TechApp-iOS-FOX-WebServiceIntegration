//
//  MoreViewController.h
//  YesPayCardHolderWallet
//
//  Created by ankit on 10/22/13.
//
//

#import <UIKit/UIKit.h>
#import "HudView.h"
#import "CAppDelegate.h"

@interface MoreViewController : UIViewController{
    
   CAppDelegate *appdelegate;

    
    UIButton *btnSetting;
    UIButton *btnContactUs;
    UIButton *btnAboutUs;
    UIButton *btnLogout;
    
    UIButton *btnPromotions;
    
    
    UILabel *lblSetting;
    UILabel *lblContactUs;
    UILabel *lblAboutUs;
    UILabel *lblLogout;
    UILabel *lblPromotions;
    
    UIImageView *imgOnline;
    
    HudView *aHUD;
    
    
}

@property(strong,nonatomic)IBOutlet UILabel *lblSetting;
@property(strong,nonatomic)IBOutlet UILabel *lblContactUs;
@property(strong,nonatomic)IBOutlet UILabel *lblAboutUs;
@property(strong,nonatomic)IBOutlet UILabel *lblLogout;

@property (nonatomic,strong)IBOutlet UIImageView *imgOnline;

@property(strong,nonatomic)IBOutlet UIButton *btnSetting;
@property(strong,nonatomic)IBOutlet UIButton *btnContactUs;
@property(strong,nonatomic)IBOutlet UIButton *btnAboutUs;
@property(strong,nonatomic)IBOutlet UIButton *btnLogout;




-(IBAction)btnTap:(UIButton *)sender;
-(void) logouts;


- (void) killHUD;
- (void)showHUD:(NSString*)message;



@end
