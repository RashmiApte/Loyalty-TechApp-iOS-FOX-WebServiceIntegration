//
//  HomeViewController.h
//  YesPayCardHolderWallet
//
//  Created by ankit on 11/13/13.
//
//

#import <UIKit/UIKit.h>
@class CAppDelegate;

@interface HomeViewController : UIViewController
{
    CAppDelegate *appdelegate;

}
@property(strong,nonatomic)IBOutlet UILabel *lblnewtoworlpayLbl;
@property(strong,nonatomic)IBOutlet UILabel *lblalreadycreateLbl;
@property(strong,nonatomic)IBOutlet UIButton *btnSignup;
@property(strong,nonatomic)IBOutlet UIButton *btnLogin;
@property(strong,nonatomic)IBOutlet UIImageView *imgOnline;
@property(strong,nonatomic)IBOutlet UIImageView *imgBottomImage;
@property(strong,nonatomic)IBOutlet UIImageView *imglogo;


-(IBAction)sighnup:(id)sender;
-(IBAction)login:(id)sender;
-(IBAction)Help:(id)sender;


@end
