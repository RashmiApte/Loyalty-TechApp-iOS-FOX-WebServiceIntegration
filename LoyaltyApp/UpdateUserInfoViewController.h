//
//  UpdateUserInfoViewController.h
//  YesPayCardHolderWallet
//
//  Created by Nirmal Patidar on 04/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "HudView.h"

@class CAppDelegate;
@interface UpdateUserInfoViewController : UIViewController <UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    
    UITableView *tableUpdateUserInfo;
	CAppDelegate *appDelegate;
	UITextField *fNameText;
	UITextField *mNameText;
	UITextField *lNameText;
	UITextField *mobileText;
	UITextField *emailText;
	UITextField *addressText1;
	UITextField *addressText2;
	UITextField *CityText;
	UITextField *RegionText;
	UITextField *PostCodeText;
	UITextField *sexText;
	//UILabel *sexLabel;
	////// Added
	UITextField *dateOfBirthField;
	UITextField *dateOfBirthText;
	UIView *TempViewForDatePicker;
	UIButton *pickerDoneButton;
	UILabel *startDateLabel;
	UILabel *expiryDateLabel;
	UIDatePicker *datePicker;
	BOOL isStartDate,isEndDate;
	NSDateFormatter *dateFormat;
	IBOutlet UILabel *isNetwork;
	NSString *updateQuery,*updateQueryValues;
	NSMutableArray *resultArray;
	UIImageView *datePickerTopBorder,*datePickerBottomBorder,*datePickerLeftBorder,*datePickerRightBorder;
	
	BOOL isFirstNameChange,isMiddleNameChange,isLastNameChange,isDOBChange,isSexChange,isAddress1Change;
	BOOL isAddress2Change,isCityChange,isCountryChange,isRegionChange,isPostCodeChange,isMobileChange,isEmailChange;
	NSString *setCounCodeSetting;
	
	///// 091211
	UITextField *countryText;
    UIPickerView *countryPicker;
    UIPickerView *genderPicker;
    NSMutableArray *arrayGenderPicker;
	NSMutableArray *getCountryList,*getCountryName,*getCountryCode;
	NSString *pickerValue;
	NSMutableDictionary *settingsDictionary;
	int selectRow;
    int selectRowGender;
	NSString *setCounryCode;
	NSString *setTextcountryLabel;
    HudView *aHUD;
    UILabel *lblBackAlertTitle;
    UIButton *btndrawerleft;
    
}

@property (nonatomic,strong)IBOutlet UILabel *lblBackAlertTitle;
@property (nonatomic,strong)IBOutlet UITableView *tableUpdateUserInfo;
@property (strong,nonatomic)UIImageView *pickerbgimage;
//@property (strong,nonatomic)UIDatePicker *datePicker;
@property (strong,nonatomic)UIView *TempViewForDatePicker;
@property(strong,nonatomic)UITextField *holdertextfield;
@property(strong,nonatomic)UIButton *btnShowPicker;
@property(strong,nonatomic)UIButton *btnShowcountryPicker;
@property(strong,nonatomic)UIButton *btnShowgenderPicker;
@property(strong,nonatomic)UIImageView *pickertransperntimg;
@property(strong,nonatomic)IBOutlet UIImageView *imgOnline;
@property(strong,nonatomic)NSString *headertitle;

@property(strong,nonatomic)UILabel* fnamlbl;
@property(strong,nonatomic)UILabel* lnamelbl;
@property(strong,nonatomic)UILabel* mobilelbl;
@property(strong,nonatomic)UILabel* emailibl;
@property(strong,nonatomic)UILabel* sexlbl;
@property(strong,nonatomic)UILabel* mnamelbl;
@property(strong,nonatomic)UILabel* addresslbl1;
@property(strong,nonatomic)UILabel* addresslbl2;
@property(strong,nonatomic)UILabel* citylbl;
@property(strong,nonatomic)UILabel* regionlbl;
@property(strong,nonatomic)UILabel* postcodelbl;
@property(strong,nonatomic)UILabel* countrylbl;
@property(strong,nonatomic)UILabel* dateofbirthlbl;


//closebuttn str
@property(strong,nonatomic)NSString *cancelbtnstr;









-(IBAction)BacktoView;
-(void)UpdateUserInfo;
- (void) addReturnButtonInNumPad;
- (void) removeReturnButtonFromNumPad;
-(void)setViewMovedUp:(BOOL)movedUp;
//-(void)setPickerMoveUp:(BOOL)moveUp;
-(void)checkForFirstResponder;
//-(void)doneAction;
-(void)goBackToSettings;
-(void)setTextFieldChangeValue;
- (BOOL) validateEmail: (NSString *) candidate;

- (void) killHUD;
- (void)showHUD:(NSString*)message;


@end
