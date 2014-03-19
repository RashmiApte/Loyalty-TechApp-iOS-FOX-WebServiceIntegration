//
//  UpdatePasswordViewController.h
//  YesPayCardHolderWallet
//
//  Created by Nirmal Patidar on 04/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HudView.h"

@class CAppDelegate;
@interface UpdatePasswordViewController : UIViewController <UITextFieldDelegate,UIGestureRecognizerDelegate>{
	
	
    CAppDelegate *appdelegate;
	
    UITextField *oldPasswordText,*newPasswordText,*confirmPasswordText;
	
    NSString *enString;
    HudView *aHUD;
    
    UITextField *txtOldPassword;
    UITextField *txtNewPassword;
    UITextField *txtConfirmPassword;
    UIButton *btndrawerleft;
    
    UILabel *lblBorderOldPassword;
    UILabel *lblBorderNewPassword;
    UILabel *lblBorderReEnterPassword;
    
    
    
}

@property(strong,nonatomic)IBOutlet  UITextField *txtOldPassword;
@property(strong,nonatomic)IBOutlet  UITextField *txtNewPassword;
@property(strong,nonatomic)IBOutlet UITextField *txtConfirmPassword;

@property(strong,nonatomic)IBOutlet UILabel *lblBorderOldPassword;
@property(strong,nonatomic)IBOutlet UILabel *lblBorderNewPassword;
@property(strong,nonatomic)IBOutlet UILabel *lblBorderReEnterPassword;

@property(strong,nonatomic)UITextField *holdertextfield;
@property(strong,nonatomic)IBOutlet UIImageView *imgOnline;
@property(strong,nonatomic)IBOutlet UIImageView *pwdchangeimage;



-(void)goBackToSettings;
-(void)UpdatePassword;
- (void) addReturnButtonInNumPad;
- (void) removeReturnButtonFromNumPad;

-(NSString*) sha256:(NSString *)cipherPassword;

- (void) killHUD;
- (void)showHUD:(NSString*)message;

@end
