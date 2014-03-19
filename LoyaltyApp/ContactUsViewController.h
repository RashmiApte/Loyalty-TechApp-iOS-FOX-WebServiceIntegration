//
//  ContectUsViewController.h
//  YesPayCardHolderWallet
//
//  Created by Nirmal Patidar on 14/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAppDelegate.h"
#import "HudView.h"

@interface ContactUsViewController : UIViewController<NSXMLParserDelegate> {
	CAppDelegate *appDelegate;
	IBOutlet UITableView *tableContactUs;
	NSMutableArray *resultArray,*keyArray,*valueArray;
	IBOutlet UILabel *isNetwork;
    UIButton *backbutton;
    HudView *aHUD;
    UIImageView *imgOnline;
    
    NSMutableArray *arrayCountry;
    NSMutableArray *arrayEmail;
    NSMutableArray *arrayMessage;
    NSMutableArray *arrayPhone;
    
    NSString *strElementName;
    
    UILabel *lblBackAlertTitle;
    NSMutableArray *array1;
    NSMutableArray *array2;
    NSMutableArray *array3;
    
    int addressNumber;
    NSMutableArray *arrayTitle1;
    NSMutableArray *arrayTitle2;
    NSMutableArray *arrayTitle3;
    
    int statusCode;
    NSString *strErrorMessage;
   
    
 
}
@property (nonatomic,strong)IBOutlet UIImageView *imgOnline;
@property (nonatomic,strong)IBOutlet UILabel *lblBackAlertTitle;

@property (nonatomic,strong) NSMutableArray *resultArray;
@property (nonatomic,strong) NSMutableArray *keyArray;
@property (nonatomic,strong) NSMutableArray *valueArray;
@property (nonatomic,strong) UITableView *tableContactUs;

- (void)showHUD:(NSString*)message;
- (void) killHUD;

-(void)getrowcount;

- (int)lineCountForLabel:(UILabel *)label;
- (CGSize)sizeForLabel:(UILabel *)label;


@end
