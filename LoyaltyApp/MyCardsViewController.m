//
//  MyCardsViewController.m
//  YesPayCardHolderWallet
//
//  Created by Nirmal Patidar on 04/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
/* Date            Name                Description
 * ------------------------------------------------
 
 * 09/08/13    Ankit Jain           UITextAlignmentLeft is deprecated in ios 6.0 replace it with NSTextAlignmentLeft
 * Bug History:
 *
 * Date            Id                Description
 * ------------------------------------------------
 *
 */

#import "MyCardsViewController.h"
#import "DataBase.h"
#import "CardDetailsData.h"
#import "AddNewCardInWalletViewController.h"
#import "Constant.h"
#import "WebserviceOperation.h"
#import "YPGetCardsInWalletDetailedRequest.h"
#import "YPGetCardsInWalletDetailedResponse.h"
#import "YPRemoveCardRequest.h"
#import "YPRemoveCardResponse.h"

//#import "YPCardHolderServiceService.h"
#import "Common.h"
#import "YPCardInWalletDetailed.h"

#import "updateDateTimeStampData.h"
#import <QuartzCore/QuartzCore.h>
//#import "UpdateWalletCard.h"

#import "UIViewController+JASidePanel.h"
#import "AddCardInSideLoginViewController.h"
#import "JASidePanelController.h"

@implementation MyCardsViewController

@synthesize tableMyWallet;
@synthesize viewcontroller ,cardReference;
@synthesize updateQuery,isNetwork,imgOnline,lblBackAlertTitle,lblBackAlertSubTitle,isCardFetchCalled;


int tabView=0;
int count=0;
int flag = 0;
int rowSelected=0;
BOOL isPayButton,isUpdateButton,isReactvateButton,isSuspendButton,isDeleteButton;
BOOL isOpen=NO;


#pragma mark - UIViewController Methods ------------------------------------------------



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // self.title = @"My wallet";
    
    // self.tabBarItem.image = [UIImage imageNamed:@"icon_my_wallet_active"];
    
    /* ----- UILABEL NEW OBJECTS ----- for card  back info  */
    
    lblAddress1=[[UILabel alloc] init];
    lblAddress2=[[UILabel alloc] init];
    lblCity=[[UILabel alloc] init];
    lblCountry=[[UILabel alloc] init];
    lblPostCode=[[UILabel alloc] init];
    labelEmail = [[UILabel alloc] init];
    
    //-----------------------------------
    
    
    [self.navigationController.navigationBar setTintColor:NavigationColor];
    
    strButtonSelected=[[NSString alloc] init];
    
    self.isCardFetchCalled=NO;
    
    //Added by Ankit jain 24/oct/2013 ios 7
    //[appDelegate.tabController.tabBar setAlpha:0.0];
    
    if ([UIScreen mainScreen].bounds.size.height==568) {
        NSLog(@"iphone 5------------------------");
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            self.tabBarController.tabBar.frame=CGRectMake(0,500,320,49);
            self.tableMyWallet.frame=CGRectMake(self.tableMyWallet.frame.origin.x, self.tableMyWallet.frame.origin.y, self.tableMyWallet.frame.size.width, self.tableMyWallet.frame.size.height+35);
            //self.tableMyWallet.backgroundColor=[UIColor redColor];
            
        }
        else
        {
            self.tabBarController.tabBar.frame=CGRectMake(0,517,320,49);
        }
    }
    else
    {
        NSLog(@"iphone 4-----------------");
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            self.tableMyWallet.frame=CGRectMake(self.tableMyWallet.frame.origin.x, self.tableMyWallet.frame.origin.y, self.tableMyWallet.frame.size.width, self.tableMyWallet.frame.size.height-95);
            self.tabBarController.tabBar.frame=CGRectMake(0,413,320,49);        }
        else
        {
            self.tableMyWallet.frame=CGRectMake(self.tableMyWallet.frame.origin.x, self.tableMyWallet.frame.origin.y, self.tableMyWallet.frame.size.width, self.tableMyWallet.frame.size.height-95);
            self.tabBarController.tabBar.frame=CGRectMake(0,430,320,49);
        }
        
        
        
    }
    
	isPayButton = NO;
	isUpdateButton = NO;
	isReactvateButton = NO;
	isSuspendButton = NO;
	isDeleteButton = NO;
    y = 0;
	detailisdisplay= 0; // Used for identify the rotation of card
	isRowSelected = NO;
	appDelegate = (CAppDelegate*)[[UIApplication sharedApplication] delegate];
	resultArray = [[NSMutableArray alloc] init];
	
	[self.navigationItem setTitle:@"My Pouch Wallet"];
    
    //--------------- header --------------------------------------------
    CGRect re= CGRectMake(0, 0, 320, 53);
    UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_back.png"]];
    
    UILabel *lbl =[[UILabel alloc]init];
    CGRect lblrect= CGRectMake(0, 10, 320, 23);
    if ([UIScreen mainScreen].bounds.size.height!=568) {
        lblrect= CGRectMake(0, 10, 320, 23);
    }
    lbl.frame=lblrect;
    lbl.text=@"My Cards";
    [lbl setFont:[UIFont fontWithName:labelregularFont size:22]];
    lbl.backgroundColor=[UIColor clearColor];
    lbl.textColor =[UIColor colorWithRed:39.0/255.0 green:73.0/255.0 blue:141.0/255.0 alpha:1.0];
    lbl.textAlignment=NSTextAlignmentCenter;
    img.frame=re;
    [self.view addSubview:img];
    [img addSubview:lbl];
    //-------------------------------------------------------------------
    
    
	[self.tableMyWallet setSeparatorColor:TableViewCellSeperatorColor];
    PersonalDetailView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 280, 250)];
    
    // ???ajeet
	UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
	[button1 setFrame:CGRectMake(16, -3, 278, 175)];
	[button1 setBackgroundImage:[UIImage imageNamed:@"credit_card_glossy.png"] forState:UIControlStateNormal];
	[button1 addTarget:self action:@selector(showPersonalDetails) forControlEvents:UIControlEventTouchDown];
	[PersonalDetailView addSubview:button1];
    
    
	yForDetail = 17;
	isBackFromAddCard = NO;
    
	
    //---------------- add new card ------------------------------------
	UIButton *btnAddNewCard =  [UIButton buttonWithType:UIButtonTypeCustom];
	[btnAddNewCard setBackgroundImage:[UIImage imageNamed:@"button_add_new_card.png"] forState:UIControlStateNormal];
    // [btnAddNewCard setTitle:@"ADD NEW CARD" forState:UIControlStateNormal];
    [btnAddNewCard setTitleColor:[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:255.0/255] forState:UIControlStateNormal];
    btnAddNewCard.titleLabel.font=[UIFont fontWithName:labelregularFont size:14.0];
    btnAddNewCard.titleLabel.textAlignment=NSTextAlignmentRight;
	[btnAddNewCard addTarget:self action:@selector(AddNewCard) forControlEvents:UIControlEventTouchUpInside];
    
    
    if ([UIScreen mainScreen].bounds.size.height==568)
    {
        NSLog(@"iphone 5");
        [btnAddNewCard setFrame:CGRectMake(157, 490, 142, 32)];
        lblCardCount=[[UILabel alloc] initWithFrame:CGRectMake(18, 490, 50, 32)];
        lblCardIn=[[UILabel alloc] initWithFrame:CGRectMake(68, 490, 60, 16)];
        lblMyWallet=[[UILabel alloc] initWithFrame:CGRectMake(68, 506, 70, 16)];
        imgOnline.frame=CGRectMake(273,525, 42, 9);
    }
    else
    {
        NSLog(@"iphone 4");
        [btnAddNewCard setFrame:CGRectMake(157,405, 142, 32)];
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            lblCardCount=[[UILabel alloc] initWithFrame:CGRectMake(16, 405, 50, 32)];
        }
        else{
            lblCardCount=[[UILabel alloc] initWithFrame:CGRectMake(16, 410, 50, 32)];
            
        }
        lblCardIn=[[UILabel alloc] initWithFrame:CGRectMake(68, 410, 60, 16)];
        lblMyWallet=[[UILabel alloc] initWithFrame:CGRectMake(68, 423, 70, 16)];
        imgOnline.frame=CGRectMake(260,445, 42, 9);
    }
	
    [self.view addSubview:btnAddNewCard];
    //-------------------------------------------------------------------
    
    //lable to show card counts------------------------------------------
    
    lblCardCount.backgroundColor=[UIColor clearColor];
    lblCardCount.textAlignment=NSTextAlignmentRight;
//    lblCardCount.lineBreakMode=UILineBreakModeWordWrap; // ios 6 depricated
    lblCardCount.lineBreakMode=NSLineBreakByWordWrapping;
    lblCardCount.textColor=[UIColor colorWithRed:39.0/255.0 green:73.0/255.0 blue:141.0/255.0 alpha:1.0];
    lblCardCount.text=@"";
    lblCardCount.font=[UIFont fontWithName:labelregularFont size:42];
    [self.view addSubview:lblCardCount];
    
    lblCardIn.backgroundColor=[UIColor clearColor];
    lblCardIn.textColor=[UIColor colorWithRed:39.0/255.0 green:73.0/255.0 blue:141.0/255.0 alpha:1.0];
    lblCardIn.text=@"Cards in";
    lblCardIn.font=[UIFont fontWithName:labelregularFont size:15.5];
    [self.view addSubview:lblCardIn];
    
    lblMyWallet.backgroundColor=[UIColor clearColor];
    lblMyWallet.textColor=[UIColor colorWithRed:39.0/255.0 green:73.0/255.0 blue:141.0/255.0 alpha:1.0];
    lblMyWallet.text=@"My Wallet";
    lblMyWallet.font=[UIFont fontWithName:labelmediumFont size:15.5];
    [self.view addSubview:lblMyWallet];
    //-------------------------------------------------------------------
    //----------------------------Drawerleftbutn-Added by Ankit jain 3 Mar 2014----------------------
    
    btndrawerleft = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btndrawerleft.frame = CGRectMake(15,5,32, 32);
    btndrawerleft.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [btndrawerleft addTarget:self action:@selector(_addRightTapped:) forControlEvents:UIControlEventTouchUpInside];
    [btndrawerleft setBackgroundImage:[UIImage imageNamed:@"drawer.png"] forState:UIControlStateNormal];
    [self.view addSubview:btndrawerleft];
	//-------------------------------------------------------------------------------
}

