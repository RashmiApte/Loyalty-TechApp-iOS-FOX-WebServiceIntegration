/*
 *
 * Copyright -Year _Company Name_.  All rights reserved.
 *
 * File Name       : UpdateUserInfoViewController.m
 *
 * Created Date    : 04/05/10
 *
 * Description     :
 *
 * Modification History:
 *
 * Date            Name                Description
 * ------------------------------------------------
 * 04/05/10	   Nirmal Patidar
 * 02/08/13    Rashmi Jati Apte     initWithFrame:reuseIdentifier: is deprecated in iOS 3.0. Replaced it                          with initWithStyle:reuseIdentifier:
 *
 * Bug History:
 *
 * Date            Id                Description
 * ------------------------------------------------
 *
 */

#import "UpdateUserInfoViewController.h"
#import "CAppDelegate.h"
#import "Constant.h"
#import "DataBase.h"
#import "UserInfoData.h"
#import "Common.h"
#import "WebserviceOperation.h"
#import "YPUserInfoRequest.h"
#import "YPUserInfoResponse.h"
#import "YPUpdateUserInfoRequest.h"
#import "YPUpdateUserInfoResponse.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"




#define kOFFSET_FOR_KEYBOARD 50.0

#define kNumPadReturnButtonTag 500

@implementation UpdateUserInfoViewController
@synthesize tableUpdateUserInfo;
@synthesize pickerbgimage;
@synthesize holdertextfield;
@synthesize btnShowPicker;
@synthesize btnShowcountryPicker;
@synthesize btnShowgenderPicker;
@synthesize pickertransperntimg;
@synthesize imgOnline;
@synthesize headertitle;
@synthesize fnamlbl,lnamelbl,mobilelbl,emailibl,sexlbl,mnamelbl,addresslbl1,addresslbl2,citylbl,regionlbl,postcodelbl,countrylbl,dateofbirthlbl;
@synthesize cancelbtnstr,lblBackAlertTitle;


UIButton *doneButton;
BOOL isViewMoveUp;
BOOL isPickerMoveUp;
BOOL isSex;
BOOL isProcess;
BOOL isCountry;
#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    headertitle=@"Enter Details";
	isProcess=NO;
	isCountry=NO;
	if([Common isNetworkAvailable])
	{
        imgOnline.image=[UIImage imageNamed:@"online.png"];
	}
	else {
        imgOnline.image=[UIImage imageNamed:@"offline.png"];
	}
	appDelegate =(CAppDelegate*) [[UIApplication sharedApplication] delegate];
	isSex=NO;
	[self setTextFieldChangeValue];
	[tableUpdateUserInfo setBackgroundColor:[UIColor clearColor]];
	[tableUpdateUserInfo setSeparatorColor:TableViewCellSeperatorColor];
   	
    CGFloat navBarHeight = 50.0f;
	CGRect frame = CGRectMake(0.0f, 20.0f, 320.0f, navBarHeight);
	[self.navigationController.navigationBar setFrame:frame];
    
    //----------------------------------------------------------------
    
    arrayGenderPicker=[[NSMutableArray alloc] initWithObjects:@"Male",@"Female",nil];
    getCountryName = [[NSMutableArray alloc] init];
	getCountryCode = [[NSMutableArray alloc] init];
	getCountryList = [[NSMutableArray alloc] init];
    //----------------------------------------------------------------
    
    
    //---------------------- set delegate to textfield -------------------------
    
    [fNameText setDelegate:self];
    [mNameText setDelegate:self];
    [lNameText setDelegate:self];
    [dateOfBirthText setDelegate:self];
    [sexText setDelegate:self];
    [addressText1 setDelegate:self];
    [addressText2 setDelegate:self];
    [CityText setDelegate:self];
    [RegionText setDelegate:self];
    [countryText setDelegate:self];
    [PostCodeText setDelegate:self];
    [mobileText setDelegate:self];
    [emailText setDelegate:self];
    
    //--------------------------------------------------------------------------
    
    //----------- set frames ----------------------------------------
    
    //Added by Ankit jain 12 /nov/2013
    CGRect textfieldframe=CGRectMake(3,7,283,36);
    //CGRectMake(32,7, 210, 25)
    
	fNameText = [[UITextField alloc] initWithFrame:textfieldframe];
	lNameText = [[UITextField alloc] initWithFrame:textfieldframe];
	mobileText = [[UITextField alloc] initWithFrame:textfieldframe];
	emailText = [[UITextField alloc] initWithFrame:textfieldframe];
	sexText = [[UITextField alloc] initWithFrame:textfieldframe];
	dateOfBirthText = [[UITextField alloc] initWithFrame:textfieldframe];
	mNameText = [[UITextField alloc] initWithFrame:textfieldframe];
	addressText1 = [[UITextField alloc] initWithFrame:textfieldframe];
	addressText2 = [[UITextField alloc] initWithFrame:textfieldframe];
	CityText = [[UITextField alloc] initWithFrame:textfieldframe];
	RegionText = [[UITextField alloc] initWithFrame:textfieldframe];
	PostCodeText = [[UITextField alloc] initWithFrame:textfieldframe];
    countryText = [[UITextField alloc] initWithFrame:textfieldframe];
    holdertextfield=[[UITextField alloc]initWithFrame:textfieldframe];
    btnShowPicker=[UIButton buttonWithType:UIButtonTypeCustom];
    btnShowPicker.frame=textfieldframe;
    btnShowcountryPicker=[UIButton buttonWithType:UIButtonTypeCustom];
    btnShowcountryPicker.frame=textfieldframe;
    btnShowgenderPicker=[UIButton buttonWithType:UIButtonTypeCustom];
    btnShowgenderPicker.frame=textfieldframe;
    
    //----------------------------------------------------------------
    
	
    
    
    //----------------------------------------------------------------
    [sexText setBackgroundColor:[UIColor clearColor]];
	[sexText setTextColor:[UIColor lightGrayColor]];
	[dateOfBirthText setBackgroundColor:[UIColor clearColor]];
	[dateOfBirthText setTextColor:[UIColor lightGrayColor]];
  	[countryText setTextColor:[UIColor blackColor]];
	[countryText setBackgroundColor:[UIColor clearColor]];
    //----------------------------------------------------------------
    
    
    setCounCodeSetting=[[NSString alloc] init];
    
	setTextcountryLabel= [[NSUserDefaults standardUserDefaults] objectForKey:@"CountrySetting"];
	setCounCodeSetting= [[NSUserDefaults standardUserDefaults] objectForKey:@"CountryCodeSetting"];
    isViewMoveUp = YES;
	isPickerMoveUp = YES;
    
    //----------------------------------------------------------------
	TempViewForDatePicker = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 250)];
	[TempViewForDatePicker setBackgroundColor:[UIColor clearColor]];
    //added by Ankit jain 25/oct/2013.
    self.pickertransperntimg=[[UIImageView alloc]initWithFrame:CGRectMake(0,30, 320, 210)];
	self.pickerbgimage=[[UIImageView alloc]initWithFrame:CGRectMake(0,30, 320, 210)];
    self.pickerbgimage.image=[UIImage imageNamed:@"calendar_bg.png"];
    self.pickertransperntimg.image=[UIImage imageNamed:@"background_white.png"];
    [TempViewForDatePicker addSubview:self.pickertransperntimg];
    [TempViewForDatePicker addSubview:self.pickerbgimage];
    
    
    datePicker=[[UIDatePicker alloc] init];
	datePicker.datePickerMode=UIDatePickerModeDate;
	datePicker.center=CGPointMake(160.0,138);
    //----------------------------------------------------------------
    
    //--------------------SetFrameForIphone4AndIphone5-----------------
    
    if ([UIScreen mainScreen].bounds.size.height==568) {
        
        imgOnline.frame=CGRectMake(273,525, 42, 9);
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
            TempViewForDatePicker.center=CGPointMake(160.0,435);
        }
        else{
            TempViewForDatePicker.center=CGPointMake(160.0,455);
        }
    }
    else{
        imgOnline.frame=CGRectMake(260, 445, 42, 9);

        TempViewForDatePicker.center=CGPointMake(160.0,360.0);
    }
    //----------------------------------------------------------------
	countryPicker.hidden=YES;
	datePicker.hidden=YES;
	[TempViewForDatePicker setHidden:YES];
	dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"dd/MM/yyyy"];
	if([resultArray count] > 0)
	{
		dateOfBirthText.text = ((UserInfoData*)[resultArray objectAtIndex:0]).dob;
	}
    //--------------------- Update button ---------------------------
	UIButton *btnSubmit =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSubmit setBackgroundImage:[UIImage imageNamed:@"button_home_60_29.png"] forState:UIControlStateNormal];
	//[btnSubmit setImage:[UIImage imageNamed:@"submit.png"] forState:UIControlStateNormal];
	[btnSubmit addTarget:self action:@selector(UpdateUserInfo:) forControlEvents:UIControlEventTouchUpInside];
    [btnSubmit setTitle:@"Edit" forState:UIControlStateNormal];
	[btnSubmit setFrame:CGRectMake(253,7,60,29)];//0, 0, 76, 44
    btnSubmit.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(14.0)];
    [btnSubmit.titleLabel setTextColor:btntextColor];
    //----------------------------------------------------------------
    
    
    //--------------------- Design heder of This screen ----------------------------
    CGRect re= CGRectMake(0, 0, 320, 53);
    UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_back.png"]];//create_new_ac_back.png
    UILabel *lbl =[[UILabel alloc]init];
    CGRect lblrect= CGRectMake(80, 8, 180, 23);// 73, 10, 142, 23
    lbl.frame=lblrect;
    lbl.text=@"Consumer Profile";
    [lbl setTextColor:headertitletextColor];
    lbl.font = [UIFont fontWithName:labelregularFont size:(22.0)];
    lbl.backgroundColor=[UIColor clearColor];
    [img addSubview:lbl];
    img.frame=re;
    [self.view addSubview:img];
    [img addSubview:lbl];
    //[self.view addSubview:btnBack];
    [self.view addSubview:btnSubmit];
    //------------------------------------------------------------------------------
    
    
    //----------------------------Drawerleftbutn-Added by Ankit jain 3 Mar 2014----------------------
    
    btndrawerleft = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btndrawerleft.frame = CGRectMake(15,5,32, 32);
    btndrawerleft.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [btndrawerleft addTarget:self action:@selector(_addRightTapped:) forControlEvents:UIControlEventTouchUpInside];
    [btndrawerleft setBackgroundImage:[UIImage imageNamed:@"drawer.png"] forState:UIControlStateNormal];
    [self.view addSubview:btndrawerleft];
	//-------------------------------------------------------------------------------
    

    
    //------------------- Fatch userinfo  ------------------
    
    
    if([Common isNetworkAvailable] )
    {
        //  [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isNewSessionUserInfo"];
        [self showHUD:loadingaything];
        
        WebserviceOperation *serviceGetuserinfo=[[WebserviceOperation alloc] initWithDelegate:self callback:@selector(getUserInfoHandler:)];
        
        YPUserInfoRequest *userInfoRequest = [[YPUserInfoRequest alloc] init];
      
        userInfoRequest.SC = appDelegate.SC;
        userInfoRequest.userName = appDelegate.userName;
        userInfoRequest.valid = TRUE;
        
        self.lblBackAlertTitle.hidden=YES;
        [serviceGetuserinfo getUserInfo:userInfoRequest];
        
    }
    else
    {
        if([DataBase getNumberOfRows:@"UserInfo"] > 0)
        {
            NSString *query = @"Select * from UserInfo where userid = ";
            query = [query stringByAppendingString:appDelegate.userID];
            NSMutableArray *temp=[DataBase getUserInfoTableData:query];
            resultArray = [[NSMutableArray alloc] init];
            for (int i=0;i< [temp count]; i++)
            {
                [resultArray addObject:[temp objectAtIndex:i]];
            }
            
            if (resultArray.count==0)
            {
                self.lblBackAlertTitle.hidden=YES;
                self.tableUpdateUserInfo.hidden=YES;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:networkconnectiontitle message:networkconnectionmessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert setTag:111];
                [alert show];
            }
            else
            {
                [self.tableUpdateUserInfo reloadData];
                self.lblBackAlertTitle.hidden=YES;
                self.tableUpdateUserInfo.hidden=NO;
            }
        }
        else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:networkconnectiontitle message:networkconnectionmessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert setTag:111];
            [alert show];
            // self.lblBackAlertTitle.hidden=YES;
            //self.tableUpdateUserInfo.hidden=YES;
        }
    }
    //----------------------------------------------------------
    fnamlbl=[[UILabel alloc] initWithFrame:CGRectMake(8,6,110, 36)];
    lnamelbl=[[UILabel alloc] initWithFrame:CGRectMake(8,6,110, 36)];
    mobilelbl=[[UILabel alloc] initWithFrame:CGRectMake(8,6,110, 36)];
    emailibl=[[UILabel alloc] initWithFrame:CGRectMake(8,6,110, 36)];
    sexlbl=[[UILabel alloc] initWithFrame:CGRectMake(8,6,110, 36)];
    mnamelbl=[[UILabel alloc] initWithFrame:CGRectMake(8,6,110, 36)];
    addresslbl1=[[UILabel alloc] initWithFrame:CGRectMake(8,6,110, 36)];
    addresslbl2=[[UILabel alloc] initWithFrame:CGRectMake(8,6,110, 36)];
    citylbl=[[UILabel alloc] initWithFrame:CGRectMake(8,6,110, 36)];
    regionlbl=[[UILabel alloc] initWithFrame:CGRectMake(8,6,110, 36)];
    postcodelbl=[[UILabel alloc] initWithFrame:CGRectMake(8,6,110, 36)];
    countrylbl=[[UILabel alloc] initWithFrame:CGRectMake(8,6,110, 36)];
    dateofbirthlbl=[[UILabel alloc] initWithFrame:CGRectMake(8,6,110, 36)];
    
    
    
    fnamlbl.text = @"First Name *:";
    mnamelbl.text = @"Middle Name:";
    lnamelbl.text = @"Last Name *:";
    dateofbirthlbl.text=@"DOB:";
    sexlbl.text=@"Gender:";
    addresslbl1.text =@"Street Address 1 *:";
    addresslbl2.text =@"Street Address 2:";
    citylbl.text =@"City:";
    regionlbl.text =@"Region:";
    postcodelbl.text =@"Post Code *:";
    countrylbl.text=@"Country:";
    mobilelbl.text =@"Mobile Number:";
    emailibl.text =@"Email Address:";
    
    
    fNameText.userInteractionEnabled=NO;
    lNameText.userInteractionEnabled=NO;
    mobileText.userInteractionEnabled=NO;
    emailText.userInteractionEnabled=NO;
    sexText.userInteractionEnabled=NO;
    mNameText.userInteractionEnabled=NO;
    addressText1.userInteractionEnabled=NO;
    addressText2.userInteractionEnabled=NO;
    CityText.userInteractionEnabled=NO;
    RegionText.userInteractionEnabled=NO;
    PostCodeText.userInteractionEnabled=NO;
    countryText.userInteractionEnabled=NO;
    holdertextfield.userInteractionEnabled=NO;
    countryText.userInteractionEnabled=NO;
    btnShowPicker.userInteractionEnabled=NO;
    dateOfBirthText.userInteractionEnabled=NO;
    btnShowcountryPicker.userInteractionEnabled=NO;
    btnShowgenderPicker.userInteractionEnabled=NO;
    
    [self lablefontcolor:[textFieldnewTextFont] lbltextcolor:textFieldnoneditableColor];
    [self changetextfieldtextcolor:textFieldnoneditableColor];
    headertitle=@"View Details";
    
    
    
}

