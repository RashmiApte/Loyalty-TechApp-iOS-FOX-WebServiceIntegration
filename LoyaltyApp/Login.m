//
//  Login.m
//  LoyaltyApp
//
//  Created by Ajeet Sharma on 2/24/14.
//
//

#import "Login.h"
#import "SettingCountryCurrency.h"
#import "ForgetPassword.h"
#import "Common.h"
#import "Constant.h"
#import "WebserviceOperation.h"
#import "YPLoginResponse.h"
#import "YPLoginRequest.h"
#import "YPLoginResponse.h"
#import "LoginData.h"
#import "DataBase.h"
#import "YPLogoutResponse.h"
#import <CommonCrypto/CommonDigest.h>
#import "MyCardsViewController.h"
#import "MoreViewController.h"
#import "JASidePanelController.h"
#import "LeftPanelViewController.h"
#import "AboutUsViewController.h"
#import "ActiveCampaginViewController.h"
#import "AddNewCardInWalletViewController.h"
#import "HomeViewController.h"
#import "JASidePanelController.h"




@interface Login ()

@end

@implementation Login
@synthesize txtEmailId,txtPassword;
@synthesize btnForgetPassword,btnHome,btnLogin,btnSetting;
@synthesize imgBottomImage;
@synthesize imgOnline;
@synthesize LogintabBarController;
@synthesize lblBorderPassword,lblBorderEmailId;
@synthesize jaSidePanelobj;





