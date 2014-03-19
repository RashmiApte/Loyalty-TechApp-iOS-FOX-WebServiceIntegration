//
//  SignUpViewController.h
//  VoiceAssist_Project
//
//  Created by infobeans on 16/12/09.
//  Copyright 2009 infobeans systems india pvt. ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
//#import "UIMonthYearPicker.h"
#import "HudView.h"

@class CAppDelegate;

@interface SignUpViewController : UIViewController <UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    
	NSString *userDOBYear,*currentDOBYear;
	int userDOBYearInt,currentDOBYearInt,diffUserDOBInt;
	
	UITableView *tableSignup;
	IBOutlet UINavigationBar *navbar;
	IBOutlet UINavigationItem *navItem;
	UITextField *usernameText;
	UITextField *fNameText;
	UITextField *mNameText;
	UITextField *lNameText;
	UITextField *sexText;
	UILabel *sexLabel;
	UITextField *mobileText;
    UITextField *dateOfBirthText;
	UILabel *dateOfBirth;
	UILabel *countryLabel;
    UITextField *countryText;
	UITextField *emailText;
	UITextField *passwordText;
	UITextField *confirmPasstext;
	
	UITextField *addressText1;
	UITextField *addressText2;
	UITextField *CityText;
	UITextField *RegionText;
    
	UITextField *PostCodeText;
	
	UITextField *cardNumberText;
	UITextField *cvvText;
	UITextField		*expiryText;
	UILabel		*startDateText;
	UITextField *cardNameText;
	UITextField *cardIssuerNumberText;
	UITextField *cardIssuerNameText;
	UITextField *faxText;
	
	UIButton *agreeTermsBtn;
	UIView *TempViewForDatePicker, *TempViewForCountryPicker,*TempViewForgenderepicker;
	UIButton *pickerDoneButton;
	UIDatePicker *datePicker;
	NSDateFormatter *dateFormat;
	BOOL isStartDate,isEndDate;
    
	NSString *errorMessage;
	UIButton *myButton;
	UIImageView *datePickerTopBorder,*datePickerBottomBorder,*datePickerLeftBorder,*datePickerRightBorder;
	NSDateFormatter *date_formater;
    
	NSTimer *tableViewTimer;
    
    UIPickerView *countryPicker,*genderPicker,*expdatepickerview;
    CAppDelegate *appdelegate;
    NSMutableArray *getCountryList;
    NSMutableArray *getCountryCode;
    NSMutableArray *getCountryName;
    NSMutableArray *genderarray;
    NSMutableDictionary *settingDictionary;
    //NSString *pickerValue,*sexSelected;
    int selectRow;
    int selectRowGender;
    
	IBOutlet UILabel *isNetwork;
	NSMutableArray *maleFemaleArray;
	BOOL isSexLabel;
	NSString *setCurrCodeSetting;
	HudView *aHUD;
    UIImageView *imgBottomImage;

	
}


@property (nonatomic,strong) IBOutlet UITableView *tableSignup;
@property (nonatomic,strong) IBOutlet UIButton *agreeTermsBtn;
@property (nonatomic,strong) IBOutlet UIButton *myButton;
@property (nonatomic,strong) IBOutlet NSString *errorMessage;
@property (strong,nonatomic) UIImageView *pickerbgimage;
@property(strong,nonatomic)UITextField *fNameText;
@property(strong,nonatomic)UITextField *holdertextfield;
@property(strong,nonatomic)IBOutlet UILabel *titlelbl;
@property(strong,nonatomic)IBOutlet UIButton *cancelbtn;
@property(strong,nonatomic)IBOutlet UIButton *submitbtn;
@property(strong,nonatomic)IBOutlet UIImageView *imgOnline;
@property(strong,nonatomic)UIImageView *pickertransperntimg;

@property(strong,nonatomic)IBOutlet UIImageView *imgBottomImage;

//@property (strong, nonatomic) IBOutlet UIMonthYearPicker *expdatePicker;

//for custum date picker

@property(strong,nonatomic)NSArray *montharray;
@property(strong,nonatomic)NSArray *yeararray;
@property (nonatomic, strong) NSIndexPath *todayIndexPath;

//close
@property(strong,nonatomic)NSString *closebtnstr;

- (void)selectToday;




-(IBAction)RegisterUser;
- (IBAction) cancelSignUp;
- (void) addReturnButtonInNumPad;
- (void) removeReturnButtonFromNumPad;
-(void)setViewMovedUp:(BOOL)movedUp;
-(void)checkForFirstResponder;
- (BOOL) validateEmail: (NSString *) candidate;

- (void) killHUD;
- (void)showHUD:(NSString*)message;

@end
