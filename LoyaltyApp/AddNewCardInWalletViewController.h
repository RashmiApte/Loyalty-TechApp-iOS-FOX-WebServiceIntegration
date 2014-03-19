//
//  AddNewCardInWalletViewController.h
//  YesPayCardHolderWallet
//
//  Created by Nirmal Patidar on 13/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CAppDelegate.h"
#import "MyCardsViewController.h"
#import "HudView.h"

@interface AddNewCardInWalletViewController : UIViewController <UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    
    UITableView *tableAddNewCard;
	UITextField *cardNumberText,*cvvText,*cardNameText,*cardIssuerNumberText,*cardIssuerNameText,*cardHolderNameText;
	UITextField *address1Text,*address2Text,*cityText,*postCodeText,*phoneText,*faxText,*emailText;
	UITextField *expiryText,*startText;
    UIButton *doneButton;
	UIView *TempViewForDatePicker;
	UIButton *pickerDoneButton;
	UILabel *startDateLabel;
	UILabel *expiryDateLabel;
	BOOL isStartDate,isEndDate;
	NSDateFormatter *dateFormat;
	NSString *addCardQuery,*addCardQueryValues;
	CAppDelegate *appDelegate;
	MyCardsViewController *myCardsView;
	UIImageView *datePickerTopBorder,*datePickerBottomBorder,*datePickerLeftBorder,*datePickerRightBorder;
	NSMutableArray *resultArray;
	NSString *firstName,*middleName,*lastName,*firstMiddle,*firstMiddleLast,*firstmiddlelastFinal;
	UITextField *countryText;
    UIPickerView *countryPicker,*expdatepickerview;
	NSMutableArray *getCountryList,*getCountryName,*getCountryCode;
		
    NSMutableDictionary *settingsDictionary;
	int selectRow;
	NSString *setCounryCode,*setCurrCodeSetting;
	HudView *aHUD;
    UIImageView *staticimageview;
    
}
@property (nonatomic,strong)IBOutlet UITableView *tableAddNewCard;
@property (nonatomic,strong)IBOutlet UIImageView *staticimageview;
@property (strong,nonatomic)UIImageView *pickerbgimage;
@property(strong,nonatomic)UITextField *holdertextfield;
@property(strong,nonatomic)UIImageView *pickertransperntimg;
@property(strong,nonatomic)IBOutlet UIImageView *imgOnline;
//for expiry picker
@property(strong,nonatomic)NSArray *montharray;
@property(strong,nonatomic)NSArray *yeararray;
@property (nonatomic, strong) NSIndexPath *todayIndexPath;

@property(strong,nonatomic)NSString *strtxtcolor;


//cancebutnstr
@property(strong,nonatomic)NSString *closebtnstr;


- (void)selectToday;

-(void)BacktoView;
-(void)Submit;


- (void) addReturnButtonInNumPad;
- (void) removeReturnButtonFromNumPad;
-(void)setViewMovedUp:(BOOL)movedUp;
- (BOOL) validateEmail: (NSString *) candidate;

- (void) killHUD;
- (void)showHUD:(NSString*)message;

@end