-(void)viewDidAppear:(BOOL)animated
{
	isPayButton = NO;
	isUpdateButton = NO;
	isReactvateButton = NO;
	isSuspendButton = NO;
	isDeleteButton = NO;
    
	CGFloat navBarHeight = 50.0f;
	CGRect frame = CGRectMake(0.0f, 20.0f, 320.0f, navBarHeight);
	[self.navigationController.navigationBar setFrame:frame];
	[super viewDidAppear:animated];
	
}
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    self.lblBackAlertTitle.hidden=YES;
    self.lblBackAlertSubTitle.hidden=YES;
    if([Common isNetworkAvailable])
	{
		isNetwork.text= NSLocalizedString(@"NetWork Available", @"");
		//isNetwork.text= NSLocalizedString(@"NetWork Available", @" ");//comment by ajeet
        [imgOnline setImage:[UIImage imageNamed:@"online.png"]];
        
        if (!self.isCardFetchCalled) {
            NSLog(@"Web serivce calling -----------...............");
            [self callWebserviceForCards:YES];
        }
	}
	else {
        //---------------  Waiting end ----------------------------------------------
        [self killHUD];
        //---------------------------------------------------------------------------
        
		isNetwork.text= NSLocalizedString(@"No NetWork Available", @" ");
        [imgOnline setImage:[UIImage imageNamed:@"offline.png"]];
        NSLog(@"number of row is %d",[DataBase getNumberOfRows:@"CardDetails"]);
        
        if([DataBase getNumberOfRows:@"CardDetails"] > 0)
        {
            NSString *query = @"Select * from CardDetails where userid = ";
            query = [query stringByAppendingString:appDelegate.userID];
            NSLog(@"Card Query is %@",query);
            NSMutableArray *temp=[DataBase getCardDetailsTableData:query];
            [resultArray removeAllObjects];
            
            for (int i=0;i< [temp count]; i++) {
                
                if(![((CardDetailsData*)[temp objectAtIndex:i]).cardStatus isEqualToString:@"Deleted"]){
                    
                    [resultArray addObject:[temp objectAtIndex:i]];
                }
            }
            
            if (resultArray.count==1 || resultArray.count==0) {
                lblCardIn.text=@"Card In";
            }
            else{
                lblCardIn.text=@"Cards In";
            }
            
            lblCardCount.text=[NSString stringWithFormat:@"%lu",(unsigned long)resultArray.count];
            
            
            if (resultArray.count==0)
            {
                self.tableMyWallet.hidden=YES;
                self.lblBackAlertTitle.hidden=NO;
                self.lblBackAlertSubTitle.hidden=NO;
                
            }
            else
            {
                self.tableMyWallet.hidden=NO;
                self.lblBackAlertTitle.hidden=YES;
                self.lblBackAlertSubTitle.hidden=YES;
            }
            [self.tableMyWallet reloadData];
            
            int i = [resultArray count];
            for (; i >= 0; i--) {
                NSIndexPath *middleIndexPath;
                middleIndexPath = [NSIndexPath indexPathForRow:(i-1) inSection:0];
                UITableViewCell *cell = [self.tableMyWallet cellForRowAtIndexPath:middleIndexPath];
                [self.tableMyWallet sendSubviewToBack:cell];
            }
            //---------------  Waiting end ----------------------------------------------
            [self killHUD];
            //---------------------------------------------------------------------------
        }
        isNetwork.text= NSLocalizedString(@"No NetWork Available", @" ");
        NSLog(@" NO network");
        
 	 	
    }
	
    //???ajeet --------------------
    if(!isRowSelected)
	{
        if (resultArray.count==1 || resultArray.count==0) {
            lblCardIn.text=@"Card In";
        }
        else{
            
            lblCardIn.text=@"Cards In";
            
        }
        
        lblCardCount.text=[NSString stringWithFormat:@"%lu",(unsigned long)resultArray.count];
        
        if (resultArray.count==0)
        {
            self.tableMyWallet.hidden=YES;
            self.lblBackAlertTitle.hidden=NO;
            self.lblBackAlertSubTitle.hidden=NO;
            
        }
        else
        {
            self.tableMyWallet.hidden=NO;
            self.lblBackAlertTitle.hidden=YES;
            self.lblBackAlertSubTitle.hidden=YES;
            
        }
        
		[self.tableMyWallet reloadData];
		int i = [resultArray count];
		for (; i >= 0; i--) {
			NSLog(@"View will Appear...my Card view");
			NSIndexPath *middleIndexPath;
			middleIndexPath = [NSIndexPath indexPathForRow:(i-1) inSection:0];
			UITableViewCell *cell = [tableMyWallet cellForRowAtIndexPath:middleIndexPath];
			[self.tableMyWallet sendSubviewToBack:cell];
		}
	}
	
	CGFloat navBarHeight = 50.0f;
	CGRect frame = CGRectMake(0.0f, 20.0f, 320.0f, navBarHeight);
	[self.navigationController.navigationBar setFrame:frame];
	[super viewDidAppear:animated];
	NSIndexPath *tableSelection = [self.tableMyWallet indexPathForSelectedRow];
    [self.tableMyWallet deselectRowAtIndexPath:tableSelection animated:YES];
 	isBackFromAddCard = NO;
	
	
}

-(void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [[NSUserDefaults standardUserDefaults] setObject:@"normal" forKey:@"operationfinder"];
    
	//[appDelegate setIsInMore:YES];
    for(UIView *view in PersonalDetailView.subviews)
    {
        if(![view isKindOfClass:[UIButton class]])
        {
            [view removeFromSuperview];
        }
    }
    [self backCardIntoTable];
    
}



- (void)viewDidUnload
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	// Release any cached data, images, etc that aren't in use.
}





#pragma mark - UITableview delegate --------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 46;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
    NSLog(@"value of result array is %lu",(unsigned long)[resultArray count]);
	return [resultArray count]+5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = nil;
	NSString *cellIdentifier;
	cellIdentifier = @"SectionsTableIdentifier";
	int row = [indexPath row];
	UILabel *nameLabel =  [[UILabel alloc] initWithFrame:CGRectMake(60,11, 155, 25)];
    UILabel *nameLabelCardNumber =  [[UILabel alloc] initWithFrame:CGRectMake(215,11, 50, 25)];
    
	UILabel *cardnumber = [[UILabel alloc] initWithFrame:CGRectMake(65,32,240,15)];
	UILabel *issuerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(27, 59, 272, 24)];
	UILabel *cardNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(27, 64, 272, 35)];
	UILabel *cardHolderNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(27, 120,170, 30)];
	UILabel *cardBalanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(27, 130, 90, 31)];
    UIImageView *cardIssuerImage = [[UIImageView alloc] initWithFrame:CGRectMake(230, 130, 30, 20)];
    UILabel *cardExpirylabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 95, 100, 31)];
    UILabel *cardStartlabel = [[UILabel alloc] initWithFrame:CGRectMake(27, 130, 58, 31)];
	UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 37, 23)];
	UIImageView *cardImage = [[UIImageView alloc] initWithFrame:CGRectMake(18,10, 287,20)];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    for (UIView *view in cell.contentView.subviews){
		[view removeFromSuperview];
	}
	UIView* backgroundView =  [ [ UIView alloc ] initWithFrame:CGRectZero];
	if(row % 2 == 0)
	{
		backgroundView.backgroundColor = [UIColor whiteColor];
	}
	else
	{
		backgroundView.backgroundColor = [UIColor whiteColor];
	}
	//backgroundView.backgroundColor = [UIColor colorWithRed:0.74 green:0.41 blue:0.25 alpha:0.3];
	cell.backgroundView = backgroundView;
	for ( UIView* view in cell.contentView.subviews )
	{
		view.backgroundColor = [ UIColor clearColor ];
	}
	[cardImage setContentMode:UIViewContentModeTop];
    [cardImage setImage:[UIImage imageNamed:@"card_section_empty.png"]];
    
	[cardImage setTag:123];
	
	if((row + 1) <= [resultArray count] )
	{
		
		UIImageView *secondCardImageView;
		UIView *detailView,*cardView;
		//UIButton *hide;
        cardView = [[UIView alloc] initWithFrame:CGRectMake(23, 0, 270, 36)];
        cardView.backgroundColor=[UIColor clearColor];
        secondCardImageView = [[UIImageView alloc]initWithFrame:CGRectMake(-4,2, 285, 36)];
        detailView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 270, 190)];
		
        [cardView setTag:121];
		
        if([((CardDetailsData*)[resultArray objectAtIndex:row]).cardStatus isEqualToString:@"Suspended"])
            [secondCardImageView setImage:[UIImage imageNamed:@"Credit_Card_Suspended.png"]];
        else
            [secondCardImageView setImage:[UIImage imageNamed:@"credit_card_glossy.png"]];
        [secondCardImageView setContentMode:UIViewContentModeTop];
        
        [secondCardImageView setTag:1234];
        
        [detailView setBackgroundColor:[UIColor clearColor]];
        [detailView setTag:101];
        
        
		NSString *cardnumberLast = @"";
        cardnumberLast =[((CardDetailsData*)[resultArray objectAtIndex:row]) cardnumber];
	 	
		NSUInteger cardNumberSublength = [cardnumberLast length] - 4;
		if ([cardnumberLast length] > 4) {
			cardnumberLast = [cardnumberLast substringFromIndex:cardNumberSublength];
		}
		
		NSString *cardname=@"";
		////// Remove all (null) value .....Updated by Shailesh Tiwari 03/08/11
        NSLog(@"Card Name is below card Number..........%@",cardnumberLast);
        
		NSString *cardNameLength = @"";
 		
 		if ([((CardDetailsData*)[resultArray objectAtIndex:row]).cardname isEqualToString:@"(null)"]) {
			cardname = cardnumberLast;
            nameLabelCardNumber.hidden=YES;
		}
		else {
            
            cardname = [cardname stringByAppendingString:[NSString stringWithFormat:@"%@",
                                                          ((CardDetailsData*)[resultArray objectAtIndex:row]).cardname]];
		}
        
        
        nameLabelCardNumber.text=cardnumberLast;
        
        
		
        
		///////////////////
        NSLog(@"Card name is= %@",cardname);
        NSLog(@"issuername is= %@",((CardDetailsData*)[resultArray objectAtIndex:row]).issuerName);
        NSLog(@"cardnumber name is= %@",((CardDetailsData*)[resultArray objectAtIndex:row]).cardnumber);
        NSLog(@"cardBalance name is= %@",((CardDetailsData*)[resultArray objectAtIndex:row]).cardBalance);
        NSLog(@"startdate name is= %@",((CardDetailsData*)[resultArray objectAtIndex:row]).startdate);
        NSLog(@" images detail --- is= %@",((CardDetailsData*)[resultArray objectAtIndex:row]).imageName);
		
        
        // NSString issuerName1 = ((CardDetailsData*)[resultArray objectAtIndex:row]).issuername;
        
        if(![((CardDetailsData*)[resultArray objectAtIndex:row]).issuerName length] == 0)
        {
            issuerNameLabel.text = ((CardDetailsData*)[resultArray objectAtIndex:row]).issuerName;
        }
        else {
            issuerNameLabel.text=@" ";
            NSLog(@"issuername NULLLLLLLLLLLL");
            
        }
        if(![((CardDetailsData*)[resultArray objectAtIndex:row]).cardnumber length] == 0)
        {
            
            cardNumberLabel.text = ((CardDetailsData*)[resultArray objectAtIndex:row]).cardnumber;
        }else {
            cardNumberLabel.text=@" ";
            NSLog(@" cardnumber NULLLLLLLLLLLL");
            
        }
        
        if([((CardDetailsData*)[resultArray objectAtIndex:row]).cardholdername length]>0)
        {
            
            cardHolderNameLabel.text = ((CardDetailsData*)[resultArray objectAtIndex:row]).cardholdername;
        }else {
            cardHolderNameLabel.text=@" ";
            NSLog(@" cardNameLabel NULLLLLLLLLLLL");
            
        }
        
        if(![((CardDetailsData*)[resultArray objectAtIndex:row]).cardBalance length] == 0)
        {
            cardBalanceLabel.text = ((CardDetailsData*)[resultArray objectAtIndex:row]).cardBalance;
            
        }else {
            cardBalanceLabel.text=@" ";
            NSLog(@"cardBalance NULLLLLLLLLLLL");
            
        }
        
        if([((CardDetailsData*)[resultArray objectAtIndex:row]).expiryDate length] != 0)
        {
            NSMutableString *expirtdatestr = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%@",((CardDetailsData*)[resultArray objectAtIndex:row]).expiryDate]];
            
            [expirtdatestr insertString:@"/" atIndex:2];
            UILabel *lblValidUpto=[[UILabel alloc] initWithFrame:CGRectMake(27, 95, 80, 31)];
            lblValidUpto.backgroundColor=[UIColor clearColor];
            lblValidUpto.font=[UIFont fontWithName:labelregularFont size:17];
            lblValidUpto.textColor=[UIColor colorWithRed:114/255.0 green:140/255.0 blue:176/255.0 alpha:1];
            lblValidUpto.text=@"Valid upto:";
            [detailView addSubview:lblValidUpto];
            
            cardExpirylabel.text =  [NSString stringWithFormat:@" %@",expirtdatestr];
        }else {
            cardExpirylabel.text=@" ";
            NSLog(@"expirydate NULLLLLLLLLLLL");
            
        }
        [cardNumberLabel setBackgroundColor:[UIColor clearColor]];
		[issuerNameLabel setBackgroundColor:[UIColor clearColor]];
		[cardBalanceLabel setBackgroundColor:[UIColor clearColor]];
		[cardExpirylabel setBackgroundColor:[UIColor clearColor]];
		[cardStartlabel setBackgroundColor:[UIColor clearColor]];
		[cardHolderNameLabel setBackgroundColor:[UIColor clearColor]];
		[cardHolderNameLabel setTextColor:[UIColor whiteColor]];
        
        [nameLabel setFont:[UIFont fontWithName:labelregularFont size:20]];
        [nameLabelCardNumber setFont:[UIFont fontWithName:labelregularFont size:20]];
        
		[cardNumberLabel setFont:[UIFont fontWithName:labelregularFont size:24]];
        [cardExpirylabel setFont:[UIFont fontWithName:labelregularFont size:17]];
        [cardHolderNameLabel setFont: [UIFont fontWithName:labelregularFont size:17]];
        
        //------------ not showing -----------------------------
		[issuerNameLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
		[cardBalanceLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
		[cardExpirylabel setFont:[UIFont fontWithName:labelregularFont size:15]];
		[cardStartlabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
        //------------//------------//------------//------------
        
        
		//[detailView addSubview:issuerNameLabel];
		[detailView addSubview:cardNumberLabel];
		[detailView addSubview:cardHolderNameLabel];
		[detailView addSubview:cardBalanceLabel];
		[detailView addSubview:cardExpirylabel];
		[detailView addSubview:cardStartlabel];
		//[detailView addSubview:cardIssuerImage];
		nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabelCardNumber.textAlignment = NSTextAlignmentRight;
		nameLabel.text = cardname;
		cardnumber.textAlignment = NSTextAlignmentLeft;
		[cardnumber setTextColor:secondLabelFontColor];
		[nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabelCardNumber setBackgroundColor:[UIColor clearColor]];
        
		[cardnumber setBackgroundColor:[UIColor clearColor]];
		cardnumber.text = ((CardDetailsData*)[resultArray objectAtIndex:row]).cardnumber;
		[detailView addSubview:nameLabel];
	 	[detailView addSubview:nameLabelCardNumber];
        
		if([((CardDetailsData*)[resultArray objectAtIndex:row]).issuerName isEqualToString:@"Visa"])
		{
			//Load Image Form Documents folder
			NSArray *sysPaths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
			NSString *docDirectory = [sysPaths objectAtIndex:0];
			NSString *filePath = [NSString stringWithFormat:@"%@/%@", docDirectory,((CardDetailsData*)[resultArray objectAtIndex:row]).imageName];
			NSLog(@"File Path is %@",filePath);
			[image setImage:[UIImage imageWithContentsOfFile:filePath]];
			[detailView addSubview:image];
			[cardIssuerImage setImage:[UIImage imageWithContentsOfFile:filePath]];
            //[cardIssuerImage setImage:[UIImage imageNamed:@"visa3d.png"]];
        }
		else
		{
			//Load Image Form Documents folder
            NSArray *sysPaths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
            NSString *docDirectory = [sysPaths objectAtIndex:0];
            NSString *filePath = [NSString stringWithFormat:@"%@/%@", docDirectory,((CardDetailsData*)[resultArray objectAtIndex:row]).imageName];
            NSLog(@"File Path is %@",filePath);
            [image setImage:[UIImage imageWithContentsOfFile:filePath]];
            [detailView addSubview:image];
            [cardIssuerImage setImage:[UIImage imageWithContentsOfFile:filePath]];
        }
		[image setBackgroundColor:[UIColor clearColor]];
		
		NSString *dateStr = ((CardDetailsData*)[resultArray objectAtIndex:row]).expiryDate;
		
		// Convert string to date object
		NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
		[dateFormat setDateFormat:@"MM/yy"];
		NSDate *date = [dateFormat dateFromString:dateStr];
		//NSDate *today = [NSDate date];
		NSDate *today = [NSDate date];
		
		NSTimeInterval dateTime;
		
		
		dateTime = ([date timeIntervalSinceDate:today] / 86400);
		
		if(dateTime < 0) //Check if visit date is a past date, dateTime returns - val
		{
			
			[cardnumber setTextColor:ExpiredCardNumberColor];
            
		}
		[cardnumber setFont:secondLabelFont];
        //[nameLabel setShadowColor:[UIColor grayColor]];
		[cardnumber setFont:secondLabelFontSize];
		[cardView addSubview:secondCardImageView];
		[cardView addSubview:detailView];
		[cell.contentView addSubview:cardView];
		detailView = nil;
		
		[nameLabel setTextColor:[UIColor whiteColor]];
        [nameLabelCardNumber setTextColor:[UIColor whiteColor]];
		[cardnumber setTextColor:[UIColor whiteColor]];
		[issuerNameLabel setTextColor:[UIColor whiteColor]];
		[cardNumberLabel setTextColor:[UIColor whiteColor]];
		[cardExpirylabel setTextColor:[UIColor whiteColor]];
		[cardStartlabel setTextColor:[UIColor whiteColor]];
		[cardBalanceLabel setTextColor:[UIColor whiteColor]];
        
    }
    
 	[cell.contentView addSubview:cardImage];
    
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
    rowSelected = indexPath.row;
    selectedRow = indexPath.row;
    if (selectedRow<=resultArray.count-1) {
        
        [self getrowcount];
        
        NSLog(@"Click on indexxxxx...%d",rowSelected);
        if(!isRowSelected)
        {
            tabView=1;
            if((indexPath.row + 1) <= [resultArray count])
            {
                if(!isRowSelected)
                {
                    isCradGoesIn = NO;
                    isRowSelected = YES;
                    selectedRow = indexPath.row;
                    UITableViewCell *cell1 = [tableView cellForRowAtIndexPath:indexPath];
                    
                    UIImageView *cardImageView;
                    UIView *detailView,*cardView;
                    for (UIView *view in cell1.contentView.subviews){
                        if(view.tag == 123)
                        {
                            for (UIView *view1 in view.subviews){
                                if(view1.tag == 1234)
                                {
                                    cardImageView =(UIImageView *)view1;
                                }
                            }
                        }
                        if(view.tag == 101)
                        {
                            detailView = view;
                        }
                        if(view.tag == 121)
                        {
                            cardView = view;
                        }
                    }
                    
                    
                    
                    [UIView beginAnimations:nil context:NULL];
                    [UIView setAnimationDuration:0.99f];
                    [cardView setFrame:CGRectMake(30, -1000, 290, 190)];
                    //  [cardView setTransform:CGAffineTransformMakeRotation(0.30f)];
                    [UIView commitAnimations];
                    
                    
                    
                    
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
                    [button setBackgroundColor:[UIColor clearColor]];
                    [button setTag:102];
                    
                    [self.view addSubview:button];
                    [self.view bringSubviewToFront:cardView];
                    [self.view setUserInteractionEnabled:NO];
                    
                    detailisdisplay=0;
                    [self performSelector:@selector(moveCardImageViewToMainView:) withObject:indexPath afterDelay:0.35f];
                }
            }
		}
    }
}

#pragma mark - Card animation -----------------------------------------


-(void)backCardIntoTable
{
	
    //imgLogoSelected.frame= CGRectMake(20, 20, 30, 20);
    
	UIView *buttonView,*cardView;
	for (UIView *view in self.view.subviews){
		
		if(view.tag == 102)
		{
			buttonView = view;
		}
		if(view.tag == 103)
		{
			[view removeFromSuperview];
		}
		if(view.tag == 121)
		{
			cardView = view;
			
		}
		if(view.tag == 202)
		{
			[view removeFromSuperview];
			//[view release];
		}
		if (view.tag == 302) {
			[view removeFromSuperview];
		}
		if (view.tag == 402) {
			[view removeFromSuperview];
		}
		if (view.tag == 502) {
			[view removeFromSuperview];
		}
		if (view.tag == 602) {
			[view removeFromSuperview];
		}
	}
    yForDetail = 17;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.65f];
	[cardView setFrame:CGRectMake(framex,-600,framewidth,frameheight)];
    // [cardView setTransform:CGAffineTransformMakeRotation(0.30f)];
	[UIView commitAnimations];
	CATransition* trans = [CATransition animation];
	[trans setType:kCATransitionFade];
	[trans setDuration:0.5];
	[trans setSubtype:kCATransitionReveal];
	CALayer *layer = buttonView.layer;
	[buttonView removeFromSuperview];
	[layer addAnimation:trans forKey:@"CurlIn"];
    
    self.tableMyWallet.userInteractionEnabled=NO;
    
    
	[self performSelector:@selector(transferCardIntoTableView) withObject:nil afterDelay:0.25f];
    
}