//Added by Ankit jain 10 Dec 2013.
-(void)lablefontcolor:(UIFont*)lblfont lbltextcolor:(UIColor*)lbltxtcolor
{
    fnamlbl.font=lblfont;
    fnamlbl.textColor=lbltxtcolor;
    fnamlbl.backgroundColor=[UIColor clearColor];
    
    mnamelbl.font=lblfont;
    mnamelbl.textColor=lbltxtcolor;
    mnamelbl.backgroundColor=[UIColor clearColor];
    
    lnamelbl.font=lblfont;
    lnamelbl.textColor=lbltxtcolor;
    lnamelbl.backgroundColor=[UIColor clearColor];
    
    dateofbirthlbl.font=lblfont;
    dateofbirthlbl.textColor=lbltxtcolor;
    dateofbirthlbl.backgroundColor=[UIColor clearColor];
    
    sexlbl.font=lblfont;
    sexlbl.textColor=lbltxtcolor;
    sexlbl.backgroundColor=[UIColor clearColor];
    
    mobilelbl.font=lblfont;
    mobilelbl.textColor=lbltxtcolor;
    mobilelbl.backgroundColor=[UIColor clearColor];
    
    addresslbl1.font=lblfont;
    addresslbl1.textColor=lbltxtcolor;
    addresslbl1.backgroundColor=[UIColor clearColor];
    
    addresslbl2.font=lblfont;
    addresslbl2.textColor=lbltxtcolor;
    addresslbl2.backgroundColor=[UIColor clearColor];
    
    citylbl.font=lblfont;
    citylbl.textColor=lbltxtcolor;
    citylbl.backgroundColor=[UIColor clearColor];
    
    regionlbl.font=lblfont;
    regionlbl.textColor=lbltxtcolor;
    regionlbl.backgroundColor=[UIColor clearColor];
    
    postcodelbl.font=lblfont;
    postcodelbl.textColor=lbltxtcolor;
    postcodelbl.backgroundColor=[UIColor clearColor];
    
    countrylbl.font=lblfont;
    countrylbl.textColor=lbltxtcolor;
    countrylbl.backgroundColor=[UIColor clearColor];
    
    
    mobilelbl.font=lblfont;
    mobilelbl.textColor=lbltxtcolor;
    mobilelbl.backgroundColor=[UIColor clearColor];
    
    emailibl.font=lblfont;
    emailibl.textColor=lbltxtcolor;
    emailibl.backgroundColor=[UIColor clearColor];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    if([Common isNetworkAvailable])
    {
        imgOnline.image=[UIImage imageNamed:@"online.png"];
    }
    else {
        imgOnline.image=[UIImage imageNamed:@"offline.png"];
    }
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
												 name:UIKeyboardWillShowNotification object:self.view.window];
	
	getCountryList = [DataBase getAllCountryList];
	NSString *name;
	NSString *code;
	for (int i=0;i<[getCountryList count]; i++) {
		NSLog(@"ViewDidLoad.....GetCountryList..... %d",[getCountryList count]);
		settingsDictionary = [getCountryList objectAtIndex:i];
		name = [settingsDictionary objectForKey:@"countryName"];
		code = [settingsDictionary objectForKey:@"countryCode"];
		
		[getCountryName addObject:name];
		[getCountryCode addObject:code];
		NSLog(@"Sign UP Picker value Country Name..... %@",name);
		//noCountryList=NO;
	}
	
	countryPicker=[[UIPickerView alloc] init];
	countryPicker.center=CGPointMake(170.0,143.0);
	countryPicker.delegate = self;
    countryPicker.dataSource = self;
	countryPicker.showsSelectionIndicator=YES;
    genderPicker=[[UIPickerView alloc] init];
	genderPicker.center=CGPointMake(170.0,143.0);
	genderPicker.delegate = self;
    genderPicker.dataSource = self;
	genderPicker.showsSelectionIndicator=YES;
    
    
	
}

-(void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	TempViewForDatePicker.hidden = YES;
	datePicker.hidden =YES;
	countryPicker.hidden =YES;
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)viewDidAppear:(BOOL)animated
{
	CGFloat navBarHeight = 50.0f;
	CGRect frame = CGRectMake(0.0f, 20.0f, 320.0f, navBarHeight);
	[self.navigationController.navigationBar setFrame:frame];
	[super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	
}



#pragma mark - Pickerview delegate -------------------

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
	return 1;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView==genderPicker) {
        return  [arrayGenderPicker count];
        
    }
    else{
        return[getCountryName count];
    }
}


//Added by ANkit Jain 29/oct/2013 for set picker alighnment in ios 7

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 37)];
    label.textAlignment = UITextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    if (pickerView==genderPicker)
    {
        label.text =[arrayGenderPicker objectAtIndex:row];
    }
    else
    {
        label.text =[getCountryName objectAtIndex:row];
    }
    
	
    return label;
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	
    if (thePickerView==genderPicker) {
        
        selectRowGender=row;
        
    }
    else{
        pickerValue=[getCountryName objectAtIndex:row];
        selectRow=row;
        NSLog(@"Select Rowwwwwww %@",pickerValue);
    }
}



#pragma mark Other Functions -------------------
//Added by Ankit Jain 27/nov/2013
-(void)changetextfieldtextcolor:(UIColor *)textcolor
{
    
    [fNameText setTextColor:textcolor];
    [mNameText setTextColor:textcolor];
    [lNameText setTextColor:textcolor];
    [dateOfBirthText setTextColor:textcolor];
    [sexText setTextColor:textcolor];
    [addressText1 setTextColor:textcolor];
    [addressText2 setTextColor:textcolor];
    [CityText setTextColor:textcolor];
    [RegionText setTextColor:textcolor];
    [countryText setTextColor:textcolor];
    [PostCodeText setTextColor:textcolor];
    [mobileText setTextColor:textcolor];
    [emailText setTextColor:textcolor];
    
}

