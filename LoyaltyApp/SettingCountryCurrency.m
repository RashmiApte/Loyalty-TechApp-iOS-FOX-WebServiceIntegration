/*
 *
 * Copyright -Year _Company Name_.  All rights reserved.
 *
 * File Name       : SettingCountryCurrency.m
 *
 * Created Date    : 14/05/10
 *
 * Description     :
 *
 * Modification History:
 *
 * Date            Name                Description
 * ------------------------------------------------
 * 29/11/11	   Shailesh Tiwari
 * 02/08/13    Rashmi Jati Apte     initWithFrame:reuseIdentifier: is deprecated in iOS 3.0. Replaced it                          with initWithStyle:reuseIdentifier:
 *
 * Bug History:
 *
 * Date            Id                Description
 * ------------------------------------------------
 *
 */


#import "SettingCountryCurrency.h"
#import "YPCountryListRequest.h"
#import "YPCountryListResponse.h"
#import "WebserviceOperation.h"
#import "YPCountryDetail.h"
#import "YPCurrencyCodeDetails.h"
#import "YPCurrencyCodesResponse.h"
#import "SignUpViewController.h"



#import "Constant.h"
#import "Common.h"
#import "DataBase.h"

NSString *currencyName;
BOOL is_ForPicker;
int pickertagvalue;
#define kOFFSET_FOR_KEYBOARD 130.0

@implementation SettingCountryCurrency
@synthesize tableSettingCountryCurrency;

@synthesize imgOnline;
@synthesize imgBottomImage;

@synthesize isPushFromLogin;


BOOL noCurrencyList;
BOOL noCountryList;
BOOL isProcess;
BOOL noCurrencyFormServer;
BOOL isPickerMoveUp,isCountryMoveUp;





