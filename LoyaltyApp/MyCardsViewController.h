
//  MyCardsViewController.h
//  YesPayCardHolderWallet
//
//  Created by Nirmal Patidar on 04/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Login.h"
#import "CAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "HudView.h"

@interface MyCardsViewController : UIViewController <UIAlertViewDelegate>{
    
    
    //------ xib connected objects ---------
    UITableView *tableMyWallet;
    UILabel *isNetwork;
    UIImageView *imgOnline;
    //---------------------------------------
    
	NSMutableArray *resultArray;
    
	CAppDelegate *appDelegate;
    
	Login *viewcontroller;//???ajeet
    
    
	int y,selectedRow,detailisdisplay,yForDetail;
    
	BOOL isRowSelected;
    
	UIView *tempCardView;
	UIImageView *PersonalDetailView;
	UIView *cardDetailView;
    
    
	CGFloat framex,framey,framewidth,frameheight;
	CGFloat detailframex,detailframey,detailframewidth,detailframeheight;
	CGFloat touchBeganX,touchBeganY;
    
    
	BOOL isCradGoesIn,isBackFromAddCard;
	NSString *cardReference;
	NSString *updateButton;
    
	
    
	UILabel *labelEmail;
	UILabel *labelPhone;
	UILabel *labelFax;
    
    UILabel *lblCardCount;
    
    UILabel *lblCardIn;
    HudView *aHUD;
    
    UILabel *lblBackAlertTitle;
    UILabel *lblBackAlertSubTitle;
    NSString *strButtonSelected;
    
    UIImageView *imgLogoSelected;
    UILabel *lblCardNameSelected;
    UILabel *lblNumberLastDigitSelected;
    
    BOOL isCardFetchCalled;
    
    
    UILabel *lblAddress1;
    UILabel *lblAddress2;
    UILabel *lblCity;
    UILabel *lblCountry;
    UILabel *lblPostCode;
    
    UILabel *lblMyWallet;
    UIButton *btndrawerleft;
    
    
}

//------ xib connected objects -------------------------------------------

@property (nonatomic,strong)IBOutlet UITableView *tableMyWallet;
@property (nonatomic,strong)IBOutlet UILabel *isNetwork;
@property (nonatomic,strong)IBOutlet UIImageView *imgOnline;
//------------------------------------------------------------------------

@property (nonatomic,strong)IBOutlet UILabel *lblBackAlertTitle;
@property (nonatomic,strong)IBOutlet UILabel *lblBackAlertSubTitle;

@property(atomic) BOOL isCardFetchCalled;

@property (nonatomic, strong)Login *viewcontroller;
@property (nonatomic, strong)NSString *cardReference;
@property (nonatomic,strong)NSString *updateQuery;


-(void)callWebserviceForCards:(BOOL)isTimeStamps;

-(void)getrowcount;
-(void)backCardIntoTable;
-(void)showPersonalDetails;
-(void)chekForCardRotation;

- (void) killHUD;
- (void)showHUD:(NSString*)message;

- (int)lineCountForLabel:(UILabel *)label;
- (CGSize)sizeForLabel:(UILabel *)label;


@end

