//
//  SplasahScreen.h
//  YesPayCardHolderWallet
//
//  Created by YESpay on 1/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAppDelegate.h"
#import "HudView.h"


@interface SplashScreen : UIViewController {
	
    UIImageView *imgBackground;
    HudView *aHUD;
    CAppDelegate *appdelegate;
}
@property(nonatomic,strong) UIImageView *imgBackground;


- (void) killHUD;
- (void)showHUD:(NSString*)message;
@end
