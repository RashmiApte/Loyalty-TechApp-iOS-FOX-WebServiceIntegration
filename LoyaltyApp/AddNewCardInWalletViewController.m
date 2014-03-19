/*
 *
 * Copyright -Year _Company Name_.  All rights reserved.
 *
 * File Name       : AddNewCardInWalletViewController.m
 *
 * Created Date    : 13/05/10
 *
 * Description     :
 *
 * Modification History:
 *
 * Date            Name                Description
 * ------------------------------------------------
 * 13/05/10	   Nirmal Patidar
 * 02/08/13    Rashmi Jati Apte     initWithFrame:reuseIdentifier: is deprecated in iOS 3.0. Replaced it with initWithStyle:reuseIdentifier:
 * 09/08/13    Ankit Jain           UITextAlignmentLeft is deprecated in ios 6.0 replace it with NSTextAlignmentLeft
 * Bug History:
 *
 * Date            Id                Description
 * ------------------------------------------------
 *
 */


#import "AddNewCardInWalletViewController.h"
#import "Constant.h"
#import "Common.h"
#import "WebserviceOperation.h"
#import "YPAddCardRequest.h"
#import "DataBase.h"
#import "HudView.h"
#import "CustumDate.h"
#import "YPAddCardResponse.h"


#define kOFFSET_FOR_KEYBOARD 65.0
#define kNumPadReturnButtonTag 500

@implementation AddNewCardInWalletViewController
@synthesize tableAddNewCard;
@synthesize staticimageview;
@synthesize pickerbgimage;
@synthesize holdertextfield;
@synthesize pickertransperntimg;
@synthesize imgOnline;
//expiry picker
@synthesize montharray,yeararray;
@synthesize closebtnstr;
BOOL wantMoveUp;
BOOL isPickerMoveUp;
BOOL emailFlag,passwordFlag;
BOOL isCountry;

#pragma mark UIViewController Methods ------------------------

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    self.strtxtcolor=@"none";
    
    [super viewDidLoad];
    
    [self setTitle:@"Add New Card"];
    
    setCurrCodeSetting=[[NSString alloc] init];
    setCounryCode=[[NSString alloc] init];
    
    //---------------------------------------------------------------
    
	if([Common isNetworkAvailable])
	{
		//isNetwork.text= NSLocalizedString(@"NetWork Available", @"");
        imgOnline.image=[UIImage imageNamed:@"online.png"];
	}
	else {
		//isNetwork.text= NSLocalizedString(@"No NetWork Available", @"");
        imgOnline.image=[UIImage imageNamed:@"offline.png"];
	}
    //---------------------------------------------------------------
    
	appDelegate = (CAppDelegate*)[[UIApplication sharedApplication] delegate];
    
	[tableAddNewCard setBackgroundColor:[UIColor clearColor]];
	[tableAddNewCard setSeparatorColor:TableViewCellSeperatorColor];
    
	[countryText setBackgroundColor:[UIColor clearColor]];
	
	NSString *country=[[NSUserDefaults standardUserDefaults] objectForKey:@"CountrySetting"]; 
	setCurrCodeSetting= [[NSUserDefaults standardUserDefaults] objectForKey:@"CountryCodeSetting"];
	
	if ([country length]==0) {
        
		[countryText setText:@"United Kingdom"];
		setCurrCodeSetting=@"826";
	}else {
		[countryText setText:country];
	}
    //Added by Ankit jain 12/nov/2013.
    CGRect textfieldframe=CGRectMake(3,7,283,36);
    //----------- set frames ----------------------------------------
	countryText = [[UITextField alloc] initWithFrame:textfieldframe];
	cardNumberText = [[UITextField alloc] initWithFrame:textfieldframe];
	cvvText = [[UITextField alloc] initWithFrame:textfieldframe];
	expiryText = [[UITextField alloc] initWithFrame:textfieldframe];
	startText = [[UITextField alloc] initWithFrame:textfieldframe];
	cardNameText = [[UITextField alloc] initWithFrame:textfieldframe];
	cardHolderNameText = [[UITextField alloc] initWithFrame:textfieldframe];
	cardIssuerNumberText = [[UITextField alloc] initWithFrame:textfieldframe];
	cardIssuerNameText = [[UITextField alloc] initWithFrame:textfieldframe];
	address1Text = [[UITextField alloc] initWithFrame:textfieldframe];
	address2Text = [[UITextField alloc] initWithFrame:textfieldframe];
	cityText = [[UITextField alloc] initWithFrame:textfieldframe];
	postCodeText = [[UITextField alloc] initWithFrame:textfieldframe];
	phoneText = [[UITextField alloc] initWithFrame:textfieldframe];
	faxText = [[UITextField alloc] initWithFrame:textfieldframe];
	emailText = [[UITextField alloc] initWithFrame:textfieldframe];
    holdertextfield=[[UITextField alloc]initWithFrame:textfieldframe];
    //----------------------------------------------------------------
    //----------- set delegate to textfield objects ----------------
    cardNumberText.delegate=self;
    cvvText.delegate=self;
    expiryText.delegate=self;
    startText.delegate=self;
    cardNameText.delegate=self;
    cardHolderNameText.delegate=self;
    cardIssuerNumberText.delegate=self;
    cardIssuerNameText.delegate=self;
    address1Text.delegate=self;
    address2Text.delegate=self;
    cityText.delegate=self;
    postCodeText.delegate=self;
    phoneText.delegate=self;
    faxText.delegate=self;
    emailText.delegate=self;
    countryText.delegate=self;
    //---------------------------------------------------------------
    
    //---------------------------------------------------------------
    getCountryName = [[NSMutableArray alloc] init];
	getCountryCode = [[NSMutableArray alloc] init];
	getCountryList = [[NSMutableArray alloc] init];
    //---------------------------------------------------------------
    
    
	wantMoveUp = YES;
    isPickerMoveUp = YES;
    countryText.text=@"United Kingdom";
    countryText.textColor=[UIColor lightGrayColor];
    
    //----------------------------------------------------------------
	[expiryText setBackgroundColor:[UIColor clearColor]];
	[expiryText setTextColor:[UIColor lightGrayColor]];
	[expiryText setPlaceholder:@"Expiry Date (MM/YY)*"];
	[startText setBackgroundColor:[UIColor clearColor]];
	[startText setTextColor:[UIColor lightGrayColor]];
    //----------------------------------------------------------------
	TempViewForDatePicker = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 250)];
    
	[TempViewForDatePicker setBackgroundColor:[UIColor clearColor]];
	
    
    //----------------------------------------------------------------
    //Expiry picker
    expdatepickerview=[[UIPickerView alloc]init];
    expdatepickerview.showsSelectionIndicator=YES;
    expdatepickerview.delegate = self;
    expdatepickerview.dataSource = self;
    expdatepickerview.tag=502;
	expdatepickerview.center=CGPointMake(170.0,145.0);
    CustumDate *expdate=[[CustumDate alloc]init];
    [expdate createmonthyear];
    self.montharray=[[NSArray alloc]initWithArray:expdate.montharray];
    self.yeararray=[[NSArray alloc]initWithArray:expdate.yeararray];
    NSLog(@"month array is %@",self.montharray);
    NSLog(@"year array is %@",self.yeararray);
    
    
    //added by Ankit jain 25/oct/2013.
    self.pickertransperntimg=[[UIImageView alloc]initWithFrame:CGRectMake(0,30, 320, 210)];
	self.pickerbgimage=[[UIImageView alloc]initWithFrame:CGRectMake(0,34, 320, 210)];
    self.pickerbgimage.image=[UIImage imageNamed:@"calendar_bg.png"];
    self.pickertransperntimg.image=[UIImage imageNamed:@"background_white.png"];
    [TempViewForDatePicker addSubview:self.pickertransperntimg];
    [TempViewForDatePicker addSubview:self.pickerbgimage];
    [TempViewForDatePicker addSubview:self.pickerbgimage];
    
    //--------------------SetFrameForIphone4AndIphone5-----------------
    if ([UIScreen mainScreen].bounds.size.height==568) {
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
            TempViewForDatePicker.center=CGPointMake(160.0,430.0);
        }
        else{
            TempViewForDatePicker.center=CGPointMake(160.0,450.0);
        }
    }
    else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)
        {
            TempViewForDatePicker.center=CGPointMake(160.0,345.0);
            
        }
        else
        {
            TempViewForDatePicker.center=CGPointMake(160.0,360.0);
            
        }
        
    }
    //----------------------------------------------------------------
    countryPicker.hidden=YES;
	expdatepickerview.hidden=YES;
    expdatepickerview.hidden=YES;
	countryPicker=[[UIPickerView alloc] init];
	countryPicker.center=CGPointMake(170.0,143.0);
	countryPicker.delegate = self;
    countryPicker.dataSource = self;
	countryPicker.showsSelectionIndicator=YES;
    [countryText setTextColor:textFieldnoneditableColor];
    
	[TempViewForDatePicker setHidden:YES];
	dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"MM/yy"];
	isCountry=NO;
	isStartDate=NO;
	isEndDate=NO;
    
    //--------------------- Submit button ---------------------------
    
	UIButton *btnSubmit =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSubmit setBackgroundImage:[UIImage imageNamed:@"button_home_60_29.png"] forState:UIControlStateNormal];
	//[btnSubmit setImage:[UIImage imageNamed:@"submit.png"] forState:UIControlStateNormal];
	[btnSubmit addTarget:self action:@selector(Submit) forControlEvents:UIControlEventTouchUpInside];
    [btnSubmit setTitle:@"Submit" forState:UIControlStateNormal];
	[btnSubmit setFrame:CGRectMake(253,7,60,29)];//0, 0, 76, 44
    btnSubmit.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(14.0)];
    [btnSubmit.titleLabel setTextColor:btntextColor];
    
    //----------------------------------------------------------------
    
    //---------------------- Back button -----------------------------
    
	UIButton *btnBack =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"button_home_60_29.png"] forState:UIControlStateNormal];
	[btnBack addTarget:self action:@selector(BacktoView) forControlEvents:UIControlEventTouchUpInside];
    btnBack.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(14.0)];
    [btnBack.titleLabel setTextColor:btntextColor];
    [btnBack setTitle:@"Back" forState:UIControlStateNormal];
	[btnBack setFrame:CGRectMake(5,7, 60, 29)];
    
    
    
    
    //--------------------- Design heder of This screen --------------
    
    CGRect re= CGRectMake(0, 0, 320, 53);
    UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_back.png"]];//create_new_ac_back.png
    UILabel *lbl =[[UILabel alloc]init];
    CGRect lblrect= CGRectMake(98, 8, 180, 23);// 73, 10, 142, 23
    lbl.frame=lblrect;
    lbl.text=@"Add New Card";
    [lbl setTextColor:headertitletextColor];
    lbl.font = [UIFont fontWithName:labelregularFont size:(22.0)];
    lbl.backgroundColor=[UIColor clearColor];
    
    // lbl.textColor =[UIColor colorWithRed:01.0f/255.0f green:57.0f/255.0f blue:116.0f/255.0f alpha:1.0f];
    [img addSubview:lbl];
    img.frame=re;
    
    [self.view addSubview:img];
    [self.view addSubview:btnBack];
    [self.view addSubview:btnSubmit];
    //----------------------------------------------------------------
    if ([UIScreen mainScreen].bounds.size.height != 568)
    {
        tableAddNewCard.frame=CGRectMake(15, 61, 307, 330);
        
        imgOnline.frame=CGRectMake(260, 399, 42, 9);
    }
    
}

