//
//  AboutUsViewController.m
//  YesPayCardHolderWallet
//
//  Created by Nirmal Patidar on 14/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AboutUsViewController.h"
#import "Common.h"
#import "Constant.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"

@implementation AboutUsViewController

@synthesize versionName,imgOnline;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    
	[super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
	UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
	[button setImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
	[button addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
	[button setFrame:CGRectMake(-11, -1 , 76, 36)];
    
	navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	
    //New code for header 4-s Only
    
    if ([UIScreen mainScreen].bounds.size.height!=568) {
        CGRect re= CGRectMake(0, 0, 320, 44);
        UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_back.png"]];//create_new_ac_back.png
        UILabel *lbl =[[UILabel alloc]init];
        CGRect lblrect= CGRectMake(125, 8, 180, 23);// 73, 10, 142, 23
        lbl.frame=lblrect;
        lbl.text=@"About Us";
        [lbl setFont:[UIFont fontWithName:@"Helvetica-Bold" size:19]];
        lbl.backgroundColor=[UIColor clearColor];
        lbl.textColor =[UIColor blackColor];
        img.frame=re;
        [self.view addSubview:img];
        [img addSubview:lbl];
        imgOnline.frame=CGRectMake(260,445, 42, 9);
    }
    [self.view addSubview:button];
    
    //----------------------------
	
    
    
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
    
    tittlelable.text=@"About Us";
   /* //---------------------  Back button --------------------------------------------
	UIButton *btnBack =  [UIButton buttonWithType:UIButtonTypeCustom];
	[btnBack setBackgroundImage:[UIImage imageNamed:@"button_back_60_29.png"] forState:UIControlStateNormal];
    [btnBack setTitle:@"Back" forState:UIControlStateNormal];
	[btnBack addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
	[btnBack setFrame:CGRectMake(9, 7, 60, 29)];
    btnBack.titleLabel.font=[UIFont fontWithName:labelregularFont size:15];
    
    [self.view addSubview:btnBack];*/
    
	//-------------------------------------------------------------------------------
    
    //----------------------------Drawerleftbutn-Added by Ankit jain 3 Mar 2014----------------------
    
    btndrawerleft = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btndrawerleft.frame = CGRectMake(15,5,32, 32);
    btndrawerleft.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [btndrawerleft addTarget:self action:@selector(_addRightTapped:) forControlEvents:UIControlEventTouchUpInside];
    [btndrawerleft setBackgroundImage:[UIImage imageNamed:@"drawer.png"] forState:UIControlStateNormal];
    [self.view addSubview:btndrawerleft];
	//-------------------------------------------------------------------------------
   
}

-(void) viewWillAppear:(BOOL)animated{
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
    
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
	NSString *build = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    versionName.text=build;
    
	[super viewWillAppear:animated];
	
}
-(void)viewDidAppear:(BOOL)animated
{
	CGFloat navBarHeight = 50.0f;
	CGRect frame = CGRectMake(0.0f, 20.0f, 320.0f, navBarHeight);
	[self.navigationController.navigationBar setFrame:frame];
	[super viewDidAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO];
    
}

-(void)Back{
	[self.navigationController popViewControllerAnimated:YES];
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
