;
/*
 *
 * Copyright -Year _Company Name_.  All rights reserved.
 *
 * File Name       : ContactUsViewController.m
 *
 * Created Date    : 14/05/10
 *
 * Description     :
 *
 * Modification History:
 *
 * Date            Name                Description
 * ------------------------------------------------
 * 14/05/10	   Nirmal Patidar
 * 02/08/13    Rashmi Jati Apte     initWithFrame:reuseIdentifier: is deprecated in iOS 3.0 and later. Replaced it                          with initWithStyle:reuseIdentifier:
 * 09/08/13    Ankit Jain           UITextAlignmentLeft is deprecated in ios 6.0 replace it                                       with NSTextAlignmentLeft
 * Bug History:
 *
 * Date            Id                Description
 * ------------------------------------------------
 *
 */



#import "ContactUsViewController.h"
#import "Constant.h"
#import "Common.h"
#import "DataBase.h"
#import "updateDateTimeStampData.h"
#import "contactUsData.h"
@implementation ContactUsViewController
@synthesize resultArray,tableContactUs,keyArray,valueArray,imgOnline,lblBackAlertTitle;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setTitle:@"Contact Us"];
	[tableContactUs setBackgroundColor:[UIColor clearColor]];
	//[waitIndicator setHidden:YES];
	[self.navigationController.navigationBar setTintColor:NavigationColor];
	CGFloat navBarHeight = 50.0f;
	CGRect frame = CGRectMake(0.0f, 20.0f, 320.0f, navBarHeight);
	[self.navigationController.navigationBar setFrame:frame];
	appDelegate = [[UIApplication sharedApplication]delegate];
	resultArray = [[NSMutableArray alloc] init];
	keyArray = [[NSMutableArray alloc] init];
	valueArray = [[NSMutableArray alloc] init];
    
    
    
    arrayPhone=[[NSMutableArray alloc] init];
    arrayMessage=[[NSMutableArray alloc] init];
    arrayEmail=[[NSMutableArray alloc] init];
    arrayCountry=[[NSMutableArray alloc] init];
    
    strElementName=[[NSString alloc] init];
    
    
    strErrorMessage=[[NSString alloc] init];
    
    
    array1=[[NSMutableArray alloc] init];
    array2=[[NSMutableArray alloc] init];
    array3=[[NSMutableArray alloc] init];
    
    arrayTitle1=[[NSMutableArray alloc] initWithObjects:@"Email1:",@"Email2:",@"Tel:", nil];
    arrayTitle2=[[NSMutableArray alloc] initWithObjects:@"Email1:",@"Email2:",@"Tel:",@"Tel:", nil];
    arrayTitle3=[[NSMutableArray alloc] initWithObjects:@"Email1:",@"Email2:",@"Tel:",@"Tel:", nil];
    
    //--------------- header --------------------------------------------------------
    CGRect re= CGRectMake(0, 0, 320, 53);
    UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_back.png"]];
    
    UILabel *tittlelable =[[UILabel alloc]init];
    
    CGRect lblrect= CGRectMake(0, 10, 320, 23);
    tittlelable.frame=lblrect;
    [tittlelable setFont:[UIFont fontWithName:labelregularFont size:22]];
    tittlelable.backgroundColor=[UIColor clearColor];
    tittlelable.textColor =headertitletextColor;
    tittlelable.textAlignment=NSTextAlignmentCenter;
    img.frame=re;
    [self.view addSubview:img];
    [img addSubview:tittlelable];
    //------------------------------------------------------------------------------
    
    
    
    tittlelable.text=@"Contact Us";
    
    
    
    
    //---------------------  Back button --------------------------------------------
	UIButton *btnBack =  [UIButton buttonWithType:UIButtonTypeCustom];
	[btnBack setBackgroundImage:[UIImage imageNamed:@"button_back_60_29.png"] forState:UIControlStateNormal];
    [btnBack setTitle:@"Back" forState:UIControlStateNormal];
	[btnBack addTarget:self action:@selector(goBackToMore) forControlEvents:UIControlEventTouchUpInside];
	[btnBack setFrame:CGRectMake(9, 7, 60, 29)];
    btnBack.titleLabel.font=[UIFont fontWithName:labelregularFont size:15];
    btnBack.titleLabel.font=[UIFont fontWithName:labelregularFont size:15];
    
    
    [self.view addSubview:btnBack];
    
	
	//-------------------------------------------------------------------------------
    
    lblBackAlertTitle.hidden=YES;
    
    
    if([Common isNetworkAvailable])
	{
        [imgOnline setImage:[UIImage imageNamed:@"online.png"]];
        
		[self showHUD:loadingaything];
        
//        
//		YPCardHolderServiceService *services = [[YPCardHolderServiceService alloc] init];
//		YPContactUsInfoRequest *contactUsRequest = [[YPContactUsInfoRequest alloc] init];
//		contactUsRequest.SC = appDelegate.SC;
//		contactUsRequest.userName = appDelegate.userName;
//		contactUsRequest.valid = TRUE;
//		contactUsRequest.role = @"C";
//		contactUsRequest.applicationType = @"M";
//		[services getContactUsInfo:self action:@selector(getContactUsInfoHandlers:) contactUsInfoRequest:contactUsRequest];
	}
	else {
		//[self killHUD];
        [imgOnline setImage:[UIImage imageNamed:@"offline.png"]];
        
        
        //parsing by getting string from nsuserdefault-----------
        
        
        addressNumber=1;
        
        NSString *strResult=[[NSUserDefaults standardUserDefaults] objectForKey:@"ContactBackup"];
        
        //       strResult=@"<ContactUsInfoResponse><contactUsInfoList><ContactUsInfo><country>UK</country><emailId1>support@yes-pay.com</emailId1><emailId2>sales@yes-pay.com</emailId2><emailId3>test3@yes-pay.com</emailId3><message>If you require support from YESpay International please send mail to - or contact to the below number.11</message><phone1>+44 (0)203 006 3790</phone1><valid>true</valid></ContactUsInfo><ContactUsInfo><country>North America</country><emailId1>support@yes-pay.com</emailId1><emailId2>sales@yes-pay.com</emailId2><emailId3>test3@yes-pay.com</emailId3><message>If you require support from YESpay International please send mail to - or contact to the below number.22</message><phone1>+1 416 214 6012</phone1><phone2>(Toll free): 1 855-YES-PAY-1</phone2><valid>true</valid></ContactUsInfo><ContactUsInfo><country>India</country><emailId1>support@yes-pay.com</emailId1><emailId2>sales@yes-pay.com</emailId2><emailId3>test3@yes-pay.com</emailId3><message>If you require support from YESpay International please send mail to - or contact to the below number.22</message><phone1>+91 731 3015593</phone1><phone2>+91 731 3015594</phone2><valid>true</valid></ContactUsInfo><ContactUsInfo><valid>false</valid></ContactUsInfo><ContactUsInfo><valid>false</valid></ContactUsInfo></contactUsInfoList><responseMessage>Successful</responseMessage><statusCode>0</statusCode><valid>true</valid></ContactUsInfoResponse>";
        //hard code.....
        
        if (strResult!=nil && strResult.length>0) {
            
            NSData* dataResult = [strResult dataUsingEncoding:NSUTF8StringEncoding];
            NSXMLParser *parser=[[NSXMLParser alloc] initWithData:dataResult];
            [parser setDelegate:self];
            [parser parse];
        }
        else{
            
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:networkconnectiontitle message:networkconnectionmessage  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag=701;
            [alert show];
            
            
            
            
        }
        
        
    }
    
    if ([UIScreen mainScreen].bounds.size.height==568) {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            //        self.tabBarController.tabBar.frame=CGRectMake(0,500,320,49);
            //        self.table.frame=CGRectMake(self.table.frame.origin.x, self.table.frame.origin.y, self.table.frame.size.width, self.table.frame.size.height-15);
        }
        else
        {
            self.tableContactUs.frame=CGRectMake(self.tableContactUs.frame.origin.x, self.tableContactUs.frame.origin.y, self.tableContactUs.frame.size.width, self.tableContactUs.frame.size.height+70);

        }
    }
    else{
    
    self.tableContactUs.frame=CGRectMake(0, 45,320, 346);
        imgOnline.frame=CGRectMake(260, 399, 42, 9);

    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
    if([Common isNetworkAvailable])
    {
        [imgOnline setImage:[UIImage imageNamed:@"online.png"]];
        
        isNetwork.text= NSLocalizedString(@"NetWork Available", @"");
    }
    else {
        [imgOnline setImage:[UIImage imageNamed:@"offline.png"]];
        
        isNetwork.text= NSLocalizedString(@"No NetWork Available", @"");
    }
 	//[appDelegate setIsInMore:NO];
	backbutton.hidden=NO;
    
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
	[super viewWillDisappear:animated];
	//[appDelegate setIsInMore:YES];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
}

