//
//  ForgetPassword.h
//  LoyaltyApp
//
//  Created by Ajeet Sharma on 2/24/14.
//
//

#import <UIKit/UIKit.h>

@interface ForgetPassword : UIViewController

{

    UIImageView *imgBottomImage;
    UIImageView *imgOnline;
    UITextField *txtEmailId;
}

@property(strong,nonatomic)IBOutlet UITextField *txtEmailId;
@property(strong,nonatomic)IBOutlet UIImageView *imgBottomImage;
@property(strong,nonatomic)IBOutlet UIImageView *imgOnline;
@end