- (void)viewWillAppear:(BOOL)animated

{
    [self.navigationController setNavigationBarHidden:YES];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
												 name:UIKeyboardWillShowNotification object:self.view.window];
    [super viewWillAppear:animated];
    
    if([Common isNetworkAvailable])
    {
        //isNetwork.text= NSLocalizedString(@"NetWork Available", @"");
        imgOnline.image=[UIImage imageNamed:@"online.png"];
    }
    else {
        //isNetwork.text= NSLocalizedString(@"No NetWork Available", @"");
        imgOnline.image=[UIImage imageNamed:@"offline.png"];
    }
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
    
}

-(void)viewDidAppear:(BOOL)animated
{
	CGFloat navBarHeight = 50.0f;
	CGRect frame = CGRectMake(0.0f, 20.0f, 320.0f, navBarHeight);
	[self.navigationController.navigationBar setFrame:frame];
	[super viewDidAppear:animated];
}



-(void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	TempViewForDatePicker.hidden = YES;
	countryPicker.hidden = YES;
	expdatepickerview.hidden = YES;
    //[self setPickerMoveUp:YES];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark - Pickerview delegate -------------------------
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if(pickerView.tag==502)
    {
        return 150;
    }
    else
        return 300;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if(pickerView.tag==502)
    {
        return 2;
    }
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView.tag==502)
    {
        NSLog(@"component is %d",component);
        if(component==0)
        {
            NSLog(@"month array count is %d",[self.montharray count]);
            return [self.montharray count];
            
        }
        else{
            if(component==1)
            {
                NSLog(@"month array count is %d",[self.yeararray count]);
                return [self.yeararray count];
            }
        }
    }
    return[getCountryName count];
}


//Added by ANkit Jain 29/oct/2013 for set picker alighnment in ios 7
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    if(pickerView.tag==502)
    {
        
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        if(component==0)
        {label.frame=CGRectMake(0, 0,120, 37);
            label.text= [self.montharray objectAtIndex:row];
            NSLog(@"value of label is %@",label.text);
        }
        else
            if(component==1)
            {
                label.frame=CGRectMake(0, 0,40,40);
                label.text= [self.yeararray objectAtIndex:row];
                label.textAlignment = NSTextAlignmentLeft;
                label.backgroundColor = [UIColor clearColor];
            }
    }
    else
    {
        label.frame=CGRectMake(0, 0, 280, 37);
        label.text =[getCountryName objectAtIndex:row];
        
    }
    return label;
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	
    selectRow=0;
    
    selectRow=row;
    
}

#pragma mark  - UIAlertview delegate --------------------------

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	
	if (buttonIndex ==0) {
		
		if (alertView.tag == 101) {
		//	[appDelegate logout];
		}
	}
	if(buttonIndex == 0)
	{
		if (alertView.tag == 123) {
			[self BacktoView];
		}
        
	}
}