-(void)setTextFieldChangeValue
{
	isFirstNameChange = NO;
	isMiddleNameChange = NO;
	isLastNameChange = NO;
	isDOBChange = NO;
	isSexChange = NO;
	isAddress1Change = NO;
	isAddress2Change = NO;
	isCityChange = NO;
	isCountryChange = NO;
	isRegionChange = NO;
	isFirstNameChange = NO;
	isPostCodeChange = NO;
	isMobileChange = NO;
	isEmailChange = NO;
}

//Handles the Response of getUserInfoRequest
-(void)getUserInfoHandler:(id) value
{
    [self killHUD];
    
	
    
    // Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
		return;
	}
	
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
		return;
	}
     
    
	// Do something with the YPLoginResponse* result
	
    YPUserInfoResponse *userInfoResponse=[[YPUserInfoResponse alloc] init];
    
    [userInfoResponse parsingUserInfo:value];
    
    
    
    NSLog(@"================ status code = %d",userInfoResponse.statusCode);
	if(userInfoResponse.statusCode == 0)
	{
        NSString *strFetch=[NSString stringWithFormat:@"select * from UserInfo where userid = '%@'",appDelegate.userID];
        NSMutableArray *arrayUserInfo=[DataBase getUserInfoTableData:strFetch];
        
        
        if (arrayUserInfo.count>0) {
            NSString *deleteQuery = @"Delete from UserInfo where userid = ";
            deleteQuery = [deleteQuery stringByAppendingString:[NSString stringWithFormat:@"%@",appDelegate.userID]];
            [DataBase deleteDataFromTable:deleteQuery];
        }
        
		
		NSString *insertQuery = @"Insert into UserInfo(firstname,lastname,userid";
		NSString *insertQueryValues = @" values(";
		insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@"'%@','%@',%@",userInfoResponse.firstName,userInfoResponse.lastName,appDelegate.userID]];
		
		if(![userInfoResponse.middleName isEqualToString:@"(null)"])
		{
			insertQuery = [insertQuery stringByAppendingString:@",middlename"];
			insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",'%@'",userInfoResponse.middleName]];
		}
		if(![userInfoResponse.streetAddress1 isEqualToString:@"(null)"])
		{
			insertQuery = [insertQuery stringByAppendingString:@",address1"];
			insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",'%@'",userInfoResponse.streetAddress1]];
		}
		if(![userInfoResponse.streetAddress2 isEqualToString:@"(null)"])
		{
			insertQuery = [insertQuery stringByAppendingString:@",address2"];
			insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",'%@'",userInfoResponse.streetAddress2]];
		}
		if(![userInfoResponse.city isEqualToString:@"(null)"])
		{
			insertQuery = [insertQuery stringByAppendingString:@",city"];
			insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",'%@'",userInfoResponse.city]];
		}
		if(![userInfoResponse.country isEqualToString:@"(null)"])
		{
			insertQuery = [insertQuery stringByAppendingString:@",country"];
			insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",'%@'",userInfoResponse.country]];
		}
		if(![userInfoResponse.region isEqualToString:@"(null)"])
		{
			insertQuery = [insertQuery stringByAppendingString:@",region"];
			insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",'%@'",userInfoResponse.region]];
		}
		if(![userInfoResponse.postCode isEqualToString:@"(null)"])
		{
			insertQuery = [insertQuery stringByAppendingString:@",postcode"];
			insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",'%@'",userInfoResponse.postCode]];
		}
		if(![userInfoResponse.mobilePhoneNumber isEqualToString:@"(null)"])
		{
			insertQuery = [insertQuery stringByAppendingString:@",mobilenumber"];
			insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",'%@'",userInfoResponse.mobilePhoneNumber]];
		}
		if(![userInfoResponse.emailAddress isEqualToString:@"(null)"])
		{
			insertQuery = [insertQuery stringByAppendingString:@",emailid"];
			insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",'%@'",userInfoResponse.emailAddress]];
		}
		if(![userInfoResponse.sex isEqualToString:@"(null)"])
		{
			NSLog(@"result sexxxxx");
			insertQuery = [insertQuery stringByAppendingString:@",sex"];
			insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",'%@'",userInfoResponse.sex]];
		}
		if(![userInfoResponse.DOB length]<1)
		{
			NSMutableString *startDate = [NSMutableString stringWithFormat:@"%@",userInfoResponse.DOB];
			[startDate insertString:@"/" atIndex:2];
			[startDate insertString:@"/" atIndex:5];
			NSLog(@"Insert valueeeeeeeeee= %@",startDate);
			insertQuery = [insertQuery stringByAppendingString:@",dob"];
			insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",'%@'",startDate]];
		}
		insertQuery = [insertQuery stringByAppendingString:[NSString stringWithFormat:@")%@)",insertQueryValues]];
		NSLog(@"Insert Query for UserInfo is %@",insertQuery);
		[DataBase InsertIntoTable:insertQuery];
		
		NSString *query = @"Select * from UserInfo where userid = ";
		query = [query stringByAppendingString:[NSString stringWithFormat:@"%@",appDelegate.userID ]];
		NSMutableArray *temp = [DataBase getUserInfoTableData:query];
		resultArray = temp;
		[self setTextFieldChangeValue];
        //added by ajit
        PostCodeText.text = ((UserInfoData*)[resultArray objectAtIndex:0]).postcode;
        addressText1.text = ((UserInfoData*)[resultArray objectAtIndex:0]).address1;
        emailText.text=((UserInfoData*)[resultArray objectAtIndex:0]).emailid ;
        //added by ajit end
		[tableUpdateUserInfo reloadData];
        
		isProcess=NO;
	}
    else if (userInfoResponse.statusCode==7)
    {
        self.tableUpdateUserInfo.hidden=YES;
        self.lblBackAlertTitle.hidden=NO;
    }
    
	else{

        // self.lblBackAlertTitle.hidden=NO;
        // self.tableUpdateUserInfo.hidden=YES;
        [self cardholderalertmessages:userInfoResponse.statusCode message:userInfoResponse.responseMessage];
        
		
	}
    
}
-(void)cardholderalertmessages:(int)statuscodevalue message:(NSString *)responsemessage
{
    switch (statuscodevalue)
    {
        case 1:
            NSLog (@"zero");
            [self commonalert:unabletoupdatecard message:statuscode1];
            break;
        case 4:
            NSLog (@"one");
            [self commonalert:unabletoupdatecard message:statuscode4];
            break;
        case 6:
            NSLog (@"six");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SessionExpired" object:self];
            break;
        case 7:
            NSLog (@"seven");
            [self commonalert:unabletoupdatecard message:statuscode7];
            break;
        case 9:
            NSLog (@"nine");
            [self commonalert:unabletoupdatecard message:statuscode9];
            break;
        case 10:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SessionExpired" object:self];
            break;
            
        case 12:
            NSLog (@"tweleve");
            [self commonalert:unabletoupdatecard message:statuscode12];
            break;
        case 15:
            NSLog (@"fifteen");
            [self commonalert:unabletoupdatecard message:statuscode15];
            break;
        case 16:
            NSLog (@"sisxteen");
            [self commonalert:unabletoupdatecard message:statuscode16];
            break;
        case 17:
            NSLog (@"four");
            [self commonalert:unabletoupdatecard message:statuscode17];
            break;
        case 18:
            NSLog (@"five");
            [self commonalert:unabletoupdatecard message:statuscode18];
            break;
        case 21:
            NSLog (@"twenty one");
            [self commonalert:nil message:statuscode21];
            break;
        case 27:
            NSLog (@"twenty seven");
            [self commonalert:unabletoupdatecard message:statuscode27];
            break;
        case 30:
            NSLog (@"thirty");
            [self commonalert:unabletoupdatecard message:statuscode30];
            break;
        case 33:
            NSLog (@"thirty three");
            [self commonalert:unabletoupdatecard message:statuscode33];
            break;
            
        default:
            NSLog (@"Integer out of range");
            [self commonalert:unabletoupdatecard message:[NSString stringWithFormat:@"%@\n[Error code:%d]",responsemessage,statuscodevalue]];
            break;
    }
}
-(void)commonalert:(NSString *)title message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}



-(void)UpdateUserInfo:(id)sender