#pragma mark - UIViewcontroller delegates --------------------------------------------------
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewDidLoad {
    [super viewDidLoad];
    
	if([Common isNetworkAvailable])
	{
		
        imgOnline.image=[UIImage imageNamed:@"online.png"];
        
	}
	else {
		
        imgOnline.image=[UIImage imageNamed:@"offline.png"];
	}
    
    arrayPickerList=[[NSMutableArray alloc] init];
    
    
    //--------------------- Update button ---------------------------
    
	UIButton *btnNext =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnNext setBackgroundImage:[UIImage imageNamed:@"button_home_60_29.png"] forState:UIControlStateNormal];
	//[btnSubmit setImage:[UIImage imageNamed:@"submit.png"] forState:UIControlStateNormal];
	[btnNext addTarget:self action:@selector(Submit) forControlEvents:UIControlEventTouchUpInside];
    if (isPushFromLogin) {
        [btnNext setTitle:@"Submit" forState:UIControlStateNormal];
    }
    else{
        [btnNext setTitle:@"Next" forState:UIControlStateNormal];
    }

	[btnNext setFrame:CGRectMake(250,7,60,29)];
    btnNext.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(14.0)];
    [btnNext.titleLabel setTextColor:btntextColor];
    
    
    //----------------------------------------------------------------
    
    //---------------------- Back button -----------------------------
    
	UIButton *btnBack =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"button_home_60_29.png"] forState:UIControlStateNormal];
	[btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    btnBack.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(14.0)];
    [btnBack.titleLabel setTextColor:btntextColor];
    [btnBack setTitle:@"Back" forState:UIControlStateNormal];
    btnBack.titleLabel.font=[UIFont fontWithName:labelregularFont size:15];
    
	[btnBack setFrame:CGRectMake(10,7, 60, 29)];
    
    //--------------------- Design heder of This screen --------------
    
    CGRect re= CGRectMake(0, 0, 320, 53);
    UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_back.png"]];
    UILabel *lbl =[[UILabel alloc]init];
    CGRect lblrect= CGRectMake(0, 8, 320, 23);// 73, 10, 142, 23
    lbl.frame=lblrect;
    lbl.text=@"Settings";
    [lbl setTextColor:headertitletextColor];
    lbl.font = [UIFont fontWithName:labelregularFont size:(22.0)];
    lbl.backgroundColor=[UIColor clearColor];
    [img addSubview:lbl];
    img.frame=re;
    
    //----------------------------------------------------------------
    lbl.backgroundColor=[UIColor clearColor];
    lbl.textAlignment=NSTextAlignmentCenter;
    
    img.frame=re;
    [self.view addSubview:img];
    [img addSubview:lbl];
    [self.view addSubview:btnBack];
    [self.view addSubview:btnNext];
    //----------------------------------------------------------------

    if ([UIScreen mainScreen].bounds.size.height != 568)
    {
        imgBottomImage.frame=CGRectMake(0, 320, 320, 140);
        imgOnline.frame=CGRectMake(258, 375, 42, 9);
        tableSettingCountryCurrency.frame=CGRectMake(0, 66, 320, 250);
        
    }
    
    
    
    lblSettingCountry=[[UILabel alloc] initWithFrame:CGRectMake(40 , 10, 200, 25)];
    lblSettingCurrency=[[UILabel alloc] initWithFrame:CGRectMake(40 , 10, 200, 25)];
    lblSettingURL=[[UILabel alloc] initWithFrame:CGRectMake(40 , 10, 200, 25)];
    
    
    
    [lblSettingURL setTextAlignment:NSTextAlignmentLeft];
    lblSettingURL.font=[textFieldnewTextFont];
    [lblSettingURL setTextColor:textFieldTextColor];
    
    [lblSettingCountry setTextAlignment:NSTextAlignmentLeft];
    lblSettingCountry.font=[textFieldnewTextFont];
    [lblSettingCountry setTextColor:textFieldTextColor];
    
    [lblSettingCurrency setTextAlignment:NSTextAlignmentLeft];
    lblSettingCurrency.font=[textFieldnewTextFont];
    [lblSettingCurrency setTextColor:textFieldTextColor];
    
    
    
    
    //--------------- Putting intial value in country , currency and URL-----------------
    
    //====================== Country and currency =======================================
    
    NSString *country= [[NSUserDefaults standardUserDefaults] objectForKey:@"CountrySetting"];
    NSString *currency= [NSString stringWithFormat:@"%@ - %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"CurrencyAlphaCodeSetting"],[[NSUserDefaults standardUserDefaults] objectForKey:@"CurrencySetting"]];
    
    if ([country length]==0 || [currency length]==0)
    {
        [lblSettingCountry setText:@"United Kingdom"];
        [lblSettingCurrency setText:@"GBP - Pound Sterling"];
    }
    else
    {
        [lblSettingCountry setText:country];
        [lblSettingCurrency setText:currency];
    }
    
    //====================================================================================
    
    //========================== Setting URL =============================================
    NSString *strFinalURL=[[NSUserDefaults standardUserDefaults] objectForKey:@"FinalURL"];
    if (strFinalURL.length==0 || strFinalURL==nil || strFinalURL==NULL)
    {
        
        [lblSettingURL setText:@"Europe"];
        
    }
    else{
        
        NSString *strFetchStagingURL=NSLocalizedString(@"StagingURL",@"");
        
        NSString *strCurrentURL=[[NSUserDefaults standardUserDefaults] objectForKey:@"FinalURL"];
        
        
        if ([strCurrentURL isEqualToString:strFetchStagingURL]) {
            
            [lblSettingURL setText:@"Staging"];
            //            settingPickerstrvalue=settingLabel.text;
    	}
        else
        {
            [lblSettingURL setText:@"Europe"];
        }
        
    }
    //====================================================================================
    
    arrayURL=[[NSMutableArray alloc] init];
    
    [arrayURL addObject:@"Europe"];
    [arrayURL addObject:@"Staging"];
    
    //======================pickerview ================================
    
    if ([UIScreen mainScreen].bounds.size.height==568) {
     
        viewPicker=[[UIView alloc] initWithFrame:CGRectMake(0,550, 320, 200)];
    }
    else{
    
    viewPicker=[[UIView alloc] initWithFrame:CGRectMake(0,460, 320, 200)];
    }
    
    viewPicker.backgroundColor=[UIColor clearColor];
    
    imgPickerBorder=[[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 320, 160)];
    [imgPickerBorder setImage:[UIImage imageNamed:@"calendar_bg.png"]];

    imgPickerBack=[[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 320, 160)];
    [imgPickerBack setImage:[UIImage imageNamed:@"background_white.png"]];
    
    
    pickerList=[[UIPickerView alloc] initWithFrame:CGRectMake(10, 40, 300, 160)];
    pickerList.showsSelectionIndicator=YES;
    [pickerList setDelegate:self];
    
    btnClosePicker=[UIButton buttonWithType:UIButtonTypeCustom];
    btnClosePicker.frame=CGRectMake(20, 2, 99, 43);
    btnClosePicker.tag=0;
    [btnClosePicker addTarget:self action:@selector(pickerButton:) forControlEvents:UIControlEventTouchUpInside];
    [btnClosePicker setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    
    btnDonePicker=[UIButton buttonWithType:UIButtonTypeCustom];
    btnDonePicker.frame=CGRectMake(200, 2, 99, 43);
    btnDonePicker.tag=1;
    [btnDonePicker addTarget:self action:@selector(pickerButton:) forControlEvents:UIControlEventTouchUpInside];
    [btnDonePicker setImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateNormal];
    
    
    
    
    [viewPicker addSubview:btnClosePicker];
    [viewPicker addSubview:btnDonePicker];
    [viewPicker addSubview:imgPickerBack];
    [viewPicker addSubview:pickerList];
    [viewPicker addSubview:imgPickerBorder];
    
    [self.view addSubview:viewPicker];
    
    
    
    
    
    
    
    //=================================================================
    
    
    [self performSelector:@selector(fetchCountryList)];

    
}


-(void)viewDidAppear:(BOOL)animated
{
	
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - Webservice calling --------------------------------------------


-(void)fetchCountryList
{
    
    
    //-----------  fetching country List -------------------------------
    
    arrayCountryList =[DataBase getAllCountryList];
    
    
    
    if ([arrayCountryList count] <=0)
    {
        
        if ([Common isNetworkAvailable])
        {
            
            WebserviceOperation *serviceGetCountryList=[[WebserviceOperation alloc] initWithDelegate:self callback:@selector(getCountryListHandler:)];
            
            [self showHUD:loadingaything];
            
            [serviceGetCountryList getCountryList];
            
            
        }
        else{
        
            //set default Country name ------------------------
            
            
            
            [self performSelector:@selector(fetchCurrencyList)];

        
        }
    }
    else
    {
        NSLog(@"getCountryList = %@",arrayCountryList);

        [self performSelector:@selector(fetchCurrencyList)];
    }
    
    //------------------------------------------------------------------
    
    
    
}

-(void)fetchCurrencyList
{
    
    if (arrayCurrencyList.count>0) {
        [arrayCurrencyList removeAllObjects];
    }
    
    arrayCurrencyList=[DataBase getAllCurrencyList];
    
    
    
    if ([arrayCurrencyList count]<=0)
    {
        
        NSLog(@" NO Resords in database Now fetching records from network");
        if([Common isNetworkAvailable])
        {
            
            WebserviceOperation *serviceGetCurrencyList = [[WebserviceOperation alloc]initWithDelegate:self callback:@selector(getCurrencyListHandler:)];
            
            [serviceGetCurrencyList getCurrencyList];
            
        }
        else {
            //set default currency name ---------------------
            
            
            
        }
    }
    else
    {
        NSLog(@"getCurrencyList = %@",arrayCurrencyList);

        
    }
    
    
}



#pragma mark - Webservice Handler --------------------------------------------

-(void) getCountryListHandler: (id) value{
    
    
    //Handle error
    if([value isKindOfClass:[NSError class]]) {
        
        NSLog(@"%@", value);
        //        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
        return;
    }
    
    // Handle faults
    if([value isKindOfClass:[SoapFault class]]) {
        
        NSLog(@"%@", value);
        //        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
        return;
    }
    
    YPCountryListResponse *objCountryListResponse=[[YPCountryListResponse alloc] init];
    
    [objCountryListResponse parsingCountryList:value];
    
    
    if (objCountryListResponse.statusCode==0)
    {
        
        if ([objCountryListResponse.countryList count] >0)
        {
            for (int i=0; i<[objCountryListResponse.countryList count]; i++)
            {
                
                YPCountryDetail *countryDetails = (YPCountryDetail *)[objCountryListResponse.countryList objectAtIndex:i];
                
                NSString *insertQuery = @"insert into CountryDetails(countrycode,countryname";
                NSString *insertQueryValues = @" values(";
                
                insertQueryValues = [insertQueryValues stringByAppendingString:
                                     [NSString stringWithFormat:@"'%@','%@'",countryDetails.countryCode,[countryDetails.countryName capitalizedString]]];
                
                insertQuery = [insertQuery stringByAppendingString:[NSString stringWithFormat:@")%@)",insertQueryValues]];
                
                [DataBase InsertIntoTable:insertQuery];
            }
            
            if (arrayCountryList.count>0) {
                [arrayCountryList removeAllObjects];
            }
            
            arrayCountryList=[DataBase getAllCountryList];
            
        }
        
        [self performSelector:@selector(fetchCurrencyList)];
    }
    else{
        
        [self performSelector:@selector(fetchCurrencyList)];

        //???Status code
        
        //GetCountryList error------------------
//        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Error code: %d",objCountryListResponse.statusCode] delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        [alertView show];
        
        
        
        
        
        
    }
}


-(void)getCurrencyListHandler: (id) value {
	
   
    //Handle error
    if([value isKindOfClass:[NSError class]]) {
        
        NSLog(@"%@", value);
        //        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
        return;
    }
    
    // Handle faults
    if([value isKindOfClass:[SoapFault class]]) {
        
        NSLog(@"%@", value);
        //        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
        return;
    }
    
    
    
    YPCurrencyCodesResponse *objCurrencyCodesResponse=[[YPCurrencyCodesResponse alloc] init];
    
    [objCurrencyCodesResponse parsingCurrencyList:value];

    NSLog(@"response message = %@   status code = %d valid = %x",objCurrencyCodesResponse.responseMessage,objCurrencyCodesResponse.statusCode,objCurrencyCodesResponse.valid);
    
    if (objCurrencyCodesResponse.statusCode==0)
    {
        
        if ([objCurrencyCodesResponse.currencyCodeList count] >0)
        {
            

           
            for (int i=0; i<[objCurrencyCodesResponse.currencyCodeList count]; i++)
            {
                
                YPCurrencyCodeDetails *codeDetail= (YPCurrencyCodeDetails*)[objCurrencyCodesResponse.currencyCodeList objectAtIndex:i];
                
                [DataBase saveCurrencListInToDataBase:codeDetail.currencyCode :codeDetail.currencyAlphaCode :[codeDetail.currencyName capitalizedString]];
                
            }
        }
    }
    else{
        
        //???Status Code
        

        //GetCountryList error------------------
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Error code: %d",objCurrencyCodesResponse.statusCode] delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
        
        
        
    }
    
   
    
    
}


#pragma mark - UITableview delegate -----------------------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return tableHeaderHeight-10;
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==2) {
        return 140;
    }
    return 50;
    

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(20, 0, 300, 30);
    label.backgroundColor = [UIColor clearColor];
    label.font=[UIFont fontWithName:labelregularFont size:18];
    
    switch (section) {
        case 0:
            label.text = @"Select Country:";
            break;
        case 1:
            label.text = @"Select Currency:";
            break;
        case 2:
            label.text = @"Select URL:";
            
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 320,40)];
    view.backgroundColor=[UIColor whiteColor];
    [view addSubview:label];
	
    return view;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
    if (indexPath.section==0)
    {
        
        //lblSettingCountry.text=@"United Kingdom";
        [cell addSubview:lblSettingCountry];
        
        
    }
    else if (indexPath.section==1)
    {
        
       // lblSettingCurrency.text=@"GBP - Pound Sterling";
        [cell addSubview:lblSettingCurrency];
        
    
    }
    else if (indexPath.section==2)
    {
        
            //lblSettingURL.text=@"Staging";
            [cell addSubview:lblSettingURL];
        
    
    }
    
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    //cell.backgroundColor=[UIColor greenColor];
    
    //--------------------- Background label -------------------------------------
    UILabel *lblBackground=[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 30)];
    lblBackground.layer.cornerRadius=5;
    lblBackground.layer.borderWidth=0.5;
    lblBackground.layer.borderColor=[UIColor grayColor].CGColor;
    lblBackground.backgroundColor=[UIColor clearColor];
    [cell addSubview:lblBackground];
    //----------------------------------------------------------------------------
    
    
    return cell;

    

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (arrayPickerList.count>0) {
        [arrayPickerList removeAllObjects];
    }
    
    
    BOOL isFound=NO;
    int j;
    
    switch (indexPath.section) {
        case 0:
            
            for (int i=0; i<arrayCountryList.count; i++) {
                [arrayPickerList addObject:[arrayCountryList objectAtIndex:i]];
            }
            
            
            for ( j =0; j< arrayPickerList.count; j++) {
                if ([[[arrayPickerList objectAtIndex:j] valueForKey:@"countryName"] isEqualToString:lblSettingCountry.text]) {
                    isFound=YES;
                    break;
                }
            }
            
            break;
        
        case 1:
            
            for (int i=0; i<arrayCurrencyList.count; i++) {
                [arrayPickerList addObject:[arrayCurrencyList objectAtIndex:i]];
            }
            
            for ( j =0; j< arrayPickerList.count; j++) {
                if ([[NSString stringWithFormat:@"%@ - %@",[[arrayPickerList objectAtIndex:j] valueForKey:@"currencyAlphaCode"],[[arrayPickerList objectAtIndex:j] valueForKey:@"currencyName"]] isEqualToString:lblSettingCurrency.text]) {
                    isFound=YES;
                    break;
                }
            }
            break;
            
       case 2:
            
            for (int i=0; i<arrayURL.count; i++) {
                [arrayPickerList addObject:[arrayURL objectAtIndex:i]];
            }
            
            for ( j =0; j< arrayPickerList.count; j++) {
                if ([[arrayPickerList objectAtIndex:j] isEqualToString:lblSettingURL.text]) {
                    isFound=YES;
                    break;
                }
            }
            
            break;
       
    }
    
    NSLog(@"Country === %@",arrayPickerList);
    selectedSection=indexPath.section;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelegate:self];
    if ([UIScreen mainScreen].bounds.size.height==568) {
        
        viewPicker.frame= CGRectMake(0,350, 320, 180);
    }
    else{
        
        viewPicker.frame=CGRectMake(0,260, 320, 200);
    }
    
    [UIView commitAnimations];
    
    [pickerList reloadAllComponents];
   
    if (isFound)
    {
        [pickerList selectRow:j inComponent:0 animated:NO];
    }
    

}