#pragma mark - UIViewcontroller delegates ----------------------------------------


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appdelegate=(CAppDelegate*)[UIApplication sharedApplication].delegate;
   
      //-----------------  set text field properties -----------------
	
    txtEmailId.clearButtonMode= UITextFieldViewModeWhileEditing;
    txtPassword.clearButtonMode=UITextFieldViewModeWhileEditing;
  
    txtEmailId.returnKeyType = UIReturnKeyNext;
    txtPassword.returnKeyType=UIReturnKeyDone;
    
    //------------------------------------------------------------------------------

    if ([UIScreen mainScreen].bounds.size.height != 568)
    {
        imgBottomImage.frame=CGRectMake(0, 320, 320, 140);
        imgOnline.frame=CGRectMake(258, 375, 42, 9);
        
    }
    
    
    btnHome.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(14.0)];
    [btnHome.titleLabel setTextColor:btntextColor];
    
    txtEmailId.font=textFieldTextFont;
    txtPassword.font=textFieldTextFont;
    
    lblBorderPassword.layer.borderColor=[UIColor clearColor].CGColor;
    lblBorderPassword.layer.borderWidth=1.0;
    lblBorderPassword.layer.cornerRadius=5.0;
    
    lblBorderEmailId.layer.borderColor=[UIColor clearColor].CGColor;
    lblBorderEmailId.layer.borderWidth=1.0;
    lblBorderEmailId.layer.cornerRadius=5.0;

    

    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{

    //-------------------------- Save userid  --------------------------------------
    
	NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
	//appdelegate.lastUserID =token;
	NSLog(@"Last Mail ID %@",token);
    
	if (![token isEqualToString:@"(null)"]&& token!=nil && token!=Nil && token.length!=0) {
		txtEmailId.text = token;
		//appdelegate.lastUserID =token;
	}
    
	//------------------------------------------------------------------------------
   txtPassword.text=@"";

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Button methods -----------------------------------------------------


-(IBAction)loginButton:(id)sender{

    
    
    if ([[txtEmailId.text stringByReplacingOccurrencesOfString:@" " withString:@""] length]==0 ) {
       
        // validemailid=@"Please enter the correct Email Address.";
        
        lblBorderEmailId.layer.borderColor=[UIColor redColor].CGColor;
        lblBorderPassword.layer.borderColor=[UIColor clearColor].CGColor;

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:unabletologinntitle message:emailentr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [txtEmailId becomeFirstResponder];
        
    }
    else{
        if([self validateEmail:txtEmailId.text]!=TRUE)
        {
            
            lblBorderEmailId.layer.borderColor=[UIColor redColor].CGColor;
            lblBorderPassword.layer.borderColor=[UIColor clearColor].CGColor;


            //validemailid=@"Please enter the correct Email Address.";

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:unabletologinntitle message:validemailid delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [txtEmailId becomeFirstResponder];
        }
        else{
            
            if ([[txtPassword.text stringByReplacingOccurrencesOfString:@" " withString:@""] length]==0)
            {
                //alertmessagestr=@"Please enter password.";

                lblBorderPassword.layer.borderColor=[UIColor redColor].CGColor;
                lblBorderEmailId.layer.borderColor=[UIColor clearColor].CGColor;

                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:unabletologinntitle message:enterpwd delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
                [txtPassword becomeFirstResponder];
            }
            else{
                

                if([Common isNetworkAvailable])
                {
                    imgOnline.image=[UIImage imageNamed:@"online.png"];

                    WebserviceOperation *serviceLogin=[[WebserviceOperation alloc] initWithDelegate:self callback:@selector(loginHandler:)];
                    
                    YPLoginRequest *loginRequest=[[YPLoginRequest alloc] init];
                    
                    //------------- set request parameters ---------------------------
                    loginRequest.userName=txtEmailId.text;
                    loginRequest.password=txtPassword.text;
                    loginRequest.role = @"C";
                    loginRequest.valid = TRUE;
                    loginRequest.applicationType = @"M";
                    //----------------------------------------------------------------
                    
                    
                    // ------------- waiting -----------------------------------------
                    
                    [self showHUD:loginhud];
                    
                    //----------------------------------------------------------------

                    
                   [serviceLogin login:loginRequest];
                    /*AddNewCardInWalletViewController *addnewcard=[[AddNewCardInWalletViewController alloc]initWithNibName:@"AddNewCardInWalletViewController" bundle:nil];
                    [self.navigationController pushViewController:addnewcard animated:YES];*/
                    

                    
                    
                }
                else
                {


                    imgOnline.image=[UIImage imageNamed:@"offline.png"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:txtEmailId.text forKey:@"userName"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                   
                   
                   
                     NSString *enString=[self sha256:txtPassword.text];
                    
                    if([DataBase getNumberOfRows:@"Login"] > 0)
                    {
                        
                        NSString *query =@"select * from Login where username = '";
                        query = [query stringByAppendingString:[NSString stringWithFormat:@"%@' and password = '%@'",txtEmailId.text,enString]];
                        
                        NSMutableArray *resultsArray = [DataBase getLoginTableData:query];
                        
                        
                        if([resultsArray count] == 0)
                        {
                            UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:unabletologinntitle message:networkconnectionmessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [alert show];
                        }
                        else
                        {
                            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isNewSessionUserInfo"];
                            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isNewSessionAddress"];
                            appdelegate.userID = ((LoginData*)[resultsArray objectAtIndex:0]).uid;
                            appdelegate.userName=((LoginData*)[resultsArray objectAtIndex:0]).username;
                            appdelegate.SC= [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"securityCodeLogin"]];
                            
                            NSLog(@"//---------- offline login success ----->>>>>>>>>>>>>>>>>>>>");
                            
                            [self createCustomeTabbar];
                            
                        }
                    }
                    else {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:unabletologinntitle message:networkconnectionmessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                    }
                    
                }
            }
            
        }
    }

    
   
    

}
-(IBAction)settingButton:(id)sender{

    SettingCountryCurrency *objSetting=[[SettingCountryCurrency alloc] init];
    objSetting.isPushFromLogin=YES;
    [self.navigationController pushViewController:objSetting animated:YES];

}
-(IBAction)homeButton:(id)sender{
 
    
    for (UIViewController *controller in [self.navigationController viewControllers])
    {
        if ([controller isKindOfClass:[HomeViewController class]])
        {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }
    

   
}
-(IBAction)forgetPasswordButton:(id)sender{

    ForgetPassword *objForgetPassword=[[ForgetPassword alloc] init];
    [self.navigationController pushViewController:objForgetPassword animated:YES];

}

#pragma mark - Other methods  ------------------------------------------------

-(void)createCustomeTabbar{
    
   /* //------------- first tabbar ------------------------------
    
    UINavigationController *navigationMywallet;
    navigationMywallet = [[UINavigationController alloc] init];
    [navigationMywallet.navigationBar setTintColor:[UIColor blackColor]];
    
    MyCardsViewController *objMycard;
    objMycard = [[MyCardsViewController alloc] init];
    
    
    navigationMywallet.viewControllers = [NSArray arrayWithObjects:objMycard, nil];
    
    self.LogintabBarController = [[UITabBarController alloc] init];
    
    
    UIImage *imgTab1 = [UIImage imageNamed:@"icon_my_wallet_active"];
    [navigationMywallet.tabBarItem initWithTitle:@"My Wallet" image:imgTab1 tag:0];
    
    //-------------//-------------//-------------//-------------
    
    //------------- Second tabbar ------------------------------
    
    UINavigationController *navigationMore;
    navigationMore = [[UINavigationController alloc] init];
    [navigationMore.navigationBar setTintColor:[UIColor blackColor]];
    
    MoreViewController *objMore;
    objMore = [[MoreViewController alloc] init];
    
    
    
    UIImage *imgTab2= [UIImage imageNamed:@"icon_more_active"];
    [navigationMore.tabBarItem initWithTitle:@"More" image:imgTab2 tag:1];
    
    //-------------//-------------//-------------//-------------
    
    
    
    navigationMore.viewControllers = [NSArray arrayWithObjects:objMore, nil];
    
    self.LogintabBarController.viewControllers = [NSArray arrayWithObjects:navigationMywallet,navigationMore,nil];
    self.LogintabBarController.selectedIndex=0;
    [self.navigationController pushViewController:self.LogintabBarController animated:YES];*/
    
    
    NSUserDefaults *pushviewidentifire = [NSUserDefaults standardUserDefaults];
    if([pushviewidentifire objectForKey:@"pushview"]==nil)
    {
        NSLog(@"pushview value %@",pushviewidentifire);
        [pushviewidentifire setObject:@"fromloginview" forKey:@"pushview"];
    }
    else {
        NSLog(@"pushview value %@",pushviewidentifire);
        [pushviewidentifire removeObjectForKey:@"pushview"];
        [pushviewidentifire setObject:@"fromloginview" forKey:@"pushview"];
    }
    [pushviewidentifire synchronize];
    
    self.jaSidePanelobj = [[JASidePanelController alloc] init];
    self.jaSidePanelobj.shouldDelegateAutorotateToVisiblePanel = NO;
    
	self.jaSidePanelobj.leftPanel = [[LeftPanelViewController alloc] init];
    
	self.jaSidePanelobj.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[ActiveCampaginViewController alloc] init]];
    [self.navigationController pushViewController:self.jaSidePanelobj animated:YES];
    
    
    
    
    
}