#pragma mark TableView Functions --------------------------

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
	if(section == 0)
		return 13;
	else
		return 0;
	
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	NSString *title = nil;
	switch (section){
		case 0:{
			title = @"Enter Details";
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
    label.frame = CGRectMake(3, -5, 300, 30);
    label.backgroundColor = [UIColor whiteColor];
    label.text = sectionTitle;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,50)];
    [view addSubview:label];
    
    return view;
}
//for textfield padding Added by Ankit Jain 26/nov/2013
-(void)texfieldpadding:(UITextField*)textfield
{
    UIView *emailpaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 20)];
    textfield.leftView = emailpaddingView;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell;
	
	int row =   [indexPath row];
	int section=[indexPath section];
	CGRect nameLabelRect = CGRectMake(7 , 5, 240, 25);
	UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameLabelRect];
    
    NSString *cellIdentifier;
	
	cellIdentifier =nil;
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
	[nameLabel setTextColor:firstLabelFontColor];
    UIImageView *textFieldBackgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(3,7,283,36)];
	//UIImageView *textFieldBackgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(25, 4, 223, 30)];
	[textFieldBackgroundImage setImage:[UIImage imageNamed:@"entry_field.png"]];
	[cell.contentView addSubview:textFieldBackgroundImage];
	
	[nameLabel setBackgroundColor:[UIColor clearColor]];
	
	NSLog(@"Card holder Firsrtname.=%@, middleName=%@ and LAst Name==>%@",firstName,middleName,lastName);
	if ([middleName length]<=0 || [middleName isEqualToString:@"(null)"]) {
		firstMiddleLast = [firstName stringByAppendingString:[NSString stringWithFormat:@"  %@",lastName]];
	}
	else {
		firstMiddleLast = [firstName stringByAppendingString:[NSString stringWithFormat:@" %@  %@",middleName,lastName]];
	}
 	NSLog(@"Card holder name..%@",firstMiddleLast);
	
    if (section==0 && row==0) {
		[cardHolderNameText setKeyboardAppearance:UIKeyboardAppearanceAlert];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cardHolderNameText.tag = 1;
		cardHolderNameText.delegate = self;
		cardHolderNameText.placeholder =@"Cardholder Name *";
		cardHolderNameText.returnKeyType = UIReturnKeyNext;
		cardHolderNameText.keyboardType = UIKeyboardTypeDefault;
		cardHolderNameText.autocorrectionType = UITextAutocorrectionTypeNo;
		cardHolderNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
		cardHolderNameText.clearsOnBeginEditing = NO;
		[cardHolderNameText setTextAlignment:NSTextAlignmentLeft];
        [self texfieldpadding:cardHolderNameText];
		cardHolderNameText.font=[textFieldnewTextFont];
        [cardHolderNameText setTextColor:textFieldTextColor];
        [cardHolderNameText setValue:placeholdertexfield];
        cardHolderNameText.layer.cornerRadius=5;
        
        if(holdertextfield)
        {
            
        }
        cardHolderNameText.layer.borderWidth=0;
		[cell.contentView addSubview:cardHolderNameText];
    }
    if (section==0 && row==1) {
        
        nameLabel.textAlignment =NSTextAlignmentLeft;
		nameLabel.text = @"Card Number:";
		[cardNumberText setKeyboardAppearance:UIKeyboardAppearanceAlert];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cardNumberText.tag = 1;
		cardNumberText.delegate = self;
		cardNumberText.placeholder =@"Card Number *";
		cardNumberText.returnKeyType = UIReturnKeyNext;
		cardNumberText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
		cardNumberText.autocorrectionType = UITextAutocorrectionTypeNo;
		cardNumberText.clearButtonMode = UITextFieldViewModeWhileEditing;
		cardNumberText.clearsOnBeginEditing = NO;
		[cardNumberText setTextAlignment:NSTextAlignmentLeft];
		cardNumberText.font=[textFieldnewTextFont];
        [cardNumberText setTextColor:textFieldTextColor];
        [cardNumberText setValue:placeholdertexfield];
        [self texfieldpadding:cardNumberText];
        cardNumberText.layer.cornerRadius=5;
        cardNumberText.layer.borderWidth=0;
        [cell.contentView addSubview:cardNumberText];
        
    }
    if (section==0 && row==2) {
        
        nameLabel.textAlignment = NSTextAlignmentLeft;
		nameLabel.text = @"Card Name:";
		[cardNameText setKeyboardAppearance:UIKeyboardAppearanceAlert];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cardNameText.tag = 1;
		cardNameText.delegate = self;
		cardNameText.placeholder =@"Card Name *";
		cardNameText.returnKeyType = UIReturnKeyNext;
		cardNameText.keyboardType = UIKeyboardTypeDefault;
		cardNameText.autocorrectionType = UITextAutocorrectionTypeNo;
		cardNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
		cardNameText.clearsOnBeginEditing = NO;
		[cardNameText setTextAlignment:NSTextAlignmentLeft];
        [self texfieldpadding:cardNameText];
		cardNameText.font=[textFieldnewTextFont];
        [cardNameText setTextColor:textFieldTextColor];
        [cardNameText setValue:placeholdertexfield];
        cardNameText.layer.cornerRadius=5;
        cardNameText.layer.borderWidth=0;
        [cell.contentView addSubview:cardNameText];
        
        
    }
    if (section==0 && row==3) {
        
		[cvvText setKeyboardAppearance:UIKeyboardAppearanceAlert];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cvvText.tag = 1;
		cvvText.delegate = self;
		cvvText.placeholder =@"CVV/CSC *";
		cvvText.secureTextEntry = YES;
		cvvText.returnKeyType = UIReturnKeyNext;
		cvvText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
		cvvText.autocorrectionType = UITextAutocorrectionTypeNo;
		cvvText.clearButtonMode = UITextFieldViewModeWhileEditing;
		cvvText.clearsOnBeginEditing = NO;
		cvvText.font=[textFieldnewTextFont];
        [cvvText setTextColor:textFieldTextColor];
        [cvvText setValue:placeholdertexfield];
        [self texfieldpadding:cvvText];
		[cvvText setTextAlignment:NSTextAlignmentLeft];
        cvvText.layer.cornerRadius=5;
        cvvText.layer.borderWidth=0;
        [cell.contentView addSubview:cvvText];
        
        
    }
    if (section==0 && row==4) {
        nameLabel.textAlignment = NSTextAlignmentLeft;
		nameLabel.text = @"Expiry Date:";
		[expiryText setTextAlignment:NSTextAlignmentLeft];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        expiryText.layer.cornerRadius=5;
        expiryText.layer.borderWidth=0;
        expiryText.font=[textFieldnewTextFont];
        [expiryText setTextColor:textFieldTextColor];
        [expiryText setValue:placeholdertexfield];
        [self texfieldpadding:expiryText];
		[cell.contentView addSubview:expiryText];
        
        
        //----------------Transparent button to open picker-----------------------
        UIButton *btnShowPicker=[UIButton buttonWithType:UIButtonTypeCustom];
        btnShowPicker.frame=CGRectMake(3,7,283,36);
        btnShowPicker.backgroundColor=[UIColor clearColor];
        btnShowPicker.alpha=0.5;
        btnShowPicker.tag=0;
        [btnShowPicker addTarget:self action:@selector(openPickerButtonUpatecard:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnShowPicker];
        //-------------------------------------------------------------------------
        
    }
    if (section==0 && row==5) {
        
		[address1Text setKeyboardAppearance:UIKeyboardAppearanceAlert];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		address1Text.tag = 1;
		address1Text.delegate = self;
		address1Text.placeholder =@"Street Address 1 *";
		address1Text.returnKeyType = UIReturnKeyNext;
		address1Text.keyboardType = UIKeyboardTypeDefault;
		address1Text.autocorrectionType = UITextAutocorrectionTypeNo;
		address1Text.clearButtonMode = UITextFieldViewModeWhileEditing;
		address1Text.clearsOnBeginEditing = NO;
		[address1Text setTextAlignment:NSTextAlignmentLeft];
        [self texfieldpadding:address1Text];
		address1Text.font=[textFieldnewTextFont];
        [address1Text setTextColor:textFieldTextColor];
        [address1Text setValue:placeholdertexfield];
        address1Text.layer.cornerRadius=5;
        address1Text.layer.borderWidth=0;
		[cell.contentView addSubview:address1Text];
        
    }
    if (section==0 && row==6) {
        [address2Text setKeyboardAppearance:UIKeyboardAppearanceAlert];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		address2Text.tag = 1;
		address2Text.delegate = self;
		address2Text.placeholder =@"Street Address 2";
		address2Text.returnKeyType = UIReturnKeyNext;
		address2Text.keyboardType = UIKeyboardTypeDefault;
		address2Text.autocorrectionType = UITextAutocorrectionTypeNo;
		address2Text.clearButtonMode = UITextFieldViewModeWhileEditing;
		address2Text.clearsOnBeginEditing = NO;
		[address2Text setTextAlignment:NSTextAlignmentLeft];
        [self texfieldpadding:address2Text];
		address2Text.font=[textFieldnewTextFont];
        [address2Text setTextColor:textFieldTextColor];
        [address2Text setValue:placeholdertexfield];
        address2Text.layer.cornerRadius=5;
        address2Text.layer.borderWidth=0;
		[cell.contentView addSubview:address2Text];
    }
    if (section==0 && row==7) {
        [cityText setKeyboardAppearance:UIKeyboardAppearanceAlert];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cityText.tag = 1;
		cityText.delegate = self;
		cityText.placeholder =@"City";
		cityText.returnKeyType = UIReturnKeyNext;
		cityText.keyboardType = UIKeyboardTypeDefault;
		cityText.autocorrectionType = UITextAutocorrectionTypeNo;
		cityText.clearButtonMode = UITextFieldViewModeWhileEditing;
		cityText.clearsOnBeginEditing = NO;
		[cityText setTextAlignment:NSTextAlignmentLeft];
        [self texfieldpadding:cityText];
		cityText.font=[textFieldnewTextFont];
        [cityText setTextColor:textFieldTextColor];
        [cityText setValue:placeholdertexfield];
        cityText.layer.cornerRadius=5;
        cityText.layer.borderWidth=0;
		[cell.contentView addSubview:cityText];
    }
    if (section==0 && row==8) {
        [postCodeText setKeyboardAppearance:UIKeyboardAppearanceAlert];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		postCodeText.tag = 1;
		postCodeText.delegate = self;
		postCodeText.placeholder =@"Post Code *";
		postCodeText.returnKeyType = UIReturnKeyNext;
		postCodeText.keyboardType = UIKeyboardTypeDefault;
		postCodeText.autocorrectionType = UITextAutocorrectionTypeNo;
		postCodeText.clearButtonMode = UITextFieldViewModeWhileEditing;
		postCodeText.clearsOnBeginEditing = NO;
        [self texfieldpadding:postCodeText];
		[postCodeText setTextAlignment:NSTextAlignmentLeft];
		postCodeText.font=[textFieldnewTextFont];
        [postCodeText setTextColor:textFieldTextColor];
        [postCodeText setValue:placeholdertexfield];
        postCodeText.layer.cornerRadius=5;
        postCodeText.layer.borderWidth=0;
        [cell.contentView addSubview:postCodeText];
        
        
        
    }
    if (section==0 && row==9) {
        
        
        [countryText setTextAlignment:NSTextAlignmentLeft];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        countryText.layer.cornerRadius=5;
        countryText.layer.borderWidth=0;
        [self texfieldpadding:countryText];
        countryText.font=[textFieldnewTextFont];
        
        [countryText setValue:placeholdertexfield];
		[cell.contentView addSubview:countryText];
        countryText.placeholder=@"Country";
        //----------------Transparent button to open picker-----------------------
        UIButton *btnShowPicker=[UIButton buttonWithType:UIButtonTypeCustom];
        btnShowPicker.frame=CGRectMake(3,7,283,36);
        btnShowPicker.backgroundColor=[UIColor clearColor];
        btnShowPicker.alpha=0.5;
        btnShowPicker.tag=1;
        [btnShowPicker addTarget:self action:@selector(openPickerButtonUpatecard:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnShowPicker];
        //-------------------------------------------------------------------------
    }
    if (section==0 && row==10) {
        
		[emailText setKeyboardAppearance:UIKeyboardAppearanceAlert];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		emailText.tag = 1;
		emailText.delegate = self;
	    emailText.placeholder=@"Email Address";
		emailText.returnKeyType = UIReturnKeyNext;
		emailText.keyboardType = UIKeyboardTypeDefault;
		emailText.autocorrectionType = UITextAutocorrectionTypeNo;
		emailText.clearButtonMode = UITextFieldViewModeWhileEditing;
		emailText.clearsOnBeginEditing = NO;
		[emailText setTextAlignment:NSTextAlignmentLeft];
        [self texfieldpadding:emailText];
        emailText.font=[textFieldnewTextFont];
        [emailText setTextColor:textFieldTextColor];
        [emailText setValue:placeholdertexfield];
        emailText.layer.cornerRadius=5;
        emailText.layer.borderWidth=0;
        
        [cell.contentView addSubview:emailText];
    }
    if (section==0 && row==11) {
        [phoneText setKeyboardAppearance:UIKeyboardAppearanceAlert];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		phoneText.tag = 1;
		phoneText.delegate = self;
		phoneText.placeholder =@"Phone";
		phoneText.returnKeyType = UIReturnKeyNext;
		phoneText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
		phoneText.autocorrectionType = UITextAutocorrectionTypeNo;
		phoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
		phoneText.clearsOnBeginEditing = NO;
		[phoneText setTextAlignment:NSTextAlignmentLeft];
        [self texfieldpadding:phoneText];
        phoneText.font=[textFieldnewTextFont];
        [phoneText setTextColor:textFieldTextColor];
        [phoneText setValue:placeholdertexfield];
        phoneText.layer.cornerRadius=5;
        phoneText.layer.borderWidth=0;
		[cell.contentView addSubview:phoneText];
    }
    if (section==0 && row==12) {
        [faxText setKeyboardAppearance:UIKeyboardAppearanceAlert];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		faxText.tag = 1;
		faxText.delegate = self;
		faxText.placeholder =@"Fax";
		faxText.returnKeyType = UIReturnKeyDone;
		faxText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
		faxText.autocorrectionType = UITextAutocorrectionTypeNo;
		faxText.clearButtonMode = UITextFieldViewModeWhileEditing;
		faxText.clearsOnBeginEditing = NO;
		[faxText setTextAlignment:NSTextAlignmentLeft];
        [self texfieldpadding:faxText];
        faxText.font=[textFieldnewTextFont];
        [faxText setTextColor:textFieldTextColor];
        [faxText setValue:placeholdertexfield];
        faxText.layer.cornerRadius=5;
        faxText.layer.borderWidth=0;
		[cell.contentView addSubview:faxText];
    }
    cell.backgroundColor=[UIColor clearColor];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark -expirypicker othe methode
-(void)selectToday
{
    NSInteger monthselectRow=0;
    NSInteger yearselectRow1=0;
    NSString *month = [self currentMonthName];
    NSString *year  = [self currentYearName];
    monthselectRow=[self.montharray indexOfObject:month];
    [expdatepickerview selectRow:monthselectRow inComponent:0 animated:NO];
    yearselectRow1=[self.yeararray indexOfObject:year];
    [expdatepickerview selectRow:yearselectRow1 inComponent:1 animated:NO];
}
-(NSString *)currentMonthName
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    return [formatter stringFromDate:[NSDate date]];
}

-(NSString *)currentYearName
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    return [formatter stringFromDate:[NSDate date]];
}

