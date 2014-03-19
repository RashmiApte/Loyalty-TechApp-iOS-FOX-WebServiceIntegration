//
//  MoreViewController.m
//  YesPayCardHolderWallet
//
//  Created by ankit on 10/22/13.
//
//

#import "MoreViewController.h"
#import "WebserviceOperation.h"
#import "YPLogoutRequest.h"
#import "YPLogoutResponse.h"
#import "SettingsViewController.h"
//#import "CardtoCardTransViewController.h"
//#import "MessageViewController.h"
#import "AboutUsViewController.h"
#import "ContactUsViewController.h"
#import "Common.h"
#import "Constant.h"
//#import "YPCardHolderServiceService.h"


@interface MoreViewController ()

@end

@implementation MoreViewController
//@synthesize moretabtableview,moretabarray;
@synthesize lblAboutUs,lblContactUs,lblLogout,lblSetting;
@synthesize btnAboutUs,btnContactUs,btnLogout,btnSetting;
@synthesize imgOnline;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - ViewController methods -----------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appdelegate=(CAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    self.navigationController.navigationBarHidden=YES;
    //--------------- header --------------------------------------------------------
    UIImageView* imgHeader = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_back.png"]];
    
    UILabel *tittlelable =[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 320, 23)];
    
    [tittlelable setFont:[UIFont fontWithName:labelregularFont size:22]];
    tittlelable.backgroundColor=[UIColor clearColor];
    tittlelable.textColor =headertitletextColor;
    tittlelable.textAlignment=NSTextAlignmentCenter;
    imgHeader.frame=CGRectMake(0, 0, 320, 53);
    [self.view addSubview:imgHeader];
    [self.view addSubview:tittlelable];
    //------------------------------------------------------------------------------
    
    
    
    tittlelable.text=@"More";
    
    lblPromotions.font =[UIFont fontWithName:labelregularFont size:20];
    lblSetting.font=[UIFont fontWithName:labelregularFont size:20];
    lblLogout.font =[UIFont fontWithName:labelregularFont size:20];
    lblContactUs.font=[UIFont fontWithName:labelregularFont size:20];
    lblAboutUs.font =[UIFont fontWithName:labelregularFont size:20];
    
    if ([UIScreen mainScreen].bounds.size.height != 568)
    {
        
        imgOnline.frame=CGRectMake(260, 399, 42, 9);
    }
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    if([Common isNetworkAvailable])
    {
        imgOnline.image=[UIImage imageNamed:@"online.png"];
    }
    else {
        imgOnline.image=[UIImage imageNamed:@"offline.png"];
    }
    [self.navigationController setNavigationBarHidden:YES];
    [btnPromotions setBackgroundImage:[UIImage imageNamed:@"cell_button_deselect.png"] forState:UIControlStateNormal];
    [btnAboutUs setBackgroundImage:[UIImage imageNamed:@"cell_button_deselect.png"] forState:UIControlStateNormal];
    [btnContactUs setBackgroundImage:[UIImage imageNamed:@"cell_button_deselect.png"] forState:UIControlStateNormal];
    [btnLogout setBackgroundImage:[UIImage imageNamed:@"cell_button_deselect.png"] forState:UIControlStateNormal];
    [btnSetting setBackgroundImage:[UIImage imageNamed:@"cell_button_deselect.png"] forState:UIControlStateNormal];
    
    [btnPromotions setBackgroundImage:[UIImage imageNamed:@"cell_button_select.png"] forState:UIControlStateHighlighted];
    [btnAboutUs setBackgroundImage:[UIImage imageNamed:@"cell_button_select.png"] forState:UIControlStateHighlighted];
    [btnContactUs setBackgroundImage:[UIImage imageNamed:@"cell_button_select.png"] forState:UIControlStateHighlighted];
    [btnLogout setBackgroundImage:[UIImage imageNamed:@"cell_button_select.png"] forState:UIControlStateHighlighted];
    [btnSetting setBackgroundImage:[UIImage imageNamed:@"cell_button_select.png"] forState:UIControlStateHighlighted];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UIAlerview delegate ---------------------------------------

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag ==4321)
	{
		if(buttonIndex ==1)
            
        {
            
            if([Common isNetworkAvailable])
            {
                
                
                WebserviceOperation *serviceLogout=[[WebserviceOperation alloc] initWithDelegate:self callback:@selector(logoutHandlers:)];
                
                YPLogoutRequest *objLogoutRequest=[[YPLogoutRequest alloc] init];
                objLogoutRequest.userName=[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
                objLogoutRequest.applicationType=@"M";
                objLogoutRequest.role=@"C";
                [self showHUD:loginhud];
                
                [serviceLogout logout:objLogoutRequest];
                
            }
            else
            {
                
                //skip
                
                appdelegate=(CAppDelegate*)[UIApplication sharedApplication].delegate;
                NSArray *arrayViewController=[appdelegate.navigationWindow viewControllers];
                [appdelegate.navigationWindow popToViewController:[arrayViewController objectAtIndex:arrayViewController.count-2] animated:YES];
                

                
                //  [appdelegate.navigationController popToViewController:[[appdelegate.navigationController viewControllers] objectAtIndex:1] animated:NO];
            }
            
            
            
        }
        // [appdelegate logouts];
		
	}
    
}

#pragma mark - Webservice handler -----------------------------------------------------------

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
        
        appdelegate=(CAppDelegate*)[UIApplication sharedApplication].delegate;
        NSArray *arrayViewController=[appdelegate.navigationWindow viewControllers];
        [appdelegate.navigationWindow popToViewController:[arrayViewController objectAtIndex:arrayViewController.count-2] animated:YES];
		
        
    }
    else{
        appdelegate=(CAppDelegate*)[UIApplication sharedApplication].delegate;
        NSArray *arrayViewController=[appdelegate.navigationWindow viewControllers];
        [appdelegate.navigationWindow popToViewController:[arrayViewController objectAtIndex:arrayViewController.count-2] animated:YES];

        
        
    }
    
}


#pragma mark - Button methods -------------------------------------------------------------

-(IBAction)btnTap:(UIButton *)sender{
    
    
    
    
    if (sender.tag==1) {
        NSLog(@"setting push");
        
                SettingsViewController *settingsview=[[SettingsViewController alloc] init];
        
                [self.navigationController pushViewController:settingsview animated:YES];
        
    }
    
    if (sender.tag==2) {
        
        NSLog(@"aboutus push");
        
               AboutUsViewController *aboutUsView= [[AboutUsViewController alloc] init];
        
        
        
               [self.navigationController pushViewController:aboutUsView animated:YES];
        
        
        
    }
    else if (sender.tag==3){
        
        NSLog(@"contactus push");
        
        
               ContactUsViewController *contactsView= [[ContactUsViewController alloc] init];
        
               [self.navigationController pushViewController:contactsView animated:YES];
        
        
    }
    else if (sender.tag==4){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:logoutalert delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        
        [alert setTag:4321];
        [alert show];
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