-(NSString*) sha256:(NSString *)cipherPassword
{
    const char *s=[cipherPassword cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData=[NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(keyData.bytes, keyData.length, digest);
    NSData *out=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}



- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

-(void)commonalert:(NSString *)title message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert setTag:1234];
    [alert show];
}

-(void)cardholderalertmessages:(int)statuscodevalue message:(NSString *)responsemessage
{
    switch (statuscodevalue)
    {
        case 1:
            NSLog (@"zero");
            [self commonalert:unabletologinntitle message:statuscode1];
            break;
        case 4:
            NSLog (@"one");
            //[self commonalert:unabletologinntitle message:statuscode4];
            //Added by Sumit
            [self commonalert:@"User already Login.Please logout from logged in device first." message:statuscode4];
            break;
        case 6:
            NSLog (@"six");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SessionExpired" object:self];
            break;
        case 7:
            NSLog (@"seven");
            [self commonalert:unabletologinntitle message:statuscode7];
            break;
        case 9:
            NSLog (@"nine");
            [self commonalert:unabletologinntitle message:statuscode9];
            break;
        case 10:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SessionExpired" object:self];
            break;
            
        case 12:
            NSLog (@"tweleve");
            [self commonalert:unabletologinntitle message:statuscode12];
            break;
        case 15:
            NSLog (@"fifteen");
            [self commonalert:unabletologinntitle message:statuscode15];
            break;
        case 16:
            NSLog (@"sisxteen");
            [self commonalert:unabletologinntitle message:statuscode16];
            break;
        case 17:
            NSLog (@"four");
            [self commonalert:unabletologinntitle message:statuscode17];
            break;
        case 18:
            NSLog (@"five");
            [self commonalert:unabletologinntitle message:statuscode18];
            break;
        case 21:
            NSLog (@"twenty one");
            [self commonalert:unabletologinntitle message:statuscode21];
            break;
        case 27:
            NSLog (@"twenty seven");
            [self commonalert:unabletologinntitle message:statuscode27];
            break;
        case 30:
            NSLog (@"thirty");
            [self commonalert:unabletologinntitle message:statuscode30];
            break;
        case 33:
            NSLog (@"thirty three");
            [self commonalert:unabletologinntitle message:statuscode33];
            break;
            
            
        default:
            NSLog (@"Integer out of range");
            [self commonalert:unabletologinntitle message:[NSString stringWithFormat:@"%@\n[Error code:%d]",responsemessage,statuscodevalue]];
            break;
    }
}

