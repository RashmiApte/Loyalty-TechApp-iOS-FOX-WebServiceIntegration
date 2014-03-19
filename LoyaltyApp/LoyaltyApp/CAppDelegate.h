//
//  CAppDelegate.h
//  LoyaltyApp
//
//  Created by Ajeet Sharma on 2/20/14.
//
//  4ABDD2A20CAB71B724C3C25C52FCA7FCE9774A6F

#import <UIKit/UIKit.h>

@interface CAppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate>
{

    NSMutableDictionary *dictionaryForImageCacheing;
    UINavigationController *navigationWindow;

    NSString *userID;
    NSString *SC;
    NSString *userName;
    
}

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic) UINavigationController *navigationWindow;

@property (strong, nonatomic) NSMutableDictionary *dictionaryForImageCacheing;



@property (strong,nonatomic)NSString *userID;
@property (strong,nonatomic)NSString *SC;
@property (strong,nonatomic)NSString *userName;



@end