- (void)viewDidUnload {
    
}



#pragma mark UITableView Functions
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//	return UITableViewCellEditingStyleNone;
//}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 30;
	
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
    
    
    if (section==0) {
        
        NSLog(@"number of row for row 1= %d",array1.count);
        return array1.count;
        
    }
    else if (section==1){
        
        NSLog(@"number of row for row 2= %d",array2.count);
        return array2.count;
        
    }
    NSLog(@"number of row for row 3= %d",array3.count);
    return array3.count;
    
    
    
    
    
	
	
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//	NSString *title = nil;
//	switch (section){
//		case 0:{
//            break;
//		}
//	}
//	return title;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = nil;
	
	NSString *cellIdentifier;
	
	cellIdentifier = @"SectionsTableIdentifier";
    
	UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(19, 8, 60, 25)];
	UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(80 , 8, 220, 25)];
	cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
	
    // Remove all subview from cell content view
	for (UIView *view in cell.contentView.subviews){
		[view removeFromSuperview];
	}
	
	[cell setBackgroundColor:[UIColor clearColor]];
	
	for ( UIView* view in cell.contentView.subviews )
	{
		view.backgroundColor = [ UIColor clearColor ];
	}
	
    
	[nameLabel setTextColor:staticFirstLabelFontColor];
    
    
    [valueLabel setFont:[UIFont fontWithName:labelregularFont size:16.0]];
    [nameLabel setFont:[UIFont fontWithName:labelregularFont size:16.0]];
    
	nameLabel.textAlignment = NSTextAlignmentLeft;
    valueLabel.textAlignment = NSTextAlignmentLeft;
    
    
    [valueLabel setBackgroundColor:[UIColor clearColor]];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
	
    if (indexPath.section==0)
    {
        
        if (indexPath.row!=0) {
            nameLabel.text = [arrayTitle1 objectAtIndex:indexPath.row-1];
        }
        else
        {
            nameLabel.hidden=YES;
            valueLabel.frame=CGRectMake(19, 8, 120, 25);
            valueLabel.font=[UIFont boldSystemFontOfSize:16];
            
            
        }
        
        
        valueLabel.text = [array1 objectAtIndex:indexPath.row];
    }
    else if (indexPath.section==1){
        
        
        if (indexPath.row!=0) {
            nameLabel.text = [arrayTitle2 objectAtIndex:indexPath.row-1];
        }
        else
        {
            nameLabel.hidden=YES;
            valueLabel.frame=CGRectMake(19, 8, 120, 25);
            valueLabel.font=[UIFont boldSystemFontOfSize:16];
            
            
        }
        
        
        valueLabel.text = [array2 objectAtIndex:indexPath.row];
    }
    else if (indexPath.section==2){
        if (indexPath.row!=0) {
            nameLabel.text = [arrayTitle3 objectAtIndex:indexPath.row-1];
        }
        else
        {
            nameLabel.hidden=YES;
            valueLabel.frame=CGRectMake(19, 8, 120, 25);
            valueLabel.font=[UIFont boldSystemFontOfSize:16];
            
            
        }
        valueLabel.text = [array3 objectAtIndex:indexPath.row];
    }
    
    
    CGSize sizeOfLabel=[self sizeForLabel:nameLabel];
    nameLabel.frame=CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y, sizeOfLabel.width, sizeOfLabel.height);
    nameLabel.numberOfLines=[self lineCountForLabel:nameLabel];
    
    
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
    
    [nameLabel sizeToFit];
    [valueLabel sizeToFit];
    [cell.contentView addSubview: nameLabel];
	[cell.contentView addSubview: valueLabel];
	
    
	return cell;
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



