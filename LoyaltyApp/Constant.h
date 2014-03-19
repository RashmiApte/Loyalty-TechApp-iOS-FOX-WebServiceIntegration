//
//  Constant.h
//  YesPayCardHolderWallet
//
//  Created by Nirmal Patidar on 18/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Set the table view properties

//These two is for dark blue
//#define TableViewCellColor [UIColor colorWithRed:0.07 green:0.13 blue:0.26 alpha:0.50]
//#define TableViewCellColor2 [UIColor colorWithRed:0.07 green:0.13 blue:0.26 alpha:0.50]
#define TableViewCellColor [UIColor clearColor]
#define TableViewCellColor2 [UIColor clearColor]

//These Two is for Blue
//#define TableViewCellColor [UIColor colorWithRed:0.16 green:0.68 blue:0.94 alpha:0.50]
//#define TableViewCellColor2 [UIColor colorWithRed:0.16 green:0.68 blue:0.94 alpha:0.50]

// These two is for orange
//#define TableViewCellColor [UIColor colorWithRed:0.98 green:0.49 blue:0.06 alpha:0.34]
//#define TableViewCellColor2 [UIColor colorWithRed:0.98 green:0.49 blue:0.06 alpha:0.34]

// These two is for Black
//#define TableViewCellColor [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:0.34]
//#define TableViewCellColor2 [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:0.34]

#define TableViewCellSeperatorColor [UIColor clearColor]
#define cellHeightForDoubleLabel 59
#define cellHeightForSingleLabel 43
#define cellHeightForGroupedTable 45
#define tableHeaderHeight 40
#define HeaderTextColor [UIColor blackColor]
#define HeaderTextShadowColor [UIColor blackColor]
#define HeaderTextFontSize [UIFont boldSystemFontOfSize:16]
#define TextfieldErrorColor [UIColor redColor]

//#define TableViewCellSeperatorColor [UIColor colorWithRed:0.35 green:0.68 blue:0.90 alpha:0.5]

//End of table view

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Set the Lable Properties
#define staticFirstLabelFont [UIFont fontWithName:@"Helvetica" size:14]
#define staticFirstLabelFontSize [UIFont boldSystemFontOfSize:14]
#define staticFirstLabelFontColor [UIColor blackColor]
#define firstLabelFont [UIFont fontWithName:@"Helvetica" size:16]
#define firstLabelFontSize [UIFont boldSystemFontOfSize:16]
#define firstLabelFontColor [UIColor grayColor]

#define secondLabelFont [UIFont fontWithName:@"Helvetica" size:15]
#define secondLabelFontSize [UIFont boldSystemFontOfSize:15]
#define secondLabelFontColor [UIColor grayColor]

//End of Label Properties

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Set Text Field Properties



//End Text Field Properties

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Set Card Properties

#define ExpiredCardColor [UIColor colorWithRed:0.6 green:0.60 blue:0.53 alpha:0.7]
#define ExpiredCardNumberColor [UIColor redColor]

//End Of Card Properties

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define SecondLabelColor [UIColor grayColor]


#define commonFontAndSize [UIFont fontWithName:@"Helvetica" size:16]
#define commonFontSize [UIFont boldSystemFontOfSize:16]
#define commonTextColor [UIColor blackColor]
#define commonSecondTextColor [UIColor colorWithblack:1.0 alpha:0.65]

#define NavigationColor [UIColor blackColor]
//#define NavigationColor [UIColor colorWithRed:0.56 green:0.80 blue:0.89 alpha:1.0]
#define NavigationButtonTitleColor [UIColor colorWithRed:0.05 green:0.31 blue:0.50 alpha:1.0]

//#define TableViewCellColor [UIColor colorWithRed:0.35 green:0.68 blue:0.90 alpha:0.7]
//#define TableViewCellColor2 [UIColor colorWithRed:0.35 green:0.68 blue:0.90 alpha:0.4]

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define ConnectionErrorMessage @"Internet Connection is not found please check Internet Connection first."
#define ConnectionErrorTitle @"Connection Error"

////////////////////////////////////////////////////////////////////////////


//Added by Ankit jain 21/nov/2013 for lable color and font.
#define  labelmediumFont  @"FoundersGrotesk-Medium"
#define  labelregularFont  @"FoundersGrotesk-Regular"
#define  labeltextColor [UIColor colorWithRed:(62/255.f) green:(69/255.f) blue:(73/255.f) alpha:1.0f]
#define  btntextColor   [UIColor colorWithRed:(255/255.f) green:(255/255.f) blue:(255/255.f) alpha:1.0f]
#define  headertitletextColor [UIColor colorWithRed:(39/255.f) green:(73/255.f) blue:(141/255.f) alpha:1.0f]
//for placeholdertextcolor
#define placeholdertexfield [UIColor colorWithRed:163/255.0 green:165/255.0 blue:168/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"
//Added by Ankit jain 22/nov/2013for Textfield textcolor
#define textFieldTextColor [UIColor colorWithRed:(38/255.f) green:(35/255.f) blue:(36/255.f) alpha:1.0f]
#define textFieldnewTextFont UIFont fontWithName:labelregularFont size:(15)
#define textFieldTextFont [UIFont fontWithName:@"Helvetica" size:16]
#define textFieldnoneditableColor [UIColor colorWithRed:163/255.0 green:165/255.0 blue:168/255.0 alpha:1.0]

//-----------------ajit added ------------------

