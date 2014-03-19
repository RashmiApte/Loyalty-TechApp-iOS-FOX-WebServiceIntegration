/*
 * Copyright -Year _Company Name_.  All rights reserved.
 *
 * File Name       : SignUpViewController.m
 *
 * Created Date    : 16/12/09
 *
 * Description     :
 *
 * Modification History:
 *
 * Date            Name                Description
 * ------------------------------------------------
 * 16/12/09
 * 02/08/13    Rashmi Jati Apte     initWithFrame:reuseIdentifier: is deprecated in iOS 3.0. Replaced it                          with initWithStyle:reuseIdentifier:
 *
 * Bug History:
 *
 * Date            Id                Description
 * ------------------------------------------------
 *
 Non-3D-Secure MasterCard:
 CardNumber: 5199992312641465
 Address:  21
 Postcode: 14
 CSC: 006
 */


#import "SignUpViewController.h"
#import "DataBase.h"
#import "Constant.h"
#import "Common.h"
#import "WebserviceOperation.h"
//#import "YPCardHolderServiceService.h"
#import "YPCountryListResponse.h"
#import "YPCountryDetail.h"
#import "YPCountryListRequest.h"
#import "CAppDelegate.h"
#import "CustumDate.h"
#import "YPRegisterRequest.h"
#import "WebserviceOperation.h"
#import "YPCardInfo.h"
#import "YPRegisterResponse.h"


#define kOFFSET_FOR_KEYBOARD 93.0

#define kNumPadReturnButtonTag 500

@implementation SignUpViewController

@synthesize tableSignup;
@synthesize agreeTermsBtn;
@synthesize errorMessage;
@synthesize myButton;
@synthesize fNameText;
@synthesize holdertextfield;
@synthesize titlelbl;
@synthesize submitbtn,cancelbtn;
@synthesize imgOnline;
@synthesize pickertransperntimg;
@synthesize imgBottomImage;


//for closeing the picker view .
@synthesize closebtnstr;

//for custum picker
//@synthesize expdatepickerview;
@synthesize montharray,yeararray;

UIButton *doneButton;

int isClicked = 0;
int counter;
BOOL wantMoveUp,isPickerMoveUp,isDOB,isCountry,isCountryMoveUp;
BOOL noCurrencyFormServer;
BOOL emailFlag,passwordFlag;
BOOL isProcess;
#pragma mark UIViewController Functions ----------------------------

- (void)viewDidLoad{
    [super viewDidLoad];
    isProcess=YES;
    isSexLabel=NO;
    selectRowGender=0;
    NSLog(@"sighnup viewdidlaod");
    appdelegate = (CAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSLocalizedString(@"CreateOneTimeCardTitle", @"");
    
    if([Common isNetworkAvailable])
    {
        isNetwork.text= NSLocalizedString(@"NetWork Available", @"");
    }
    else {
        isNetwork.text= NSLocalizedString(@"No NetWork Available", @"");
    }
    
    noCurrencyFormServer= NO;
    [tableSignup setBackgroundColor:[UIColor clearColor]];
    [tableSignup setSeparatorColor:TableViewCellSeperatorColor];
    
    //Added by Ankit jan 12/nov/2013
    CGRect textfieldframe=CGRectMake(3,7,283,36);
    
    self.fNameText = [[UITextField alloc] initWithFrame:textfieldframe];
    holdertextfield=[[UITextField alloc]initWithFrame:textfieldframe];
    lNameText = [[UITextField alloc] initWithFrame:textfieldframe];
    sexText = [[UITextField alloc] initWithFrame:textfieldframe];
    mobileText = [[UITextField alloc] initWithFrame:textfieldframe];
    dateOfBirthText = [[UITextField alloc] initWithFrame:textfieldframe];
    countryText = [[UITextField alloc] initWithFrame:textfieldframe];
    emailText = [[UITextField alloc] initWithFrame:textfieldframe];
    passwordText = [[UITextField alloc] initWithFrame:textfieldframe];
    confirmPasstext = [[UITextField alloc] initWithFrame:textfieldframe];
    
    mNameText = [[UITextField alloc] initWithFrame:textfieldframe];
    addressText1 = [[UITextField alloc] initWithFrame:textfieldframe];
    addressText2 = [[UITextField alloc] initWithFrame:textfieldframe];
    CityText = [[UITextField alloc] initWithFrame:textfieldframe];
    RegionText = [[UITextField alloc] initWithFrame:textfieldframe];
    PostCodeText = [[UITextField alloc] initWithFrame:textfieldframe];
    usernameText = [[UITextField alloc] initWithFrame:textfieldframe];
    cardNumberText = [[UITextField alloc] initWithFrame:textfieldframe];
    cvvText = [[UITextField alloc] initWithFrame:textfieldframe];
    expiryText = [[UITextField alloc] initWithFrame:textfieldframe];
    startDateText = [[UILabel alloc] initWithFrame:textfieldframe];
    cardNameText = [[UITextField alloc] initWithFrame:textfieldframe];
    cardIssuerNumberText = [[UITextField alloc] initWithFrame:textfieldframe];
    cardIssuerNameText = [[UITextField alloc] initWithFrame:textfieldframe];
    faxText = [[UITextField alloc] initWithFrame:textfieldframe];
    
    [sexText setBackgroundColor:[UIColor clearColor]];
    [sexText setTextColor:[UIColor lightGrayColor]];
    
    [sexText setDelegate:self];
    
    
    
    [dateOfBirthText setTextColor:[UIColor lightGrayColor]];
    
    [dateOfBirthText setDelegate:self];
    [dateOfBirthText setBackgroundColor:[UIColor clearColor]];
    isDOB = NO;
    
    [countryText  setTextColor:textFieldnoneditableColor];
    
    [countryText setDelegate:self];
    
    
    setCurrCodeSetting=[[NSString alloc] init];
    
    NSString *country= [[NSUserDefaults standardUserDefaults] objectForKey:@"CountrySetting"];
    setCurrCodeSetting= [[NSUserDefaults standardUserDefaults] objectForKey:@"CountryCodeSetting"];
    
    
    if ([country length]==0 || [setCurrCodeSetting length]==0) {
        //BRITAIN
        [countryText setText:@"United Kingdom"];
        setCurrCodeSetting=@"826";
    }else {
        [countryText setText:country];
    }
    
    [countryText setBackgroundColor:[UIColor clearColor]];
    [countryText setDelegate:self];
    isCountry = NO;
    [expiryText setBackgroundColor:[UIColor clearColor]];
    [startDateText setBackgroundColor:[UIColor clearColor]];
    [expiryText setTextColor:[UIColor lightGrayColor]];
    [startDateText setTextColor:[UIColor lightGrayColor]];
    [expiryText setDelegate:self];
    myButton.highlighted  = NO;
    [myButton setImage:[UIImage imageNamed:@"unselected.png"] forState: UIControlStateNormal];
    //isPickerMoveUp = YES;
    isCountryMoveUp =YES;
    self.pickertransperntimg=[[UIImageView alloc]initWithFrame:CGRectMake(0,30, 320, 210)];
    self.pickerbgimage=[[UIImageView alloc]initWithFrame:CGRectMake(0,30, 320, 210)];
    self.pickerbgimage.image=[UIImage imageNamed:@"calendar_bg.png"];
    self.pickertransperntimg.image=[UIImage imageNamed:@"background_white.png"];
    TempViewForDatePicker = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 257)];
    [TempViewForDatePicker setBackgroundColor:[UIColor clearColor]];
    [TempViewForDatePicker addSubview:self.pickertransperntimg];
    [TempViewForDatePicker addSubview:self.pickerbgimage];
    
    datePicker=[[UIDatePicker alloc] init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.center=CGPointMake(160.0,138);
    //for expiry picker----------------------------------------------------
    expdatepickerview=[[UIPickerView alloc]init];
    expdatepickerview.showsSelectionIndicator=YES;
    expdatepickerview.delegate = self;
    expdatepickerview.dataSource = self;
    expdatepickerview.tag=502;
    expdatepickerview.center=CGPointMake(170.0,143.0);
    
    CustumDate *expdate=[[CustumDate alloc]init];
    [expdate createmonthyear];
    self.montharray=[[NSArray alloc]initWithArray:expdate.montharray];
    self.yeararray=[[NSArray alloc]initWithArray:expdate.yeararray];
  
    
    genderPicker=[[UIPickerView alloc] init];
    genderPicker.showsSelectionIndicator=YES;
    genderPicker.delegate = self;
    genderPicker.dataSource = self;
    genderPicker.tag=501;
    genderPicker.center=CGPointMake(170.0,143.0);
    genderarray=[[NSMutableArray alloc]initWithObjects:@"Male",@"Female", nil];
    
    countryPicker=[[UIPickerView alloc] init];
    countryPicker.showsSelectionIndicator=YES;
    countryPicker.delegate = self;
    countryPicker.dataSource = self;
    countryPicker.center=CGPointMake(170.0,143.0);
    
    getCountryName = [[NSMutableArray alloc] init];
    getCountryCode = [[NSMutableArray alloc] init];
    getCountryList = [[NSMutableArray alloc] init];
    getCountryList = [DataBase getAllCountryList];
    
    
    
    //NSLog(@"Records from Databse count is====== %d",[getCountryList count]);
    if ([getCountryList count] <=0) {

    }
    else {
        NSString *name;
        NSString *code;
        
        for (int i=0;i<[getCountryList count]; i++) {
           // NSLog(@"ViewDidLoad.....GetCountryList..... %d",[getCountryList count]);
            settingDictionary = [getCountryList objectAtIndex:i];
            name = [settingDictionary objectForKey:@"countryName"];
            code = [settingDictionary objectForKey:@"countryCode"];
            
            [getCountryName addObject:name];
            [getCountryCode addObject:code];
           
        }
    }
    
    if ([UIScreen mainScreen].bounds.size.height==568) {
        
        TempViewForDatePicker.center=CGPointMake(160.0,440);
        TempViewForCountryPicker.center=CGPointMake(160.0,432);
        TempViewForCountryPicker.center=CGPointMake(100,339);
    }
    else{
        TempViewForDatePicker.center=CGPointMake(160.0,350);
        TempViewForCountryPicker.center=CGPointMake(160.0,343);
        TempViewForCountryPicker.center=CGPointMake(100,250);
    }
    
    datePicker.hidden=YES;
    countryPicker.hidden=YES;
    expdatepickerview.hidden=YES;
    genderPicker.hidden=YES;
    
    [TempViewForDatePicker setHidden:YES];
    [TempViewForCountryPicker setHidden:YES];
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"DD/MM/YYYY"];
    isStartDate = NO;
    isEndDate = NO;
    CGFloat navBarHeight = 50.0f;
    CGRect frame = CGRectMake(0.0f, 0.0f, 320.0f, navBarHeight);
    [navbar setFrame:frame];
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"submit.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(RegisterUser) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(-11, 0, 76, 36)];
    navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIButton *button1 =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(cancelSignUp) forControlEvents:UIControlEventTouchUpInside];
    [button1 setFrame:CGRectMake(-11, 0, 76, 36)];
    navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button1];
    
    maleFemaleArray = [[NSMutableArray alloc]init];
    [maleFemaleArray addObject:@"Male"];
    [maleFemaleArray addObject:@"Female"];
    NSString *url=@"/cardholder/services/CardHolderService";
    
    
    if ([UIScreen mainScreen].bounds.size.height != 568)
    {
        tableSignup.frame=CGRectMake(15, 64, 290, 258);

        imgBottomImage.frame=CGRectMake(0, 320, 320, 140);
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    cancelbtn.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(14.0)];
    submitbtn.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(14.0)];
    titlelbl.font=[UIFont fontWithName:labelregularFont size:(22.0)];
    [cancelbtn.titleLabel setTextColor:btntextColor];
    [submitbtn.titleLabel setTextColor:btntextColor];
    [titlelbl setTextColor:headertitletextColor];
    if([Common isNetworkAvailable])
    {
        isNetwork.text= NSLocalizedString(@"NetWork Available", @"");
    }
    else {
        isNetwork.text= NSLocalizedString(@"No NetWork Available", @"");
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [super viewWillDisappear:animated];
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
    if(pickerView.tag==501)
        return [genderarray count];
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
    
    //UILabel *label;
    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = UITextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    
    if(pickerView.tag==501)
    {
        // label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 37)];
        label.frame=CGRectMake(0, 0, 280, 37);
        
        label.text= [genderarray objectAtIndex:row];
    }
    else
    {
        
        if(pickerView.tag==502)
        {
            label.frame=CGRectMake(0, 0,120, 37);
            label.textAlignment = UITextAlignmentLeft;
            label.backgroundColor = [UIColor clearColor];
            if(component==0)
            {
                label.text= [self.montharray objectAtIndex:row];
                NSLog(@"value of label is %@",label.text);
            }
            else
                if(component==1)
                {
                    label.frame=CGRectMake(0, 0,40,40);
                    label.text= [self.yeararray objectAtIndex:row];
                    label.textAlignment = UITextAlignmentLeft;
                    label.backgroundColor = [UIColor clearColor];
                }
            
        }
        else
        {
            label.frame=CGRectMake(0, 0, 280, 37);
            label.text=[getCountryName objectAtIndex:row];
        }
    }
    
    return label;
}


- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if(thePickerView.tag==501)
    {
        //pickerValue=[genderarray objectAtIndex:row];
        selectRowGender=row;
        
    }
    else
    {
        
        if(thePickerView.tag==502)
        {
            
        }
        else
        {
            // pickerValue=[getCountryName objectAtIndex:row];
            selectRow=row;
        }
        
    }
    
    
}


#pragma mark TableView Functions ---------------------------------

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
        return 3;
    if(section ==1)
        return 14;
    if(section == 2)
        return 4;
    else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==2) {
        if (indexPath.row==3) {
            return 200;
        }
    }
    return cellHeightForGroupedTable;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *title = nil;
    switch (section){
        case 0:{
            title = @"Account Information";
            break;
        }
        case 1:{
            title = @"Personal Information";
            break;
        }
        case 2:{
            title = @"Card Details";
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
        // If no section header title, no section header needed
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
    label.text = sectionTitle;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,60)];
    [view addSubview:label];
    
    return view;
}

-(void)texfieldpadding:(UITextField*)textfield
{
    UIView *emailpaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, textfield.frame.size.height)];
    textfield.leftView = emailpaddingView;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    
    NSString *cellIdentifier;
    
    cellIdentifier = @"SectionsTableIdentifier";
    int row = [indexPath row];
    int section=[indexPath section];
    
    
    //UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameLabelRect];
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    // Remove all subview from cell content view
    for (UIView *view in cell.contentView.subviews){
        [view removeFromSuperview];
    }
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setBackgroundColor:TableViewCellColor];
    
    
    
    UIImageView *textFieldBackgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(3,7,283,36)];
    [textFieldBackgroundImage setImage:[UIImage imageNamed:@"entry_field.png"]];
    [cell.contentView addSubview:textFieldBackgroundImage];
    
    NSLog(@"----------------------------- %@",NSStringFromCGRect(cell.frame));
    //Section 1
    if (section==0) {
        
        if (row==0) {
            [usernameText setKeyboardAppearance:UIKeyboardAppearanceAlert];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            usernameText.tag = 2;
            usernameText.delegate = self;
            usernameText.placeholder =@"Email Address (Username) *";
            usernameText.returnKeyType = UIReturnKeyNext;
            usernameText.keyboardType = UIKeyboardTypeEmailAddress;
            usernameText.autocorrectionType = UITextAutocorrectionTypeNo;
            usernameText.clearButtonMode = UITextFieldViewModeWhileEditing;
            usernameText.autocapitalizationType = NO;
            usernameText.clearsOnBeginEditing = NO;
            [usernameText setTextAlignment:NSTextAlignmentLeft];
            usernameText.layer.cornerRadius=5;
            usernameText.layer.borderWidth=0;
            [usernameText setValue:placeholdertexfield];
            [usernameText  setTextColor:textFieldTextColor];
            [self texfieldpadding:usernameText];
            [cell.contentView addSubview:usernameText];
            usernameText.font=[textFieldnewTextFont];
            
            
        }
        
        if (row==1) {
            [passwordText setKeyboardAppearance:UIKeyboardAppearanceAlert];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            passwordText.tag = 2;
            passwordText.delegate = self;
            passwordText.placeholder =@"Password *";
            passwordText.returnKeyType = UIReturnKeyNext;
            passwordText.keyboardType = UIKeyboardTypeDefault;
            passwordText.autocorrectionType = UITextAutocorrectionTypeNo;
            passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
            passwordText.secureTextEntry = YES;
            passwordText.clearsOnBeginEditing = NO;
            [passwordText setTextAlignment:NSTextAlignmentLeft];
            passwordText.layer.cornerRadius=5;
            passwordText.layer.borderWidth=0;
            [passwordText setValue:placeholdertexfield];
            passwordText.font=[textFieldnewTextFont];
            [passwordText  setTextColor:textFieldTextColor];
            [self texfieldpadding:passwordText];
            [cell.contentView addSubview:passwordText];
            
        }
        if (row==2) {
            [confirmPasstext setKeyboardAppearance:UIKeyboardAppearanceAlert];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            confirmPasstext.tag = 2;
            confirmPasstext.delegate = self;
            confirmPasstext.placeholder =@"Re-enter Password *";
            confirmPasstext.returnKeyType = UIReturnKeyNext;
            confirmPasstext.keyboardType = UIKeyboardTypeDefault;
            confirmPasstext.autocorrectionType = UITextAutocorrectionTypeNo;
            confirmPasstext.clearButtonMode = UITextFieldViewModeWhileEditing;
            confirmPasstext.secureTextEntry = YES;
            confirmPasstext.clearsOnBeginEditing = NO;
            [confirmPasstext setTextAlignment:NSTextAlignmentLeft];
            confirmPasstext.layer.cornerRadius=5;
            confirmPasstext.layer.borderWidth=0;
            [confirmPasstext setValue:placeholdertexfield];
            confirmPasstext.font=[textFieldnewTextFont];
            [confirmPasstext  setTextColor:textFieldTextColor];
            [self texfieldpadding:confirmPasstext];
            [cell.contentView addSubview:confirmPasstext];
            
        }
        
    }
    
    //section2
    
    if (section==1) {
        
        
        if (row==0) {
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self.fNameText setKeyboardAppearance:UIKeyboardAppearanceAlert];
            self.fNameText.tag = 1;
            self.fNameText.delegate = self;
            self.fNameText.placeholder =@"First Name *";
            self.fNameText.returnKeyType = UIReturnKeyNext;
            self.fNameText.keyboardType = UIKeyboardTypeDefault;
            self.fNameText.autocorrectionType = UITextAutocorrectionTypeNo;
            self.fNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
            self.fNameText.layer.cornerRadius=5;
            self.fNameText.layer.borderWidth=0;
            [self.fNameText setTextAlignment:NSTextAlignmentLeft];
            self.fNameText.clearsOnBeginEditing = NO;
            self.fNameText.font=[textFieldnewTextFont];
            [self texfieldpadding:self.fNameText];
            //textFieldTextColor
            [self.fNameText  setTextColor:textFieldTextColor];
            [self.fNameText setValue:placeholdertexfield];
            [self.fNameText setBackground:[UIImage imageNamed:@"entry_field.png"]];
            
            [cell.contentView addSubview:self.fNameText];
            
        }
        if (row==1) {
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [mNameText setKeyboardAppearance:UIKeyboardAppearanceAlert];
            mNameText.tag = 2;
            mNameText.delegate = self;
            mNameText.placeholder =@"Middle Name";
            mNameText.returnKeyType = UIReturnKeyNext;
            mNameText.keyboardType = UIKeyboardTypeDefault;
            mNameText.autocorrectionType = UITextAutocorrectionTypeNo;
            mNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
            mNameText.layer.cornerRadius=5;
            mNameText.layer.borderWidth=0;
            [mNameText setValue:placeholdertexfield];
            mNameText.clearsOnBeginEditing = NO;
            [mNameText setTextAlignment:NSTextAlignmentLeft];
            [self texfieldpadding:mNameText];
            mNameText.font=[textFieldnewTextFont ];
            [mNameText  setTextColor:textFieldTextColor];
            [cell.contentView addSubview:mNameText];
        }
        if (row==2) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [lNameText setKeyboardAppearance:UIKeyboardAppearanceAlert];
            lNameText.tag = 2;
            lNameText.delegate = self;
            lNameText.placeholder =@"Last Name *";
            [lNameText setValue:placeholdertexfield];
            lNameText.returnKeyType = UIReturnKeyNext;
            lNameText.keyboardType = UIKeyboardTypeDefault;
            lNameText.autocorrectionType = UITextAutocorrectionTypeNo;
            lNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
            lNameText.font=[textFieldnewTextFont];
            [lNameText  setTextColor:textFieldTextColor];
            [self texfieldpadding:lNameText];
            lNameText.clearsOnBeginEditing = NO;
            [lNameText setTextAlignment:NSTextAlignmentLeft];
            lNameText.layer.cornerRadius=5;
            lNameText.layer.borderWidth=0;
            [cell.contentView addSubview:lNameText];
            
            
        }
        if (row==3) {
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [dateOfBirthText setTextAlignment:NSTextAlignmentLeft];
            dateOfBirthText.layer.cornerRadius=5;
            dateOfBirthText.layer.borderWidth=0;
            dateOfBirthText.placeholder=@"DOB";
            dateOfBirthText.font=[textFieldnewTextFont];
            [cell.contentView addSubview:dateOfBirthText];
            [dateOfBirthText setValue:placeholdertexfield];
            [dateOfBirthText  setTextColor:textFieldTextColor];
            [self texfieldpadding:dateOfBirthText];
            UIButton *btnShowPicker=[UIButton buttonWithType:UIButtonTypeCustom];
            btnShowPicker.frame=CGRectMake(20,13, 250, 35);
            btnShowPicker.backgroundColor=[UIColor clearColor];
            btnShowPicker.tag=0;
            [btnShowPicker addTarget:self action:@selector(openPickerButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnShowPicker];
            
            
        }
        if (row==4) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [sexText setTextAlignment:NSTextAlignmentLeft];
            sexText.layer.cornerRadius=5;
            sexText.layer.borderWidth=0;
            [cell.contentView addSubview:sexText];
            [sexText setValue:placeholdertexfield];
            sexText.font=[textFieldnewTextFont ];
            [sexText  setTextColor:textFieldTextColor];
            [sexText setPlaceholder:@"Gender"];
            [self texfieldpadding:sexText];
            
            UIButton *btnShowPicker=[UIButton buttonWithType:UIButtonTypeCustom];
            btnShowPicker.frame=CGRectMake(20,13, 250, 35);
            btnShowPicker.backgroundColor=[UIColor clearColor];
            btnShowPicker.tag=2;
            [btnShowPicker addTarget:self action:@selector(openPickerButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnShowPicker];
        }
        if (row==5) {
            
            [addressText1 setKeyboardAppearance:UIKeyboardAppearanceAlert];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            addressText1.tag = 2;
            addressText1.delegate = self;
            addressText1.placeholder =@"Street Address 1 *";
            addressText1.returnKeyType = UIReturnKeyNext;
            addressText1.keyboardType = UIKeyboardTypeDefault;
            addressText1.autocorrectionType = UITextAutocorrectionTypeNo;
            addressText1.clearButtonMode = UITextFieldViewModeWhileEditing;
            addressText1.font=[textFieldnewTextFont];
            addressText1.clearsOnBeginEditing = NO;
            [addressText1 setTextAlignment:NSTextAlignmentLeft];
            addressText1.layer.cornerRadius=5;
            addressText1.layer.borderWidth=0;
            [addressText1 setValue:placeholdertexfield];
            [addressText1  setTextColor:textFieldTextColor];
            [self texfieldpadding:addressText1];
            [cell.contentView addSubview:addressText1];
            
        }
        if (row==6) {
            [addressText2 setKeyboardAppearance:UIKeyboardAppearanceAlert];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            addressText2.tag = 2;
            addressText2.delegate = self;
            addressText2.placeholder =@"Street Address 2";
            addressText2.returnKeyType = UIReturnKeyNext;
            addressText2.keyboardType = UIKeyboardTypeDefault;
            addressText2.autocorrectionType = UITextAutocorrectionTypeNo;
            addressText2.clearButtonMode = UITextFieldViewModeWhileEditing;
            addressText2.font=[textFieldnewTextFont];
            addressText2.clearsOnBeginEditing = NO;
            [addressText2 setTextAlignment:NSTextAlignmentLeft];
            addressText2.layer.cornerRadius=5;
            addressText2.layer.borderWidth=0;
            [addressText2 setValue:placeholdertexfield];
            [addressText2  setTextColor:textFieldTextColor];
            [self texfieldpadding:addressText2];
            
            [cell.contentView addSubview:addressText2];
            
            
        }
        if (row==7) {
            [CityText setKeyboardAppearance:UIKeyboardAppearanceAlert];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            CityText.tag = 2;
            CityText.delegate = self;
            CityText.placeholder =@"City";
            CityText.returnKeyType = UIReturnKeyNext;
            CityText.keyboardType = UIKeyboardTypeDefault;
            CityText.autocorrectionType = UITextAutocorrectionTypeNo;
            CityText.clearButtonMode = UITextFieldViewModeWhileEditing;
            CityText.clearsOnBeginEditing = NO;
            [CityText setTextAlignment:NSTextAlignmentLeft];
            CityText.layer.cornerRadius=5;
            CityText.layer.borderWidth=0;
            [CityText setValue:placeholdertexfield];
            CityText.font=[textFieldnewTextFont ];
            [CityText  setTextColor:textFieldTextColor];
            [self texfieldpadding:CityText];
            [cell.contentView addSubview:CityText];
            
            
        }
        if (row==8) {
            [RegionText setKeyboardAppearance:UIKeyboardAppearanceAlert];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            RegionText.tag = 2;
            RegionText.delegate = self;
            RegionText.placeholder =@"Region";
            RegionText.returnKeyType = UIReturnKeyNext;
            RegionText.keyboardType = UIKeyboardTypeDefault;
            RegionText.autocorrectionType = UITextAutocorrectionTypeNo;
            RegionText.clearButtonMode = UITextFieldViewModeWhileEditing;
            RegionText.clearsOnBeginEditing = NO;
            [RegionText setTextAlignment:NSTextAlignmentLeft];
            RegionText.layer.cornerRadius=5;
            RegionText.layer.borderWidth=0;
            [RegionText setValue:placeholdertexfield];
            RegionText.font=[textFieldnewTextFont];
            [RegionText  setTextColor:textFieldTextColor];
            [self texfieldpadding:RegionText];
            [cell.contentView addSubview:RegionText];
        }
        if (row==9) {
            
            [PostCodeText setKeyboardAppearance:UIKeyboardAppearanceAlert];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            PostCodeText.tag = 2;
            PostCodeText.delegate = self;
            PostCodeText.placeholder =@"Post Code *";
            PostCodeText.returnKeyType = UIReturnKeyNext;
            PostCodeText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            PostCodeText.autocorrectionType = UITextAutocorrectionTypeNo;
            PostCodeText.clearButtonMode = UITextFieldViewModeWhileEditing;
            PostCodeText.clearsOnBeginEditing = NO;
            [PostCodeText setTextAlignment:NSTextAlignmentLeft];
            PostCodeText.layer.cornerRadius=5;
            PostCodeText.layer.borderWidth=0;
            [PostCodeText setValue:placeholdertexfield];
            [self texfieldpadding:PostCodeText];
            [cell.contentView addSubview:PostCodeText];
            PostCodeText.font=[textFieldnewTextFont];
            [PostCodeText  setTextColor:textFieldTextColor];
            
            
        }
        if (row==10) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [countryText setTextAlignment:NSTextAlignmentLeft];
            countryText.layer.cornerRadius=5;
            countryText.layer.borderWidth=0;
            [cell.contentView addSubview:countryText];
            countryText.font=[textFieldnewTextFont];
            [countryText setValue:placeholdertexfield];
            //[countryText  setTextColor:textFieldTextColor];
            [self texfieldpadding:countryText];
            UIButton *btnShowPicker=[UIButton buttonWithType:UIButtonTypeCustom];
            btnShowPicker.frame=CGRectMake(20,13, 250, 35);
            btnShowPicker.backgroundColor=[UIColor clearColor];
            btnShowPicker.tag=1;
            [btnShowPicker addTarget:self action:@selector(openPickerButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnShowPicker];
            
        }
        if (row==11) {
            [emailText setKeyboardAppearance:UIKeyboardAppearanceAlert];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            emailText.tag = 2;
            emailText.delegate = self;
            emailText.placeholder =@"Email Address";
            emailText.returnKeyType = UIReturnKeyNext;
            emailText.keyboardType = UIKeyboardTypeEmailAddress;
            emailText.autocorrectionType = UITextAutocorrectionTypeNo;
            emailText.clearButtonMode = UITextFieldViewModeWhileEditing;
            emailText.autocapitalizationType = NO;
            emailText.clearsOnBeginEditing = NO;
            [emailText setTextAlignment:NSTextAlignmentLeft];
            emailText.layer.cornerRadius=5;
            emailText.layer.borderWidth=0;
            [emailText setValue:placeholdertexfield];
            emailText.font=[textFieldnewTextFont ];
            [emailText  setTextColor:textFieldTextColor];
            [self texfieldpadding:emailText];
            [cell.contentView addSubview:emailText];
            
        }
        
        if (row==12) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [mobileText setKeyboardAppearance:UIKeyboardAppearanceAlert];
            mobileText.tag = 2;
            mobileText.delegate = self;
            mobileText.placeholder =@"Mobile Number";
            mobileText.returnKeyType = UIReturnKeyNext;
            mobileText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            mobileText.autocorrectionType = UITextAutocorrectionTypeNo;
            mobileText.clearButtonMode = UITextFieldViewModeWhileEditing;
            mobileText.clearsOnBeginEditing = NO;
            mobileText.layer.cornerRadius=5;
            mobileText.layer.borderWidth=0;
            [mobileText setTextAlignment:NSTextAlignmentLeft];
            [mobileText setValue:placeholdertexfield];
            mobileText.font=[textFieldnewTextFont];
            [mobileText  setTextColor:textFieldTextColor];
            [self texfieldpadding:mobileText];
            [cell.contentView addSubview:mobileText];
            
        }
        if (row==13) {
            [faxText setKeyboardAppearance:UIKeyboardAppearanceAlert];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            faxText.tag = 1;
            faxText.delegate = self;
            faxText.placeholder =@"Fax";
            faxText.returnKeyType = UIReturnKeyNext;
            faxText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            faxText.autocorrectionType = UITextAutocorrectionTypeNo;
            faxText.clearButtonMode = UITextFieldViewModeWhileEditing;
            faxText.clearsOnBeginEditing = NO;
            faxText.layer.cornerRadius=5;
            faxText.layer.borderWidth=0;
            [faxText setValue:placeholdertexfield];
            [faxText setTextAlignment:NSTextAlignmentLeft];
            faxText.font=[textFieldnewTextFont];
            [faxText  setTextColor:textFieldTextColor];
            [self texfieldpadding:faxText];
            [cell.contentView addSubview:faxText];
        }
        
    }
    //section 3
    if (section==2) {
        if (row==0) {
            
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
            cardNumberText.layer.cornerRadius=5;
            cardNumberText.layer.borderWidth=0;
            [cardNumberText setValue:placeholdertexfield];
            cardNumberText.font=[textFieldnewTextFont];
            [cardNumberText  setTextColor:textFieldTextColor];
            [self texfieldpadding:cardNumberText];
            [cell.contentView addSubview:cardNumberText];
            
        }
        if (row==1) {
            
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
            cardNameText.layer.cornerRadius=5;
            cardNameText.layer.borderWidth=0;
            [cardNameText setTextAlignment:NSTextAlignmentLeft];
            [cardNameText setValue:placeholdertexfield];
            cardNameText.font=[textFieldnewTextFont];
            [cardNameText  setTextColor:textFieldTextColor];
            [self texfieldpadding:cardNameText];
            [cell.contentView addSubview:cardNameText];
            
            
        }
        if (row==2) {
            
            [cvvText setKeyboardAppearance:UIKeyboardAppearanceAlert];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cvvText.tag = 1;
            cvvText.delegate = self;
            cvvText.placeholder =@"CVV/CSC *";
            cvvText.returnKeyType = UIReturnKeyNext;
            cvvText.secureTextEntry = YES;
            cvvText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            cvvText.autocorrectionType = UITextAutocorrectionTypeNo;
            cvvText.clearButtonMode = UITextFieldViewModeWhileEditing;
            cvvText.clearsOnBeginEditing = NO;
            [cvvText setTextAlignment:NSTextAlignmentLeft];
            cvvText.layer.cornerRadius=5;
            cvvText.layer.borderWidth=0;
            [cvvText setValue:placeholdertexfield];
            cvvText.font=[textFieldnewTextFont];
            [cvvText  setTextColor:textFieldTextColor];
            [self texfieldpadding:cvvText];
            [cell.contentView addSubview:cvvText];
        }
        if (row==3) {
            [expiryText setTextAlignment:NSTextAlignmentLeft];
            expiryText.placeholder=@"Expiry Date (MM/YY) *";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            expiryText.layer.cornerRadius=5;
            expiryText.layer.borderWidth=0;
            [cell.contentView addSubview:expiryText];
            [expiryText setValue:placeholdertexfield];
            expiryText.font=[textFieldnewTextFont ];
            [expiryText  setTextColor:textFieldTextColor];
            [self texfieldpadding:expiryText];
            UIButton *btnShowPicker=[UIButton buttonWithType:UIButtonTypeCustom];
            btnShowPicker.frame=CGRectMake(20,13, 250, 35);
            btnShowPicker.backgroundColor=[UIColor clearColor];
            btnShowPicker.tag=3;
            [btnShowPicker addTarget:self action:@selector(openPickerButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnShowPicker];
        }
    }
    return cell;
}