#pragma mark Other Fucntions
-(void)getrowcount{
    
    if(((contactUsData*)[resultArray objectAtIndex:0]).message != nil){
		[keyArray addObject:@"Country:"];
		[valueArray addObject:((contactUsData*)[resultArray objectAtIndex:0]).country];
        
	}
	if(((contactUsData*)[resultArray objectAtIndex:0]).country != nil){
		[keyArray addObject:@"Country:"];
		[valueArray addObject:((contactUsData*)[resultArray objectAtIndex:0]).country];
        
	}
	if(((contactUsData*)[resultArray objectAtIndex:0]).email1!=nil){
		[keyArray addObject:@"Support Email Id:"];
		[valueArray addObject:((contactUsData*)[resultArray objectAtIndex:0]).email1];
	}
	if(((contactUsData*)[resultArray objectAtIndex:0]).email2 != nil){
		[keyArray addObject:@"Sales Email Id:"];
		[valueArray addObject:((contactUsData*)[resultArray objectAtIndex:0]).email2];
		
	}
	if(((contactUsData*)[resultArray objectAtIndex:0]).email3 != nil){
		[keyArray addObject:@"Complaint Email Id:"];
		[valueArray addObject:((contactUsData*)[resultArray objectAtIndex:0]).email3];
		
	}
	if(((contactUsData*)[resultArray objectAtIndex:0]).phone1 != nil){
		[keyArray addObject:@"Contact number:"];
		[valueArray addObject:((contactUsData*)[resultArray objectAtIndex:0]).phone1];
		
	}
	if(((contactUsData*)[resultArray objectAtIndex:0]).phone2 != nil){
		[keyArray addObject:@"Phone2:"];
		[valueArray addObject:((contactUsData*)[resultArray objectAtIndex:0]).phone2];
		
	}
	if(((contactUsData*)[resultArray objectAtIndex:0]).phone3 != nil){
		[keyArray addObject:@"Phone3:"];
		[valueArray addObject:((contactUsData*)[resultArray objectAtIndex:0]).phone3];
		
	}
    
}

