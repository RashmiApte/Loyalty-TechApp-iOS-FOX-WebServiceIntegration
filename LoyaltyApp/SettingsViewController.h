//
//  SettingsViewController.h
//  YesPayCardHolderWallet
//
//  Created by Nirmal Patidar on 03/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HudView.h"

@interface SettingsViewController : UIViewController {
	
	HudView *aHUD;
    UIButton *bckbtn;
    
    UILabel *lblPswd;
    UILabel *lblUserInfo;

    UIButton *btnPswd;
    UIButton *btnUserInfo;
    UIImageView *imgOnline;
    
    
    
    
}
@property (nonatomic,strong)IBOutlet UIImageView *imgOnline;

@property (nonatomic,strong)IBOutlet UILabel *lblPswd;
@property (nonatomic,strong)IBOutlet UILabel *lblUserInfo;
@property (nonatomic,strong)IBOutlet UIButton *btnPswd;
@property (nonatomic,strong)IBOutlet UIButton *btnUserInfo;

-(void)goBackToMore;

-(IBAction)btnTap:(UIButton *)sender;

@end