#pragma mark - Scrollview delegate ------------------------------
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //    if(!wantMoveUp)
    //	{
    //		wantMoveUp = YES;
    //	}
    [self checkForFirstResponder];
}


#pragma mark DatePicker Functions -------------------------------

-(void)checkForFirstResponder{
    
    [usernameText resignFirstResponder];
    [fNameText resignFirstResponder];
    [mNameText resignFirstResponder];
    [lNameText resignFirstResponder];
    [sexText resignFirstResponder];
    [mobileText resignFirstResponder];
    [dateOfBirthText resignFirstResponder];
    [countryText resignFirstResponder];
    [emailText resignFirstResponder];
    [passwordText resignFirstResponder];
    [confirmPasstext resignFirstResponder];
    [addressText1 resignFirstResponder];
    [addressText2 resignFirstResponder];
    [CityText resignFirstResponder];
    [RegionText resignFirstResponder];
    [PostCodeText resignFirstResponder];
    [cardNumberText resignFirstResponder];
    [cvvText resignFirstResponder];
    [expiryText resignFirstResponder];
    [cardNameText resignFirstResponder];
    [cardIssuerNumberText resignFirstResponder];
    [cardIssuerNameText resignFirstResponder];
    [faxText resignFirstResponder];
}
-(void)closPicker
{
    TempViewForDatePicker.hidden= YES;
    datePicker.hidden =YES;
    countryPicker.hidden =YES;
    expdatepickerview.hidden=YES;
    if([closebtnstr isEqualToString:@"countrycancel"])
    {
        [emailText becomeFirstResponder];
    }
    if([closebtnstr isEqualToString:@"datecancel"])
    {
        [self performSelector:@selector(openGenderPicker) withObject:nil afterDelay:0.4];
    }
    if([closebtnstr isEqualToString:@"malefemalecancel"])
    {
        [addressText1 becomeFirstResponder];
    }
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
    [dateOfBirthText setTextColor:textFieldTextColor];
    NSLog(@"Done Action datePicker.date==>%@",datePicker.date);
    dateOfBirthText.text=[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:datePicker.date]];//[datePicker date]];
    userDOBYear=[dateOfBirthText.text stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSUInteger cardNumberSublength = [userDOBYear length] - 4;
    if ([userDOBYear length] > 4) {
        userDOBYear = [userDOBYear substringFromIndex:cardNumberSublength];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY"];
    currentDOBYear = [formatter stringFromDate:[NSDate date]];
    userDOBYearInt= [userDOBYear intValue];
    currentDOBYearInt = [currentDOBYear intValue];
    diffUserDOBInt=currentDOBYearInt-userDOBYearInt;
    CATransition* trans = [CATransition animation];
    [trans setType:kCATransitionPush];
    [trans setDuration:0.35];
    [trans setSubtype:kCATransitionFromBottom];
    CALayer *layer = TempViewForDatePicker.layer;
    CALayer *layer1 = pickerDoneButton.layer;
    [layer1 addAnimation:trans forKey:@"CurlIn"];
    [layer addAnimation:trans forKey:@"CurlIn"];
    NSIndexPath *middleIndexPath;
    middleIndexPath = [NSIndexPath indexPathForRow:4 inSection:1];
    [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    [self performSelector:@selector(openGenderPicker) withObject:nil afterDelay:0.4];
    
}
-(void)donegenderpicker
{
    TempViewForDatePicker.hidden= YES;
    genderPicker.hidden=YES;
    [sexText setTextColor:textFieldTextColor];
    
    sexText.text=[genderarray objectAtIndex:selectRowGender];
    
    // show keyboard for username text field and scrolltable view..
    [addressText1 becomeFirstResponder];
    NSIndexPath *middleIndexPath;
    middleIndexPath = [NSIndexPath indexPathForRow:5 inSection:1];
    [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    //....
    
}
-(void)doneContryPicker
{
    TempViewForDatePicker.hidden= YES;
    countryPicker.hidden =YES;
    [countryText setTextColor:textFieldTextColor];
    
    
    if ([getCountryName count]>0)
    {
        NSLog(@"row selected of pickerValue country Done %@",countryPicker);
        countryText.text = [getCountryName objectAtIndex:selectRow];
        
    }
    
    
    
    //[countryText resignFirstResponder];
    isCountry = NO;
    
    
    [emailText becomeFirstResponder];
    NSIndexPath *middleIndexPath;
    middleIndexPath = [NSIndexPath indexPathForRow:12 inSection:1];
    [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    //....
}

-(void)doneExpPicker
{
    //NSString *combinedmonthyear;
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
            UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:Unabletosignuptitle message:selctvalidexpirydate delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
    
    //expiryText.text=[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:datePicker.date]];//[datePicker date]];
    TempViewForDatePicker.hidden= YES;
    datePicker.hidden =YES;
    countryPicker.hidden =YES;
    expdatepickerview.hidden=YES;
    CATransition* trans = [CATransition animation];
    [trans setType:kCATransitionPush];
    [trans setDuration:0.35];
    [trans setSubtype:kCATransitionFromBottom];
    CALayer *layer = TempViewForDatePicker.layer;
    CALayer *layer1 = pickerDoneButton.layer;
    [layer1 addAnimation:trans forKey:@"CurlIn"];
    [layer addAnimation:trans forKey:@"CurlIn"];
    
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

#pragma mark - Other Functions -------------------------------


/*
-(void) getCountryList: (id) value{
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        NSLog(@"Handle errorssssssss%@", value);
        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        NSLog(@"%@", value);
        return;
    }
    
    // Handle faults
    if([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Handle faultssssssssss%@", value);
        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        NSLog(@"%@", value);
        return;
    }
    NSLog(@"Called Country List Response");
    
    YPCountryListResponse *countryListResponse = (YPCountryListResponse *)value;
    NSLog(@"Country list are........count %d",[countryListResponse.countryList count]);
    
    if ([countryListResponse.countryList count] == 0) {
        noCurrencyFormServer = YES;
    }
    else {
        noCurrencyFormServer =NO;
        for (int i=0; i<[countryListResponse.countryList count]-2; i++) {
            YPCountryDetails *countryDetails = (YPCountryDetails *)[countryListResponse.countryList objectAtIndex:i];
            
            NSString *insertQuery = @"insert into CountryDetails(countrycode,countryname";
            NSString *insertQueryValues = @" values(";
            
            insertQueryValues = [insertQueryValues stringByAppendingString:
                                 [NSString stringWithFormat:@"'%@','%@'",countryDetails.countryCode,countryDetails.countryName]];
            
            insertQuery = [insertQuery stringByAppendingString:[NSString stringWithFormat:@")%@)",insertQueryValues]];
            
            NSLog(@"Insert Query is %@",insertQuery);
            
            NSLog(@"Country List issssss %@",[countryDetails countryName]);
            [DataBase InsertIntoTable:insertQuery];
        }
        getCountryList = [DataBase getAllCountryList];
        NSString *name;
        NSString *code;
        //[getCountryName addObject:@"Great Britain"];
        for (int i=0;i<[getCountryList count]; i++) {
            NSLog(@"In Service.....GetCountryList..... %d",[getCountryList count]);
            settingDictionary = [getCountryList objectAtIndex:i];
            name = [settingDictionary objectForKey:@"countryName"];
            code = [settingDictionary objectForKey:@"countryCode"];
            
            [getCountryName addObject:name];
            [getCountryCode addObject:code];
            NSLog(@"In service Sign UP Picker value Country Name..... %@",name);
            
        }
    }
}*/
-(void)flashTableScrollIndicator
{
    //[table flashScrollIndicators];
}

- (void)updateCountDown {
    //webServices *webSer = [[webServices alloc] init];
    
    if(counter > 0){
        counter -- ;
        if(counter == 1){
            
            [self killHUD];
            
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            
        }
    }
    
}

- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}


-(void)registerUserHandlers:(id)value
{
    holdertextfield.layer.cornerRadius=5;
    holdertextfield.layer.borderWidth=0;
    
    [self killHUD];
    
    
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        NSLog(@"%@", value);
        return;
    }
    // Handle faults
    if([value isKindOfClass:[SoapFault class]]) {
        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    
    YPRegisterResponse *registerResponse=[[YPRegisterResponse alloc] init];
    [registerResponse parsingRegistration:value];
    
    
    
    
    // Do something with the YPLoginResponse* result
    
    NSLog(@"Sign UP:: Result Status code==> %d",registerResponse.statusCode);
    
    if(registerResponse.statusCode == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:successfullyregistered delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert setTag:100];
        [alert show];
    }
    else
    {
        [self cardholderalertmessages:registerResponse.statusCode message:registerResponse.responseMessage];
    }
}
-(void)cardholderalertmessages:(int)statuscodevalue message:(NSString *)responsemessage
{
    switch (statuscodevalue)
    {
        case 1:
            NSLog (@"zero");
            [self commonalert:Unabletosignuptitle message:statuscode1];
            break;
        case 4:
            NSLog (@"one");
            [self commonalert:Unabletosignuptitle message:statuscode4];
            break;
        case 6:
            NSLog (@"six");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SessionExpired" object:self];
            break;
        case 7:
            NSLog (@"seven");
            [self commonalert:Unabletosignuptitle message:statuscode7];
            break;
        case 9:
            NSLog (@"nine");
            [self commonalert:Unabletosignuptitle message:statuscode9];
            break;
        case 10:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SessionExpired" object:self];
            break;
            
        case 12:
            NSLog (@"tweleve");
            [self commonalert:Unabletosignuptitle message:statuscode12];
            break;
        case 15:
            NSLog (@"fifteen");
            [self commonalert:Unabletosignuptitle message:statuscode15];
            break;
        case 16:
            NSLog (@"sisxteen");
            [self commonalert:Unabletosignuptitle message:statuscode16];
            break;
        case 17:
            NSLog (@"four");
            [self commonalert:Unabletosignuptitle message:statuscode17];
            break;
        case 18:
            NSLog (@"five");
            [self commonalert:Unabletosignuptitle message:statuscode18];
            break;
        case 21:
            NSLog (@"twenty one");
            [self commonalert:Unabletosignuptitle message:statuscode21];
            break;
        case 27:
            NSLog (@"twenty seven");
            [self commonalert:Unabletosignuptitle message:statuscode27];
            break;
        case 30:
            NSLog (@"thirty");
            [self commonalert:Unabletosignuptitle message:statuscode30];
            break;
        case 33:
            NSLog (@"thirty three");
            [self commonalert:Unabletosignuptitle message:statuscode33];
            break;
        default:
            NSLog (@"Integer out of range");
            [self commonalert:Unabletosignuptitle message:[NSString stringWithFormat:@"%@\n[Error code:%d]",responsemessage,statuscodevalue]];
            break;
    }
    
}
-(void)commonalert:(NSString *)title message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5]; // if you want to slide up the view
    
    CGRect rect = tableSignup.frame;
    if (movedUp)
    {
        
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    tableSignup.frame = rect;
    
    [UIView commitAnimations];
}

#pragma mark - Button methods -------------------------------
-(void)openPickerButton:(UIButton*)sender
{
    [self.view endEditing:YES];
    [self checkForFirstResponder];
    
    if (sender.tag==0) {
        [self performSelector:@selector(openDOBPicker)];
    }
    else if (sender.tag==1){
        [self performSelector:@selector(openCountryPicker)];
    }
    else if (sender.tag==2){
        [self performSelector:@selector(openGenderPicker)];
        
    }else if (sender.tag==3){
        
        [self performSelector:@selector(openExpiryPicker)];
        
    }
    
    
}
-(void)currenttextfield:(UITextField *)textfieldvalue alerttitle:(NSString *)alerttitlestr alertmessage:(NSString *)alertmessagestr
{
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


-(int)alphanumericvalue
{
    
    int i;
    
    NSString *originalString = passwordText.text;
    
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    while ([scanner isAtEnd] == NO) {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer])
        {
            i=0;
            
        }else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }
    
    NSMutableCharacterSet* testCharSet = [[NSMutableCharacterSet alloc] init];
    [testCharSet formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
    NSUInteger length = [originalString length];
    NSUInteger totalNonAlnumCharacters = length;
    for( NSUInteger i = 0; i < length; i++ ) {
        if( [testCharSet characterIsMember:[originalString characterAtIndex:i]] )
            totalNonAlnumCharacters--;
    }
    if (totalNonAlnumCharacters < length) {
        // passwordFlag = FALSE;
        i=1;
    }
    NSLog(@"====%d",i);
    if(i==0)
    {
        NSRegularExpression *regex = [[NSRegularExpression alloc]
                                      initWithPattern:@"[a-zA-Z]" options:0 error:NULL];
        
        // Assuming you have some NSString `myString`.
        NSUInteger matches = [regex numberOfMatchesInString:passwordText.text options:0
                                                      range:NSMakeRange(0, [passwordText.text length])];
        
        if (matches > 0) {
            // `myString` contains at least one English letter.
            i=0;
        }
        else{
            i=2;
        }
        
    }
    else
    {
        i=1;
        
    }
    
    return i;
    
}


-(IBAction)RegisterUser
{
   
    
     YPRegisterRequest *registerRequest = [[YPRegisterRequest alloc] init];
    
    emailFlag = FALSE;
    passwordFlag = FALSE;
    //	NSString *emailStr = emailText.text;
    NSString *passwordStr = passwordText.text;
    //NSString *mailID= emailText.text;
    NSLog(@"DOB...%@",dateOfBirthText.text);
    NSString *alerttitlestr;
    NSString *alertmessagestr;
    NSIndexPath *middleIndexPath;
    alerttitlestr=Unabletosignuptitle;
    
    //New VALIDATIONS ---------------------------------
    if (([usernameText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0)) {
        
        //[Common ShowAlert:@"Please enter email address as username." alertTitle:@"Unable to Register"];
        [usernameText becomeFirstResponder];
        
        middleIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        
        alertmessagestr=emailentr;
        [self currenttextfield:usernameText alerttitle:alerttitlestr alertmessage:alertmessagestr];
        
        return;
    }
    
    //Check valid register email - id ----------------------------
    
    BOOL isValidRegEmailId;
    
    if ([usernameText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0) {
        isValidRegEmailId=YES;
    }
    else
    {
        
        isValidRegEmailId=[self validateEmail:usernameText.text];
    }
    if (!isValidRegEmailId) {
        
        middleIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        
        alertmessagestr=validemailid;
        [self currenttextfield:usernameText alerttitle:alerttitlestr alertmessage:alertmessagestr];
        
        
        return;
    }
    
    if (([passwordText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0)) {
        
        middleIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        alertmessagestr=enterpwd;
        [self currenttextfield:passwordText alerttitle:alerttitlestr alertmessage:alertmessagestr];
        [passwordText becomeFirstResponder];
        return;
    }
    
    //------------------------------------------------------------
    
    if ([passwordStr length]<6) {
        
        middleIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        alertmessagestr=passwordminimunlegnth;
        [self currenttextfield:passwordText alerttitle:alerttitlestr alertmessage:alertmessagestr];
        [passwordText becomeFirstResponder];
        return;
    }
    
    //password validation--------------------------
    int validatevalue=[self alphanumericvalue];
    if(validatevalue==1)
    {
        isProcess=YES;
        middleIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        [self currenttextfield:passwordText alerttitle:unabletoupdatecard alertmessage:alphanumericvalueinPWd];
        return;
    }
    if (validatevalue==2) {
        isProcess=YES;
        middleIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        middleIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        [self currenttextfield:passwordText alerttitle:unabletoupdatecard alertmessage:alphanumericvalueinalphabet];
        return;
    }
    if (([confirmPasstext.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0)) {
        //[Common ShowAlert:@"Please enter Re-type password." alertTitle:@"Unable to Register"];
        middleIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        alertmessagestr=reenterpwd;
        [self currenttextfield:confirmPasstext alerttitle:alerttitlestr alertmessage:alertmessagestr];
        [confirmPasstext becomeFirstResponder];
        return;
    }
    if (![passwordText.text isEqualToString:confirmPasstext.text])
    {
        //[Common ShowAlert:@"Please enter both the passwords same."alertTitle:@"Unable to Register"];
        middleIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        alertmessagestr=bothpwdsame;
        [self currenttextfield:passwordText alerttitle:alerttitlestr alertmessage:alertmessagestr];
        [passwordText becomeFirstResponder];
        return;
    }
    
    
    
    //secondsection validation
    
    if (([self.fNameText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0)) {
        
        middleIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        
        alertmessagestr=firstnameentr;
        [self currenttextfield:self.fNameText alerttitle:alerttitlestr alertmessage:alertmessagestr];
        
        return;
    }
    
    if (([lNameText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0)) {
        
        middleIndexPath = [NSIndexPath indexPathForRow:2 inSection:1];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        
        //[Common ShowAlert:@"Please enter Last Name." alertTitle:@"Unable to Register"];
        alertmessagestr=lastnameentr;
        [self currenttextfield:lNameText alerttitle:alerttitlestr alertmessage:alertmessagestr];
        return;
    }
    
    if (([addressText1.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0)) {
        
        //[Common ShowAlert:@"Please enter Address Line1." alertTitle:@"Unable to Register"];
        [addressText1 becomeFirstResponder];
        middleIndexPath = [NSIndexPath indexPathForRow:6 inSection:1];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        
        //[Common ShowAlert:@"Please enter Last Name." alertTitle:@"Unable to Register"];
        alertmessagestr=enterstreetAdd1;
        [self currenttextfield:addressText1 alerttitle:alerttitlestr alertmessage:alertmessagestr];
        
        
        return;
    }
    if (([PostCodeText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0)) {
        
        //[Common ShowAlert:@"Please enter Post Code." alertTitle:@"Unable to Register"];
        [PostCodeText becomeFirstResponder];
        middleIndexPath = [NSIndexPath indexPathForRow:11 inSection:1];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        alertmessagestr=enterpostcode;
        [self currenttextfield:PostCodeText alerttitle:alerttitlestr alertmessage:alertmessagestr];
        return;
    }
    //------------------------------------------------------------
    //Check valid  email - id ------------------------------------
    
    BOOL isValidEmailId;
    
    if ([emailText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0) {
        isValidEmailId=YES;
    }
    else
    {
        
        isValidEmailId=[self validateEmail:emailText.text];
    }
    
    if (!isValidEmailId) {
        
        //[Common ShowAlert:@"Please enter a valid Email Id." alertTitle:@"Unable to Register"];
        [emailText becomeFirstResponder];
        
        
        
        middleIndexPath = [NSIndexPath indexPathForRow:2 inSection:1];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        
        alertmessagestr=secondryemail;
        [self currenttextfield:emailText alerttitle:alerttitlestr alertmessage:alertmessagestr];
        
        
        return;
        
    }
    
    //---------------------------------------------
    if (([cardNumberText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0)) {
        
        //[Common ShowAlert:@"Please enter Card Number." alertTitle:@"Unable to Register"];
        middleIndexPath = [NSIndexPath indexPathForRow:1 inSection:2];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        
        alertmessagestr=entercardnumber;
        [self currenttextfield:cardNumberText alerttitle:alerttitlestr alertmessage:alertmessagestr];
        
        [cardNumberText becomeFirstResponder];
        
        return;
    }
    
    
    if (([cardNameText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0)) {
        
        //  [Common ShowAlert:@"Please enter Card Name." alertTitle:@"Unable to Register"];
        
        middleIndexPath = [NSIndexPath indexPathForRow:2 inSection:2];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        alertmessagestr=entercardname;
        [self currenttextfield:cardNameText alerttitle:alerttitlestr alertmessage:alertmessagestr];
        [cardNameText becomeFirstResponder];
        return;
    }
    
    if (([cvvText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0)) {
        
        //[Common ShowAlert:@"Please enter CVV / CSC." alertTitle:@"Unable to Register"];
        middleIndexPath = [NSIndexPath indexPathForRow:3 inSection:2];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        alertmessagestr=enterCvv;
        [self currenttextfield:cvvText alerttitle:alerttitlestr alertmessage:alertmessagestr];
        [cvvText becomeFirstResponder];
        
        return;
    }
    if (([expiryText.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0)) {
        
        //[Common ShowAlert:@"Please enter Card Expiry Date." alertTitle:@"Unable to Register"];
        middleIndexPath = [NSIndexPath indexPathForRow:3 inSection:2];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        alertmessagestr=expirydate;
        [self currenttextfield:expiryText alerttitle:alerttitlestr alertmessage:alertmessagestr];
        [self checkForFirstResponder];
        //[self performSelector:@selector(openExpiryPicker)];
        return;
    }
    
    if(![Common isNetworkAvailable])
    {
        isNetwork.text= NSLocalizedString(@" No NetWork Available", @"");
        //[Common ShowAlert:ConnectionErrorMessage alertTitle:ConnectionErrorTitle];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:networkconnectiontitle message:networkconnectionmessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    //after check all validation -------------------------
    
    [self.view setUserInteractionEnabled:NO];
    isNetwork.text= NSLocalizedString(@"NetWork Available", @"");
    
//    WebserviceOperation *serviceSignup = [[WebserviceOperation alloc] initWithDelegate:self callback:@selector(registerUserHandlers:)];
//    
//    YPCardInfo *cardInfo = [[YPCardInfo alloc] init];
//    
//    registerRequest.firstName = self.fNameText.text;
//    registerRequest.lastName = lNameText.text;
//    registerRequest.valid =TRUE;
//    registerRequest.userID = usernameText.text;
//    
//    cardInfo.cardNumber = cardNumberText.text;
//    cardInfo.cardName = cardNameText.text;
//    cardInfo.CVV = cvvText.text;
//    cardInfo.expiryDate = [expiryText.text stringByReplacingOccurrencesOfString:@"/" withString:@""];
//    
//    registerRequest.password=passwordText.text;
//    
//    if([mNameText.text stringByReplacingOccurrencesOfString:@" " withString:@""]!=0)
//    {
//        registerRequest.middleName = mNameText.text;
//    }
//    
//    registerRequest.streetAddress1=addressText1.text;
//    
//    if([addressText2.text stringByReplacingOccurrencesOfString:@" " withString:@""]!=0)
//    {
//        registerRequest.streetAddress2 = addressText2.text;
//    }
//    
//    if([RegionText.text stringByReplacingOccurrencesOfString:@" " withString:@""]!=0)
//    {
//        registerRequest.region = RegionText.text;
//    }
//    if([countryText.text stringByReplacingOccurrencesOfString:@" " withString:@""]!=0)
//    {
//        registerRequest.country = setCurrCodeSetting;
//    }
//    
//    //--------- to find country code by country name ----------
//    
//    registerRequest.country=setCurrCodeSetting;
//    for (int i=0; i<getCountryList.count; i++)
//    {
//        if ([[[getCountryList objectAtIndex:i] valueForKey:@"countryName"] isEqualToString:countryText.text]) {
//            registerRequest.country=[[getCountryList objectAtIndex:i] valueForKey:@"countryCode"];
//            break;
//        }
//    }
//    
//    //---------------------------------------------------------
//    
//    if([PostCodeText.text stringByReplacingOccurrencesOfString:@" " withString:@""]!=0)
//    {
//        registerRequest.postCode = PostCodeText.text;
//    }
//    if([mobileText.text stringByReplacingOccurrencesOfString:@" " withString:@""]!=0)
//    {
//        registerRequest.mobilePhoneNumber = mobileText.text;
//    }
//    if (([dateOfBirthText.text stringByReplacingOccurrencesOfString:@" " withString:@""]!=0)) {
//        
//        registerRequest.DOB=[dateOfBirthText.text stringByReplacingOccurrencesOfString:@"/" withString:@""];
//        
//    }
//    
//    if([PostCodeText.text stringByReplacingOccurrencesOfString:@" " withString:@""]!=0)
//    {
//        registerRequest.cardInfo.fax = faxText.text;
//    }
//    if([sexText.text stringByReplacingOccurrencesOfString:@" " withString:@""]!=0)
//    {
//        registerRequest.sex = sexText.text;
//    }
//    if([CityText.text stringByReplacingOccurrencesOfString:@" " withString:@""]!=0)
//    {
//        registerRequest.city= CityText.text;
//    }
//    if([emailText.text stringByReplacingOccurrencesOfString:@" " withString:@""]!=0)
//    {
//        registerRequest.emailAddress= emailText.text;
//    }
//    registerRequest.cardInfo = cardInfo;
//    [self showHUD:sighnuphud];
//    
    
       // [serviceSignup registerUser:registerRequest];
    
    NSLog(@"value of registerrequest is %@",registerRequest);
    //----------------------------------------------------------------
    
}



-(IBAction)cancelSignUp
{
    if (isProcess) {
        [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:[[self.navigationController viewControllers] count]-3] animated:YES];
        
    }
}



#pragma mark - UIAlertview delegate -------------------------------

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 100) {
        if (buttonIndex ==0) {
            isProcess=YES;
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
            //[self cancelSignUp];
        }
    }
    
    if (alertView.tag == 010) {
        [sexText setTextColor:textFieldTextColor];
        
        if (buttonIndex ==0) {
            sexText.text=@"Male";
        }
        else {
            sexText.text=@"Female";
        }
        
    }
    
    if (alertView.tag == 610) {
        if (buttonIndex ==0) {
            //[appdelegate logout];
        }
    }
}

#pragma mark - UItextfield delegate ---------------------

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    TempViewForDatePicker.hidden= YES;
    datePicker.hidden =YES;
    countryPicker.hidden =YES;
    NSLog(@"Click on text field..!!!!!!");
    datePicker.hidden=YES;
    //section 0
    
    if([usernameText isFirstResponder]){
        [usernameText becomeFirstResponder];
        /*NSIndexPath *middleIndexPath;
         middleIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
         [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];*/
        
    }
    if([passwordText isFirstResponder])
    {
        [passwordText becomeFirstResponder];
    }
    if([confirmPasstext isFirstResponder])
    {
        [confirmPasstext becomeFirstResponder];
    }
    /* if([passwordText isFirstResponder]){
     NSIndexPath *middleIndexPath;
     middleIndexPath = [NSIndexPath indexPathForRow:2 inSection:1];
     [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
     }
     if([confirmPasstext isFirstResponder]){
     NSIndexPath *middleIndexPath;
     middleIndexPath = [NSIndexPath indexPathForRow:3 inSection:1];
     [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
     }*/
    //section 1
    
    if(self.fNameText==textField)
    {
        NSLog(@"value of textfield is %@",textField);
        NSIndexPath *middleIndexPath;
        middleIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    if(mNameText==textField)
    {
        NSLog(@"value of textfield is %@",textField);
        NSIndexPath *middleIndexPath;
        middleIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    if([lNameText isFirstResponder])
    {
        NSIndexPath *middleIndexPath;
        middleIndexPath = [NSIndexPath indexPathForRow:2 inSection:1];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    if([dateOfBirthText isFirstResponder]){
        [textField resignFirstResponder];
        NSIndexPath *middleIndexPath;
        middleIndexPath = [NSIndexPath indexPathForRow:3 inSection:1];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    
    if([sexText isFirstResponder]){
        [self.view endEditing:YES];
        [textField resignFirstResponder];
        NSIndexPath *middleIndexPath;
        middleIndexPath = [NSIndexPath indexPathForRow:4 inSection:1];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    if([addressText1 isFirstResponder]){
        NSIndexPath *middleIndexPath;
        middleIndexPath = [NSIndexPath indexPathForRow:5 inSection:1];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    
    if([addressText2 isFirstResponder]){
        NSIndexPath *middleIndexPath;
        middleIndexPath = [NSIndexPath indexPathForRow:6 inSection:1];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    if([CityText isFirstResponder]){
        NSIndexPath *middleIndexPath;
        middleIndexPath = [NSIndexPath indexPathForRow:7 inSection:1];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    if([RegionText isFirstResponder]){
        NSIndexPath *middleIndexPath;
        middleIndexPath = [NSIndexPath indexPathForRow:8 inSection:1];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    
    if([countryText isFirstResponder]){
        [textField resignFirstResponder];
        NSIndexPath *middleIndexPath;
        middleIndexPath = [NSIndexPath indexPathForRow:9 inSection:1];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    
    if([PostCodeText isFirstResponder]){
        NSIndexPath *middleIndexPath;
        middleIndexPath = [NSIndexPath indexPathForRow:10 inSection:1];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    if([emailText isFirstResponder]){
        NSIndexPath *middleIndexPath;
        middleIndexPath = [NSIndexPath indexPathForRow:11 inSection:1];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    if([mobileText isFirstResponder]){
        NSIndexPath *middleIndexPath;
        middleIndexPath = [NSIndexPath indexPathForRow:12 inSection:1];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    if([faxText isFirstResponder]){
        NSIndexPath *middleIndexPath;
        middleIndexPath = [NSIndexPath indexPathForRow:13 inSection:1];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    
    if([cardNumberText isFirstResponder]){
        NSIndexPath *middleIndexPath;
        middleIndexPath = [NSIndexPath indexPathForRow:1 inSection:2];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        [self addReturnButtonInNumPad];
    }
    if([cardNameText isFirstResponder]){
        NSIndexPath *middleIndexPath;
        middleIndexPath = [NSIndexPath indexPathForRow:1 inSection:2];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    if([cvvText isFirstResponder]){
        NSIndexPath *middleIndexPath;
        middleIndexPath = [NSIndexPath indexPathForRow:2 inSection:2];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        
    }
    if([expiryText isFirstResponder]){
        [textField resignFirstResponder];
        NSIndexPath *middleIndexPath;
        middleIndexPath = [NSIndexPath indexPathForRow:3 inSection:2];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    if (textField==usernameText)
    {
        [passwordText becomeFirstResponder];
    }
    else if(textField==passwordText)
    {
        [confirmPasstext becomeFirstResponder];
    }
    else if(textField==confirmPasstext)
    {
        [fNameText becomeFirstResponder];
    }
    else if (textField==self.fNameText) {
        [mNameText becomeFirstResponder];
    }
    else if (textField==mNameText){
        [lNameText becomeFirstResponder];
    }
    else if (textField==lNameText){
        [self.view endEditing:YES];
        [self checkForFirstResponder];
        [self performSelector:@selector(openDOBPicker)];
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
        [self.view endEditing:YES];
        [self checkForFirstResponder];
        [self performSelector:@selector(openCountryPicker)];
        //
    }else if (textField==emailText){
        [mobileText becomeFirstResponder];
    }
    else if (textField==mobileText){
        [faxText becomeFirstResponder];
    }
    else if (textField==faxText){
        [cardNumberText becomeFirstResponder];
    }
    else if (textField==cardNumberText){
        [cardNameText becomeFirstResponder];
    }
    else if (textField==cardNameText){
        [cvvText becomeFirstResponder];
    }
    else if (textField==cvvText){
        // [expiryText becomeFirstResponder];
        [self.view endEditing:YES];
        [self checkForFirstResponder];
        [self performSelector:@selector(openExpiryPicker)];
        
    }
    
    
    return YES;
    
}
-(void)tempKeyboardShow:(UITextField*)sender{
    
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
        
        
        if (textField==cardNumberText||textField==cvvText||textField==PostCodeText||textField==mobileText||textField==faxText) {
            
            if ([string isEqualToString:@" "]) {
                return NO;
            }
            else{
                // return YES;
            }
        }
        if( textField == usernameText ||textField == emailText || textField == cardNameText)
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
        if( textField ==self.fNameText ||textField == mNameText || textField == lNameText)
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
                
                if (textField.text.length<30) {
                    
                    if(textField==CityText)
                    {
                        if (textField.keyboardType == UIKeyboardTypeDefault)
                        {
                            if ([string rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound)
                            {
                                // BasicAlert(@"", @"This field accepts only numeric entries.");
                                if (textField.text.length<30) {
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
                    else
                        return YES;
                }
                else{
                    return NO;
                }
            }
        }
        if( textField == RegionText ||textField == countryText || textField == cardNumberText)
        {
            //max 20 charactersss.....
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
        
        if( textField == faxText||textField==mobileText)
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
        if(textField == PostCodeText)
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
        if(textField==confirmPasstext|| textField==passwordText)
        {
            if (string.length==0) {
                return YES;
            }
            else{
                
                if( textField == passwordText || textField == confirmPasstext)
                {
                    NSLog(@"string legnth %d",[textField.text length]);
                    if([textField.text length]>15)
                    {
                        return NO;
                        
                    }
                    else{
                        for (int i = 0; i < [string length]; i++)
                        {
                            NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"%",@"&",@"'",@";",nil];
                            
                            
                            for(int j = 0; j<[arr count];j++)
                            {
                                NSString *strg = [arr objectAtIndex:j];
                                
                                NSCharacterSet *myCharSet =[NSCharacterSet characterSetWithCharactersInString:strg];
                                unichar c = [string characterAtIndex:i];
                                if ([myCharSet characterIsMember:c])
                                {
                                    return NO;
                                    
                                }
                            }
                        }
                        
                        NSUInteger newLength = [textField.text length] + [string length] - range.length;
                        
                        if([string length]==0)
                        {
                            return NO;
                        }
                        else
                        {
                            BOOL is_chek = (newLength>=32)? NO : YES;
                            
                            if(is_chek ==NO && [string isEqualToString:@"\n"])
                            {
                                return YES;
                            }
                            else
                            {
                                return is_chek;
                            }
                            
                        }
                    }
                }

                
                
               /* if (textField.text.length<15) {
                    return YES;
                }
                else{
                    return NO;
                }*/
                
            }
            
            
        }
        if(textField==cvvText)
        {
            //max 8 charactersss.....
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
        if( textField == cardIssuerNumberText)
        {
            //max 2 charactersss.....
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

#pragma mark  - Picker open methods -------------------

-(void)openDOBPicker{
    
    
    //dob
    NSLog(@"dob");
    genderPicker.hidden=YES;
    countryPicker.hidden=YES;
    expdatepickerview.hidden=YES;
    closebtnstr=@"datecancel";
    //to scroll table..//ajit
    NSIndexPath *middleIndexPath;
    middleIndexPath = [NSIndexPath indexPathForRow:3 inSection:1];
    [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    //................
    
    
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
    [self.view addSubview:TempViewForDatePicker];
    
    if([dateOfBirthText.text length]!=0)
    {
        NSString *dateStr =dateOfBirthText.text;
        
        // Convert string to date object
        
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSDate *date = [dateFormat dateFromString:dateStr];
        datePicker.date = date;
        
    }
    else{
        datePicker.date = [NSDate date];
    }
    
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    isDOB = YES;
    
}

-(void)openGenderPicker{
    
    //gender
    NSLog(@"gender");
    closebtnstr=@"malefemalecancel";
    //scroll for gender text ------ ajit
    NSIndexPath *middleIndexPath;
    middleIndexPath = [NSIndexPath indexPathForRow:4 inSection:1];
    [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    //---------------------------------
    [TempViewForDatePicker addSubview:genderPicker];
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
    [pickerDoneButton addTarget:self action:@selector(donegenderpicker) forControlEvents:UIControlEventTouchUpInside];
    [TempViewForDatePicker addSubview:pickerDoneButton];
    [TempViewForDatePicker bringSubviewToFront:pickerDoneButton];
    [TempViewForDatePicker bringSubviewToFront:self.pickerbgimage];
    pickerDoneButton.hidden=NO;
    //------
    datePicker.hidden =YES;
    TempViewForDatePicker.hidden = NO;
    genderPicker.hidden=NO;
    countryPicker.hidden=YES;
    if (sexText.text==nil) {
        sexText.text=@"";
        [genderPicker selectRow:0 inComponent:0 animated:NO];
        
    }
    
    else{
        NSString *strGenderName = [[NSString alloc] initWithString:sexText.text];
        //	BOOL isOk = [getCountryName containsObject:strCntryName];
        selectRowGender = [genderarray indexOfObject:strGenderName];
        if (selectRowGender!=0&&selectRowGender!=1) {
            selectRowGender=0;
        }
        [genderPicker selectRow:selectRowGender inComponent:0 animated:NO];
        
    }
    [self.view addSubview:TempViewForDatePicker];
    isCountry = YES;
    [self checkForFirstResponder];
    
}

-(void)openCountryPicker{
    //contry
    NSLog(@"contry");
    NSLog(@"Tap on Countryyyyyyyyy ");
    closebtnstr=@"countrycancel";
    
    if (noCurrencyFormServer) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:Unablecountrylist delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else {
        closebtnstr=@"countrycancel";
        [self.view endEditing:YES];
        [self checkForFirstResponder];
        //scroll for country text.. ajit...
        NSIndexPath *middleIndexPath;
        middleIndexPath = [NSIndexPath indexPathForRow:11 inSection:1];
        [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        //---------------------------------
        [TempViewForDatePicker addSubview:countryPicker];
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
        [pickerDoneButton addTarget:self action:@selector(doneContryPicker) forControlEvents:UIControlEventTouchUpInside];
        [TempViewForDatePicker addSubview:pickerDoneButton];
        [TempViewForDatePicker bringSubviewToFront:pickerDoneButton];
        [TempViewForDatePicker bringSubviewToFront:self.pickerbgimage];
        
        pickerDoneButton.hidden=NO;
        
        datePicker.hidden=YES;
        genderPicker.hidden=YES;
        expdatepickerview.hidden=YES;
        
        
        
        if (getCountryName.count>0) {
            
            TempViewForDatePicker.hidden = NO;
            countryPicker.hidden=NO;
            
            BOOL isFound=NO;
            
            for (int i=0; i< getCountryName.count; i++) {
                if ([countryText.text isEqualToString:[NSString stringWithFormat:@"%@",[getCountryName objectAtIndex:i]]]) {
                    isFound=YES;
                }
            }
            if (isFound) {
                NSString *strCntryName = [[NSString alloc] initWithString:countryText.text];
                selectRow = [getCountryName indexOfObject:strCntryName];
                NSLog(@"Countryyyyyy Picker");
                [countryPicker selectRow:selectRow inComponent:0 animated:NO];
            }
            else{
                [countryPicker selectRow:0 inComponent:0 animated:NO];
            }
            [self.view addSubview:TempViewForDatePicker];
            isCountry = YES;
            [self checkForFirstResponder];
        }
        else{
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:Unablecountrylist delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alert show];
            
        }
        
    }
    
    
}

-(void)openExpiryPicker{
    //expiry..
    NSLog(@"Expiry");
    closebtnstr=@"expirydatecanel";
    //expiery date scroll tableview....--- ajit
    NSIndexPath *middleIndexPath;
    [self.view endEditing:YES];
    [self checkForFirstResponder];
    middleIndexPath = [NSIndexPath indexPathForRow:3 inSection:2];
    [tableSignup scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    //-----------------
    
    
    [TempViewForDatePicker addSubview:expdatepickerview];
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
    [pickerDoneButton addTarget:self action:@selector(doneExpPicker) forControlEvents:UIControlEventTouchUpInside];
    [TempViewForDatePicker addSubview:pickerDoneButton];
    [TempViewForDatePicker bringSubviewToFront:pickerDoneButton];
    [TempViewForDatePicker bringSubviewToFront:self.pickerbgimage];
    
    
    pickerDoneButton.hidden=NO;
    // Added by Manoj 20/09/2011
    
    //------
    TempViewForDatePicker.hidden = YES;
    datePicker.hidden =YES;
    
    
    TempViewForDatePicker.hidden = NO;
    expdatepickerview.hidden=NO;
    countryPicker.hidden=YES;
    genderPicker.hidden=YES;
    
    [self.view addSubview:TempViewForDatePicker];
    [self selectToday];
    
    
    
}




@end