#pragma mark - UIScrollview delegate --------------------------

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if(!wantMoveUp)
	{
		//[self setViewMovedUp:NO];
		wantMoveUp = YES;
	}
}

#pragma mark Other Functions

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5]; // if you want to slide up the view
	
    CGRect rect = tableAddNewCard.frame;
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
    tableAddNewCard.frame = rect;
	
    [UIView commitAnimations];
}


- (void)keyboardWillShow:(NSNotification *)notif
{
    //keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
	NSLog(@"Origin is %f",tableAddNewCard.frame.origin.y );
	
	if ( [postCodeText isFirstResponder] || [phoneText isFirstResponder] || [faxText isFirstResponder] || [emailText isFirstResponder])
    {
        if(wantMoveUp)
		{
			//[self setViewMovedUp:YES];
			wantMoveUp = NO;
			
		}
		
    }
	else if(!wantMoveUp) {
		//[self setViewMovedUp:NO];
		wantMoveUp = YES;
	}
    
    
}


//Numeric key pad : adding return button
- (void) addReturnButtonInNumPad
{
	// locate keyboard view
	NSLog(@"Call");
	UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
	UIView* keyboard;
	for(int i=0; i<[tempWindow.subviews count]; i++) {
		keyboard = [tempWindow.subviews objectAtIndex:i];
		
		// keyboard view found; add the custom button to it
		if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
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


- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}


#pragma  mark - Webservice handler ---------------------
//Handles the Response of getUserInfoRequest


-(void)cardholderalertmessages:(int)statuscodevalue message:(NSString *)responsemessage
{
    switch (statuscodevalue)
    {
        case 1:
            NSLog (@"zero");
            [self commonalert:unabletoaddnewcard message:statuscode1];
            break;
        case 4:
            NSLog (@"one");
            [self commonalert:unabletoaddnewcard message:statuscode4];
            break;
        case 6:
            NSLog (@"six");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SessionExpired" object:self];
            break;
        case 7:
            NSLog (@"seven");
            [self commonalert:unabletoaddnewcard message:statuscode7];
            break;
        case 9:
            NSLog (@"nine");
            [self commonalert:unabletoaddnewcard message:statuscode9];
            break;
        case 10:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SessionExpired" object:self];
            break;
            
        case 12:
            NSLog (@"tweleve");
            [self commonalert:unabletoaddnewcard message:statuscode12];
            break;
        case 15:
            NSLog (@"fifteen");
            [self commonalert:unabletoaddnewcard message:statuscode15];
            break;
        case 16:
            NSLog (@"sisxteen");
            [self commonalert:unabletoaddnewcard message:statuscode16];
            break;
        case 17:
            NSLog (@"four");
            [self commonalert:unabletoaddnewcard message:statuscode17];
            break;
        case 18:
            NSLog (@"five");
            [self commonalert:unabletoaddnewcard message:statuscode18];
            break;
        case 21:
            NSLog (@"twenty one");
            [self commonalert:unabletoaddnewcard message:statuscode21];
            break;
        case 27:
            NSLog (@"twenty seven");
            [self commonalert:unabletoaddnewcard message:statuscode27];
            break;
        case 30:
            NSLog (@"thirty");
            [self commonalert:unabletoaddnewcard message:statuscode30];
            break;
        case 33:
            NSLog (@"thirty three");
            [self commonalert:unabletoaddnewcard message:statuscode33];
            break;
        default:
            NSLog (@"Integer out of range");
            [self commonalert:unabletoaddnewcard message:[NSString stringWithFormat:@"%@\n[Error code:%d]",responsemessage,statuscodevalue]];
            break;
    }
}
-(void)commonalert:(NSString *)title message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}