#pragma mark - UIPickerview delegate
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    return arrayPickerList.count;
    


}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    switch (selectedSection) {
        case 0:
            return [[arrayPickerList objectAtIndex:row] valueForKey:@"countryName"];
            
            break;
        case 1:
            
            return [NSString stringWithFormat:@"%@ - %@",[[arrayPickerList objectAtIndex:row] valueForKey:@"currencyAlphaCode"],[[arrayPickerList objectAtIndex:row] valueForKey:@"currencyName"]];
            break;
            
        case 2:
            
            return [arrayPickerList objectAtIndex:row];
            break;
            
            
    }
return [arrayPickerList objectAtIndex:row];

}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 37)];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    
    
    
    switch (selectedSection) {
        case 0:
            label.text= [[arrayPickerList objectAtIndex:row] valueForKey:@"countryName"];
            
            break;
        case 1:
            
            label.text= [NSString stringWithFormat:@"%@ - %@",[[arrayPickerList objectAtIndex:row] valueForKey:@"currencyAlphaCode"],[[arrayPickerList objectAtIndex:row] valueForKey:@"currencyName"]];
            break;
            
        case 2:
            
            label.text= [arrayPickerList objectAtIndex:row];
            break;
            
            
    }
    
    
    return label;
}

#pragma mark - Button methods -----------------------------------
-(void)pickerButton:(UIButton *)pickerButton{
    
    if (pickerButton.tag==0) {
        //close button
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.4];
        [UIView setAnimationDelegate:self];
        if ([UIScreen mainScreen].bounds.size.height==568) {
            
            viewPicker.frame= CGRectMake(0,550, 320, 180);
        }
        else{
            
            viewPicker.frame=CGRectMake(0,460, 320, 200);
        }
        
        [UIView commitAnimations];
    
        
        
    }
    else if (pickerButton.tag==1){
       // Done button
        
        switch (selectedSection) {
            case 0:
                
                lblSettingCountry.text=[[arrayCountryList objectAtIndex:[pickerList selectedRowInComponent:0]] valueForKey:@"countryName"];
                
                break;
                
            case 1:
                
                lblSettingCurrency.text=[NSString stringWithFormat:@"%@ - %@",[[arrayCurrencyList objectAtIndex:[pickerList selectedRowInComponent:0]] valueForKey:@"currencyAlphaCode"],[[arrayCurrencyList objectAtIndex:[pickerList selectedRowInComponent:0]] valueForKey:@"currencyName"]];

                break;
                
            case 2:
                lblSettingURL.text=[arrayURL objectAtIndex:[pickerList selectedRowInComponent:0]];

                break;
                
            default:
                break;
        }
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.4];
        [UIView setAnimationDelegate:self];
        if ([UIScreen mainScreen].bounds.size.height==568) {
            
            viewPicker.frame= CGRectMake(0,550, 320, 180);
        }
        else{
            
            viewPicker.frame=CGRectMake(0,460, 320, 200);
        }
        
        [UIView commitAnimations];
        
        

    
    
    }

}
-(void) Submit{
    
   //???arraysearch
    
    NSString *strCountryCode=@"";
    NSString *strCurrencyCode=@"";
    NSString *strCurrencyAlphaCode=@"";
    NSString *strCurrencyName=@"";
    
    strCurrencyAlphaCode=[[lblSettingCurrency.text componentsSeparatedByString:@"-"] objectAtIndex:0];
    strCurrencyName=[[lblSettingCurrency.text componentsSeparatedByString:@"-"] objectAtIndex:1];
    
    
   strCurrencyAlphaCode = [strCurrencyAlphaCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
   
    strCurrencyName = [strCurrencyName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    
    for (int j=0; j< arrayCurrencyList.count; j++) {
        if ([[[arrayCurrencyList objectAtIndex:j] valueForKey:@"currencyAlphaCode"] isEqualToString:strCurrencyAlphaCode]) {
            strCurrencyCode=[[arrayCurrencyList objectAtIndex:j] valueForKey:@"currencyCode"];
        }
    }
    
    for (int i=0; i<arrayCountryList.count; i++) {
        if ([[[arrayCountryList objectAtIndex:i] valueForKey:@"countryName"] isEqualToString:lblSettingCountry.text]) {
            strCountryCode=[[arrayCountryList objectAtIndex:i] valueForKey:@"countryCode"];
        }
        
    }
     //--------------------- Currency ------------------------------
	[[NSUserDefaults standardUserDefaults] setObject:strCurrencyName forKey:@"CurrencySetting"];
    
	[[NSUserDefaults standardUserDefaults] setObject:strCurrencyCode forKey:@"CurrencyCodeSetting"];
    
	
	[[NSUserDefaults standardUserDefaults] setObject:strCurrencyAlphaCode forKey:@"CurrencyAlphaCodeSetting"];
    
    //-------------------------------------------------------------
    
    
    //---------------------------- Country ----------------------------
	[[NSUserDefaults standardUserDefaults] setObject:strCountryCode forKey:@"CountryCodeSetting"];
    
	
	[[NSUserDefaults standardUserDefaults] setObject:lblSettingCountry.text forKey:@"CountrySetting"];
	
    
    //------------------------------------------------------------------
   
    //-------------------Set Webservice URL ----------------------------
    if ([lblSettingURL.text isEqualToString:@"Europe"])
    {
        
        NSString *strFetchURL=NSLocalizedString(@"DomainURL",@"");
        [[NSUserDefaults standardUserDefaults] setObject:strFetchURL forKey:@"FinalURL"];
	}
	else
    {
        NSString *strFetchURL=NSLocalizedString(@"StagingURL",@"");
        [[NSUserDefaults standardUserDefaults] setObject:strFetchURL forKey:@"FinalURL"];
        
	}
    //------------------------------------------------------------------
    
    
    
	    NSLog(@"SET url ----------------  %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"FinalURL"]);
	    NSLog(@"CurrencySetting = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"CurrencySetting"]);
    	NSLog(@"CurrencyCodeSetting = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"CurrencyCodeSetting"]);
    	NSLog(@"CurrencyAlphaCodeSetting = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"CurrencyAlphaCodeSetting"]);
    	NSLog(@"CountryCodeSetting = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"CountryCodeSetting"]);
    	NSLog(@"CountrySetting = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"CountrySetting"]);
    
    
    //----------------------- Check from where this class has pushed ----------------------------
    if (isPushFromLogin) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:countrycurrencysuccessfullysert delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert setTag:101];
    }
    else{
        SignUpViewController *objSignUpViewController = [[SignUpViewController alloc] init];
        [self.navigationController pushViewController:objSignUpViewController animated:YES];
    }
    //--------------------------------------------------------------------------------------------
    

    
}



-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



#pragma mark - UIAlerview delegates --------------------------------------------------

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (alertView.tag==101) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}



#pragma mark - HudView methods --------------------------------------------

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

#pragma mark - Status bar ------------------------------------------------------

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