{
    if ([Common isNetworkAvailable]) {
        
        
        UIButton *button = (UIButton *)sender;
        NSLog(@"button title is %@",button.titleLabel.text);
        if([button.titleLabel.text isEqualToString:@"Edit"]){
            [button setTitle:@"Update" forState:UIControlStateNormal];
            fNameText.userInteractionEnabled=YES;
            lNameText.userInteractionEnabled=YES;
            mobileText.userInteractionEnabled=YES;
            emailText.userInteractionEnabled=YES;
            dateOfBirthText.userInteractionEnabled=YES;
            sexText.userInteractionEnabled=YES;
            mNameText.userInteractionEnabled=YES;
            addressText1.userInteractionEnabled=YES;
            addressText2.userInteractionEnabled=YES;
            CityText.userInteractionEnabled=YES;
            RegionText.userInteractionEnabled=YES;
            PostCodeText.userInteractionEnabled=YES;
            countryText.userInteractionEnabled=YES;
            holdertextfield.userInteractionEnabled=YES;
            countryText.userInteractionEnabled=YES;
            btnShowPicker.userInteractionEnabled=YES;
            btnShowcountryPicker.userInteractionEnabled=YES;
            btnShowgenderPicker.userInteractionEnabled=YES;
            headertitle=@"Enter Details";
            [tableUpdateUserInfo reloadData];
            [self lablefontcolor:[textFieldnewTextFont] lbltextcolor:textFieldTextColor];
            [self changetextfieldtextcolor:textFieldTextColor];
        }
        else{
            isProcess=NO;
            
            
            
            NSIndexPath *middleIndexPath;
            
            
            // ----------- new validation ------------------
            if ([fNameText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length!=0) {
                if ([lNameText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length!=0) {
                    if ([addressText1.text stringByReplacingOccurrencesOfString:@" " withString:@""].length!=0) {
                        
                        if ([PostCodeText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length!=0) {
                            
                            if ([self validateEmail:emailText.text]||[emailText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0) {
                                
                                if([Common isNetworkAvailable])
                                {
                                    [self showHUD:dataupdatinghud];
                                    
                                    WebserviceOperation *serviceUpdateUserInfo=[[WebserviceOperation alloc] initWithDelegate:self callback:@selector(updateUserInfohandlers:)];
                                    YPUpdateUserInfoRequest *updateUserInfoRequest=[[YPUpdateUserInfoRequest alloc] init];
                                    
                                    
                                    
                                  
                                    updateUserInfoRequest.SC = appDelegate.SC;
                                    updateUserInfoRequest.userName = appDelegate.userName;
                                    updateUserInfoRequest.valid =TRUE;
                                    updateUserInfoRequest.applicationType = @"M";
                                    updateUserInfoRequest.firstName = fNameText.text;
                                    updateUserInfoRequest.lastName = lNameText.text;
                                    updateUserInfoRequest.country = setCounCodeSetting;
                                    
                                    
                                    //--------- to find country code by country name ----------
                                    
                                    updateUserInfoRequest.country=setCounCodeSetting;
                                    for (int i=0; i<getCountryList.count; i++)
                                    {
                                        if ([[[getCountryList objectAtIndex:i] valueForKey:@"countryName"] isEqualToString:countryText.text]) {
                                            updateUserInfoRequest.country=[[getCountryList objectAtIndex:i] valueForKey:@"countryCode"];
                                            break;
                                        }
                                    }
                                    
                                    //---------------------------------------------------------
                                    
                                    
                                    
                                    if(mNameText.text != NULL)
                                    {
                                        updateUserInfoRequest.middleName = mNameText.text;
                                        
                                    }
                                    if([dateOfBirthText.text isEqualToString:@"Date of birth"])
                                    {
                                        dateOfBirthText.text=NULL;
                                        updateUserInfoRequest.DOB = dateOfBirthText.text;
                                    }
                                    else
                                    {
                                        updateUserInfoRequest.DOB = [dateOfBirthText.text stringByReplacingOccurrencesOfString:@"/" withString:@""];
                                    }
                                    if([sexText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0)
                                    {
                                        sexText.text=NULL;
                                        updateUserInfoRequest.sex = sexText.text;
                                        NSLog(@"nulllllllll Sent Value isssssss=> %@",sexText.text);
                                    }
                                    else
                                    {
                                        updateUserInfoRequest.sex = sexText.text;
                                        NSLog(@"Sent Value isssssss=> %@",sexText.text);
                                        
                                    }
                                    if([addressText1.text length] >0)
                                    {
                                        updateUserInfoRequest.streetAddress1 = addressText1.text;
                                        
                                    }
                                    if([addressText2.text length] >0)
                                    {
                                        updateUserInfoRequest.streetAddress2 = addressText2.text;
                                        
                                    }
                                    if([CityText.text length] >0)
                                    {
                                        updateUserInfoRequest.city = CityText.text;
                                        
                                    }
                                    if([RegionText.text length] >0)
                                    {
                                        updateUserInfoRequest.region = RegionText.text;
                                        
                                    }
                                    
                                    if([PostCodeText.text length] >0)
                                    {
                                        updateUserInfoRequest.postCode = PostCodeText.text;
                                        
                                    }
                                    if([mobileText.text length] >0)
                                    {
                                        updateUserInfoRequest.mobilePhoneNumber = mobileText.text;
                                        
                                    }
                                    if([emailText.text length] >0 && emailText!= NULL)
                                    {
                                        updateUserInfoRequest.emailAddress = emailText.text;
                                        
                                        
                                    }
                                    [serviceUpdateUserInfo updateUserInfo:updateUserInfoRequest];
                                    
                                   // [services updateUserInfo:self action:@selector(updateUserInfohandlers:) updateUserInfoRequest:updateRequest];
                                    NSLog(@"updateRequest %@",updateUserInfoRequest);
                                    isProcess=YES;
                                }
                                else {
                                    
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ConnectionErrorTitle message:ConnectionErrorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                    [alert show];
                                }
                            }
                            else{
                                
                                //alertmessagestr=@"Please enter Valid email-id." ;
                                middleIndexPath = [NSIndexPath indexPathForRow:12 inSection:0];
                                [tableUpdateUserInfo scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                                [self currenttextfield:PostCodeText alerttitle:unabletoupdatecard alertmessage:validemailid];
                                
                            }
                            
                        }
                        else{
                            
                            middleIndexPath = [NSIndexPath indexPathForRow:10 inSection:0];
                            [tableUpdateUserInfo scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                            [self currenttextfield:PostCodeText alerttitle:unabletoupdatecard alertmessage:enterpostcode];
                            
                        }
                        
                    }
                    else{
                        
                        middleIndexPath = [NSIndexPath indexPathForRow:5 inSection:0];
                        [tableUpdateUserInfo scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                        [self currenttextfield:addressText1 alerttitle:unabletoupdatecard alertmessage:enterstreetAdd1];
                        
                    }
                }
                else{
                    
                    
                    middleIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
                    [tableUpdateUserInfo scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                    [self currenttextfield:lNameText alerttitle:unabletoupdatecard alertmessage:lastnameentr];
                    
                }
            }
            else{
                
                
                middleIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [tableUpdateUserInfo scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                [self currenttextfield:fNameText alerttitle:unabletoupdatecard alertmessage:firstnameentr];
                
            }
        }
        
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:networkconnectiontitle message:networkconnectionmessage delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //  [alert setTag:111];
        [alert show];
        
        
    }
    
}

//Added by Ankit jain 8/nov/2013
-(void)currenttextfield:(UITextField *)textfieldvalue alerttitle:(NSString *)alerttitlestr alertmessage:(NSString *)alertmessagestr
{
    
    //[Common ShowAlert:alertmessagestr alertTitle:alerttitlestr];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alerttitlestr message:alertmessagestr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    double delayInSeconds = .2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [textfieldvalue becomeFirstResponder];
        textfieldvalue.layer.borderWidth=1;
        
        textfieldvalue.layer.borderColor = TextfieldErrorColor.CGColor;
        if(textfieldvalue!=holdertextfield)
        {
            holdertextfield.layer.cornerRadius=5;
            holdertextfield.layer.borderWidth=0;
            holdertextfield=textfieldvalue;
        }
    });
    
}


-(void)updateUserInfohandlers:(id)value
{
    holdertextfield.layer.cornerRadius=5;
    holdertextfield.layer.borderWidth=0;
    [self killHUD];
    
    
    YPUpdateUserInfoResponse *updateUserInfoResponse=[[YPUpdateUserInfoResponse alloc] init];
    
    [updateUserInfoResponse parsingUpdateUserInfo:value];
    
    
  
	isProcess=YES;
	// Handle errors
    
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
		return;
	}
	
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
		return;
	}
	
    /*
	YPUpdateUserInfoResponse* result = (YPUpdateUserInfoResponse*)value;
	*/
	if(updateUserInfoResponse.statusCode == 0)
	{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:succesfulyupdate  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert setTag:111];
	}
	else{
        [self cardholderalertmessages:updateUserInfoResponse.statusCode message:updateUserInfoResponse.responseMessage];
        
	}
   
    
}

#pragma mark - UIAlertview delegate -------------------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //  NSLog(@"clickedButtonAtIndex tag = %d", alertView.tag);
	if (alertView.tag == 004) {
		[sexText setTextColor:[UIColor lightGrayColor]];
		[sexText setFont:textFieldTextFont];
		if (buttonIndex ==0)
        {
			sexText.text=@"Male";
		}
		else
        {
			sexText.text=@"Female";
		}
	}
	if (alertView.tag == 610) {
        if (buttonIndex ==0)
        {
			//[appDelegate logout];
		}
	}
	if (alertView.tag == 111)
    {
		if (buttonIndex ==0)
        {
            isProcess=NO;
			[self goBackToSettings];
		}
	}
	
}

-(void)goBackToSettings
{
    
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)checkForFirstResponder{
	if([fNameText isFirstResponder])
		[fNameText resignFirstResponder];
	else if([mNameText isFirstResponder])
		[mNameText resignFirstResponder];
	else if([lNameText isFirstResponder])
		[lNameText resignFirstResponder];
	else if([sexText isFirstResponder])
		[sexText resignFirstResponder];
	else if([addressText1 isFirstResponder])
		[addressText1 resignFirstResponder];
	else if([addressText2 isFirstResponder])
		[addressText2 resignFirstResponder];
	else if([CityText isFirstResponder])
		[CityText resignFirstResponder];
	else if([RegionText isFirstResponder])
		[RegionText resignFirstResponder];
    
	else if([PostCodeText isFirstResponder])
		[PostCodeText resignFirstResponder];
	else if([mobileText isFirstResponder])
		[mobileText resignFirstResponder];
	else if([emailText isFirstResponder])
		[emailText resignFirstResponder];
    
}


-(IBAction)BacktoView
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView delegate -------------------
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
	return UITableViewCellEditingStyleNone;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==12) {
        return 100;
    }
	return cellHeightForGroupedTable;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
	return 13;
	
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	NSString *title = nil;
	switch (section){
		case 0:{
            
			title = headertitle;
			break;
		}
	}
	return title;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self tableView:tableView titleForHeaderInSection:section] != nil) {
        return tableHeaderHeight;
    }
    else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
	
    // Create label with section title
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(3, 0, 300, 30);
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = HeaderTextColor;
    label.text = sectionTitle;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,60)];
    [view addSubview:label];
	
    return view;
}
//for textfield padding Added by Ankit Jain 26/nov/2013
-(void)texfieldpadding:(UITextField*)textfield
{
    UIView *emailpaddingView ;
    
    if(textfield==fNameText||textfield==lNameText)
    {
        emailpaddingView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 20)];
    }
    else{
        if(textfield==mNameText)
        {
            emailpaddingView= [[UIView alloc] initWithFrame:CGRectMake(0, 0,95, 20)];
        }
        else
        {
            if(textfield==dateOfBirthText)
            {
                emailpaddingView= [[UIView alloc] initWithFrame:CGRectMake(0, 0,45, 20)];
                
            }
            else{
                
                if(textfield==sexText)
                {
                    emailpaddingView= [[UIView alloc] initWithFrame:CGRectMake(0, 0,60, 20)];
                    
                }else{
                    
                    if(textfield==addressText1||textfield==addressText2)
                    {
                        emailpaddingView= [[UIView alloc] initWithFrame:CGRectMake(0, 0,120,20)];
                        
                    }
                    else{
                        if(textfield==countryText)
                        {
                            emailpaddingView= [[UIView alloc] initWithFrame:CGRectMake(0, 0,65,20)];
                        }
                        else
                        {
                            if(textfield==CityText)
                            {
                                emailpaddingView= [[UIView alloc] initWithFrame:CGRectMake(0, 0,40, 20)];
                            }
                            else{
                                if(textfield==PostCodeText)
                                {
                                    emailpaddingView= [[UIView alloc] initWithFrame:CGRectMake(0, 0,85, 20)];
                                }
                                else{
                                    if(textfield==CityText)
                                    {
                                        emailpaddingView= [[UIView alloc] initWithFrame:CGRectMake(0, 0,60, 20)];
                                    }
                                    else
                                    {
                                        if(textfield==RegionText)
                                        {
                                            emailpaddingView= [[UIView alloc] initWithFrame:CGRectMake(0, 0,55, 20)];
                                            
                                        }
                                        else
                                        {
                                            if(textfield==mobileText)
                                            {
                                                emailpaddingView= [[UIView alloc] initWithFrame:CGRectMake(0, 0,105, 20)];
                                            }
                                            else
                                            {
                                                if(textfield==emailText)
                                                {
                                                    emailpaddingView= [[UIView alloc] initWithFrame:CGRectMake(0, 0,100, 20)];
                                                }
                                                else
                                                    emailpaddingView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 20)];
                                                
                                            }
                                        }
                                    }
                                }
                                
                            }
                            
                        }
                    }
                    
                }
                
                
            }
        }
    }
    
    textfield.leftView = emailpaddingView;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = nil;
    
	NSString *cellIdentifier;
	cellIdentifier = @"SectionsTableIdentifier";
	int row = [indexPath row];
	int section=[indexPath section];
	CGRect nameLabelRect = CGRectMake(7 ,7,200, 25);
	
	UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameLabelRect];
	cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //Rashmi: 02-08-2013: initWithFrame deprecated in 3.0
	/*if(cell == nil){
     cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdentifier] autorelease];
     }*/
	
	// Remove all subview from cell content view
	for (UIView *view in cell.contentView.subviews){
		[view removeFromSuperview];
	}
	[cell setAccessoryType:UITableViewCellAccessoryNone];
	[cell setBackgroundColor:[UIColor clearColor]];
	[cell setBackgroundColor:TableViewCellColor];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    
	//UIImageView *textFieldBackgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(25, 4, 223, 30)];
    UIImageView *textFieldBackgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(3,7,283,36)];
	[textFieldBackgroundImage setImage:[UIImage imageNamed:@"entry_field.png"]];
	[cell.contentView addSubview:textFieldBackgroundImage];
	if(section == 0 && row == 0){
		nameLabel.textAlignment = NSTextAlignmentLeft;
		nameLabel.text = @"First Name:";
		//[cell.contentView addSubview: nameLabel];
		[fNameText setKeyboardAppearance:UIKeyboardAppearanceAlert];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		fNameText.tag = 1;
		fNameText.delegate = self;
		if([resultArray count] > 0 && isFirstNameChange == NO)
		{
			fNameText.text = ((UserInfoData*)[resultArray objectAtIndex:0]).firstname;
			isFirstNameChange = YES;
		}
        //	fNameText.text=NULL;
		//fNameText.placeholder =@"First Name *";
		fNameText.returnKeyType = UIReturnKeyNext;
		fNameText.keyboardType = UIKeyboardTypeDefault;
		fNameText.autocorrectionType = UITextAutocorrectionTypeNo;
		fNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
		fNameText.clearsOnBeginEditing = NO;
		[fNameText setTextAlignment:NSTextAlignmentLeft];
        fNameText.font=[textFieldnewTextFont];
        
        [fNameText setValue:placeholdertexfield];
        [self texfieldpadding:fNameText];
        fNameText.layer.cornerRadius=5;
        fNameText.layer.borderWidth=0;
        [cell.contentView addSubview:fnamlbl];
		[cell.contentView addSubview:fNameText];
	}
	if(section == 0 && row == 1){
		nameLabel.textAlignment = NSTextAlignmentLeft;
		nameLabel.text = @"Middle Name:";
		//[cell.contentView addSubview: nameLabel];
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		[mNameText setKeyboardAppearance:UIKeyboardAppearanceAlert];
		mNameText.tag = 2;
		mNameText.delegate = self;
		NSString *middle = ((UserInfoData*)[resultArray objectAtIndex:0]).middlename;
        
        if (![middle isEqualToString:@"(null)"]) {
            if([resultArray count] > 0 && isMiddleNameChange == NO )
            {
                mNameText.text = ((UserInfoData*)[resultArray objectAtIndex:0]).middlename;
                isMiddleNameChange = YES;
            }
		}
		else {
	 		
            // mNameText.placeholder =@"Middle Name";
		}
        //mNameText.placeholder =@"Middle Name";
		mNameText.returnKeyType = UIReturnKeyNext;
		mNameText.keyboardType = UIKeyboardTypeDefault;
		mNameText.autocorrectionType = UITextAutocorrectionTypeNo;
		mNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
		mNameText.clearsOnBeginEditing = NO;
        mNameText.font=[textFieldnewTextFont];
        
        [mNameText setValue:placeholdertexfield];
        [self texfieldpadding:mNameText];
		[mNameText setTextAlignment:NSTextAlignmentLeft];
        mNameText.layer.cornerRadius=5;
        mNameText.layer.borderWidth=0;
        [cell.contentView addSubview:mnamelbl];
		[cell.contentView addSubview:mNameText];
		
	}
	
	if(section == 0 && row == 2){
		nameLabel.textAlignment = NSTextAlignmentLeft;
		nameLabel.text = @"Last Name:";
		//[cell.contentView addSubview: nameLabel];
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		[lNameText setKeyboardAppearance:UIKeyboardAppearanceAlert];
		lNameText.tag = 2;
		lNameText.delegate = self;
		if([resultArray count] > 0 && isLastNameChange == NO && [ ((UserInfoData*)[resultArray objectAtIndex:0]).lastname length]>0)
		{
			lNameText.text = ((UserInfoData*)[resultArray objectAtIndex:0]).lastname;
			isLastNameChange = YES;
		}
		//lNameText.text=NULL;
		//lNameText.placeholder =@"Last Name *";
		lNameText.returnKeyType = UIReturnKeyNext;
		lNameText.keyboardType = UIKeyboardTypeDefault;
		lNameText.autocorrectionType = UITextAutocorrectionTypeNo;
		lNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
		lNameText.clearsOnBeginEditing = NO;
		lNameText.font=[textFieldnewTextFont];
        
        [lNameText setValue:placeholdertexfield];
        [self texfieldpadding:lNameText];
		[lNameText setTextAlignment:NSTextAlignmentLeft];
        lNameText.layer.cornerRadius=5;
        lNameText.layer.borderWidth=0;
        [cell.contentView addSubview:lnamelbl];
		[cell.contentView addSubview:lNameText];
		
	}
	
	if(section == 0 && row == 3){
		nameLabel.textAlignment = NSTextAlignmentLeft;
        
		if([resultArray count] > 0 && isDOBChange == NO)
		{
			if ([((UserInfoData*)[resultArray objectAtIndex:0]).dob length] >1) {
				NSLog(@"Date of birth...%@",((UserInfoData*)[resultArray objectAtIndex:0]).dob);
                dateOfBirthText.text = ((UserInfoData*)[resultArray objectAtIndex:0]).dob;
                isDOBChange = YES;
			}
			else {
				//[dateOfBirthText setText:@"Date of birth"];
			}
            
		}
		
		[dateOfBirthText setTextAlignment:NSTextAlignmentLeft];
        //dateOfBirthText.placeholder=@"DOB";
		dateOfBirthText.font=[textFieldnewTextFont];
        
        [dateOfBirthText setValue:placeholdertexfield];
        [self texfieldpadding:dateOfBirthText];
		isDOBChange = YES;
	    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        dateOfBirthText.layer.cornerRadius=5;
        dateOfBirthText.layer.borderWidth=0;
        [cell.contentView addSubview:dateofbirthlbl];
		[cell.contentView addSubview:dateOfBirthText];
        
        //----------------Transparent button to open picker-----------------------
        
        btnShowPicker.backgroundColor=[UIColor clearColor];
        btnShowPicker.alpha=0.5;
        btnShowPicker.tag=0;
        [btnShowPicker addTarget:self action:@selector(openPickerButtonUpatecard:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnShowPicker];
        //-------------------------------------------------------------------------
        
		
	}
	
	if(section == 0 && row == 4){
		nameLabel.textAlignment = NSTextAlignmentLeft;
		nameLabel.text = @"Sex:";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //sexText.placeholder=@"Gender";
		NSString *gender = ((UserInfoData*)[resultArray objectAtIndex:0]).sex;
	  	NSLog(@"..Gender.....%@",gender);
		if (![gender isEqualToString:@"(null)"]) {
			if([resultArray count] > 0 && isSexChange == NO )
			{
				isSex=YES;
				sexText.text = ((UserInfoData*)[resultArray objectAtIndex:0]).sex;
                if ([sexText.text isEqualToString:@"M"]) {
                    sexText.text=@"Male";
                }
                else if ([sexText.text isEqualToString:@"F"]) {
                    sexText.text=@"Female";
                }
				isSexChange = YES;
			}
		}else {
            // sexText.text = @"Male/Female";
        }
        //sexText.text = @"Male/Female";
	 	sexText.font=[textFieldnewTextFont];
        
        [sexText setValue:placeholdertexfield];
        [self texfieldpadding:sexText];
		[sexText setTextAlignment:NSTextAlignmentLeft];
        sexText.layer.cornerRadius=5;
        sexText.layer.borderWidth=0;
        [cell.contentView addSubview:sexlbl];
		[cell.contentView addSubview:sexText];
        //----------------Transparent button to open picker-----------------------
        
        btnShowgenderPicker.backgroundColor=[UIColor clearColor];
        btnShowgenderPicker.alpha=0.5;
        btnShowgenderPicker.tag=1;
        [btnShowgenderPicker addTarget:self action:@selector(openPickerButtonUpatecard:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnShowgenderPicker];
        //-------------------------------------------------------------------------
        
		
	}
    
	if(section == 0 && row == 5){
		nameLabel.textAlignment = NSTextAlignmentLeft;
		nameLabel.text = @"Address1:";
		//[cell.contentView addSubview: nameLabel];
		[addressText1 setKeyboardAppearance:UIKeyboardAppearanceAlert];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		addressText1.tag = 2;
		addressText1.delegate = self;
		NSString *add= ((UserInfoData*)[resultArray objectAtIndex:0]).address1;
		NSLog(@"..Adddressssss Add...%@",add);
		if([resultArray count] > 0 && isAddress1Change == NO && ![((UserInfoData*)[resultArray objectAtIndex:0]).address1 isEqualToString:@"(null)"])
		{
			addressText1.text = ((UserInfoData*)[resultArray objectAtIndex:0]).address1;
			isAddress1Change = YES;
		}
        /*else {
         addressText1.placeholder =@"Street Address 1 *";
         }*/
        
        
        
		addressText1.returnKeyType = UIReturnKeyNext;
		addressText1.keyboardType = UIKeyboardTypeDefault;
		addressText1.autocorrectionType = UITextAutocorrectionTypeNo;
		addressText1.clearButtonMode = UITextFieldViewModeWhileEditing;
		addressText1.clearsOnBeginEditing = NO;
		addressText1.font=[textFieldnewTextFont];
        
        [addressText1 setValue:placeholdertexfield];
        [self texfieldpadding:addressText1];
		[addressText1 setTextAlignment:NSTextAlignmentLeft];
        addressText1.layer.cornerRadius=5;
        addressText1.layer.borderWidth=0;
        [cell.contentView addSubview:addresslbl1];
		[cell.contentView addSubview:addressText1];
		
	}
	
	if(section == 0 && row == 6){
		nameLabel.textAlignment = NSTextAlignmentLeft;
		nameLabel.text = @"Address2:";
		//[cell.contentView addSubview: nameLabel];
		[addressText2 setKeyboardAppearance:UIKeyboardAppearanceAlert];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		addressText2.tag = 2;
		addressText2.delegate = self;
		if([resultArray count] > 0 && isAddress2Change == NO && ![((UserInfoData*)[resultArray objectAtIndex:0]).address2 isEqualToString:@"(null)"])
		{
			addressText2.text = ((UserInfoData*)[resultArray objectAtIndex:0]).address2;
			isAddress2Change = YES;
		}
		//addressText2.placeholder =@"Street Address 2";
		addressText2.returnKeyType = UIReturnKeyNext;
		addressText2.keyboardType = UIKeyboardTypeDefault;
		addressText2.autocorrectionType = UITextAutocorrectionTypeNo;
		addressText2.clearButtonMode = UITextFieldViewModeWhileEditing;
		addressText2.clearsOnBeginEditing = NO;
		addressText2.font=[textFieldnewTextFont];
        
        [addressText2 setValue:placeholdertexfield];
        [self texfieldpadding:addressText2];
		[addressText2 setTextAlignment:NSTextAlignmentLeft];
        addressText2.layer.cornerRadius=5;
        addressText2.layer.borderWidth=0;
        [cell.contentView addSubview:addresslbl2];
		[cell.contentView addSubview:addressText2];
		
	}
	if(section == 0 && row == 7){
		nameLabel.textAlignment = NSTextAlignmentLeft;
		nameLabel.text = @"City:";
		//[cell.contentView addSubview: nameLabel];
		[CityText setKeyboardAppearance:UIKeyboardAppearanceAlert];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		CityText.tag = 2;
		CityText.delegate = self;
		if([resultArray count] > 0 && isCityChange == NO && ![((UserInfoData*)[resultArray objectAtIndex:0]).city isEqualToString:@"(null)"])
		{
			CityText.text = ((UserInfoData*)[resultArray objectAtIndex:0]).city;
			isCityChange = YES;
		}
		//CityText.placeholder =@"City";
		CityText.returnKeyType = UIReturnKeyNext;
		CityText.keyboardType = UIKeyboardTypeDefault;
		CityText.autocorrectionType = UITextAutocorrectionTypeNo;
		CityText.clearButtonMode = UITextFieldViewModeWhileEditing;
		CityText.clearsOnBeginEditing = NO;
        CityText.font=[textFieldnewTextFont];
        
        [CityText setValue:placeholdertexfield];
        [self texfieldpadding:CityText];
		[CityText setTextAlignment:NSTextAlignmentLeft];
        CityText.layer.cornerRadius=5;
        CityText.layer.borderWidth=0;
        [cell.contentView addSubview:citylbl];
		[cell.contentView addSubview:CityText];
		
	}
	if(section == 0 && row == 8){
		nameLabel.textAlignment = NSTextAlignmentLeft;
		nameLabel.text = @"Region:";
		//[cell.contentView addSubview: nameLabel];
		[RegionText setKeyboardAppearance:UIKeyboardAppearanceAlert];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		RegionText.tag = 2;
		RegionText.delegate = self;
		if([resultArray count] > 0 && isRegionChange == NO && ![((UserInfoData*)[resultArray objectAtIndex:0]).region isEqualToString:@"(null)"])
		{
			RegionText.text = ((UserInfoData*)[resultArray objectAtIndex:0]).region;
			isRegionChange = YES;
		}
		//RegionText.placeholder =@"Region";
		RegionText.returnKeyType = UIReturnKeyNext;
		RegionText.keyboardType = UIKeyboardTypeDefault;
		RegionText.autocorrectionType = UITextAutocorrectionTypeNo;
		RegionText.clearButtonMode = UITextFieldViewModeWhileEditing;
		RegionText.clearsOnBeginEditing = NO;
		RegionText.font=[textFieldnewTextFont];
        
        [RegionText setValue:placeholdertexfield];
        [self texfieldpadding:RegionText];
		[RegionText setTextAlignment:NSTextAlignmentLeft];
        RegionText.layer.cornerRadius=5;
        RegionText.layer.borderWidth=0;
        [cell.contentView addSubview:regionlbl];
		[cell.contentView addSubview:RegionText];
		
	}
	if(section == 0 && row == 9){
		nameLabel.textAlignment = NSTextAlignmentLeft;
		nameLabel.text = @"Post Code:";
		
		[PostCodeText setKeyboardAppearance:UIKeyboardAppearanceAlert];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		PostCodeText.tag = 2;
		PostCodeText.delegate = self;
		if([resultArray count] > 0 && isPostCodeChange == NO && ![((UserInfoData*)[resultArray objectAtIndex:0]).postcode isEqualToString:@"(null)"])
		{
			PostCodeText.text = ((UserInfoData*)[resultArray objectAtIndex:0]).postcode;
			isPostCodeChange = YES;
		}
		//PostCodeText.placeholder =@"Post Code *";
		PostCodeText.returnKeyType = UIReturnKeyNext;
		PostCodeText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
		PostCodeText.autocorrectionType = UITextAutocorrectionTypeNo;
		PostCodeText.clearButtonMode = UITextFieldViewModeWhileEditing;
		PostCodeText.clearsOnBeginEditing = NO;
        PostCodeText.font=[textFieldnewTextFont];
        
        [PostCodeText setValue:placeholdertexfield];
        [self texfieldpadding:PostCodeText];
		[PostCodeText setTextAlignment:NSTextAlignmentLeft];
        PostCodeText.layer.cornerRadius=5;
        PostCodeText.layer.borderWidth=0;
        [cell.contentView addSubview:postcodelbl];
		[cell.contentView addSubview:PostCodeText];
        
	}
	
	if(section == 0 && row == 10){
        nameLabel.textAlignment = NSTextAlignmentLeft;
        if([resultArray count] > 0 && ![((UserInfoData*)[resultArray objectAtIndex:0]).country isEqualToString:@"(null)"])
		{
			countryText.text = ((UserInfoData*)[resultArray objectAtIndex:0]).country;
			//isCityChange = YES;
		}
		else if ([setTextcountryLabel length]==0) {
			[countryText setText:@"ERITREA"];
			setCounCodeSetting=@"826";
		}else {
			[countryText setText:setTextcountryLabel];
		}
		
		[countryText setTextAlignment:NSTextAlignmentLeft];
        countryText.font=[textFieldnewTextFont];
        
        [countryText setValue:placeholdertexfield];
        [self texfieldpadding:countryText];
        
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        countryText.layer.cornerRadius=5;
        countryText.layer.borderWidth=0;
        [cell.contentView addSubview:countrylbl];
		[cell.contentView addSubview:countryText];
        
        //----------------Transparent button to open picker-----------------------
        btnShowcountryPicker.backgroundColor=[UIColor clearColor];
        btnShowcountryPicker.alpha=0.5;
        btnShowcountryPicker.tag=2;
        [btnShowcountryPicker addTarget:self action:@selector(openPickerButtonUpatecard:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnShowcountryPicker];
        //-------------------------------------------------------------------------
		
		
	}
	if(section == 0 && row == 11){
        nameLabel.textAlignment = NSTextAlignmentLeft;
		nameLabel.text = @"Email:";
		//[cell.contentView addSubview: nameLabel];
		[emailText setKeyboardAppearance:UIKeyboardAppearanceAlert];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		emailText.tag = 2;
		emailText.delegate = self;
		NSString *emilaID=((UserInfoData*)[resultArray objectAtIndex:0]).emailid;
		
		if([resultArray count] > 0 && isEmailChange == NO && [((UserInfoData*)[resultArray objectAtIndex:0]).emailid length]>0)
		{
			emailText.text = ((UserInfoData*)[resultArray objectAtIndex:0]).emailid;
			isEmailChange = YES;
		}
		if([emilaID isEqualToString:@"(null)"])
		{
            emailText.text=@"";
		}
        
		//emailText.placeholder =@"Email Address";
		emailText.returnKeyType = UIReturnKeyNext;
		emailText.keyboardType = UIKeyboardTypeDefault;
		emailText.autocorrectionType = UITextAutocorrectionTypeNo;
		emailText.clearButtonMode = UITextFieldViewModeWhileEditing;
		emailText.autocapitalizationType = NO;
		emailText.clearsOnBeginEditing = NO;
        emailText.font=[textFieldnewTextFont];
        
        [emailText setValue:placeholdertexfield];
        [self texfieldpadding:emailText];
		[emailText setTextAlignment:NSTextAlignmentLeft];
        emailText.layer.cornerRadius=5;
        emailText.layer.borderWidth=0;
        [cell.contentView addSubview:emailibl];
		[cell.contentView addSubview:emailText];
        
		
	}
	if(section == 0 &&  row == 12)
	{
		
        
        
        //////
        
		//[cell.contentView addSubview: nameLabel];
		[mobileText setKeyboardAppearance:UIKeyboardAppearanceAlert];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		mobileText.tag = 2;
		mobileText.delegate = self;
		if([resultArray count] > 0 && isMobileChange == NO && ![((UserInfoData*)[resultArray objectAtIndex:0]).mobileno isEqualToString:@"(null)"])
            
		{
			mobileText.text = ((UserInfoData*)[resultArray objectAtIndex:0]).mobileno;
			isMobileChange = YES;
		}
		//mobileText.placeholder =@"Mobile Number";
		mobileText.returnKeyType = UIReturnKeyDone;
		mobileText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
		mobileText.autocorrectionType = UITextAutocorrectionTypeNo;
		mobileText.clearButtonMode = UITextFieldViewModeWhileEditing;
		mobileText.clearsOnBeginEditing = NO;
        mobileText.font=[textFieldnewTextFont];
        
        [mobileText setValue:placeholdertexfield];
        [self texfieldpadding:mobileText];
		[mobileText setTextAlignment:NSTextAlignmentLeft];
        mobileText.layer.cornerRadius=5;
        mobileText.layer.borderWidth=0;
        [cell.contentView addSubview:mobilelbl];
		[cell.contentView addSubview:mobileText];
        
	}
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	if(indexPath.row==3){
        [self performSelector:@selector(openDatePicker)];
    }
	if(indexPath.section == 0 && indexPath.row  == 4)
    {
        [self performSelector:@selector(openGenderPicker)];
    }
	if(indexPath.row==10){
        [self performSelector:@selector(openCountryPicker)];
	}
}

#pragma mark - Scrollview delegate ---------------------------------
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if(!isViewMoveUp)
	{
		
		isViewMoveUp = YES;
	}
	//[self checkForFirstResponder];
}


#pragma mark - Hud view methods -------------------------------------------


//to kill hud view
- (void) killHUD
{
	if(aHUD != nil )
    {
		[aHUD.loadingView removeFromSuperview];
        [aHUD removeFromSuperview];
		[aHUD setUserInteractionEnabledForSuperview:self.view];
		[aHUD setUserInteractionEnabledForSuperview:self.view];
		[self.navigationController.view setUserInteractionEnabled:YES];
        aHUD = nil;
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	}
}

//to show hud view
- (void)showHUD:(NSString*)message
{
	if(aHUD == nil)
	{
        
		aHUD = [[HudView alloc]init];
 		[aHUD setUserInteractionEnabledForSuperview:self.view];
		[aHUD loadingViewInView:self.view text:message];
        
        
        [self.navigationController.navigationBar setUserInteractionEnabled:NO];
		[self.view setUserInteractionEnabled:NO];
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		
	}
	
}


#pragma mark - Other methods ---------------------------------------



- (BOOL)validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	
    return [emailTest evaluateWithObject:candidate];
}