-(void)addCardHandlers:(id)value
{
    [self killHUD];
    
    [self.view endEditing:YES];
	// Handle errors
    holdertextfield.layer.cornerRadius=5;
    holdertextfield.layer.borderWidth=0;
    
    
    	if([value isKindOfClass:[NSError class]]) {
    		//[self performSelector:@selector(killHUD)];`
    		NSLog(@"%@", value);
            UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:unabletoaddnewcard message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
    		return;
    	}
    	// Handle faults
    	if([value isKindOfClass:[SoapFault class]]) {
    		//[self performSelector:@selector(killHUD)];
            UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:unabletoaddnewcard message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
    		NSLog(@"%@", value);
    		return;
    	}
   
    
    YPAddCardResponse *objCardResponse=[[YPAddCardResponse alloc] init];
    
    [objCardResponse parsingAddcard:value];
    
    
    	if(objCardResponse.statusCode == 0)
    	{
    
            [[NSUserDefaults standardUserDefaults] setObject:@"addopration" forKey:@"operationfinder"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:successfullyaddcard  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert setTag:123];
            [alert show];
    	}
        else
        {
            [self cardholderalertmessages:objCardResponse.statusCode message:objCardResponse.responseMessage];
            
        }

    
    

}

#pragma mark - Button methods --------------------------
-(void)BacktoView
{
    
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)openPickerButtonUpatecard:(UIButton*)sender
{
    [self.view endEditing:YES];
    [self checkForFirstResponder];
    
    
    if (sender.tag==1) {
        [self performSelector:@selector(openCountryPicker)];
    }
    else if (sender.tag==0){
        NSLog(@"Tap on End dateeeeeeeeeeee ");
        
        [self performSelector:@selector(openDatePicker)];
    }
}

-(void)doneAction{
	
	TempViewForDatePicker.hidden= YES;
	countryPicker.hidden =YES;
	expdatepickerview.hidden =YES;
	//[countryText setTextColor:[UIColor blackColor]];
	
	CATransition* trans = [CATransition animation];
	[trans setType:kCATransitionPush];
	[trans setDuration:0.35];
	[trans setSubtype:kCATransitionFromBottom];
	// code to change the view//
	CALayer *layer = TempViewForDatePicker.layer;
    [layer addAnimation:trans forKey:@"CurlIn"];
	if ([getCountryName count]>0)
	{
		NSLog(@"row selected of pickerValue country Done %@",countryPicker);
		countryText.text = [getCountryName objectAtIndex:selectRow];
	}
    
}


