//
//  SettingsViewController.m
//  YesPayCardHolderWallet
//
//  Created by Nirmal Patidar on 03/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "UpdatePasswordViewController.h"
#import "UpdateUserInfoViewController.h"
#import "CAppDelegate.h"
#import "Constant.h"
#import "Common.h"
//#import "YPServices.h"

@implementation SettingsViewController
@synthesize lblPswd,lblUserInfo,btnPswd,btnUserInfo,imgOnline;

#pragma mark - UIViewController Methods---------------------------
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
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//	appdelegate = [[UIApplication sharedApplication]delegate];
	
	
	
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
    
    
    
    tittlelable.text=@"Profile Settings";
    
    
    
    
    //---------------------  Back button --------------------------------------------
	UIButton *btnBack =  [UIButton buttonWithType:UIButtonTypeCustom];
	[btnBack setBackgroundImage:[UIImage imageNamed:@"button_back_60_29.png"] forState:UIControlStateNormal];
    [btnBack setTitle:@"Back" forState:UIControlStateNormal];
	[btnBack addTarget:self action:@selector(goBackToMore) forControlEvents:UIControlEventTouchUpInside];
	[btnBack setFrame:CGRectMake(9, 7, 60, 29)];
    btnBack.titleLabel.font=[UIFont fontWithName:labelregularFont size:15];
    
    [self.view addSubview:btnBack];
    
	
	//-------------------------------------------------------------------------------
    
    [btnUserInfo setBackgroundImage:[UIImage imageNamed:@"cell_button_deselect.png"] forState:UIControlStateNormal];
    [btnPswd setBackgroundImage:[UIImage imageNamed:@"cell_button_deselect.png"] forState:UIControlStateNormal];
    
    [btnUserInfo setBackgroundImage:[UIImage imageNamed:@"cell_button_select.png"] forState:UIControlStateHighlighted];
    [btnPswd setBackgroundImage:[UIImage imageNamed:@"cell_button_select.png"] forState:UIControlStateHighlighted];
    
    
    lblUserInfo.font=[UIFont fontWithName:labelregularFont size:20];
    lblPswd.font =[UIFont fontWithName:labelregularFont size:20];
    
    if ([UIScreen mainScreen].bounds.size.height != 568)
    {
        
        imgOnline.frame=CGRectMake(260, 399, 42, 9);
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
    [self.navigationController setNavigationBarHidden:YES];
    if([Common isNetworkAvailable])
    {
        [imgOnline setImage:[UIImage imageNamed:@"online.png"]];
        
    }
    else {
        [imgOnline setImage:[UIImage imageNamed:@"offline.png"]];
        
    }
	//[appdelegate setIsInMore:NO];
	
    
    
    bckbtn .hidden=NO;
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
	//[appdelegate setIsInMore:YES];
}


-(void)viewDidAppear:(BOOL)animated
{
//	CGFloat navBarHeight = 50.0f;
//	CGRect frame = CGRectMake(0.0f, 20.0f, 320.0f, navBarHeight);
//	[self.navigationController.navigationBar setFrame:frame];
//	NSIndexPath *tableSelection = [self.tableSetting indexPathForSelectedRow];
//    [self.tableSetting deselectRowAtIndexPath:tableSelection animated:YES];
//	UITableViewCell *cell1 = [tableSetting cellForRowAtIndexPath:tableSelection];
//	UIImageView *cellImage = (UIImageView*)cell1.backgroundView;
//	[cellImage setImage:[UIImage imageNamed:@"cell_back_normal.png"]];
	[super viewDidAppear:animated];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}




#pragma mark - Button Methodes -----------------------------------


-(void)goBackToMore
{
    
	[self.navigationController popViewControllerAnimated:YES];
	
}



-(IBAction)btnTap:(UIButton *)sender{
    
    
    
	
	if(sender.tag== 0)
	{
        if ([Common isNetworkAvailable])
        {
            
            [imgOnline setImage:[UIImage imageNamed:@"online.png"]];
            
        }
        else{
            
            [imgOnline setImage:[UIImage imageNamed:@"offline.png"]];
            
        }
        
        UpdatePasswordViewController *cardsController=[[UpdatePasswordViewController alloc] init];
        [self.navigationController pushViewController:cardsController animated:YES];
        
	}
	if(sender.tag== 1)
	{
        
        if ([Common isNetworkAvailable])
        {
            
            [imgOnline setImage:[UIImage imageNamed:@"online.png"]];
            
        }
        else{
            
            [imgOnline setImage:[UIImage imageNamed:@"offline.png"]];
            
        }

        UpdateUserInfoViewController *cardsController = [[UpdateUserInfoViewController alloc] init];
        [imgOnline setImage:[UIImage imageNamed:@"online.png"]];
        

        [self.navigationController pushViewController:cardsController animated:YES];
        
		
	}
    
	
    
    
}


#pragma mark - HUDView delegates----------------------------------
// to kill hud view
- (void) killHUD
{
	if(aHUD != nil ){
		[aHUD.loadingView removeFromSuperview];
		[aHUD setUserInteractionEnabledForSuperview:self.view];
		[aHUD setUserInteractionEnabledForSuperview:self.view];
		[self.navigationController.view setUserInteractionEnabled:YES];
		aHUD = nil;
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		
	}
	//is_flageHUD = YES;
}


- (void) killHUDAlert{
	
	
	if(aHUD != nil ){
		[aHUD.loadingView removeFromSuperview];
		[aHUD setUserInteractionEnabledForSuperview:self.view];
		[aHUD setUserInteractionEnabledForSuperview:self.view];
		[self.navigationController.view setUserInteractionEnabled:YES];
		aHUD = nil;
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		
        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        
	}
	
}

//to show hud view
- (void)showHUD
{
	if(aHUD == nil)
	{
		aHUD = [[HudView alloc]init];
		[aHUD setUserInteractionEnabledForSuperview:self.view];
		[aHUD loadingViewInView:self.view text:NULL];
		[self.view setUserInteractionEnabled:NO];
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		[self.navigationController.view setUserInteractionEnabled:NO];
		
	}
	
}

#pragma mark - Status bar ------------------------------------------------------

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