#define lableVirtualTabSelected [UIColor colorWithRed:(40/255.f) green:(74/255.f) blue:(142/255.f) alpha:1.0f];
#define lableVirtualTabNonSelected [UIColor colorWithRed:(69/255.f) green:(78/255.f) blue:(87/255.f) alpha:1.0f];
#define lableVirtualCardScoreNonSelected [UIColor colorWithRed:(96/255.f) green:(99/255.f) blue:(102/255.f) alpha:1.0f];
#define lableVirtualCardScoreSelected [UIColor colorWithRed:(255/255.f) green:(255/255.f) blue:(255/255.f) alpha:1.0f];
#define labelTransactionListTitle [UIColor colorWithRed:(60/255.f) green:(64/255.f) blue:(71/255.f) alpha:1.0f];
#define labelTransactionListSubTitle [UIColor colorWithRed:(145/255.f) green:(145/255.f) blue:(145/255.f) alpha:1.0f];
#define labelAlertBackGround [UIColor colorWithRed:(67/255.f) green:(189/255.f) blue:(190/255.f) alpha:1.0f];


//to check iOS version system---------------------------------
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending

//---------------------Alert constant Added by ANkit Jain 3 Dec 2013.

//signupAlert

extern NSString* const Unabletosignuptitle;
extern NSString* const passwordminimunlegnth;
extern NSString* const alphanumericvalueinPWd;

extern NSString* const passwordAtleastOneCaps;

extern NSString* const validemailid;
extern NSString* const specialcharacterpwd;
extern NSString* const firstnameentr;
extern NSString* const lastnameentr;
extern NSString* const emailentr;
extern NSString* const bothpwdsame;
extern NSString* const enterCvv;
extern NSString* const entercardnumber;
extern NSString* const entercardname;
extern NSString* const enterpwd;
extern NSString* const reenterpwd;
extern NSString* const enterpostcode;
extern NSString* const enterstreetAdd1;
extern NSString* const secondryemail;
extern NSString* const expirydate;
extern NSString* const unablecurrencylist;
extern NSString* const Unablecountrylist;
extern NSString* const successfullyregistered;

//network connection
extern NSString* const networkconnectiontitle;
extern NSString* const networkconnectionmessage;

//Cardholder Alert
extern NSString* const statuscode1;
extern NSString* const statuscode3;
extern NSString* const statuscode4;
extern NSString* const statuscode6;
extern NSString* const statuscode7;
extern NSString* const statuscode9;
extern NSString* const statuscode12;
extern NSString* const statuscode15;
extern NSString* const statuscode16;
extern NSString* const statuscode17;
extern NSString* const statuscode18;
extern NSString* const statuscode21;
extern NSString* const statuscode27;
extern NSString* const statuscode30;
extern NSString* const statuscode33;

//Add newcard
extern NSString* const unabletoaddnewcard;
extern NSString* const successfullyaddcard;
extern NSString* const cardholdername;
extern NSString* const invalideemail;
//UPdatecaard

extern NSString* const unabletoupdatecard;
extern NSString* const succesfulyupdate;

//updatedelivery Address
extern NSString* const entercity;
extern NSString* const enterstreet;
extern NSString* const entercountry;
extern NSString* const deliveryaddressupdatesuccessfully;
//pwd
extern NSString* const enternewpwd;
extern NSString* const enteroldpwd;
extern NSString* const reenternewpwd;
extern NSString* const pwdupdatesuccessfully;
extern NSString* const Cardnumberlegnth;
extern NSString* const Invalidecardnumber;


//virtualcard
extern NSString* const cardcanbeactiveonemonth;
extern NSString* const successfullycreated;
extern NSString* const enteramountforvirtualcard;
extern NSString* const amountlegnthlessthan9digit;
extern NSString* const entervirtualcardname;

//ResetPwd
extern NSString* const pleaseenterregisteremail;
extern NSString* const newpwdhassendto;
extern NSString* const alphanumericvalueinalphabet;

//Loginscreen
extern NSString* const alreadyloginalert;
extern NSString* const unknownuserid;
extern NSString* const entercorrectidpwd;
extern NSString* const unabletologinntitle;

//problem occuring atserver
extern NSString* const problemoccuratserver;
extern NSString* const internetconnectionrequired;
extern NSString* const networkconnectiontitle;
// hud alerts
extern NSString* const dataupdatinghud;
extern NSString* const loginhud;
extern NSString* const sighnuphud;
extern NSString* const logouthud;
extern NSString* const deletecardhud;
extern NSString* const activatingcardhud;
extern NSString* const supendcardhud;
extern NSString* const loadingaything;
extern NSString* const generatingcard;
extern NSString* const transferringardhud;

// session expired Alert
extern NSString* const sessionexpired;
//MYcardoperation
extern NSString* const cardwillsuspend;
extern NSString* const cardwilldelete;
extern NSString* const createvirtualcardfornonactivecard;
extern NSString* const successfullysuspend;
extern NSString* const successfullyreactivated;
extern NSString* const successfullydeleted;
extern NSString* const cardwillreactivated;
extern NSString* const cardwilltransferred;
//logout
extern NSString* const logoutalert;

//setting country and currency
extern NSString* const countrycurrencysuccessfullysert;
extern NSString* const successfullyTransfer;

extern NSString *const startEndDateValidation;
extern NSString *const setStartEndDate;
extern NSString* const selctvalidexpirydate;
extern NSString* const transferredvirtualcard;






