-(void)closPicker
{
    if([closebtnstr isEqualToString:@"expirydatecanel"])
    {
        [address1Text becomeFirstResponder];
    }
    else
    {
        if([closebtnstr isEqualToString:@"countrycancel"])
        {
            [emailText becomeFirstResponder];
            
        }
        
    }
	TempViewForDatePicker.hidden= YES;
	expdatepickerview.hidden =YES;
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
	expdatepickerview.hidden =YES;
    
	//expiryText.text=[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:datePicker.date]];//[datePicker date]];
	expiryText.textColor=textFieldTextColor;
    int monthindex=[expdatepickerview selectedRowInComponent:0];
    NSString *monthindexstr=[NSString stringWithFormat:@"%d",monthindex+1];
    NSLog(@"value of index is %d",monthindex);
	NSString *monthtemp=[montharray objectAtIndex:monthindex];
    NSString *yeartemp=[yeararray objectAtIndex:[expdatepickerview selectedRowInComponent:1]];
    NSLog(@"value of month is %@ %@",monthtemp,yeartemp);
    
    NSDateFormatter *expdateformate=[[NSDateFormatter alloc] init];
    [expdateformate setDateFormat:@"MM/yyyy"];
    NSString *datestr = [NSString stringWithFormat:@"%@",[expdateformate stringFromDate:[NSDate date]]];
    NSDate *currentdate = [expdateformate dateFromString:datestr];
    NSDate *expdate=[expdateformate dateFromString:[NSString stringWithFormat:@"%@/%@",monthindexstr,yeartemp]];
    NSComparisonResult result = [currentdate compare:expdate];
    switch (result){
        case NSOrderedAscending:
        {
            NSLog(@"Date is valide date");
            [self selectexpirydate:monthindexstr yearstr:yeartemp];
            break;
        }
        case NSOrderedDescending:
        {
            NSLog(@"select valide date");
            UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:unabletoaddnewcard message:selctvalidexpirydate delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            break;
        }
        case NSOrderedSame:
        {
            NSLog(@"Date is  valide");
            [self selectexpirydate:monthindexstr yearstr:yeartemp];
            break;
        }
        default:
        {
            NSLog(@"invalide date");
        }
            break;
    }
    
}