-(void)goBackToMore
{	 //[self.navigationController setNavigationBarHidden:NO];
	[self.navigationController popViewControllerAnimated:YES];
}

//Handle the Response of getContactUsInfoHandlers
-(void)getContactUsInfoHandlers:(id) value
{
    
    [self killHUD];
  
    
    

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}
	
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}
	
	
	// Do something with the YPLoginResponse* result
    /* result --- hard code
     
     
     <ContactUsInfoResponse><contactUsInfoList><ContactUsInfo><country>UK</country><emailId1>support@yes-pay.com</emailId1><emailId2>sales@yes-pay.com</emailId2><emailId3>test3@yes-pay.com</emailId3><message>If you require support from YESpay International please send mail to - or contact to the below number.11</message><phone1>+44 (0)203 006 3790</phone1><valid>true</valid></ContactUsInfo><ContactUsInfo><country>North America</country><emailId1>support@yes-pay.com</emailId1><emailId2>sales@yes-pay.com</emailId2><emailId3>test3@yes-pay.com</emailId3><message>If you require support from YESpay International please send mail to - or contact to the below number.22</message><phone1>+1 416 214 6012</phone1><phone2>(Toll free): 1 855-YES-PAY-1</phone2><valid>true</valid></ContactUsInfo><ContactUsInfo><country>India</country><emailId1>support@yes-pay.com</emailId1><emailId2>sales@yes-pay.com</emailId2><emailId3>test3@yes-pay.com</emailId3><message>If you require support from YESpay International please send mail to - or contact to the below number.22</message><phone1>+91 731 3015593</phone1><phone2>+91 731 3015594</phone2><valid>true</valid></ContactUsInfo><ContactUsInfo><valid>false</valid></ContactUsInfo><ContactUsInfo><valid>false</valid></ContactUsInfo></contactUsInfoList><responseMessage>Successful</responseMessage><statusCode>0</statusCode><valid>true</valid></ContactUsInfoResponse>
//     
//     
//     */
//    addressNumber=1;
//    
//    
//	YPContactUsInfoResponse* result = (YPContactUsInfoResponse*)value;
//	
//    NSLog(@"result = %@",result);
//    
//    // NSString *strResult=[NSString stringWithFormat:@"%@",value]; //actual code.....
//    
//    NSString *strResult=[NSString stringWithFormat:@"%@",result];
//    
//    //    strResult=@"<ContactUsInfoResponse><contactUsInfoList><ContactUsInfo><country>UK</country><emailId1>support@yes-pay.com</emailId1><emailId2>sales@yes-pay.com</emailId2><emailId3>test3@yes-pay.com</emailId3><message>If you require support from YESpay International please send mail to - or contact to the below number.11</message><phone1>+44 (0)203 006 3790</phone1><valid>true</valid></ContactUsInfo><ContactUsInfo><country>North America</country><emailId1>support@yes-pay.com</emailId1><emailId2>sales@yes-pay.com</emailId2><emailId3>test3@yes-pay.com</emailId3><message>If you require support from YESpay International please send mail to - or contact to the below number.22</message><phone1>+1 416 214 6012</phone1><phone2>(Toll free): 1 855-YES-PAY-1</phone2><valid>true</valid></ContactUsInfo><ContactUsInfo><country>India</country><emailId1>support@yes-pay.com</emailId1><emailId2>sales@yes-pay.com</emailId2><emailId3>test3@yes-pay.com</emailId3><message>If you require support from YESpay International please send mail to - or contact to the below number.22</message><phone1>+91 731 3015593</phone1><phone2>+91 731 3015594</phone2><valid>true</valid></ContactUsInfo><ContactUsInfo><valid>false</valid></ContactUsInfo><ContactUsInfo><valid>false</valid></ContactUsInfo></contactUsInfoList><responseMessage>Successful</responseMessage><statusCode>0</statusCode><valid>true</valid></ContactUsInfoResponse>";
//    //hard code.....
//    
//    
//    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",strResult] forKey:@"ContactBackup"];
//    
//    strResult=[[NSUserDefaults standardUserDefaults] objectForKey:@"ContactBackup"];
//    
//    NSData* dataResult = [strResult dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:dataResult];
//    [parser setDelegate:self];
//    [parser parse];
//    
//    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	
	if (buttonIndex ==0) {
		
		if (alertView.tag == 101) {
			
			//[appDelegate logout];
		}
		
		if (alertView.tag == 701) {
			NSLog(@"Other alert view..2");
			[self.navigationController popViewControllerAnimated:YES];
		}
		
	}
	else {
		// (buttonIndex != [alertView cancelButtonIndex])
		NSLog(@"Clicked Cancel....Name: %d", [alertView cancelButtonIndex]);
		
	}
}

