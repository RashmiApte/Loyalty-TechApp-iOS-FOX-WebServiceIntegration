//
//  HomeViewController.m
//  YesPayCardHolderWallet
//
//  Created by ankit on 11/13/13.
//
//

#import "HomeViewController.h"
#import "CAppDelegate.h"
#import "Login.h"
#import "SettingCountryCurrency.h"
#import "Help.h"
#import "Common.h"
#import "Constant.h"
#import "TermsConditionViewController.h"
#import "NewAddNewCardInWalletViewController.h"


@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize lblalreadycreateLbl,lblnewtoworlpayLbl;
@synthesize btnLogin,btnSignup;
@synthesize imgOnline;
@synthesize imgBottomImage,imglogo;



#pragma mark - Viewcontroller ------------------------------------------------------

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
    appdelegate = (CAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    // -------------- set font type and size of buttons labels ----------------
    lblnewtoworlpayLbl.font=[UIFont fontWithName:labelregularFont size:(20.0)];
    lblalreadycreateLbl.font=[UIFont fontWithName:labelregularFont size:(20.0)];
    [lblalreadycreateLbl setTextColor:labeltextColor];
    [lblnewtoworlpayLbl setTextColor:labeltextColor];
    btnLogin.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(22.0)];
    btnSignup.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(22.0)];
    [btnSignup.titleLabel setTextColor:btntextColor];
    [btnLogin.titleLabel setTextColor:btntextColor];
    //-------------------------------------------------------------------------
   
    
    //--------------- Check condition for iPhone 4/ 4s and set frames -------------
    if ([[UIScreen mainScreen] bounds].size.height != 568)
    {
        lblnewtoworlpayLbl.frame=CGRectMake(24, 110, 273, 54);
        btnSignup.frame=CGRectMake(20, 168, 280, 40);
        imgOnline.frame=CGRectMake(258, 375, 42, 9);

        lblalreadycreateLbl.frame=CGRectMake(9, 210, 303, 55);
        btnLogin.frame=CGRectMake(20, 274, 280, 40);
        imgBottomImage.frame=CGRectMake(0, 320, 320, 140);
        imglogo.frame=CGRectMake(37, 58, 246, 38);
        
    }
   //------------------------------------------------------------------------------
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    

    if([Common isNetworkAvailable])
    {
        imgOnline.image=[UIImage imageNamed:@"online.png"];
    }
    else
    {
        imgOnline.image=[UIImage imageNamed:@"offline.png"];
    }
	
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIButton methods ------------------------------------------------------
-(IBAction)sighnup:(id)sender{
   
    
    if([Common isNetworkAvailable])
    {
        
        TermsConditionViewController *objTerms=[[TermsConditionViewController alloc]init];
        [self.navigationController pushViewController:objTerms animated:YES];
       //        imgOnline.image=[UIImage imageNamed:@"online.png"];
//        
//        SettingCountryCurrency *settingcuntry = [[SettingCountryCurrency alloc]init];
//        settingcuntry.isPushFromLogin=NO;
//        [self.navigationController pushViewController:settingcuntry animated:YES];
    }
    else
    {
        imgOnline.image=[UIImage imageNamed:@"offline.png"];
      
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:networkconnectiontitle message:networkconnectionmessage  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        
    }
  
    
}
-(IBAction)login:(id)sender
{
    Login *login=[[Login alloc] init];
    NSUserDefaults *pushviewidentifire = [NSUserDefaults standardUserDefaults];
    if([pushviewidentifire objectForKey:@"pushview"]==nil)
    {
        NSLog(@"pushview value %@",pushviewidentifire);
        [pushviewidentifire setObject:@"Loginidentifire" forKey:@"pushview"];
    }
    else {
        NSLog(@"pushview value %@",pushviewidentifire);
        [pushviewidentifire removeObjectForKey:@""];
        [pushviewidentifire setObject:@"Loginidentifire" forKey:@"pushview"];
    }

    [self.navigationController pushViewController:login animated:YES];
}
-(IBAction)Help:(id)sender
{
    
    if ([Common isNetworkAvailable]) {
        
        Help *objHelp=[[Help alloc] init];
        objHelp.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:objHelp animated:YES];
	}
	else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:networkconnectiontitle message:networkconnectionmessage  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
       
	}
    
}
#pragma mark - Status bar ------------------------------------------------------

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