#pragma mark - UIAlerview delegate -------------------------------------------

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    if (alertView.tag == 127) {
        
        if (buttonIndex == 0)
        {
			if([Common isNetworkAvailable])
			{
                
                WebserviceOperation *serviceLogout=[[WebserviceOperation alloc] initWithDelegate:self callback:@selector(logoutHandlers:)];
                
                YPLogoutRequest *objLogoutRequest=[[YPLogoutRequest alloc] init];
                objLogoutRequest.userName=txtEmailId.text;
                objLogoutRequest.applicationType=@"M";
                objLogoutRequest.role=@"C";
                [self showHUD:loginhud];

                [serviceLogout logout:objLogoutRequest];
                
                
//				YPCardHolderServiceService *services = [[YPCardHolderServiceService alloc] init];
//				YPLogoutRequest *logoutRequest = [[YPLogoutRequest alloc] init];
//				logoutRequest.userName = txtEmail.text;
//				logoutRequest.valid = TRUE;
//				logoutRequest.applicationType = @"M";
//				logoutRequest.role = @"C";
//                
//                [self showHUD:loginhud];
//                [services logout:self action:@selector(logoutHandlers:) logoutRequest:logoutRequest];
//				NSLog(@"Logout request is.....%@",logoutRequest);
//				[logoutRequest release];
//				[services release];
                
                
            }
        }
        else
        {
            txtPassword.text=@"";
            [self killHUD];
        }
        
    }
    else if(alertView.tag==1234){
    
       [txtEmailId becomeFirstResponder];
    
    }
	
}



#pragma mark - Webservice handler----------------------------------------------------

-(void)logoutHandlers:(id)value
{
    // ------------- waiting ------------------
    [self killHUD];
    
    //------------------------------------------
    
//	if([value isKindOfClass:[NSError class]]) {
//		
//		NSLog(@"%@", value);
//        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//		return;
//	}
//	
//	// Handle faults
//	if([value isKindOfClass:[SoapFault class]]) {
//		
//		NSLog(@"%@", value);
//        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//		return;
//	}
//	
	
	// Do something with the YPLoginResponse* result
	YPLogoutResponse* logoutResponse =[[YPLogoutResponse alloc] init];
    [logoutResponse parsingLogout:value];
    
    
    
	if(logoutResponse.statusCode == 0)
	{
		NSLog(@"Logout Successfully");
		if([Common isNetworkAvailable])
		{
			
            imgOnline.image=[UIImage imageNamed:@"online.png"];
            
            WebserviceOperation *serviceLogin=[[WebserviceOperation alloc] initWithDelegate:self callback:@selector(loginHandler:)];
            
            YPLoginRequest *loginRequest=[[YPLoginRequest alloc] init];
            
            //------------- set request parameters --------------
            loginRequest.userName=txtEmailId.text;
            loginRequest.password=txtPassword.text;
            loginRequest.role = @"C";
            loginRequest.valid = TRUE;
            loginRequest.applicationType = @"M";
            //---------------------------------------------------
            
            // ------------- waiting ------------------
            [self showHUD:loginhud];
            //------------------------------------------
            
            
            [serviceLogin login:loginRequest];
            
		}
		else {
			NSLog(@" NO network");
            imgOnline.image=[UIImage imageNamed:@"offline.png"];
			[Common ShowAlert:ConnectionErrorMessage alertTitle:ConnectionErrorTitle];
	    }
	}
    
}