#pragma mark - NSXML parser delegate ----------------------------------------
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    NSLog(@"didStartElement");
    if ([elementName isEqualToString:@"ContactUsInfo"]) {
        strElementName=elementName;
    }
    else{
        // strElementName=@"";
    }
    
    
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    NSLog(@"didEndElement");
    if ([elementName isEqualToString:@"ContactUsInfo"])
    {
        addressNumber++;
    }
    
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    NSLog(@"foundCharacters");
    
    
    if ([strElementName isEqualToString:@"ContactUsInfo"])
    {
        if (addressNumber==1)
        {
            [array1 addObject:string];
        }
        else if (addressNumber==2)
        {
            
            [array2 addObject:string];
            
        }
        else if (addressNumber==3)
        {
            
            [array3 addObject:string];
            
        }
    }
    else if ([strElementName isEqualToString:@"statusCode"]){
        
        statusCode=string;
        
        
    }
    else if ([strElementName isEqualToString:@"responseMessage"]){
        strErrorMessage=string;
        
        
    }
    
    
    
}
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    
    NSLog(@"arryay1 \n %@ ------------- ",array1);
    NSLog(@"arryay2 \n %@ ------------- ",array2);
    NSLog(@"arryay3 \n %@ ------------- ",array3);
    
    
    if (array1.count==0 && array2.count==0 && array3.count==0)
    {
        
        self.tableContactUs.hidden=YES;
        self.lblBackAlertTitle.hidden=NO;
        
    }
    else
    {
        self.tableContactUs.hidden=NO;
        self.lblBackAlertTitle.hidden=YES;
        
    }
    
    if (array1.count>0) {
        [array1 removeObjectAtIndex:3];
        [array1 removeLastObject];
        [array1 replaceObjectAtIndex:0 withObject:@"UK"];
    }
    if (array2.count>0) {
        [array2 removeObjectAtIndex:3];
        [array2 removeLastObject];
    }
    if (array3.count>0) {
        [array3 removeObjectAtIndex:3];
        [array3 removeLastObject];
        
    }
    
    
    if (statusCode==0) {
        if (array1.count!=0 || array2.count!=0 || array3.count!=0)
        {
            
            UILabel *lblTablHeader=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, 320, 50)];
            lblTablHeader.text=@"      YESpay International Limited";
            lblTablHeader.backgroundColor=[UIColor clearColor];
            lblTablHeader.font=[UIFont fontWithName:labelmediumFont size:16.0];
            self.tableContactUs.tableHeaderView=lblTablHeader;
            
            
        }
        
        [tableContactUs reloadData];
    }
    else
    {
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Message:" message:strErrorMessage delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        
    }
    
    
}


#pragma mark - UILabel size methods ----------------------------

- (int)lineCountForLabel:(UILabel *)label
{
    CGSize constrain = CGSizeMake(label.bounds.size.width, 1000000);
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:constrain lineBreakMode:UILineBreakModeWordWrap];
    
    return ceil(size.height / label.font.lineHeight);
}
- (CGSize)sizeForLabel:(UILabel *)label
{
    CGSize constrain = CGSizeMake(label.bounds.size.width, 1000000);
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:constrain lineBreakMode:UILineBreakModeWordWrap];
    
    return size;
}
#pragma mark - Status bar ------------------------------------------------------

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
