//
//  SettingCountryCurrency.h
//  YesPayCardHolderWallet
//
//  Created by YESDesk-144 on 29/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "HudView.h"


@interface SettingCountryCurrency : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDataSource,UITableViewDelegate>{
	
  
//	 UITableView *tableSettingCountryCurrency;
     HudView *aHUD;
//    
//    UILabel *countryLabel,*currencyLabel;
//    
//	NSMutableArray *resultArray,*cardReferenceArray;
//    
//	UIView *TempViewForCountryPicker;
//	UIPickerView *countryPicker,*currencyPicker,*settingurlPicker;
//	
//	UIImageView *datePickerTopBorder,*datePickerBottomBorder,*datePickerLeftBorder,*datePickerRightBorder;
//	
//	NSMutableArray *currencyNameList,*getCountryName,*getCountryCode;
//	NSMutableArray *currencyList,*getCountryList;
//	NSMutableArray *currencyCodeList,*currencyAlphaCodeList;
//	NSString *countryPickerValue,*currencyPickerValue;
//	NSMutableDictionary *settingsDictionary;
//	int selectRow;
//    
//	NSString *currencyCode;
// 	UIButton *pickerDoneButton;
//	BOOL isCountry,isCurrency,isCountryMoveUp,isPickerMoveUp;
//	NSMutableArray *discCouponValidityArray;
//	NSString *setCounryCode,*setCurrencyCode,*setCurrencyAlphaCode;
    
    UIImageView *imgBottomImage;
    UIImageView *imgOnline;
    
    
    BOOL isPushFromLogin;
    
    
    //------------- array for results ------------
    NSMutableArray *arrayCountryList;
    NSMutableArray *arrayCurrencyList;
    NSMutableArray *arrayURL;
    NSMutableArray *arrayPickerList;
    
    //--------------------------------------------
    
    UITableView *tableSettingCountryCurrency;
    
    //------------ PickerView --------------------

    UIView *viewPicker;
    UIImageView *imgPickerBorder;
    UIImageView *imgPickerBack;
    UIPickerView *pickerList;
    UIButton *btnClosePicker;
    UIButton *btnDonePicker;
    
    //--------------------------------------------

    
    
    //------------- UILABELS----------------
    
    UILabel *lblSettingCountry;
    UILabel *lblSettingCurrency;
    UILabel *lblSettingURL;
    
    //--------------------------------------
    
    int selectedSection;
    
    
}
@property(atomic)BOOL isPushFromLogin;

@property(nonatomic,strong)IBOutlet     UITableView *tableSettingCountryCurrency;


@property(strong,nonatomic)IBOutlet UIImageView *imgBottomImage;
@property(strong,nonatomic)IBOutlet UIImageView *imgOnline;



- (void)showHUD:(NSString*)message;
- (void) killHUD;



@end