-(void)loginHandler:(id)value
{

//    NSLog(@"loginHandler = %@",value);
    
    [self killHUD];
    
    
        //Handle error 
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
    
    
    
    
    YPLoginResponse *objLoginResponse=[[YPLoginResponse alloc] init];
    [objLoginResponse parsingLogin:value];
    
    NSLog(@"SC==== == == %@",objLoginResponse.SC);
    NSLog(@"LAST login date = %@",objLoginResponse.lastLoginDate);
    NSLog(@"LAST login time = %@",objLoginResponse.lastLoginTime);
    NSLog(@"responseMessage = %@",objLoginResponse.responseMessage);
    NSLog(@"statusCode = %d",objLoginResponse.statusCode);
    
    
    
    if(objLoginResponse.statusCode == 0 || objLoginResponse.statusCode == 27)
	{
		if (objLoginResponse.statusCode == 27)
        {
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:unabletologinntitle message:alreadyloginalert  delegate:self  cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel" , nil];
            [alertView setTag:127];
			[alertView show];
		}
		else {
            
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isNewSessionUserInfo"];
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isNewSessionAddress"];
            
			[[NSUserDefaults standardUserDefaults] setObject:txtEmailId.text forKey:@"userName"];
            [[NSUserDefaults standardUserDefaults] synchronize];     //???ajeet
            
            
            NSString  *enString=[self sha256:txtPassword.text];
            
            NSMutableArray *resultsArray = [[NSMutableArray alloc] init];
            [[NSUserDefaults standardUserDefaults] setObject:objLoginResponse.SC forKey:@"securityCodeLogin"];
            
            
            if([DataBase getNumberOfRows:@"Login"] > 0)
            {
                //Fetch Data for User ID
                
                NSString *query = @"select * from Login where username = '";
                query = [query stringByAppendingString:[NSString stringWithFormat:@"%@'",txtEmailId.text]];
                resultsArray = [DataBase getLoginTableData:query];
                
                NSLog(@"resultAtrray=====>%ld...... ",(unsigned long)[resultsArray count]);
                
                if ([resultsArray count] == 0)
                {

                    NSString *insertQuery = @"insert into Login(username,password) values(";
                    insertQuery = [insertQuery stringByAppendingString:[NSString stringWithFormat:@"'%@','%@')",txtEmailId.text,enString]];
                    [DataBase InsertIntoTable:insertQuery];
                    
                    //Fetch insert Data for User ID
                    NSString *query =@"select * from Login where username = '";
                    query = [query stringByAppendingString:[NSString stringWithFormat:@"%@' and password = '%@'",txtEmailId.text,enString]];
                    resultsArray = [DataBase getLoginTableData:query];
			    }
				else
                {
                    NSLog(@"SAME user LOGINNNNNNNNNNNNN");
                    
                    
				}
            }
            else
            {
                //First time user login thats why insert his data into login table
                NSString *insertQuery = @"insert into Login(username,password) values(";
                insertQuery = [insertQuery stringByAppendingString:[NSString stringWithFormat:@"'%@','%@')",txtEmailId.text,enString]];
                [DataBase InsertIntoTable:insertQuery];
                NSLog(@"enString.....%@",enString);

                NSString *query = @"select * from Login where username = '";
                query = [query stringByAppendingString:[NSString stringWithFormat:@"%@' and password = '%@'",txtEmailId.text,enString]];
                resultsArray = [DataBase getLoginTableData:query];
            }
            
          		
			appdelegate.userID = ((LoginData*)[resultsArray objectAtIndex:0]).uid;
			appdelegate.userName = ((LoginData*)[resultsArray objectAtIndex:0]).username;
            appdelegate.SC=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"securityCodeLogin"]];
            
               NSLog(@"//---------- online login success ----->>>>>>>>>>>>>>>>>>>>");
            [self createCustomeTabbar];
		}
        
    }
	else{
        
        [self cardholderalertmessages:objLoginResponse.statusCode message:objLoginResponse.responseMessage];
        [txtEmailId setText:@""];
		[txtPassword setText:@""];
		
	}

    
    
}
#pragma mark - UITextfield delegates -------------------------------------------------
-(BOOL)textFieldShouldReturn:(UITextField *)textField{


    [textField resignFirstResponder];
    [textField resignFirstResponder];
    
	if(textField==txtEmailId) {
		[txtEmailId resignFirstResponder];
		[txtPassword becomeFirstResponder];
	}
	else if(txtPassword==textField) {
		[txtPassword resignFirstResponder];
		[txtEmailId resignFirstResponder];
	}
	
    
    return YES;
    

}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (textField==txtEmailId) {
        lblBorderEmailId.layer.borderColor=[UIColor clearColor].CGColor;

    }
    else if (textField==txtPassword)
    {
        lblBorderPassword.layer.borderColor=[UIColor clearColor].CGColor;

    
    }

    return YES;
    
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
