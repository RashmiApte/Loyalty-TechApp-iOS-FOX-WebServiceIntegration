//
//  Login.h
//  LoyaltyApp
//
//  Created by Ajeet Sharma on 2/24/14.
//
//

#import <UIKit/UIKit.h>
#import "CAppDelegate.h"
#import "HudView.h"
@class JASidePanelController;

@interface Login : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
   
    
  
    //------------------- NIB connected objects -------------------- //
    
    UIImageView *imgBottomImage;
    UIImageView *imgOnline;
    UIButton *btnHome;
    UIButton *btnSetting;
    UIButton *btnLogin;
    UIButton *btnForgetPassword;
    
    UITextField *txtEmailId;
    UITextField *txtPassword;
    
    UILabel *lblBorderEmailId;
    UILabel *lblBorderPassword;

    //-------------------------------------------------------------- //
    
    
    UITabBarController *LogintabBarController;
    
    
    CAppDelegate *appdelegate;
    HudView *aHUD;
    

}
@property(strong,nonatomic) UITabBarController *LogintabBarController;

//------------------- NIB connected objects -------------------- //
@property(strong,nonatomic)IBOutlet UIButton *btnHome;
@property(strong,nonatomic)IBOutlet UIButton *btnSetting;
@property(strong,nonatomic)IBOutlet UIButton *btnLogin;
@property(strong,nonatomic)IBOutlet UIButton *btnForgetPassword;       // ----- Not in fox release -----//
@property(strong,nonatomic)IBOutlet UITextField *txtEmailId;
@property(strong,nonatomic)IBOutlet UITextField *txtPassword;
@property(strong,nonatomic)IBOutlet UILabel *lblBorderEmailId;
@property(strong,nonatomic)IBOutlet UILabel *lblBorderPassword;
@property(strong,nonatomic)IBOutlet UIImageView *imgBottomImage;
@property(strong,nonatomic)IBOutlet UIImageView *imgOnline;
//-------------------------------------------------------------- //


@property (strong, nonatomic) JASidePanelController *jaSidePanelobj;


- (BOOL) validateEmail: (NSString *) candidate;
-(NSString*) sha256:(NSString *)cipherPassword;

//------------------- Button methos ---------------------------- //
-(IBAction)loginButton:(id)sender;
-(IBAction)settingButton:(id)sender;
-(IBAction)homeButton:(id)sender;
-(IBAction)forgetPasswordButton:(id)sender;                           // ----- Not in fox release -----//
//-------------------------------------------------------------- //


//---------------------- Hudview methods ------------------------//
- (void) killHUD;
- (void)showHUD:(NSString*)message;
//-------------------------------------------------------------- //
@end