-(void)selectexpirydate:(NSString*)monthindexstr yearstr:(NSString*)yeartemp
{
    if(monthindexstr.length>1)
        expiryText.text = [NSString stringWithFormat:@"%@/%@",monthindexstr, [yeartemp substringFromIndex: [yeartemp length] - 2]];
    else
        expiryText.text = [NSString stringWithFormat:@"0%@/%@",monthindexstr, [yeartemp substringFromIndex: [yeartemp length] - 2]];
    NSLog(@"value of expirydateis %@",expiryText.text);
	CATransition* trans = [CATransition animation];
	[trans setType:kCATransitionPush];
	[trans setDuration:0.35];
	[trans setSubtype:kCATransitionFromBottom];
	CALayer *layer = TempViewForDatePicker.layer;
	CALayer *layer1 = pickerDoneButton.layer;
	[layer1 addAnimation:trans forKey:@"CurlIn"];
	[layer addAnimation:trans forKey:@"CurlIn"];
    
    //---------------- card number text field become active ------//
    [address1Text becomeFirstResponder];
    NSIndexPath *middleIndexPath;
    middleIndexPath = [NSIndexPath indexPathForRow:5 inSection:0];
    [tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    //------------------------------------------------------------
}
-(void)doneContryPicker
{
	TempViewForDatePicker.hidden= YES;
	countryPicker.hidden =YES;
	//[countryText setTextColor:[UIColor blackColor]];
    [countryText setTextColor:textFieldTextColor];
	if ([getCountryName count]>0)
	{
		countryText.text = [getCountryName objectAtIndex:selectRow];
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
    
    //---------------- card number text field become active ------
    [emailText becomeFirstResponder];
    NSIndexPath *middleIndexPath;
    middleIndexPath = [NSIndexPath indexPathForRow:9 inSection:0];
    [tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    //------------------------------------------------------------
    
    
	
}

-(void)Submit
{
	emailFlag = TRUE;
	passwordFlag = FALSE;
	NSString *emailStr = emailText.text;
	NSIndexPath *middleIndexPath;
    
    NSString *alertmessagestr;
    
	if([cardHolderNameText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length!=0)
	{
		if([cardNumberText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length!=0)
		{
            if([cardNameText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length!=0)
            {
                if ([cvvText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length!=0)
                {
                    if([expiryText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length!=0)
                    {
                        if([address1Text.text stringByReplacingOccurrencesOfString:@" " withString:@""].length!=0)
                        {
                            
                            if([postCodeText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length!=0)
                            {
                                if([Common isNetworkAvailable])
                                {
                                    //isNetwork.text= NSLocalizedString(@"NetWork Available", @"");
                                    imgOnline.image=[UIImage imageNamed:@"online.png"];
                                    
                                    [self showHUD:generatingcard];
                                    
                                    
//                                    
                                    WebserviceOperation *serviceAddnewcard = [[WebserviceOperation alloc] initWithDelegate:self callback:@selector(addCardHandlers:)];
                                    
                                    
                                    YPAddCardRequest *addCardRequest=[[YPAddCardRequest alloc] init];
                                    
                                    addCardRequest.cardNumber = cardNumberText.text;
                                    addCardRequest.cardholderName = cardHolderNameText.text;
                                    addCardRequest.cardName = cardNameText.text;
                                    addCardRequest.valid =TRUE;
                                    addCardRequest.CVV = cvvText.text;
                                    addCardRequest.expiryDate = [expiryText.text stringByReplacingOccurrencesOfString:@"/" withString:@""];
                                    NSLog(@"expiry date is= %@",addCardRequest.expiryDate);
                                    NSLog(@"expiry date of text field id %@",expiryText.text);
                                    addCardRequest.SC = appDelegate.SC;
                                    addCardRequest.userName = appDelegate.userName;
                                    
                                    //--------- to find country code by country name ----------
                                    
                                    addCardRequest.country=setCurrCodeSetting;
                                    for (int i=0; i<getCountryList.count; i++)
                                    {
                                        if ([[[getCountryList objectAtIndex:i] valueForKey:@"countryName"] isEqualToString:countryText.text]) {
                                            addCardRequest.country=[[getCountryList objectAtIndex:i] valueForKey:@"countryCode"];
                                            break;
                                        }
                                    }
                                    
                                    //---------------------------------------------------------
                                    
                                    
                                    addCardRequest.applicationType = @"M";
                                    if([address1Text.text length]!=0)
                                    {
                                        addCardRequest.addressLine1 = address1Text.text;
                                    }
                                    if([address2Text.text length]!=0)
                                    {
                                        addCardRequest.addressLine2 = address2Text.text;
                                    }
                                    if([cityText.text length]!=0)
                                    {
                                        addCardRequest.city = cityText.text;
                                    }
                                    if([postCodeText.text length]!=0)
                                    {
                                        addCardRequest.postCode = postCodeText.text;
                                    }
                                    if([phoneText.text length]!=0)
                                    {
                                        addCardRequest.phone1 = phoneText.text;
                                    }
                                    if([faxText.text length]!=0)
                                    {
                                        addCardRequest.fax1 = faxText.text;
                                    }
                                    if([emailText.text length]!=0)
                                    {
                                        emailFlag = FALSE;
                                        
                                        BOOL check = [self validateEmail:emailStr];
                                        if (check == TRUE)
                                        {
                                            addCardRequest.email1 = emailText.text;
                                            emailFlag = TRUE;
                                        }
                                        else
                                        {
                                            emailFlag = FALSE;
                                            //[Common ShowAlert:@"Please enter a valid Email Id." alertTitle:@"Invalid Email Id"];
                                            //alertmessagestr=@"Please enter Post Code.";
                                            middleIndexPath = [NSIndexPath indexPathForRow:10 inSection:0];
                                            [tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                                            [self currenttextfield:emailText alerttitle:unabletoaddnewcard alertmessage:invalideemail];
                                            [self killHUD];
                                            return ;
                                            
                                        }
                                    }
                                    /*if(emailFlag== TRUE)
                                     {
                                     
                                     
                                     }*/
                                    
                                    [serviceAddnewcard addNewCard:addCardRequest];
                                    
                                    
                                }
                                else {
                                    //isNetwork.text= NSLocalizedString(@"No NetWork Available", @"");
                                    imgOnline.image=[UIImage imageNamed:@"offline.png"];
                                    //[Common ShowAlert:ConnectionErrorMessage alertTitle:ConnectionErrorTitle];
                                }
                                
                            }
                            else
                            {
                                //[Common ShowAlert:@"Please enter Post Code." alertTitle:@"Unable to Add Card"];
                                //alertmessagestr=@"Please enter Post Code.";
                                middleIndexPath = [NSIndexPath indexPathForRow:6 inSection:0];
                                [tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                                [self currenttextfield:postCodeText alerttitle:unabletoaddnewcard alertmessage:enterpostcode];
                                
                            }
                        }
                        else
                        {
                            //[Common ShowAlert:@"Please enter Address Line1." alertTitle:@"Unable to Add Card"];
                            /// alertmessagestr=@"Please enter Address Line1.";
                            middleIndexPath = [NSIndexPath indexPathForRow:5 inSection:0];
                            [tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                            [self currenttextfield:address1Text alerttitle:unabletoaddnewcard alertmessage:enterstreetAdd1];
                            
                        }
                        
                    }
                    else
                    {
                        // [Common ShowAlert:@"Please enter Expiry Date." alertTitle:@"Unable to Add Card"];
                        // alertmessagestr=@"Please enter Expiry Date.";
                        middleIndexPath = [NSIndexPath indexPathForRow:4 inSection:0];
                        [tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                        [self currenttextfield:expiryText alerttitle:unabletoaddnewcard alertmessage:expirydate];
                    }
                }
                else
                {
                    //[Common ShowAlert:@"Please enter  CVV/CSC." alertTitle:@"Unable to Add Card"];
                    //alertmessagestr=@"Please enter  CVV/CSC.";
                    middleIndexPath = [NSIndexPath indexPathForRow:3 inSection:0];
                    [tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                    [self currenttextfield:cvvText alerttitle:unabletoaddnewcard alertmessage:enterCvv];
                }
            }
            else
            {
                //[Common ShowAlert:@"Please enter Card Number." alertTitle:@"Unable to Add New Card"];
                //alertmessagestr=@"Please enter Card Number.";
                middleIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
                [tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                [self currenttextfield:cardNameText alerttitle:unabletoaddnewcard alertmessage:entercardname];
                
            }
        }
        else
        {
            //[Common ShowAlert:@"Please enter My Card Name." alertTitle:@"Unable to Add Card"];
            
            //alertmessagestr=@"Please enter My Card Name.";
            middleIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            [tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
            [self currenttextfield:cardNumberText alerttitle:unabletoaddnewcard alertmessage:entercardnumber];
        }
    }
	else
	{
		//[Common ShowAlert:@"Please enter Cardholder Name." alertTitle:@"Unable to Add New Card"];
        //alertmessagestr=@"Please enter Cardholder Name.";
        middleIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        [self currenttextfield:cardHolderNameText alerttitle:unabletoaddnewcard alertmessage:cardholdername];
        
	}
	
}
//Added by Ankit Jain 7/nov/2013 and call this methode on every aler
-(void)currenttextfield:(UITextField *)textfieldvalue alerttitle:(NSString *)alerttitlestr alertmessage:(NSString *)alertmessagestr
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alerttitlestr message:alertmessagestr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
    double delayInSeconds = .1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if(textfieldvalue==expiryText){
            [self checkForFirstResponder];
            [textfieldvalue resignFirstResponder];
            [self openDatePicker];
            
        }else{
            [textfieldvalue becomeFirstResponder];
        }
        
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

#pragma mark - UITextfield delegates --------------------------


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    if (textField==cardHolderNameText) {
        [cardNumberText becomeFirstResponder];
    }
    else if (textField==cardNumberText) {
        [cardNameText becomeFirstResponder];
    }
    else if (textField==cardNameText) {
        [cvvText becomeFirstResponder];
    }
    else if (textField==cvvText) {
        [self performSelector:@selector(openDatePicker)];
    }
    else if (textField==address1Text) {
        [address2Text becomeFirstResponder];
    }
    else if (textField==address2Text) {
        [cityText becomeFirstResponder];
    }
    else if (textField==cityText) {
        [postCodeText becomeFirstResponder];
        
    }
    else if (textField==postCodeText) {
        
        [self performSelector:@selector(openCountryPicker)];
        
    }
    else if (textField==emailText) {
        [phoneText becomeFirstResponder];
        
    }
    else if (textField==phoneText) {
        [faxText becomeFirstResponder];
        
    }
    return  YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
	[self removeReturnButtonFromNumPad];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
	
	TempViewForDatePicker.hidden= YES;
	expdatepickerview.hidden =YES;
	countryPicker.hidden =YES;
	NSLog(@"TExt ");
	if(!isPickerMoveUp)
	{
		//[self doneAction];
		isPickerMoveUp = YES;
	}
	if([cardNumberText isFirstResponder])
	{
		[self addReturnButtonInNumPad];
	}
	if([cvvText isFirstResponder])
	{
		[self addReturnButtonInNumPad];
	}
	if([cardNumberText isFirstResponder])
	{
		NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
		[tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
		
	}
	if([cvvText isFirstResponder]){
		NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:3 inSection:0];
		[tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
	}
	if([expiryText isFirstResponder]){
		NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:4 inSection:0];
		[tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
	}
	
	
	if([address1Text isFirstResponder]){
		NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:5 inSection:0];
		[tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
		[self addReturnButtonInNumPad];
	}
    
	
	if([address2Text isFirstResponder]){
		NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:6 inSection:0];
		[tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
	}
	
	if([cityText isFirstResponder]){
		NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:7 inSection:0];
		[tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
	}
	
	if([countryText isFirstResponder]){
		
		NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:8 inSection:0];
		[tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
	}
	
	if([postCodeText isFirstResponder]){
		NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:9 inSection:0];
		[tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
		
	}
	if([emailText isFirstResponder]){
        
		NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:10 inSection:0];
		[tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
	}
	if([phoneText isFirstResponder]){
		if(wantMoveUp)
		{
            NSIndexPath *middleIndexPath;
            middleIndexPath = [NSIndexPath indexPathForRow:11 inSection:0];
            [tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        }
        
    }
    if([faxText isFirstResponder]){
        
		NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:12 inSection:0];
		[tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
	}
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (range.location > 0 && range.length == 1 && string.length == 0)
    {
        // iOS is trying to delete the entire string
        // textField.text = [textField.text substringToIndex:textField.text.length - 1];
        return YES;
    }
    else{
        
        
        if (textField==cardNumberText||textField==cvvText||textField==postCodeText||textField==phoneText||textField==faxText) {
            
            if ([string isEqualToString:@" "]) {
                return NO;
            }
            else{
                // return YES;
            }
        }
        
        
        if (textField==cardNameText||textField==emailText) {
            //max 50 character...
            
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
        if (textField==cardHolderNameText||textField==address1Text||textField==address2Text ||textField==cityText ) {
            //max 40 character...
            
            if (string.length==0) {
                return YES;
            }
            else{
                
                if (textField.text.length<40) {
                    
                    if(textField==cityText)
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
                        
                        
                    }else
                        
                        
                        return YES;
                }
                else{
                    return NO;
                }
            }
        }
        
        if (textField==cardNumberText||textField==countryText) {
            //max 20 character...
            
            if (string.length==0) {
                return YES;
            }
            else{
                
                if (textField.text.length<20) {
                    
                    
                    if(textField==cardNumberText)
                    {
                        if (textField.keyboardType == UIKeyboardTypeNumbersAndPunctuation)
                        {
                            if ([string rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound)
                            {
                                
                                
                                return NO;
                            }
                            else{
                                return YES;
                            }
                        }
                    }
                    else{
                        return YES;
                    }
                }
                else{
                    return NO;
                }
            }
        }
        if (textField==faxText||textField==phoneText||textField==postCodeText) {
            //max 15 character...
            if (string.length==0) {
                return YES;
            }
            else{
                
                if (textField.text.length<15) {
                    
                    if(textField==phoneText)
                    {
                        if (textField.keyboardType == UIKeyboardTypeNumbersAndPunctuation)
                        {
                            if ([string rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound)
                            {
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
        
        if (textField==cvvText) {
            //max 8 character...
            
            if (string.length==0) {
                return YES;
            }
            else{
                
                if (textField.text.length<8) {
                    return YES;
                }
                else{
                    return NO;
                }
            }
        }
        
        if (textField==cardIssuerNumberText) {
            //max 2 character...
            
            if (string.length==0) {
                return YES;
            }
            else{
                
                if (textField.text.length<2) {
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
#pragma mark - Pickeropen methods
-(void)openDatePicker{
    NSLog(@"Tap on End dateeeeeeeeeeee ");
    selectRow=0;
    [self checkForFirstResponder];
    [TempViewForDatePicker addSubview:expdatepickerview];
    closebtnstr=@"expirydatecanel";
    
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(25,-4, 99, 43);
    
    [closeButton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    closeButton.tag = 101;
    [closeButton addTarget:self action:@selector(closPicker) forControlEvents:UIControlEventTouchUpInside];
    [TempViewForDatePicker addSubview:closeButton];
    
    [TempViewForDatePicker bringSubviewToFront:closeButton];
    
    pickerDoneButton=[UIButton buttonWithType:UIButtonTypeCustom];
    pickerDoneButton.frame = CGRectMake(194,-4, 99, 43);
    
    [pickerDoneButton setImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateNormal];
    pickerDoneButton.tag = 111;
    [pickerDoneButton addTarget:self action:@selector(doneDatePicker) forControlEvents:UIControlEventTouchUpInside];
    [TempViewForDatePicker addSubview:pickerDoneButton];
    [TempViewForDatePicker bringSubviewToFront:pickerDoneButton];
    [TempViewForDatePicker bringSubviewToFront:pickerbgimage];
    pickerDoneButton.hidden=NO;
    expdatepickerview.hidden=NO;
    TempViewForDatePicker.hidden =NO;
    [self.tabBarController.view addSubview:TempViewForDatePicker];
    
    NSIndexPath *middleIndexPath;
    middleIndexPath = [NSIndexPath indexPathForRow:4 inSection:0];
    [tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    [self selectToday];
}
-(void)openCountryPicker{
    NSLog(@"Tap on Countryyyyyyyyy ");
    [self checkForFirstResponder];
    
    if ([getCountryName count]>0) {
        
        //show contry name ------- -- -- -- -
        closebtnstr=@"countrycancel";
        [TempViewForDatePicker addSubview:countryPicker];
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame = CGRectMake(25,-4, 99, 43);
        [closeButton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
        closeButton.tag = 101;
        [closeButton addTarget:self action:@selector(closPicker) forControlEvents:UIControlEventTouchUpInside];
        [TempViewForDatePicker addSubview:closeButton];
        
        [TempViewForDatePicker bringSubviewToFront:closeButton];
        
        pickerDoneButton=[UIButton buttonWithType:UIButtonTypeCustom];
        pickerDoneButton.frame = CGRectMake(194,-4, 99, 43);
        
        [pickerDoneButton setImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateNormal];
        pickerDoneButton.tag = 111;
        [pickerDoneButton addTarget:self action:@selector(doneContryPicker) forControlEvents:UIControlEventTouchUpInside];
        [TempViewForDatePicker addSubview:pickerDoneButton];
        
        [TempViewForDatePicker bringSubviewToFront:pickerDoneButton];
        [TempViewForDatePicker bringSubviewToFront:pickerbgimage];
        
        pickerDoneButton.hidden=NO;
        // Added by Manoj 20/09/2011
        
        //------
        TempViewForDatePicker.hidden = YES;
        expdatepickerview.hidden =YES;
        
        TempViewForDatePicker.hidden = NO;
        countryPicker.hidden=NO;
        
        NSString *strCntryName = [[NSString alloc] initWithString:countryText.text];
        
        BOOL isOk = [getCountryName containsObject:strCntryName];
        if (isOk) {
            selectRow=0;
            selectRow = [getCountryName indexOfObject:strCntryName];
            [countryPicker selectRow:selectRow inComponent:0 animated:NO];
        }
        else{
            [countryPicker selectRow:0 inComponent:0 animated:NO];
        }
        
        [self.tabBarController.view addSubview:TempViewForDatePicker];
    }
    else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:Unablecountrylist delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    
    NSIndexPath *middleIndexPath;
    middleIndexPath = [NSIndexPath indexPathForRow:9 inSection:0];
    [tableAddNewCard scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    
}
-(void)checkForFirstResponder
{
    [cardHolderNameText resignFirstResponder];
    [cardNumberText resignFirstResponder];
    [cardNameText resignFirstResponder];
    [cvvText resignFirstResponder];
    [expiryText resignFirstResponder];
    [address1Text resignFirstResponder];
    [address2Text resignFirstResponder];
    [cityText resignFirstResponder];
    [postCodeText resignFirstResponder];
    [countryText resignFirstResponder];
    [emailText resignFirstResponder];
    [phoneText resignFirstResponder];
    [faxText resignFirstResponder];
    [cardIssuerNumberText resignFirstResponder];
    [cardIssuerNameText resignFirstResponder];
    
    
}

#pragma mark - Status bar ------------------------------------------------------

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