-(void)setLogoAtTop{
    
}

-(void)transferCardIntoTableView
{
    imgLogoSelected.frame= CGRectMake(15, 15, 37, 23);
    
    if (resultArray.count>0) {
        
        
        
        if ([((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).issuerName isEqualToString:@"Visa"])
        {
            [imgLogoSelected setImage:[UIImage imageNamed:@"icon_visa.png"]];
        }
        else if ([((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).issuerName isEqualToString:@"MasterCard"])
        {
            [imgLogoSelected setImage:[UIImage imageNamed:@"icon_mastercard.png"]];
        }
        
        
        
        
        
        
        lblCardNameSelected.frame=CGRectMake(60,11, 155, 25);
        lblCardNameSelected.font=[UIFont fontWithName:labelregularFont size:20];
        
        
        NSString *cardnumberLast = @"";
        cardnumberLast =[((CardDetailsData*)[resultArray objectAtIndex:selectedRow]) cardnumber];
        NSUInteger cardNumberSublength = [cardnumberLast length] - 4;
        if ([cardnumberLast length] > 4) {
            cardnumberLast = [cardnumberLast substringFromIndex:cardNumberSublength];
        }
        NSString *cardNameLength = @"";
        NSString *cardname=@"";
        if ([((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).cardname isEqualToString:@"(null)"]) {
            cardname = cardnumberLast;
            lblNumberLastDigitSelected.hidden=YES;
        }
        else {
            // cardNameLength = ((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).cardname;
            lblNumberLastDigitSelected.hidden=NO;
            
            cardname = [cardname stringByAppendingString:[NSString stringWithFormat:@"%@",
                                                          ((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).cardname]];
        }
        
        if (![cardname isEqualToString:@"(null)"] && ![cardname isEqualToString:@"null"] && cardname !=NULL  && cardname !=nil && cardname.length!=0 )
        {
            lblCardNameSelected.text=cardname;
        }
        else{
            
            lblCardNameSelected.text=@"";
            
        }
        
        
        
        
        
        
    }
    
    
	//sleep(1);
	NSIndexPath *middleIndexPath;
	middleIndexPath = [NSIndexPath indexPathForRow:selectedRow inSection:0];
	UITableViewCell *cell = [self.tableMyWallet cellForRowAtIndexPath:middleIndexPath];
	UIImageView *cardImageView,*cardImage;
	UIView *detailView,*cardView;
    
	for (UIView *view in self.view.subviews){
		if(view.tag == 1234)
		{
			cardImageView =(UIImageView *)view;
		}
		if(view.tag == 101)
		{
			detailView = view;
		}
		if(view.tag == 121)
		{
			cardView = view;
		}
	}
	for (UIView *view in cell.contentView.subviews){
		if(view.tag == 123)
		{
			cardImage = (UIImageView*)view;
		}
	}
	
	[cell.contentView addSubview:cardView];
	//[cardView setFrame:CGRectMake(62, -312, 290, 190)];
	
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.75f];
	[cardView setFrame:CGRectMake(23, 0, 270, 36)];
	
	//[cardView setTransform:CGAffineTransformMakeRotation(0.0f)];
	
	[UIView commitAnimations];
	[self.view bringSubviewToFront:cell];
    [cell.contentView bringSubviewToFront:cardImage];
    
	isRowSelected = NO;
	
    [self performSelector:@selector(tableEnabled) withObject:self afterDelay:0.5];
    
}
-(void)tableEnabled{
    
	self.tableMyWallet.userInteractionEnabled=YES;
    
}

-(void)moveCardImageViewToMainView:(NSIndexPath *)cellSelectedIndexPath
{
	//sleep(1);
    
	UITableViewCell *cellSelected = [tableMyWallet cellForRowAtIndexPath:cellSelectedIndexPath];
    
    NSLog(@"%@",[cellSelected.contentView subviews]);
    
    // logo position - [[[[[[cellSelected.contentView subviews] objectAtIndex:0] subviews] objectAtIndex:1] subviews] objectAtIndex:7]
    
    imgLogoSelected=[[[[[[cellSelected.contentView subviews] objectAtIndex:0] subviews] objectAtIndex:1] subviews] objectAtIndex:8];
    imgLogoSelected.frame= CGRectMake(200, 120, 53, 31);
    
    if ([((CardDetailsData*)[resultArray objectAtIndex:cellSelectedIndexPath.row]).issuerName isEqualToString:@"Visa"]) {
        [imgLogoSelected setImage:[UIImage imageNamed:@"icon_visa_big.png"]];
    }
    else if ([((CardDetailsData*)[resultArray objectAtIndex:cellSelectedIndexPath.row]).issuerName isEqualToString:@"MasterCard"]){
        
        [imgLogoSelected setImage:[UIImage imageNamed:@"icon_mastercard_big.png"]];
        
    }
    
    // card name label position - [[[[[[cellSelected.contentView subviews] objectAtIndex:0] subviews] objectAtIndex:1] subviews] objectAtIndex:6]
    
    lblCardNameSelected=[[[[[[cellSelected.contentView subviews] objectAtIndex:0] subviews] objectAtIndex:1] subviews] objectAtIndex:6];
    
    lblNumberLastDigitSelected=[[[[[[cellSelected.contentView subviews] objectAtIndex:0] subviews] objectAtIndex:1] subviews] objectAtIndex:7];
    
    lblNumberLastDigitSelected.hidden=YES;
    
    
    
    if (![((CardDetailsData*)[resultArray objectAtIndex:cellSelectedIndexPath.row]).cardname isEqualToString:@"(null)"] && ![((CardDetailsData*)[resultArray objectAtIndex:cellSelectedIndexPath.row]).cardname isEqualToString:@"null"] && ((CardDetailsData*)[resultArray objectAtIndex:cellSelectedIndexPath.row]).cardname !=NULL  && ((CardDetailsData*)[resultArray objectAtIndex:cellSelectedIndexPath.row]).cardname !=nil && ((CardDetailsData*)[resultArray objectAtIndex:cellSelectedIndexPath.row]).cardname.length!=0 )
    {
        lblCardNameSelected.text=((CardDetailsData*)[resultArray objectAtIndex:cellSelectedIndexPath.row]).cardname;
    }
    else
    {
        lblCardNameSelected.text=@"";
    }
    
    lblCardNameSelected.frame=CGRectMake(27, 39, 220, 25);
    lblCardNameSelected.font=[UIFont fontWithName:labelregularFont size:17];
    
    NSLog(@"---------------   select row = %d",selectedRow);
    
	
    isOpen=YES;
	NSIndexPath *middleIndexPath;
	middleIndexPath = [NSIndexPath indexPathForRow:selectedRow inSection:0];
	UITableViewCell *cell = [tableMyWallet cellForRowAtIndexPath:middleIndexPath];
	UIView *detailView,*cardView;
	UIButton *buttonView;
	for (UIView *view in cell.contentView.subviews){
        
		if(view.tag == 101)
		{
			detailView = view;
		}
		if(view.tag == 121)
		{
			cardView = view;
		}
	}
	for (UIView *view in self.view.subviews){
		if(view.tag == 102)
		{
			buttonView =(UIButton*) view;
		}
		
	}
	[self.view addSubview:cardView];
 	NSLog(@"Value Of Y After Subtraction is %d",[[self.tableMyWallet visibleCells] count]);
	NSArray *visibleCellArray = [self.tableMyWallet visibleCells];
	NSIndexPath *IndexPath;
	
	CGFloat y1 ;
	int i;
	for (i=0; i<[visibleCellArray count]; i++) {
		IndexPath = [self.tableMyWallet indexPathForCell:[visibleCellArray objectAtIndex:i]];
		NSLog(@"Row number for Visible Cell is %d",IndexPath.row);
		if(IndexPath.row <= selectedRow)
			y1 = i*46 - 200 - 48;
	}
	//[cardView setFrame:CGRectMake(cardView.frame.origin.x+65 ,y1 - 33, cardView.frame.size.width,cardView.frame.size.height)];
    
	framex = cardView.frame.origin.x;
	framey = cardView.frame.origin.y;
	framewidth = cardView.frame.size.width;
	frameheight = cardView.frame.size.height;
 	UIButton *detail = [[UIButton alloc] init];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5f];
	
    [cardView setFrame:CGRectMake(23, 50 , 290, 190)];
    [detail setFrame:CGRectMake(23, 60 , 290, 190)];
 	[buttonView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
	[buttonView addTarget:self action:@selector(chekForCardRotation) forControlEvents:UIControlEventTouchDown];
    [UIView commitAnimations];
	
	
	
	[detail addTarget:self action:@selector(showPersonalDetails) forControlEvents:UIControlEventTouchUpInside];
	[detail setUserInteractionEnabled:NO];
	[detail setTag:103];
	
	[self.view addSubview:detail];
	[self.view bringSubviewToFront:cardView];
	[self.view bringSubviewToFront:detail];
	[self performSelector:@selector(addOptionView) withObject:nil afterDelay:0.4f];
    
    
	[self getrowcount];
	
    
	
}

-(void)addOptionView
{
	
	UIView *cardView;
	for (UIView *view in self.view.subviews){
		
		if(view.tag == 121)
		{
			cardView = view;
		}
        
	}
	
    
    
	UIButton *reactivateButton;
	UIButton *suspendButton;
	UIButton *updateCardButton;
	
	UIButton *createVCButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[createVCButton setFrame:CGRectMake(cardView.frame.origin.x+140, cardView.frame.origin.y + 232,135, 40)];
	//[createVCButton setTitle:@"Create Virtual Card" forState:UIControlStateNormal];
	[createVCButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[createVCButton addTarget:self action:@selector(createVirtualCard) forControlEvents:UIControlEventTouchUpInside];
	[createVCButton setBackgroundImage:[UIImage imageNamed:@"button_create_virtual_card.png"] forState:UIControlStateNormal];
    
	createVCButton.tag = 202;
    
	CATransition* trans = [CATransition animation];
	[trans setType:kCATransitionFade];
	[trans setDuration:0.3f];
	[trans setSubtype:kCATransitionReveal];
	CALayer *layer = createVCButton.layer;
	
	
	UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
	//[deleteButton setFrame:CGRectMake(cardView.frame.origin.x+3, cardView.frame.origin.y + 232,135, 40)];//old frame
    [deleteButton setFrame:CGRectMake(cardView.frame.origin.x+140, cardView.frame.origin.y + 188,135, 40)];
	//[deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
	[deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[deleteButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[deleteButton addTarget:self action:@selector(deleteRecord) forControlEvents:UIControlEventTouchUpInside];
	[deleteButton setBackgroundImage:[UIImage imageNamed:@"button_delete_card.png"] forState:UIControlStateNormal];
	
	deleteButton.tag = 602;
	
	[self.view addSubview:deleteButton];
 	[self.view bringSubviewToFront:deleteButton];
	CALayer *layer1 = deleteButton.layer;
	
	[layer1 addAnimation:trans forKey:@"CurlIn"];
	[self.view bringSubviewToFront:deleteButton];
	isDeleteButton = YES;
	
	
	
//	appDelegate.cardReference = [((CardDetailsData*)[resultArray objectAtIndex:selectedRow]) cardreferance];
    
	updateCardButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[updateCardButton setFrame:CGRectMake(cardView.frame.origin.x+3, cardView.frame.origin.y + 188,135, 40)];
	//[updateCardButton setTitle:@"Update" forState:UIControlStateNormal];
	[updateCardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[updateCardButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[updateCardButton addTarget:self action:@selector(updateCard) forControlEvents:UIControlEventTouchUpInside];
	[updateCardButton setBackgroundImage:[UIImage imageNamed:@"button_update_card.png"] forState:UIControlStateNormal];
	updateCardButton.tag = 502;
    
	[self.view addSubview:updateCardButton];
	[self.view bringSubviewToFront:updateCardButton];
	CALayer *layer3= updateCardButton.layer;
	
	[layer3 addAnimation:trans forKey:@"CurlIn"];
	[self.view bringSubviewToFront:updateCardButton];
	isUpdateButton =YES;
	
	if([((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).cardStatus isEqualToString:@"Suspended"]){
		NSLog(@"Card Suspended is===>%@",[((CardDetailsData*)[resultArray objectAtIndex:selectedRow]) cardStatus]);
		NSLog(@"Card Suspended And selected row is===>%d",selectedRow);
		reactivateButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[reactivateButton setFrame:CGRectMake(cardView.frame.origin.x+140, cardView.frame.origin.y + 188,135, 40)];
		//[reactivateButton setTitle:@"Reactive" forState:UIControlStateNormal];
		[reactivateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[reactivateButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[reactivateButton addTarget:self action:@selector(reactivateCard) forControlEvents:UIControlEventTouchUpInside];
		[reactivateButton setBackgroundImage:[UIImage imageNamed:@"button_reactivate_card.png"] forState:UIControlStateNormal];
		reactivateButton.tag = 302;
		//[self.view addSubview:reactivateButton];
		//[self.view addSubview:reactivateButton];
		[self.view bringSubviewToFront:reactivateButton];
		CALayer *layer2 = reactivateButton.layer;
		
		[layer2 addAnimation:trans forKey:@"CurlIn"];
		[self.view bringSubviewToFront:reactivateButton];
    }
	if([((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).cardStatus isEqualToString:@"Active"]){
        
        
		NSLog(@"Card Activated is===>%@",[((CardDetailsData*)[resultArray objectAtIndex:selectedRow]) cardStatus]);
		suspendButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[suspendButton setFrame:CGRectMake(cardView.frame.origin.x+140, cardView.frame.origin.y + 188,135, 40)];
        //	[suspendButton setTitle:@"Suspend" forState:UIControlStateNormal];
		[suspendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[suspendButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[suspendButton addTarget:self action:@selector(suspendCard) forControlEvents:UIControlEventTouchUpInside];
		[suspendButton setBackgroundImage:[UIImage imageNamed:@"button_suspend_card.png"] forState:UIControlStateNormal];
		suspendButton.tag = 402;
		//[self.view addSubview:suspendButton];
		[self.view bringSubviewToFront:suspendButton];
		CALayer *layer4 = suspendButton.layer;
        
		[layer4 addAnimation:trans forKey:@"CurlIn"];
		[self.view bringSubviewToFront:suspendButton];
	   	
	}
    
	//[self.view addSubview:createVCButton];
    
	[self.view bringSubviewToFront:createVCButton];
	[layer addAnimation:trans forKey:@"CurlIn"];
	[self.view bringSubviewToFront:createVCButton];
    
    [self.view setUserInteractionEnabled:YES];
    
}
/*
 -(void) payNFC{
 
 CustomAlertView *alert =[[CustomAlertView alloc] initWithTitle:@"NFC Payment" message:@"Contactless payment will be available soon..!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
 [alert setTag:102];
 [alert show];
 [alert release];
 }
 */

#pragma mark - Button methods -------------------------------------------

-(void)AddNewCard
{
	@try {
		
        if ([Common isNetworkAvailable]) {
            
            AddCardInSideLoginViewController *Objaddcard=[[AddCardInSideLoginViewController alloc]init];
            
            [self.navigationController pushViewController:Objaddcard animated:YES];
            isBackFromAddCard = YES;
            
        }
        else{
            
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:networkconnectiontitle message:networkconnectionmessage  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
	}
	@catch (NSException * e) {
        
	}
	@finally {
        
	}
}

-(void) deleteRecord{
	
	if ([Common isNetworkAvailable]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:cardwilldelete delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
        [alert setTag:100];
        [alert show];
	}
	else{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:networkconnectiontitle message:networkconnectionmessage  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
	}
	
}
-(void) updateCard{
//	if ([Common isNetworkAvailable])
//    {
//		
//		NSLog(@"Update card ....called new Screen..%@",updateButton);
//        
//        CGRect screenBounds = [[UIScreen mainScreen] bounds];
//        UpdateWalletCard *updateCard=[[UpdateWalletCard alloc] init];
//        
//        
//		
//		[self.navigationController pushViewController:updateCard animated:YES];
//	}
//	else{
//		
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:networkconnectiontitle message:networkconnectionmessage  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//	}
}
-(void)reactivateCard{
	
//	if ([Common isNetworkAvailable]) {
//        
//	 	isReactvateButton =YES;
//		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:cardwillreactivated delegate:self  cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel" , nil];
//		[alertView setTag:201];
//		[alertView show];
//	}
// 	else{
//		
//        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:networkconnectiontitle message:networkconnectionmessage  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//	}
    
}

-(void)suspendCard{
//	if ([Common isNetworkAvailable]) {
//        isSuspendButton =YES;
//		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:cardwillsuspend delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
//		[alertView setTag:202];
//		[alertView show];
//	}
//	else{
//        
//        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:networkconnectiontitle message:networkconnectionmessage  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//	}
	
}

#pragma mark - Touch methods --------------------------------------------

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"touchesBegan Selected row is.1.%d",rowSelected);
    
	if ([resultArray count]>rowSelected) {
        
        UITouch *touch = [touches anyObject];
        
        CGPoint location = [touch locationInView:self.view.superview];
		touchBeganX = location.x;
        touchBeganY = location.y;
	}
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
	NSLog(@"touchesMoved Selected row is2..%d",rowSelected);
	if ([resultArray count]>rowSelected) {
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView:self.view.superview]; // <--- note self.superview
        NSLog(@"Touch Loaction is X = %f, Y = %f",location.x,location.y);
        //if(touchBeganY - 20 > location.y   && isCradGoesIn == NO  )
        if(touchBeganY - 60> location.y   && isCradGoesIn == NO &&  touch.view.tag ==101 )
        {
            [self chekForCardRotation];
            isCradGoesIn = YES;
        }
	}
    // self.center = location;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"touchesEnded Selected row is.1.%d",rowSelected);
	if ([resultArray count]>rowSelected) {
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView:self.view.superview];
        //  if(touchBeganY - 20 > location.y )
        
        if(touchBeganY - 60 > location.y  )
        {
            
        }
        else {
            NSLog(@"touchesEnded Selected row is.2 .%d",rowSelected);
            if (isOpen) {
                NSLog(@"touchesEnded Selected Card id open");
                isOpen=NO;
                [self showPersonalDetails];
            }
        }
    }
}



-(void)showPersonalDetails
{
	isOpen=YES;
	NSLog(@"Show Personal Details");
	UIView *cardView;
    
    for (UIView *view in self.view.subviews){
        
        if(view.tag == 121)
        {
            cardView = view;
        }
        
    }
    @try {
        
        if(detailisdisplay == 0)
        {
            
            
            [PersonalDetailView setFrame:CGRectMake(-16,5, 280, 250)];
            PersonalDetailView.backgroundColor=[UIColor clearColor];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:1.0f];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight  forView:cardView cache:YES];
            [PersonalDetailView setFrame:CGRectMake(-16,5, 280, 250)];
            
            
            [cardView addSubview:PersonalDetailView];
            NSLog(@"%@",NSStringFromCGRect(cardView.frame));
            [UIView commitAnimations];
            // [PersonalDetailView setFrame:CGRectMake(-50,3, 280, 240)];
            UIButton *btnTemp=[[PersonalDetailView subviews] objectAtIndex:0];
            detailisdisplay = 1;
            
        }
        else
        {
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:1.0f];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight  forView:cardView cache:YES];
            
            [PersonalDetailView removeFromSuperview];
            
            [UIView commitAnimations];
            
            
            detailisdisplay = 0;
        }
    }
    @catch (NSException * e) {
        
	}
	@finally {
		
	}
}

-(void)chekForCardRotation
{
    
    [self showcardfrontviewintableview];
    [self backCardIntoTable];
    
    
}

#pragma mark - UIScrollview delegate ------------------------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	NSLog(@"Scroll View Did Scroll");
	int i = [resultArray count];
	for (; i >= 0; i--) {
		
		NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:(i-1) inSection:0];
		UITableViewCell *cell = [self.tableMyWallet cellForRowAtIndexPath:middleIndexPath];
		[self.tableMyWallet sendSubviewToBack:cell];
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	NSLog(@"Scroll View Did Decelerating");
	int i = [resultArray count];
	for (; i >= 0; i--) {
		
		NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:(i-1) inSection:0];
		UITableViewCell *cell = [self.tableMyWallet cellForRowAtIndexPath:middleIndexPath];
		[self.tableMyWallet sendSubviewToBack:cell];
	}
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
	NSLog(@"Scroll View Will Begin Decelerating");
	int i = [resultArray count];
	for (; i >= 0; i--) {
		
		NSIndexPath *middleIndexPath;
		middleIndexPath = [NSIndexPath indexPathForRow:(i-1) inSection:0];
		UITableViewCell *cell = [self.tableMyWallet cellForRowAtIndexPath:middleIndexPath];
		[self.tableMyWallet sendSubviewToBack:cell];
	}
}




#pragma mark - Other Functions ---------------------------------------------------------
-(void)callWebserviceForCards:(BOOL)isTimeStamps
{
    
    //---------------  Waiting -----------------------------------------
    
    
    
    //---------------//---------------//---------------//---------------
    
    
    
    //------------------ set request parameters -------------------------------
  //  YPCardHolderServiceService *services = [[YPCardHolderServiceService alloc] init];
    
    WebserviceOperation *serviceGetAllcards=[[WebserviceOperation alloc] initWithDelegate:self callback:@selector(getCardsInWalletDetailedHandler:)];
    
    YPGetCardsInWalletDetailedRequest *getCards = [[YPGetCardsInWalletDetailedRequest alloc] init];
    getCards.SC = appDelegate.SC;
    getCards.userName = appDelegate.userName;
    getCards.valid = TRUE;
    getCards.applicationType = @"M";
    //-------------------------------------------------------------------------
    
    
    if (isTimeStamps) {
        [self showHUD:loadingaything];
        strButtonSelected=@"";
        NSString *query = @"Select CardDetails from UpdateDateTimeStamp where userid = ";
        query = [query stringByAppendingString:[NSString stringWithFormat:@"%@",appDelegate.userID]];
        if([DataBase getNumberOfRowsForQuery:query] > 0)
        {
            getCards.updateDatetimestamp = @"";
        }
    }
    
    
    
    self.lblBackAlertTitle.textColor=[UIColor clearColor];
    self.lblBackAlertSubTitle.textColor=[UIColor clearColor];
    
    self.isCardFetchCalled=YES;
    [serviceGetAllcards getAllCards:getCards];
    
    
    
   // [services getCardsInWalletDetailed:self action:@selector(getCardsInWalletDetailedHandler:) getCardsInWalletDetailedRequest:getCards];
    
}


-(void)getrowcount{
    
	if ([resultArray count]>0)
    {
        
        yForDetail = 5;
        if(labelEmail.superview)
        {
            [labelEmail removeFromSuperview];
        }
        labelEmail.frame = CGRectMake(25, yForDetail+140, 260, 25);
        [labelEmail setTextAlignment:NSTextAlignmentLeft];
        [labelEmail setTextColor:[UIColor whiteColor]];
        [labelEmail setFont:[UIFont fontWithName:labelregularFont size:17]];
        
        
        //[labelEmail setShadowColor:[UIColor whiteColor]];
        [labelEmail setBackgroundColor:[UIColor clearColor]];
        NSLog(@"selected row vaue is %d",selectedRow);
        
        NSString *strLength = ((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).email1;
        
        NSLog(@"value of str leghnth value is %@",strLength);
        
        
        
        if(strLength ==nil)
        {
            labelEmail.text =@"";
        }
       
        else if ([strLength length]>0)//-------------------------- email ------------
        {
            NSString *str =[NSString stringWithFormat:@"%@",((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).email1];
            if (str ==(id)[NSNull null] || str.length == 0||[str isEqualToString:@"null"])
            {
                labelEmail.text =@"";
            }
            else
            {
                labelEmail.text =str;
            }
            
        }
        [PersonalDetailView addSubview:labelEmail];
        yForDetail += 24;
        
        if(labelPhone.superview)
        {
            [labelPhone removeFromSuperview];
        }
        labelPhone= [[UILabel alloc] initWithFrame:CGRectMake(20, yForDetail, 260, 25)];
        [labelPhone setTextAlignment:NSTextAlignmentLeft];
        [labelPhone setTextColor:[UIColor whiteColor]];
        [labelPhone setBackgroundColor:[UIColor clearColor]];
        
        NSString *strPhone=((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).phone1;
        
        if(strPhone ==nil)
        {
            NSLog(@"Phone  nulll");
            labelPhone.text = @"Phone:-";
            
        }
        
        else if ([strPhone length]>0)//------------------- phone1
        {
            NSString *str =[NSString stringWithFormat:@"%@",((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).phone1];
            labelPhone.text =str;
            
        }
        //[PersonalDetailView addSubview:labelPhone];
        
        // [labelPhone release];
        
        yForDetail += 24;
        if(labelFax.superview)
        {
            [labelFax removeFromSuperview];
        }
        labelFax = [[UILabel alloc] initWithFrame:CGRectMake(20, yForDetail, 260, 25)];
        [labelFax setTextAlignment:NSTextAlignmentRight];
        [labelFax setTextColor:[UIColor whiteColor]];
        //[labelFax setShadowColor:[UIColor whiteColor]];
        
        [labelFax setBackgroundColor:[UIColor clearColor]];
        
        NSString *strFax=((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).fax1;
        
        if(strFax ==nil)
        {
            labelFax.text =@"Fax:-";
            
        }
        else if([strFax length]>0)//------------------------------------ fax
        {
            NSString *str=[NSString stringWithFormat:@"Fax: %@",((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).fax1];
            labelFax.text =str;
        }
        
        yForDetail += 24;
        
       // NSLog(@"((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).address1..%d",[((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).address1 length]);
        if([((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).address1 length]>0){ //--------------- address1
            
            [lblAddress1 setFrame:CGRectMake(25, yForDetail+22, 260, 25)];
            [lblAddress1 setText:((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).address1];
            [PersonalDetailView addSubview:lblAddress1];
            [lblAddress1 setTextColor:[UIColor whiteColor]];
            [lblAddress1 setBackgroundColor:[UIColor clearColor]];
            
            [lblAddress1 setFont:[UIFont fontWithName:labelregularFont size:15]];
        }
        else
        {
            
            lblAddress1.text=@"";
            
            
        }
        
       
        if([((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).address2 length]>0){ //--------------- address2
            
            [lblAddress2 setFrame:CGRectMake(25, yForDetail, 260, 25)];
            NSString *address2lbl=((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).address2;
            if([address2lbl isEqualToString:@"null"])
            {
                [lblAddress2 setText:@""];
            }
            else{
                [lblAddress2 setText:address2lbl];
            }
            
            [PersonalDetailView addSubview:lblAddress2];
            [lblAddress2 setTextColor:[UIColor whiteColor]];
            [lblAddress2 setBackgroundColor:[UIColor clearColor]];
            [lblAddress2 setFont:[UIFont fontWithName:labelregularFont size:15]];
            
        }
        else{
            [lblAddress2 setText:@""];
            
            
        }
        
        
        if([((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).city length]>0) ///---------------city
        {
            
            [lblCity setFrame:CGRectMake(25, yForDetail+40, 260, 25)];
            [lblCity setFont:[UIFont fontWithName:labelregularFont size:15]];
            
            [lblCity setText:((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).city];
            
            [PersonalDetailView addSubview:lblCity];
            [lblCity setTextColor:[UIColor whiteColor]];
            [lblCity setBackgroundColor:[UIColor clearColor]];
            yForDetail += 24;
            
        }
        else{
            lblCity.text=@"";
            
        }
        
        float yTemp = labelEmail.frame.origin.y;
        
        if (labelEmail.text.length>0 && labelEmail !=nil) {
            
            labelEmail.frame=CGRectMake(labelEmail.frame.origin.x, yTemp, labelEmail.frame.size.width, labelEmail.frame.size.height);
            yTemp=yTemp-22;
            
            
        }
        else{
            
            labelEmail.text=@"";
        }
        
        
        if (lblCountry.text.length>0 && lblCountry !=nil) {
            
            lblCountry.frame=CGRectMake(lblCountry.frame.origin.x, yTemp, lblCountry.frame.size.width, lblCountry.frame.size.height);
            yTemp=yTemp-22;
            
            
        }
        if (lblPostCode.text.length>0 && lblPostCode !=nil) {
            
            lblPostCode.frame=CGRectMake(lblPostCode.frame.origin.x, yTemp, lblPostCode.frame.size.width, lblPostCode.frame.size.height);
            yTemp=yTemp-22;
            
            
        }
        
        if (lblCity.text.length>0 && lblCity !=nil) {
            lblCity.frame=CGRectMake(lblCity.frame.origin.x, yTemp, lblCity.frame.size.width, lblCity.frame.size.height);
            yTemp=yTemp-22;
            
            
        }
        if (lblAddress2.text.length>0 && lblAddress2 !=nil) {
            lblAddress2.frame=CGRectMake(lblAddress2.frame.origin.x, yTemp, lblAddress2.frame.size.width, lblAddress2.frame.size.height);
            yTemp=yTemp-22;
            
        }
        if (lblAddress1.text.length>0 && lblAddress1 !=nil) {
            
            lblAddress1.frame=CGRectMake(lblAddress1.frame.origin.x, yTemp, lblAddress1.frame.size.width, lblAddress1.frame.size.height);
            yTemp=yTemp-22;
            
        }

        
        
       /******************** old code appdelegate.emailString and other are confusing ***********
        yForDetail = 5;
        if(labelEmail.superview)
        {
            [labelEmail removeFromSuperview];
        }
        labelEmail.frame = CGRectMake(25, yForDetail+140, 260, 25);
        [labelEmail setTextAlignment:NSTextAlignmentLeft];
        [labelEmail setTextColor:[UIColor whiteColor]];
        [labelEmail setFont:[UIFont fontWithName:labelregularFont size:17]];
        
        
        //[labelEmail setShadowColor:[UIColor whiteColor]];
        [labelEmail setBackgroundColor:[UIColor clearColor]];
        NSLog(@"selected row vaue is %d",selectedRow);
        
        NSString *strLength = ((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).email1;
        
        NSLog(@"value of str leghnth value is %@",strLength);
       
        
        if(strLength ==nil && appDelegate.emailString ==nil)
        {
            labelEmail.text =@"";
        }
        else if([appDelegate.emailString length]>0)  //--------------- email
        {
            NSLog(@"Email recordssss");
            if([appDelegate.emailString isEqualToString:@"null"])
            {
                labelEmail.text =@"";
            }else
            {
                NSString *str =[NSString stringWithFormat:@"%@",appDelegate.emailString];
                NSLog(@"str %@",str);
                labelEmail.text =str;
            }
            
        }
        else if ([strLength length]>0)
        {
            NSLog(@"Email recordssss");
            NSString *str =[NSString stringWithFormat:@"%@",((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).email1];
            if (str ==(id)[NSNull null] || str.length == 0||[str isEqualToString:@"null"])
            {
                labelEmail.text =@"";
            }
            else
            {
                NSLog(@"str %@",str);
                labelEmail.text =str;
            }
            
            
            
        }
        [PersonalDetailView addSubview:labelEmail];
        yForDetail += 24;
        //[labelEmail release];
        
        if(labelPhone.superview)
        {
            [labelPhone removeFromSuperview];
        }
        labelPhone= [[UILabel alloc] initWithFrame:CGRectMake(20, yForDetail, 260, 25)];
        [labelPhone setTextAlignment:NSTextAlignmentLeft];
        [labelPhone setTextColor:[UIColor whiteColor]];
        //[labelPhone setShadowColor:[UIColor whiteColor]];
        [labelPhone setBackgroundColor:[UIColor clearColor]];
        
        NSString *strPhone=((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).phone1;
        
        if(strPhone ==nil && appDelegate.phoneString ==nil)
        {
            NSLog(@"Phone  nulll");
            labelPhone.text = @"Phone:-";
            
        }
        else if([appDelegate.phoneString length]>0) //--------------- phone
        {
            NSString *str =[NSString stringWithFormat:@"%@",appDelegate.phoneString];
            labelPhone.text =str;
        }
        else if ([strPhone length]>0)
        {
            NSString *str =[NSString stringWithFormat:@"%@",((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).phone1];
            labelPhone.text =str;
            
        }
        //[PersonalDetailView addSubview:labelPhone];
        
        // [labelPhone release];
        
        yForDetail += 24;
        if(labelFax.superview)
        {
            [labelFax removeFromSuperview];
        }
        labelFax = [[UILabel alloc] initWithFrame:CGRectMake(20, yForDetail, 260, 25)];
        [labelFax setTextAlignment:UITextAlignmentRight];
        [labelFax setTextColor:[UIColor whiteColor]];
        //[labelFax setShadowColor:[UIColor whiteColor]];
        
        [labelFax setBackgroundColor:[UIColor clearColor]];
        
        NSString *strFax=((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).fax1;
        
        if(strFax ==nil && appDelegate.faxString ==nil)
        {
            labelFax.text =@"Fax:-";
            
        }
        
        else if([appDelegate.faxString length]>0) //--------------- fax
        {
            NSString *str=[NSString stringWithFormat:@"Fax: %@",appDelegate.faxString];
            labelFax.text =str;
            
        }
        else if([strFax length]>0)
        {
            NSString *str=[NSString stringWithFormat:@"Fax: %@",((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).fax1];
            labelFax.text =str;
        }
        
        yForDetail += 24;
        
        NSLog(@"((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).address1..%d",[((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).address1 length]);
        if([((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).address1 length]>0){ //--------------- address1
            
            [lblAddress1 setFrame:CGRectMake(25, yForDetail+22, 260, 25)];
            [lblAddress1 setText:((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).address1];
            [PersonalDetailView addSubview:lblAddress1];
            [lblAddress1 setTextColor:[UIColor whiteColor]];
            [lblAddress1 setBackgroundColor:[UIColor clearColor]];
            
            [lblAddress1 setFont:[UIFont fontWithName:labelregularFont size:15]];
        }
        else
        {
            
            lblAddress1.text=@"";
            
            
        }
        
        NSLog(@"((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).address2..%d",[((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).address2 length]);
        if([((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).address2 length]>0){ //--------------- address2
            
            [lblAddress2 setFrame:CGRectMake(25, yForDetail, 260, 25)];
            NSString *address2lbl=((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).address2;
            if([address2lbl isEqualToString:@"null"])
            {
                [lblAddress2 setText:@""];
            }
            else{
                [lblAddress2 setText:address2lbl];
            }
            
            [PersonalDetailView addSubview:lblAddress2];
            [lblAddress2 setTextColor:[UIColor whiteColor]];
            [lblAddress2 setBackgroundColor:[UIColor clearColor]];
            [lblAddress2 setFont:[UIFont fontWithName:labelregularFont size:15]];
            
        }
        else{
            [lblAddress2 setText:@""];
            
            
        }
        
        
        if([((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).city length]>0) ///---------------city
        {
            
            [lblCity setFrame:CGRectMake(25, yForDetail+40, 260, 25)];
            [lblCity setFont:[UIFont fontWithName:labelregularFont size:15]];
            
            [lblCity setText:((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).city];
            
            [PersonalDetailView addSubview:lblCity];
            [lblCity setTextColor:[UIColor whiteColor]];
            [lblCity setBackgroundColor:[UIColor clearColor]];
            yForDetail += 24;
            
        }
        else{
            lblCity.text=@"";
            
        }
        
        float yTemp = labelEmail.frame.origin.y;
        
        if (labelEmail.text.length>0 && labelEmail !=nil) {
            
            labelEmail.frame=CGRectMake(labelEmail.frame.origin.x, yTemp, labelEmail.frame.size.width, labelEmail.frame.size.height);
            yTemp=yTemp-22;
            
            
        }
        else{
            
            labelEmail.text=@"";
        }
        
        
        if (lblCountry.text.length>0 && lblCountry !=nil) {
            
            lblCountry.frame=CGRectMake(lblCountry.frame.origin.x, yTemp, lblCountry.frame.size.width, lblCountry.frame.size.height);
            yTemp=yTemp-22;
            
            
        }
        if (lblPostCode.text.length>0 && lblPostCode !=nil) {
            
            lblPostCode.frame=CGRectMake(lblPostCode.frame.origin.x, yTemp, lblPostCode.frame.size.width, lblPostCode.frame.size.height);
            yTemp=yTemp-22;
            
            
        }
        
        if (lblCity.text.length>0 && lblCity !=nil) {
            lblCity.frame=CGRectMake(lblCity.frame.origin.x, yTemp, lblCity.frame.size.width, lblCity.frame.size.height);
            yTemp=yTemp-22;
            
            
        }
        if (lblAddress2.text.length>0 && lblAddress2 !=nil) {
            lblAddress2.frame=CGRectMake(lblAddress2.frame.origin.x, yTemp, lblAddress2.frame.size.width, lblAddress2.frame.size.height);
            yTemp=yTemp-22;
            
        }
        if (lblAddress1.text.length>0 && lblAddress1 !=nil) {
            
            lblAddress1.frame=CGRectMake(lblAddress1.frame.origin.x, yTemp, lblAddress1.frame.size.width, lblAddress1.frame.size.height);
            yTemp=yTemp-22;
            
        }
        
        */
        
	}else {
		/*CustomAlertView *alertView = [[CustomAlertView alloc] initWithTitle:@"No Cards Available" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
         [alertView show];
         [alertView release];*/
		
    }
    
}



#pragma mark - UIAlertview delegate -------------------------------------------------
-(void)showcardfrontviewintableview
{
    if (detailisdisplay==1) {
        
        UIView *cardView;
        
        for (UIView *view in self.view.subviews){
            
            if(view.tag == 121)
            {
                cardView = view;
            }
        }
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.0f];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight  forView:cardView cache:YES];
        
        [PersonalDetailView removeFromSuperview];
        
        [UIView commitAnimations];
        detailisdisplay = 0;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	//NSString *strOK = [alertView buttonTitleAtIndex:buttonIndex];
    
    
    if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"])
    {
        
        if (alertView.tag == 100)
        {
            if (buttonIndex == 0 ){
                
                if([Common isNetworkAvailable])
                {
                    
                    isNetwork.text= NSLocalizedString(@"NetWork Available", @"");
                    count=0;
                    [imgOnline setImage:[UIImage imageNamed:@"online.png"]];
                    
                    
                  //  YPCardHolderServiceService *services = [[YPCardHolderServiceService alloc] init];
                    WebserviceOperation *serviceDeleteCard=[[WebserviceOperation alloc] initWithDelegate:self callback:@selector(deleteResponse:)];
                    
//                    NSString *cardReferenceNum = [((CardDetailsData*)[resultArray objectAtIndex:selectedRow]) cardreferance];//old
                    
                      NSString *cardReferenceNum = ((CardDetailsData*)[resultArray objectAtIndex:selectedRow]).cardReferance;
                    
					YPRemoveCardRequest *deleteCards = [[YPRemoveCardRequest alloc] init];
                    
                    //set request parameters --------------------
					deleteCards.SC = appDelegate.SC;
					deleteCards.userName = appDelegate.userName;
					deleteCards.valid = TRUE;
					deleteCards.applicationType = @"M";
					deleteCards.cardReference = cardReferenceNum;
                    //--------------------------------------------
                    
                    //-------------- waiting ------------------------
                    
                    [self showHUD:deletecardhud];
                    [self showcardfrontviewintableview];
                    //-----------------------------------------------
                    
                    
                    
                    self.isCardFetchCalled=YES;
                    
                   [serviceDeleteCard deleteCard:deleteCards];
                    
				//[services removeCard:self action:@selector(deleteResponse:) removeCardRequest:deleteCards];
                    
					[self backCardIntoTable];
                }
                else {
                    
                    [imgOnline setImage:[UIImage imageNamed:@"offline.png"]];
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:networkconnectiontitle message:networkconnectionmessage  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    
                    
                    //  [self backCardIntoTable];
                    
                    [self killHUD];
                    
                    
                }
                
                
            }
        }
        //for reactive card
        if (alertView.tag == 201) {
            
            if (buttonIndex == 0 ){
                
                if([Common isNetworkAvailable])
                {
                    isNetwork.text= NSLocalizedString(@"NetWork Available", @"");
                    count=0;
                    [imgOnline setImage:[UIImage imageNamed:@"online.png"]];
                    /*
                    YPCardHolderServiceService *services = [[YPCardHolderServiceService alloc] init];
                    NSString *cardReferenceNum = [((CardDetailsData*)[resultArray objectAtIndex:selectedRow]) cardreferance];
                    
                    
                    //Set request parameters -------------------------------------------------
                    
                    YPReactiveCardRequest *getCards = [[YPReactiveCardRequest alloc] init];
                    getCards.SC = appDelegate.SC;
                    getCards.userName = appDelegate.userName;
                    getCards.valid = TRUE;
                    getCards.applicationType = @"M";
                    getCards.cardReference = cardReferenceNum;
                    
                    //-------------------------------------------------------------------------
                    
                    //-------------- waiting ------------------------
                    [self showcardfrontviewintableview];
                    [self showHUD:activatingcardhud];
                    
                    //-----------------------------------------------
                    
                    self.isCardFetchCalled=YES;
                    [services reactiveCard:self action:@selector(reactivateResponse:) reactiveCardRequest:getCards];
                    */
                    [self backCardIntoTable];
                    
                }
                else {
                    
                    
                    [imgOnline setImage:[UIImage imageNamed:@"offline.png"]];
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:networkconnectiontitle message:networkconnectionmessage  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    //  [self backCardIntoTable];
                    
                    [self killHUD];
                    
                }
            }
        }
        //for suspend card
        if (alertView.tag == 202)
        {
            if (buttonIndex == 0){
                if([Common isNetworkAvailable]) {
                    isNetwork.text= NSLocalizedString(@"NetWork Available", @"");
                    //count=0;
                    
                    [imgOnline setImage:[UIImage imageNamed:@"online.png"]];
                    /*
                    YPCardHolderServiceService *services = [[YPCardHolderServiceService alloc] init];
                    NSString *cardReferenceNum = [((CardDetailsData*)[resultArray objectAtIndex:selectedRow]) cardreferance];
                    NSLog(@"Click on OK BUtton and button clicked is==>alertView.tag == 202");
                    
                    //	if (isSuspendButton) {
                    //		isSuspendButton = NO;
					NSLog(@"Suspended API called .......OK pressed ");
					YPSuspendCardRequest *suspendCardReq = [[YPSuspendCardRequest alloc] init];
					suspendCardReq.SC = appDelegate.SC;
					suspendCardReq.userName = appDelegate.userName;
					suspendCardReq.valid = TRUE;
					suspendCardReq.applicationType = @"M";
					suspendCardReq.cardReference = cardReferenceNum;
					
                    //-------------- waiting ------------------------
                    
                    [self showHUD:supendcardhud];
                    
                    //-----------------------------------------------
                    
                    [self showcardfrontviewintableview];
                    self.isCardFetchCalled=YES;
					[services suspendCard:self action:@selector(suspendResponse:) suspendCardRequest:suspendCardReq];
                     */
					[self backCardIntoTable];
                    //	}
                }
                else {
                    
                    [imgOnline setImage:[UIImage imageNamed:@"offline.png"]];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:networkconnectiontitle message:networkconnectionmessage  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    //[self backCardIntoTable];
                    
                    [self killHUD];
                    
                }
            }
        }
        
        
        
        
    }
    
    
    
	
	if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Ok"])
	{
        [self showHUD:loadingaything];
        
        if (alertView.tag == 101) {
            if (buttonIndex == 0 ){
                
                [self killHUD];
                
              //  [appDelegate logout];
            }
        }
        
        if (alertView.tag == 000) {
            if (buttonIndex == 0 ){
                [self killHUD];
                
                
            }
        }
        
        
        
        
        if(alertView.tag == 10)
        {
            if(buttonIndex == 0)
            {
               // [appDelegate logout];
                [self.view removeFromSuperview];
            }
        }
    }
} /// end alertView




#pragma mark - Webservice handler ----------------------------------------------



//Handles the response of the getCardsInWallet
-(void)getCardsInWalletDetailedHandler:(id) value
{
    self.isCardFetchCalled=NO;
    self.lblBackAlertTitle.textColor=[UIColor blackColor];
    self.lblBackAlertSubTitle.textColor=[UIColor blackColor];
    //-----------------  stop waiting ------------------------
    [self killHUD];
	
    //--------------------------------------------------------
    
    [self.tableMyWallet setContentOffset:CGPointMake(0, 0) animated:YES];
    

	// Handle errors
	if([value isKindOfClass:[NSError class]])
    {
		NSLog(@"%@", value);
        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
	}
	
	// Handle faults
	if([value isKindOfClass:[SoapFault class]])
    {
		NSLog(@"%@", value);
        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
		return;
	}
	   
    YPGetCardsInWalletDetailedResponse *result=[[YPGetCardsInWalletDetailedResponse alloc] init];
    NSLog(@"value is %@",value);
    [result parsingGetCards:value]; 
    
    
    
   
	if(result.statusCode == 0)
	{
       
        UILabel *lblStatusOfOperation=[[UILabel alloc] initWithFrame:CGRectMake(55, self.tableMyWallet.frame.origin.y+self.tableMyWallet.frame.size.height-20, 195, 30)];
        lblStatusOfOperation.backgroundColor=[UIColor darkGrayColor];
        lblStatusOfOperation.textColor=[UIColor whiteColor];
        
        lblStatusOfOperation.font=[UIFont fontWithName:labelregularFont size:17.0];
        lblStatusOfOperation.layer.cornerRadius=10;
        lblStatusOfOperation.textAlignment=NSTextAlignmentCenter;
        if ([strButtonSelected isEqualToString:@"delete"]) {
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"" message:successfullydeleted delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
            
            
        }
        else if ([strButtonSelected isEqualToString:@"suspend"]){
            
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"" message:successfullysuspend delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            
            
        }
        else if ([strButtonSelected isEqualToString:@"reactive"]){
            
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"" message:successfullyreactivated delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            
            
        }
        else{
          
            
        }
        
		@try {
            NSLog(@"==inside Success=========================");
            //Added by Ankit jain 18/oct/2013
            NSString *operationstr= [[NSUserDefaults standardUserDefaults] objectForKey:@"operationfinder"];
            NSLog(@"value of operation %@",operationstr);
            int cardcount=[result.cardDetailedList count]-2;
            NSLog(@"value of operation is %@",operationstr);
            NSLog(@"CArd detaillist is %@",result.cardDetailedList);
            if(cardcount==1&&[operationstr isEqualToString:@"addopration"])
            {
                NSLog(@"add new card");
            }
            else
            {
                if(cardcount!=1||(cardcount==1&&[operationstr isEqualToString:@"deleteopration"])||(cardcount==1&&[operationstr isEqualToString:@"suspendopration"])||(cardcount==1&&[operationstr isEqualToString:@"reactivateopration"]))
                {
                    NSString *deleteQuery = @"delete from CardDetails where userid = ";
                    deleteQuery = [deleteQuery stringByAppendingString:appDelegate.userID];
                    [DataBase deleteDataFromTable:deleteQuery];
                }
            }
            
            
       		
          //  NSLog(@"Total Number of Card is %d",[result.cardDetailedList count]);
            NSLog(@"carddetailedlist is %@",result.cardDetailedList);
            NSLog(@"value of update tim estamp %@",result.updateDatetimestamp);
			
			NSString *query = @"Select CardDetails from UpdateDateTimeStamp where userid = ";
			query = [query stringByAppendingString:[NSString stringWithFormat:@"%@",appDelegate.userID]];
			if ([DataBase getNumberOfRowsForQuery:query] > 0) {
				NSString *updateQueryForUpdateDateTime = @"Update UpdateDateTimeStamp set CardDetails = ";
				updateQueryForUpdateDateTime = [updateQueryForUpdateDateTime stringByAppendingString:[NSString stringWithFormat:@"'%@' where userid = %@",result.updateDatetimestamp,appDelegate.userID]];
				[DataBase UpadteTable:updateQueryForUpdateDateTime];
                NSLog(@"==========================Update Time Stamp=======");
                
			}
			else {
				NSLog(@"Insert into UpdateDateTimeStamp...%@...%@",result.updateDatetimestamp,appDelegate.userID);
				NSString *insertIntoUpdateDateTime = @"Insert into UpdateDateTimeStamp(CardDetails,userid) values(";
				insertIntoUpdateDateTime = [insertIntoUpdateDateTime stringByAppendingString:[NSString stringWithFormat:@"'%@',%@)",result.updateDatetimestamp,appDelegate.userID]];
				[DataBase InsertIntoTable:insertIntoUpdateDateTime];
                NSLog(@"update timestamp %@",result.updateDatetimestamp);
			}
            NSLog(@"update timestamp %@",result.updateDatetimestamp);
			//NSLog(@"Value of card details is =====%d",[result.cardDetailedList count]);
            NSLog(@"Value of card details is =====%@",result.cardDetailedList );
           
            
            
            for (int i =0; i< [result.cardDetailedList count]; i++)
            {
                NSLog(@"inside a loop value of i=%d and value of resultdetail is %lu",i,(unsigned long)[result.cardDetailedList count]);
                
                 // work point-----  YPCardInWalletDetailed ------ CardDetailsData ------//
                
                CardDetailsData *cardDetails = (CardDetailsData*)[result.cardDetailedList objectAtIndex:i];
                NSString *imageName = @"";
              
                
                //for Image ===========================================
                
                if(![[cardDetails.issuerImageURL uppercaseString] isEqualToString:@"(NULL)"])
                {
                    NSArray *imageNameArray = [cardDetails.issuerImageURL componentsSeparatedByString:@"/"];
                    NSUInteger count = [imageNameArray count];
                    imageName = [imageNameArray objectAtIndex:count - 1];
                    NSLog(@"Image Name is %@",imageName);
                    
                    //Storing the image in Device
                    NSLog(@"Downloading...");
                    // Get an image from the URL below
                    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:cardDetails.issuerImageURL]]];
                    
                    NSLog(@"%f,%f",image.size.width,image.size.height);
                    
                    // Let's save the file into Document folder.
                    
                    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                    
                    // If you go to the folder below, you will find those pictures
                    NSLog(@"%@",docDir);
                    
                    NSLog(@"saving png");
                    
                    NSString *pngFilePath = [NSString stringWithFormat:@"%@/%@",docDir,imageName];
                    NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(image)];
                    
                    NSLog(@"datat legnth is %@",data1);
                    
                    if (data1.length==0)
                    {
                        //1 for visa....
                        UIImage *image=[[UIImage alloc] init];
                        if ([cardDetails.issuerName isEqualToString:@"Visa"]) {
                            image= [UIImage imageNamed:@"icon_visa.png"];
                        }
                        else if([cardDetails.issuerName isEqualToString:@"MasterCard"]){
                            image = [UIImage imageNamed:@"icon_mastercard.png"];
                        }
                        else{
                            image = [UIImage imageNamed:@"icon_cards_35_23.png"];
                        }
                        data1 = [NSData dataWithData:UIImagePNGRepresentation(image)];
                    }
                    
                    
                    [data1 writeToFile:pngFilePath atomically:YES];
                }
                //end of image ===========================================
                
                
                //Added by Ankit jain 18/oct/2013 for update query
                
                NSString *operationstr= [[NSUserDefaults standardUserDefaults] objectForKey:@"operationfinder"];
                if([operationstr isEqualToString:@"updateopration"])
                {
                    //update querycode
                    updateQuery = @"Update CardDetails set cardreferance =";
                    updateQuery = [updateQuery stringByAppendingString:[NSString stringWithFormat:@"'%@'",cardDetails.cardReferance]];
                    updateQuery = [updateQuery stringByAppendingString:[NSString stringWithFormat:@",cardname = '%@'", cardDetails.cardname]];
                    updateQuery = [updateQuery stringByAppendingString:[NSString stringWithFormat:@",cardholdername = '%@'",cardDetails.cardholdername]];
                    updateQuery = [updateQuery stringByAppendingString:[NSString stringWithFormat:@",postcode = '%@'",cardDetails.postcode]];
                    updateQuery = [updateQuery stringByAppendingString:[NSString stringWithFormat:@",country = '%@'",cardDetails.country]];
                    
                    if(![cardDetails.startdate isEqualToString:@"(null)"])
                    {
                        updateQuery = [updateQuery stringByAppendingString:[NSString stringWithFormat:@",startdate = '%@'",cardDetails.startdate]];
                    }
                    
                    if([cardDetails.email1 length]>0)
                    {
                        updateQuery = [updateQuery stringByAppendingString:[NSString stringWithFormat:@", email1= '%@'",cardDetails.email1]];
                    }
                    
                    if([cardDetails.address1 length]!=0)
                    {
                        updateQuery = [updateQuery stringByAppendingString:[NSString stringWithFormat:@",address1 = '%@'",cardDetails.address1]];
                    }
                    
                    if([cardDetails.city length]>0)
                    {
                        updateQuery = [updateQuery stringByAppendingString:[NSString stringWithFormat:@",city = '%@'",cardDetails.city]];
                    }
                    
                    if([cardDetails.phone1 length]>0)
                    {
                        updateQuery = [updateQuery stringByAppendingString:[NSString stringWithFormat:@",phone1 = '%@'",cardDetails.phone1]];
                    }
                    
                    if([cardDetails.address2 length]>0)
                        updateQuery = [updateQuery stringByAppendingString:[NSString stringWithFormat:@",address2 = '%@'",cardDetails.address2]];
                    
                    if([cardDetails.fax1 length]>0)
                    {
                        updateQuery = [updateQuery stringByAppendingString:[NSString stringWithFormat:@",fax1 = '%@'",cardDetails.fax1]];
                    }
                    
                    if([cardDetails.country length]>0)
                    {
                        
                        updateQuery = [updateQuery stringByAppendingString:[NSString stringWithFormat:@",fax1 = '%@'",cardDetails.country]];
                    }
                    
                    updateQuery = [updateQuery stringByAppendingString:[NSString stringWithFormat:@"where userid = %@ and cardreferance =%@",appDelegate.userID,cardDetails.cardReferance]];
                    
                    [DataBase UpadteTable:updateQuery];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@"normal" forKey:@"operationfinder"];
                }
                else{
                    //insert card details
                    
                    NSString *insertQuery = @"insert into CardDetails(cardreferance,cardnumber,cardname,status,issuername,expirydate,userid,status,imagename";
                    NSMutableString *expiryDate = [NSMutableString stringWithFormat:@"%@",cardDetails.expiryDate];
                    
                    NSString *insertQueryValues = @" values(";
                    
                    insertQueryValues = [insertQueryValues stringByAppendingString:
                                         [NSString stringWithFormat:@"'%@','%@','%@','%@','%@','%@',%@,'%@','%@'",
                                          cardDetails.cardReferance,cardDetails.cardnumber,cardDetails.cardname,cardDetails.cardStatus,cardDetails.issuerName,
                                          expiryDate,appDelegate.userID,cardDetails.cardStatus,imageName]];
                    
                    NSString *str=	[cardDetails.cardholdername stringByReplacingOccurrencesOfString:@"'" withString:@""];
                    insertQuery = [insertQuery stringByAppendingString:@",cardholdername"];//stop....tempeorary--
                    NSLog(@"strrrrrrrrrrrrrr..%@",str);
                    insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",'%@'",str]];
                    
                    
                    if(![cardDetails.cardissuenumber isEqualToString:@"(null)"])
                    {
                        insertQuery = [insertQuery stringByAppendingString:@",cardissuenumber"];
                        insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",'%@'",cardDetails.cardissuenumber]];
                    }
                    if(![cardDetails.startdate isEqualToString:@"(null)"])
                    {
                        insertQuery = [insertQuery stringByAppendingString:@",startDate"];
                        insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",'%@'",cardDetails.startdate]];
                        
                    }
                    NSString *str1=cardDetails.address1;
                    
                    if( [str1 length]>0)
                    {
                        insertQuery = [insertQuery stringByAppendingString:@",address1"];
                        insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",\"%@\"",cardDetails.address1]];
                        
                    }
                    NSString *str2=cardDetails.address2;
                    
                    if([str2 length]>0)
                    {
                        insertQuery = [insertQuery stringByAppendingString:@",address2"];
                        insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",\"%@\"",cardDetails.address2]];
                    }
                    
                    if([cardDetails.city length]>0)
                    {
                        insertQuery = [insertQuery stringByAppendingString:@",city"];
                        insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",\"%@\"",cardDetails.city]];
                    }
                    
                    NSLog(@"card details countryyyyy..%@",cardDetails.country);
                    if([cardDetails.country length]>0)
                    {
                        insertQuery = [insertQuery stringByAppendingString:@",country"];
                        insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",\"%@\"",cardDetails.country]];
                    }
                    
                    
                    if([cardDetails.postcode length]>0)
                    {
                        insertQuery = [insertQuery stringByAppendingString:@",postcode"];
                        insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",\"%@\"",cardDetails.postcode]];
                    }
                    
                    if([cardDetails.phone1 length]>0)
                    {
                        insertQuery = [insertQuery stringByAppendingString:@",phone1"];
                        insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",\"%@\"",cardDetails.phone1]];
                    }
                    
                    if([cardDetails.fax1 length]>0)
                    {
                        insertQuery = [insertQuery stringByAppendingString:@",fax1"];
                        insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",\"%@\"",cardDetails.fax1]];
                    }
                    
                    if([cardDetails.email1 length]>0)
                    {
                        insertQuery = [insertQuery stringByAppendingString:@",email1"];
                        insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",\"%@\"",cardDetails.email1]];
                    }
                    
                    insertQuery = [insertQuery stringByAppendingString:@",fundtransferallowed"];
                    insertQueryValues = [insertQueryValues stringByAppendingString:[NSString stringWithFormat:@",\"%@\"",cardDetails.fundtransferallowed]];
                    
                    insertQuery = [insertQuery stringByAppendingString:[NSString stringWithFormat:@")%@)",insertQueryValues]];
                    
                    NSLog(@"Insert Query is %@",insertQuery);
                    [DataBase InsertIntoTable:insertQuery];
                }
            }
           
            //=========
            
            
            NSLog(@"Hello");
            
            NSLog(@"databse row count is %d",[DataBase getNumberOfRows:@"CardDetails"]);
            
            
            
            if([DataBase getNumberOfRows:@"CardDetails"] > 0)
            {
                
                NSLog(@"inside a card detail array ");
                
                NSString *query = @"Select * from CardDetails where userid = ";
                query = [query stringByAppendingString:appDelegate.userID];
                
                NSMutableArray *temp=[DataBase getCardDetailsTableData:query];
                [resultArray removeAllObjects];
                //card details Senario
                for (int i=0;i< [temp count]; i++)
                {
                    
                    if(![((CardDetailsData*)[temp objectAtIndex:i]).cardStatus isEqualToString:@"Deleted"]){
                        
						[resultArray addObject:[temp objectAtIndex:i]];
                    }
                }
                NSLog(@"in status 2 update detaILS	..%@",((CardDetailsData*)[resultArray objectAtIndex:0]).fax1);
                
                if (resultArray.count==1 || resultArray.count==0) {
                    lblCardIn.text=@"Card In";
                }
                else{
                    
                    lblCardIn.text=@"Cards In";
                    
                }
                
                if (resultArray.count==1 || resultArray.count==0) {
                    lblCardIn.text=@"Card In";
                }
                else{
                    
                    lblCardIn.text=@"Cards In";
                    
                }
                
                lblCardCount.text=[NSString stringWithFormat:@"%lu",(unsigned long)resultArray.count];
                
                
                if (resultArray.count==0)
                {
                    self.tableMyWallet.hidden=YES;
                    self.lblBackAlertTitle.hidden=NO;
                    self.lblBackAlertSubTitle.hidden=NO;
                    
                }
                else
                {
                    self.tableMyWallet.hidden=NO;
                    self.lblBackAlertTitle.hidden=YES;
                    self.lblBackAlertSubTitle.hidden=YES;
                    
                }
                
                [self.tableMyWallet reloadData];
                
                //???ajeet
                
                int i = [resultArray count];
                NSLog(@"value of array count is %d",i);
                for (; i >= 0; i--) {
                    NSIndexPath *middleIndexPath;
                    middleIndexPath = [NSIndexPath indexPathForRow:(i-1) inSection:0];
                    UITableViewCell *cell = [self.tableMyWallet cellForRowAtIndexPath:middleIndexPath];
                    [self.tableMyWallet sendSubviewToBack:cell];
                }
                
                
            }
			
        }@catch (NSException * e) {
            
            NSLog(@"catch");
		}
		@finally {
            
            if([resultArray count]==0)
            {
                
                if (resultArray.count==1 || resultArray.count==0) {
                    lblCardIn.text=@"Card In";
                }
                else{
                    
                    lblCardIn.text=@"Cards In";
                    
                }
                lblCardCount.text=[NSString stringWithFormat:@"%lu",(unsigned long)resultArray.count];
                
                
                if (resultArray.count==0)
                {
                    self.tableMyWallet.hidden=YES;
                    self.lblBackAlertTitle.hidden=NO;
                    self.lblBackAlertSubTitle.hidden=NO;
                    
                }
                else
                {
                    self.tableMyWallet.hidden=NO;
                    self.lblBackAlertTitle.hidden=YES;
                    self.lblBackAlertSubTitle.hidden=YES;
                    
                }
                [self.tableMyWallet reloadData];
            }
            
		}
		
	}
	else if (result.statusCode==2){
        
		if([DataBase getNumberOfRows:@"CardDetails"] > 0)
		{
			NSString *query = @"Select * from CardDetails where userid = ";
			query = [query stringByAppendingString:appDelegate.userID];
			NSMutableArray *temp=[DataBase getCardDetailsTableData:query];
			
            [resultArray removeAllObjects];
			
			for (int i=0;i< [temp count]; i++) {
				
				if(![((CardDetailsData*)[temp objectAtIndex:i]).cardStatus isEqualToString:@"Deleted"]){
                    [resultArray addObject:[temp objectAtIndex:i]];
				}
			}
			if (resultArray.count==1 || resultArray.count==0) {
                lblCardIn.text=@"Card In";
            }
            else{
                
                lblCardIn.text=@"Cards In";
                
            }
            
            
            lblCardCount.text=[NSString stringWithFormat:@"%lu",(unsigned long)resultArray.count];
            
            
            if (resultArray.count==0)
            {
                self.tableMyWallet.hidden=YES;
                self.lblBackAlertTitle.hidden=NO;
                self.lblBackAlertSubTitle.hidden=NO;
                
            }
            else
            {
                self.tableMyWallet.hidden=NO;
                self.lblBackAlertTitle.hidden=YES;
                self.lblBackAlertSubTitle.hidden=YES;
                
            }
			[self.tableMyWallet reloadData];
			int i = [resultArray count];
			for (; i >= 0; i--) {
				
				NSIndexPath *middleIndexPath;
				middleIndexPath = [NSIndexPath indexPathForRow:(i-1) inSection:0];
				UITableViewCell *cell = [tableMyWallet cellForRowAtIndexPath:middleIndexPath];
				[self.tableMyWallet sendSubviewToBack:cell];
			}
		}
	}
	else
    {
        [self cardholderalertmessages:result.statusCode message:result.responseMessage];
    }
    
    
}
//Added by Ankit Jain 6/dec/2013
-(void)cardholderalertmessages:(int)statuscodevalue message:(NSString *)responsemessage
{
    switch (statuscodevalue)
    {
        case 1:
            NSLog (@"zero");
            [self commonalert:nil message:statuscode1];
            break;
        case 4:
            NSLog (@"one");
            [self commonalert:nil message:statuscode4];
            break;
        case 6:
            NSLog (@"six");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SessionExpired" object:self];
            break;
        case 7:
            NSLog (@"seven");
            [self commonalert:nil message:statuscode7];
            break;
        case 9:
            NSLog (@"nine");
            [self commonalert:nil message:statuscode9];
            break;
        case 10:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SessionExpired" object:self];
            break;
            
        case 12:
            NSLog (@"tweleve");
            [self commonalert:nil message:statuscode12];
            break;
        case 15:
            NSLog (@"fifteen");
            [self commonalert:nil message:statuscode15];
            break;
        case 16:
            NSLog (@"sisxteen");
            [self commonalert:nil message:statuscode16];
            break;
        case 17:
            NSLog (@"four");
            [self commonalert:nil message:statuscode17];
            break;
        case 18:
            NSLog (@"five");
            [self commonalert:nil message:statuscode18];
            break;
        case 21:
            NSLog (@"twenty one");
            [self commonalert:nil message:statuscode21];
            break;
        case 27:
            NSLog (@"twenty seven");
            [self commonalert:nil message:statuscode27];
            break;
        case 30:
            NSLog (@"thirty");
            [self commonalert:nil message:statuscode30];
            break;
        case 33:
            NSLog (@"thirty three");
            [self commonalert:nil message:statuscode33];
            break;
            
            
        default:
            NSLog (@"Integer out of range");
            [self commonalert:nil message:[NSString stringWithFormat:@"%@\n[Error code:%d]",responsemessage,statuscodevalue]];
            break;
    }
    
}
-(void)commonalert:(NSString *)title message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert setTag:000];
    [alert show];
}