-(void)resignresponderwhenpickeropen
{
    [fNameText resignFirstResponder];
	[mNameText resignFirstResponder];
	[lNameText resignFirstResponder];
	[mobileText resignFirstResponder];
	[emailText resignFirstResponder];
	[addressText1 resignFirstResponder];
	[addressText2 resignFirstResponder];
	[CityText resignFirstResponder];
	[RegionText resignFirstResponder];
	[PostCodeText resignFirstResponder];
	[sexText resignFirstResponder];
	[dateOfBirthField resignFirstResponder];
    [countryText resignFirstResponder];
	//[dateOfBirthText resignFirstResponder];
}

-(void)openPickerButtonUpatecard:(UIButton*)sender
{
    [self.view endEditing:YES];
    [self checkForFirstResponder];
    
    
    NSLog(@"%d",sender.tag);
    if (sender.tag==0) {
        [self performSelector:@selector(openDatePicker)];
        
        
    }
    if (sender.tag==1) {
        [self performSelector:@selector(openGenderPicker)];
        
        
    }
    if (sender.tag==2) {
        [self performSelector:@selector(openCountryPicker)];
        
    }
    
}

-(void)closPicker
{
    if([cancelbtnstr isEqualToString:@"datecancel"])
    {
        //--------------------- Open Gender picker ------------------
        [self performSelector:@selector(openGenderPicker) withObject:nil afterDelay:0.4];
        //-----------------------------------------------------------
    }
    if([cancelbtnstr isEqualToString:@"gendercancel"])
    {
        [addressText1 becomeFirstResponder];
        
    }
    if([cancelbtnstr isEqualToString:@"countrycancel"])
    {
        [emailText becomeFirstResponder];
    }
	TempViewForDatePicker.hidden= YES;
	datePicker.hidden =YES;
	countryPicker.hidden =YES;
	CATransition* trans = [CATransition animation];
	[trans setType:kCATransitionPush];
	[trans setDuration:0.35];
	[trans setSubtype:kCATransitionFromBottom];
	CALayer *layer = TempViewForDatePicker.layer;
	CALayer *layer1 = pickerDoneButton.layer;
	[layer1 addAnimation:trans forKey:@"CurlIn"];
	[layer addAnimation:trans forKey:@"CurlIn"];
}
-(void)doneDatePicker
{
	TempViewForDatePicker.hidden= YES;
	datePicker.hidden =YES;
	dateOfBirthText.textColor=textFieldTextColor;
	dateOfBirthText.font = textFieldTextFont;
	dateOfBirthText.text=[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:datePicker.date]];//[datePicker date]];
	NSLog(@"dateOfBirthText  === %@",dateOfBirthText.text);
	//[dateOfBirth resignFirstResponder];
	//[mobileText becomeFirstResponder];
	
	CATransition* trans = [CATransition animation];
	[trans setType:kCATransitionPush];
	[trans setDuration:0.35];
	[trans setSubtype:kCATransitionFromBottom];
	CALayer *layer = TempViewForDatePicker.layer;
	CALayer *layer1 = pickerDoneButton.layer;
	[layer1 addAnimation:trans forKey:@"CurlIn"];
	[layer addAnimation:trans forKey:@"CurlIn"];
    
    
    //--------------------- Open Gender picker ------------------
    [self performSelector:@selector(openGenderPicker) withObject:nil afterDelay:0.4];
    //-----------------------------------------------------------
    
    
	
}
-(void)doneContryPicker
{
	TempViewForDatePicker.hidden= YES;
	countryPicker.hidden =YES;
	[countryText setTextColor:[UIColor blackColor]];
	//[countryText setFont:textFieldTextFont];
	if ([getCountryName count]>0)
	{
		NSLog(@"row selected of pickerValue country Done %@",countryPicker);
		countryText.text = [getCountryName objectAtIndex:selectRow];
		setCounCodeSetting = [getCountryCode objectAtIndex:selectRow];
		NSLog(@"setCounCodeSetting.....%@",setCounCodeSetting);
	}
	[countryText resignFirstResponder];
	isCountry = NO;
	CATransition* trans = [CATransition animation];
	[trans setType:kCATransitionPush];
	[trans setDuration:0.35];
	[trans setSubtype:kCATransitionFromBottom];
	CALayer *layer = TempViewForDatePicker.layer;
	CALayer *layer1 = pickerDoneButton.layer;
	[layer1 addAnimation:trans forKey:@"CurlIn"];
	[layer addAnimation:trans forKey:@"CurlIn"];
    
    //--------------------- Point post code textfield ------------------
    [emailText becomeFirstResponder];
    NSIndexPath *middleIndexPath;
    middleIndexPath = [NSIndexPath indexPathForRow:11 inSection:0];
    [tableUpdateUserInfo scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    //-----------------------------------------------------------
    
}
-(void)doneGenderPicker
{
	TempViewForDatePicker.hidden= YES;
	countryPicker.hidden =YES;
	[countryText setTextColor:[UIColor blackColor]];
	
    sexText.text = [arrayGenderPicker objectAtIndex:selectRowGender];
    
	[countryText resignFirstResponder];
	isCountry = NO;
	CATransition* trans = [CATransition animation];
	[trans setType:kCATransitionPush];
	[trans setDuration:0.35];
	[trans setSubtype:kCATransitionFromBottom];
	CALayer *layer = TempViewForDatePicker.layer;
	CALayer *layer1 = pickerDoneButton.layer;
	[layer1 addAnimation:trans forKey:@"CurlIn"];
	[layer addAnimation:trans forKey:@"CurlIn"];
    
    //--------------------- Point Address1 textfield ------------------
    
    NSIndexPath *middleIndexPath;
    middleIndexPath = [NSIndexPath indexPathForRow:5 inSection:0];
    [tableUpdateUserInfo scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    [addressText1 becomeFirstResponder];
    //-----------------------------------------------------------
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5]; // if you want to slide up the view
	
    CGRect rect = tableUpdateUserInfo.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        
		//rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        //rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    tableUpdateUserInfo.frame = rect;
	
    [UIView commitAnimations];
}

- (void)keyboardWillShow:(NSNotification *)notif
{
    
    
}

//Numeric key pad : adding return button
- (void) addReturnButtonInNumPad
{
	// locate keyboard view
	UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
	UIView* keyboard;
	for(int i=0; i<[tempWindow.subviews count]; i++) {
		keyboard = [tempWindow.subviews objectAtIndex:i];
		
		// keyboard view found; add the custom button to it
		if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
		{
			if([mobileText isFirstResponder] || [PostCodeText isFirstResponder])
			{
				doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
				doneButton.frame = CGRectMake(0, 163, 106, 53);
				doneButton.tag = kNumPadReturnButtonTag;
				doneButton.adjustsImageWhenHighlighted = NO;
				[doneButton setTitle:@"Done" forState:UIControlStateNormal];
                [keyboard addSubview:doneButton];
			}
		}
	}
}

- (void) removeReturnButtonFromNumPad
{
	// locate keyboard view
	UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
	UIView* keyboard;
	for(int i=0; i<[tempWindow.subviews count]; i++) {
		keyboard = [tempWindow.subviews objectAtIndex:i];
		// keyboard view found; add the custom button to it
		if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
		{
			UIView *button;
			for (int j=0; j<[keyboard.subviews count]; j++) {
				button = [keyboard.subviews objectAtIndex:j];
				if(button.tag == kNumPadReturnButtonTag)
				{
					[button removeFromSuperview];
				}
			}
		}
	}
}

#pragma mark - Open picker methods ---------------
-(void)openDatePicker
{
    //date picker -------------------
    [self resignresponderwhenpickeropen];
    cancelbtnstr=@"datecancel";
    if(btnShowPicker.userInteractionEnabled==YES)
    {
        
        [TempViewForDatePicker addSubview:datePicker];
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame = CGRectMake(25,-8, 99, 43);
        [closeButton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
        closeButton.tag = 101;
        [closeButton addTarget:self action:@selector(closPicker) forControlEvents:UIControlEventTouchUpInside];
        [TempViewForDatePicker addSubview:closeButton];
        [TempViewForDatePicker bringSubviewToFront:closeButton];
        pickerDoneButton=[UIButton buttonWithType:UIButtonTypeCustom];
        pickerDoneButton.frame = CGRectMake(194,-8, 99, 43);
        [pickerDoneButton setImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateNormal];
        pickerDoneButton.tag = 111;
        [pickerDoneButton addTarget:self action:@selector(doneDatePicker) forControlEvents:UIControlEventTouchUpInside];
        [TempViewForDatePicker addSubview:pickerDoneButton];
        [TempViewForDatePicker bringSubviewToFront:pickerDoneButton];
        [TempViewForDatePicker bringSubviewToFront:self.pickerbgimage];
        
        
        pickerDoneButton.hidden=NO;
        
        
        
        
        TempViewForDatePicker.hidden = NO;
        datePicker.hidden =NO;
        genderPicker.hidden=YES;
        countryPicker.hidden=YES;
        
        if([dateOfBirthField.text length]!=0)
        {
            NSString *dateStr =dateOfBirthField.text;
            
            // Convert string to date object
            [dateFormat setDateFormat:@"dd/MM/yyyy"];
            NSDate *date = [dateFormat dateFromString:dateStr];
            datePicker.date = date;
        }
        else{
            datePicker.date = [NSDate date];
        }
        
        
        
        
        [self.tabBarController.view addSubview:TempViewForDatePicker];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
    }
    
}
-(void)openGenderPicker
{
    //Gender picker ------------------
    [self resignresponderwhenpickeropen];
    NSLog(@"Tap on Male Femal ");
    cancelbtnstr=@"gendercancel";
    if(btnShowgenderPicker.userInteractionEnabled==YES)
    {
        datePicker.hidden =YES;
        genderPicker.hidden=NO;
        countryPicker.hidden=YES;
        //[self checkForFirstResponder];
        [TempViewForDatePicker addSubview:genderPicker];
        //close button---------
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame = CGRectMake(25,-8, 99, 43);
        [closeButton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
        closeButton.tag = 101;
        [closeButton addTarget:self action:@selector(closPicker) forControlEvents:UIControlEventTouchUpInside];
        [TempViewForDatePicker addSubview:closeButton];
        [TempViewForDatePicker bringSubviewToFront:closeButton];
        //---------------------
        
        //Done button-------------------
        pickerDoneButton=[UIButton buttonWithType:UIButtonTypeCustom];
        pickerDoneButton.frame = CGRectMake(194,-8, 99, 43);
        [pickerDoneButton setImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateNormal];
        pickerDoneButton.tag = 111;
        [pickerDoneButton addTarget:self action:@selector(doneGenderPicker) forControlEvents:UIControlEventTouchUpInside];
        [TempViewForDatePicker addSubview:pickerDoneButton];
        [TempViewForDatePicker bringSubviewToFront:pickerDoneButton];
        [TempViewForDatePicker bringSubviewToFront:self.pickerbgimage];
        [TempViewForDatePicker bringSubviewToFront:self.pickerbgimage];
        //--------------------------------
        
        
        pickerDoneButton.hidden=NO;
        //--------------------------------
        
        datePicker.hidden =YES;
        TempViewForDatePicker.hidden = NO;
        [self.tabBarController.view addSubview:TempViewForDatePicker];
    }
}


-(void)openCountryPicker
{
    
    [self resignresponderwhenpickeropen];
    if(btnShowcountryPicker.userInteractionEnabled==YES)
    {
        cancelbtnstr=@"countrycancel";
        
        datePicker.hidden =NO;
        genderPicker.hidden=YES;
        countryPicker.hidden=NO;
        NSLog(@"Countryyyyyy Picker");
        // [self checkForFirstResponder];
        [TempViewForDatePicker addSubview:countryPicker];
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame = CGRectMake(25,-8, 99, 43);
        [closeButton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
        closeButton.tag = 101;
        [closeButton addTarget:self action:@selector(closPicker) forControlEvents:UIControlEventTouchUpInside];
        [TempViewForDatePicker addSubview:closeButton];
        
        [TempViewForDatePicker bringSubviewToFront:closeButton];
        //[closeButton release];
        pickerDoneButton=[UIButton buttonWithType:UIButtonTypeCustom];
        pickerDoneButton.frame = CGRectMake(194,-8, 99, 43);
        [pickerDoneButton setImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateNormal];
        pickerDoneButton.tag = 111;
        [pickerDoneButton addTarget:self action:@selector(doneContryPicker) forControlEvents:UIControlEventTouchUpInside];
        [TempViewForDatePicker addSubview:pickerDoneButton];
        
        [TempViewForDatePicker bringSubviewToFront:pickerDoneButton];
        [TempViewForDatePicker bringSubviewToFront:self.pickerbgimage];
        
        
        pickerDoneButton.hidden=NO;
        
        TempViewForDatePicker.hidden = YES;
        datePicker.hidden =YES;
        TempViewForDatePicker.hidden = NO;
        countryPicker.hidden=NO;
        
        NSString *strCntryName = [[NSString alloc] initWithString:countryText.text];
        
        BOOL isOk = [getCountryName containsObject:strCntryName];
        if (isOk) {
            selectRow = [getCountryName indexOfObject:strCntryName];
            [countryPicker selectRow:selectRow inComponent:0 animated:NO];
        }
        else{
            [countryPicker selectRow:0 inComponent:0 animated:NO];
        }
        
        [self.tabBarController.view addSubview:TempViewForDatePicker];
    }
}


#pragma mark - UItextfield delegate ---------------

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    if (textField==fNameText) {
        [mNameText becomeFirstResponder];
    }
    else if (textField==mNameText){
        [lNameText becomeFirstResponder];
    }
    else if (textField==lNameText){
        [self performSelector:@selector(openDatePicker)];
        NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:3 inSection:0];
		[tableUpdateUserInfo scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    else if (textField==dateOfBirthText){
        [self performSelector:@selector(openGenderPicker)];
        NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:4 inSection:0];
		[tableUpdateUserInfo scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    else if (textField==addressText1){
        [addressText2 becomeFirstResponder];
    }
    else if (textField==addressText2){
        [CityText becomeFirstResponder];
    }
    else if (textField==CityText){
        [RegionText becomeFirstResponder];
    }
    else if (textField==RegionText){
        [PostCodeText becomeFirstResponder];
        
    }
    else if (textField==PostCodeText){
        
        [self performSelector:@selector(openCountryPicker)];
        NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:10 inSection:0];
		[tableUpdateUserInfo scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        
        // [mobileText becomeFirstResponder];
    }
    else if (textField==emailText){
        [mobileText becomeFirstResponder];
        
    }
    
    return YES;
    
}



- (void)textFieldDidBeginEditing:(UITextField *)textField{
	TempViewForDatePicker.hidden= YES;
	datePicker.hidden =YES;
	countryPicker.hidden =YES;
	
	if(!isPickerMoveUp)
	{
		//[self doneAction];
		isPickerMoveUp = YES;
	}
	
	if([PostCodeText isFirstResponder]){
		[self addReturnButtonInNumPad];
		
	}
	if([fNameText isFirstResponder])
	{
		if(!isViewMoveUp)
		{
			
		}
	}
	if([sexText isFirstResponder])
	{
		NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:4 inSection:0];
		[tableUpdateUserInfo scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
		
	}
	if([addressText1 isFirstResponder]){
		NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:5 inSection:0];
		[tableUpdateUserInfo scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
	}
	
	if([addressText2 isFirstResponder]){
		NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:6 inSection:0];
		[tableUpdateUserInfo scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
	}
	
	if([CityText isFirstResponder]){
		NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:7 inSection:0];
		[tableUpdateUserInfo scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
	}
	if([RegionText isFirstResponder]){
		NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:8 inSection:0];
		[tableUpdateUserInfo scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
	}
    
	if([PostCodeText isFirstResponder]){
		NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:10 inSection:0];
		[tableUpdateUserInfo scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
	}
	if([mobileText isFirstResponder]){
        
		NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:11 inSection:0];
		[tableUpdateUserInfo scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
	}
	
	
	if([emailText isFirstResponder]){
		if(isViewMoveUp)
		{
			//[self setViewMovedUp:YES];
			isViewMoveUp = NO;
		}
		NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:12 inSection:0];
		[tableUpdateUserInfo scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
	}
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (range.location > 0 && range.length == 1 && string.length == 0)
    {
        // iOS is trying to delete the entire string
        //textField.text = [textField.text substringToIndex:textField.text.length - 1];
        return YES;
    }
    else{
        
        if (textField==PostCodeText||textField==mobileText) {
            
            if ([string isEqualToString:@" "]) {
                return NO;
            }
            else{
                // return YES;
            }
        }
        if(textField == emailText)
        {
            //max 50 charactersss.....
            
            if (string.length==0) {
                return YES;
            }
            else{
                
                if (textField.text.length<50) {
                    return YES;
                }
                else{
                    return NO;
                }
            }
        }
        if( textField == fNameText ||textField == mNameText || textField == lNameText)
        {
            //max 40 charactersss.....
            if (string.length==0) {
                return YES;
            }
            else{
                
                if (textField.text.length<40) {
                    return YES;
                }
                else{
                    return NO;
                }
            }
        }
        if( textField == addressText1 ||textField == addressText2 || textField == CityText)
        {
            //max 30 charactersss.....
            if (string.length==0) {
                return YES;
            }
            else{
                
                
                
                if(textField==CityText)
                {
                    
                    if (textField.keyboardType == UIKeyboardTypeDefault)
                    {
                        if ([string rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound)
                        {
                            // BasicAlert(@"", @"This field accepts only numeric entries.");
                            if (textField.text.length<40) {
                                return YES;
                            }
                            else{
                                return NO;
                            }
                        }
                        else{
                            return NO;
                        }
                    }
                    
                    
                    
                }
                else{
                    
                    if (textField.text.length<30) {
                        return YES;
                    }
                    else{
                        return NO;
                    }
                }
            }
        }
        if( textField == RegionText ||textField == countryText)
        {
            //max 20 charactersss.....
            if (string.length==0) {
                return YES;
            }
            else{
                
                if (textField.text.length<20) {
                    return YES;
                }
                else{
                    return NO;
                }
            }
        }
        
        if(textField==mobileText)
        {
            //max 15 charactersss.....
            if (string.length==0) {
                return YES;
            }
            else{
                if (textField.text.length<15) {
                    
                    if(textField==mobileText)
                    {
                        if (textField.keyboardType == UIKeyboardTypeNumbersAndPunctuation)
                        {
                            if ([string rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound)
                            {
                                // BasicAlert(@"", @"This field accepts only numeric entries.");
                                
                                return NO;
                            }
                            else{
                                return YES;
                            }
                        }
                    }
                    else
                        
                        return YES;
                }
                else{
                    return NO;
                }
            }
        }
        if( textField == PostCodeText)
        {
            //max 10 charactersss.....
            if (string.length==0) {
                return YES;
            }
            else{
                
                if (textField.text.length<10) {
                    return YES;
                }
                else{
                    return NO;
                }
            }
        }
    }
    
	return YES;
}
#pragma mark - Status bar ------------------------------------------------------

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
#pragma mark - drawerbackbutton
- (void)_addRightTapped:(id)sender {
    NSLog(@"tapp me");
    [self.sidePanelController toggleLeftPanel:sender];
     [self.view endEditing:YES];
    // self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[JACenterViewController alloc] init]];
}



@end