-(void) deleteResponse: (id) value{
    
    // -------------- wait end --------------------
    
    [self killHUD];
    
    // --------------------------------------------
    
    // Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [self killHUD];
		return;
	}
	
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		
		NSLog(@"%@", value);
        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [self killHUD];
		return;
	}
  
    YPRemoveCardResponse *objRemoveCardResponse=[[YPRemoveCardResponse alloc] init];
    [objRemoveCardResponse parsingDeleteCard:value];
    
		
	@try {
        
//        // Do something with the YPLoginResponse* result
//        YPRemoveCardResponse *result = (YPRemoveCardResponse*)value;
//        
//        
//        NSLog(@"MycardViewConretoll......Status Code...of deleteresponse..%d",result.statusCode);
//        if(result.statusCode == 0)
//        {
//		 	strButtonSelected=@"delete";
//            [[NSUserDefaults standardUserDefaults] setObject:@"deleteopration" forKey:@"operationfinder"];
//            
//            
//            [self callWebserviceForCards:NO];
//            
//        }
//        else{
//            [self killHUD];
//            [self cardholderalertmessages:result.statusCode message:result.responseMessage];
//            
//        }
		
	}
	@catch (NSException * e) {
        NSLog(@"catch");
        
        
	}
	@finally {
        
        NSLog(@"finally");
		
        
	}
}

-(void) reactivateResponse:(id) value
{
	
    
    /*
     
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}
	
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
		return;
	}
	
	@try{
        // Do something with the YPLoginResponse* result
        YPSuspendCardResponse *result = (YPSuspendCardResponse*)value;
        NSLog(@"MycardViewConretoll......Status Code...of reactivateResponse..%d",result.statusCode);
        if(result.statusCode == 0)
        {
            strButtonSelected=@"reactive";
            [[NSUserDefaults standardUserDefaults] setObject:@"reactivateopration" forKey:@"operationfinder"];
            
            [self callWebserviceForCards:NO];
            
        }
        else{
            [self cardholderalertmessages:result.statusCode message:result.responseMessage];
        }
    }
    @catch (NSException * e) {
        
    }
    @finally {
        
    }
     
     */
}

-(void) suspendResponse:(id) value
{
    
    /*
    // Handle errors
	if([value isKindOfClass:[NSError class]]) {
        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
		NSLog(@"%@", value);
		return;
	}
	
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
		return;
	}
	
	@try{
        // Do something with the YPLoginResponse* result
        YPSuspendCardResponse *result = (YPSuspendCardResponse*)value;
        NSLog(@"MycardViewConretoll......Status Code...of Suspend Response..%d",result.statusCode);
        if(result.statusCode == 0)
        {
            strButtonSelected=@"suspend";
            
            [[NSUserDefaults standardUserDefaults] setObject:@"suspendopration" forKey:@"operationfinder"];
            [self callWebserviceForCards:NO];
        }
        else{
            [self cardholderalertmessages:result.statusCode message:result.responseMessage];
        }
        
    }
    @catch (NSException * e) {
        
    }
    @finally {
        
    }
     */
}

-(void)goBackToMore
{
	[self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - UILabel size methods ----------------------------

/*- (int)lineCountForLabel:(UILabel *)label
{
    CGSize constrain = CGSizeMake(label.bounds.size.width, 1000000);
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:constrain lineBreakMode:UILineBreakModeWordWrap];
    
    return ceil(size.height / label.font.lineHeight);
}
- (CGSize)sizeForLabel:(UILabel *)label
{
    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
    
    CGSize expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
    
    //adjust the label the the new height.
    CGRect newFrame = label.frame;
    newFrame.size.height = expectedLabelSize.height;
    return newFrame.size;
    
    
}*/



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
#pragma mark - drawerbackbutton
- (void)_addRightTapped:(id)sender {
    NSLog(@"tapp me");
    
    [self.sidePanelController toggleLeftPanel:sender];
    [self.view endEditing:YES];
    // self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[JACenterViewController alloc] init]];
}


@end
