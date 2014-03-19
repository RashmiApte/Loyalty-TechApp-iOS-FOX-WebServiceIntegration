//
//  LeftPanelViewController.m
//  LoyaltyApp
//
//  Created by ankit on 2/26/14.
//
//

#import "LeftPanelViewController.h"

#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"
#import "MyCardsViewController.h"
#import "SettingsViewController.h"
#import "AboutUsViewController.h"
#import "UpdatePasswordViewController.h"
#import "UpdateUserInfoViewController.h"
#import "AddRetailerViewController.h"
#import "CampainViewController.h"
#import "Constant.h"
#import "YPLogoutRequest.h"
#import "YPLogoutResponse.h"
#import "WebserviceOperation.h"
#import "LeftPanelcell.h"
#import "MyRetailerViewController.h"
#import "ActiveCampaginViewController.h"
#import "Login.h"
#import "Common.h"

@interface LeftPanelViewController ()

@end

@implementation LeftPanelViewController
@synthesize tabelDrawerview;
@synthesize arryDrawerelement;

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
    //--------------------- Design heder of This screen --------------
    
    CGRect re= CGRectMake(0, 0, 320,53);
    UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_back.png"]];//create_new_ac_back.png
    UILabel *lbl =[[UILabel alloc]init];
    CGRect lblrect= CGRectMake(20, 10, 180, 23);// 73, 10, 142, 23
    lbl.frame=lblrect;
    lbl.text=@"Loyalty";
    lbl.backgroundColor=[UIColor clearColor];
    [lbl setTextColor:headertitletextColor];
    lbl.font = [UIFont fontWithName:labelregularFont size:(22.0)];
    img.frame=re;
    [img addSubview:lbl];
    [self.view  addSubview:img];
    self.arryDrawerelement=[[NSMutableArray alloc]initWithObjects:@"Active Campaign",@"My Cards",@"Add Retailer",@"My Retailer",@"Consumer Profile",@"Change Password",@"About Us",@"Logout", nil];
    
    appdelegate=(CAppDelegate*)[UIApplication sharedApplication].delegate;
    
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabelDrawerview.frame=CGRectMake(0, 52, 320, 541);
}

#pragma mark - TableView Delegtes ---------------------------------------
/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 return ;
 }
 - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
 
 if(section==1)
 {
 return tableHeaderHeight;
 }
 return 0;
 
 }*
 
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
 
 
 NSString *sectionTitle;
 
 if (section==1)
 {
 sectionTitle = @"Settings";
 // Create label with section title
 UILabel *label = [[UILabel alloc] init] ;
 label.frame = CGRectMake(5, 5, 284, 23);
 label.textColor = [UIColor blackColor];
 label.font = [UIFont fontWithName:labelregularFont size:20];
 label.text = sectionTitle;
 label.backgroundColor = [UIColor whiteColor];
 
 // Create header view and add label as a subview
 UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
 view1.backgroundColor=[UIColor whiteColor];
 [view1 addSubview:label];
 
 return view1;
 }
 else{
 
 }
 
 return nil;
 }*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.arryDrawerelement count];
	
    /* if(section==0)
     return [self.arryDrawerelement count];
     else
     {
     if(section==1)
     {
     return 2;
     }else
     {
     if(section==2)
     {
     return 2;
     }
     }
     }
     return 0;*/
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	
    
    LeftPanelcell *cell=[[LeftPanelcell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    /*if(cell == nil){
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
     }*/
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lblleftpaneltitle.text=[self.arryDrawerelement objectAtIndex:indexPath.row];
    cell.lblleftpaneltitle.font=[UIFont fontWithName:labelregularFont size:(18.0)];
    if(indexPath.row==0)
    {
        cell.imgeleftpanellogo.image=[UIImage imageNamed:@"activecampign.png"];
    }
    if(indexPath.row==1)
    {
         cell.imgeleftpanellogo.image=[UIImage imageNamed:@"mycards.png"];
    }
    if(indexPath.row==2)
    {
         cell.imgeleftpanellogo.image=[UIImage imageNamed:@"addretailer.png"];
    }
    if(indexPath.row==3)
    {
         cell.imgeleftpanellogo.image=[UIImage imageNamed:@"myretailer.png"];
    }
    if(indexPath.row==4)
    {
         cell.imgeleftpanellogo.image=[UIImage imageNamed:@"consumerprofile.png"];
        
    }
    if(indexPath.row==5)
    {
         cell.imgeleftpanellogo.image=[UIImage imageNamed:@"changepassword.png"];
        
    }
    if(indexPath.row==6)
    {
         cell.imgeleftpanellogo.image=[UIImage imageNamed:@"aboutus.png"];
    }
    if(indexPath.row==7)
    {
        cell.imgeleftpanellogo.image=[UIImage imageNamed:@"logout.png"];

    }
    
    /* if(indexPath.section==0)
     {
     //cell.textLabel.text=[self.arryDrawerelement objectAtIndex:indexPath.row];
     cell.lblleftpaneltitle.text=[self.arryDrawerelement objectAtIndex:indexPath.row];
     cell.imgeleftpanellogo.image=[UIImage imageNamed:@"campagin.png"];
     }
     else
     {
     if(indexPath.section==1)
     {
     if(indexPath.row==0)
     {
     //cell.textLabel.text=@"Consumer Profile";
     cell.lblleftpaneltitle.text=@"Consumer Profile";
     cell.imgeleftpanellogo.image=[UIImage imageNamed:@"campagin.png"];
     }
     else{
     if(indexPath.row==1)
     {
     cell.lblleftpaneltitle.text=@"Change Password";
     cell.imgeleftpanellogo.image=[UIImage imageNamed:@"campagin.png"];
     }
     }
     }
     if(indexPath.section==2)
     {
     if(indexPath.row==0)
     {
     cell.lblleftpaneltitle.text=@"Aboout Us";
     cell.imgeleftpanellogo.image=[UIImage imageNamed:@"campagin.png"];
     }
     else{
     
     if(indexPath.row==1)
     {
     cell.lblleftpaneltitle.text=@"Logout";
     cell.imgeleftpanellogo.image=[UIImage imageNamed:@"campagin.png"];
     }
     }
     }
     }*/
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger i=indexPath.row;
    
    [self rowcount:i];
    
}

-(void)rowcount:(NSUInteger)count
{
    NSLog(@"value of count is %lu",(unsigned long)count);
    switch (count) {
        case 0:
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[ActiveCampaginViewController alloc] init]];
            break;
            
        case 1:
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[MyCardsViewController alloc] init]];
            break;
            
        case 2:
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[AddRetailerViewController alloc] init]];
            break;
            
        case 3:
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[MyRetailerViewController alloc] init]];
            break;
            
        case 4:
            self.sidePanelController.centerPanel=[[UINavigationController alloc] initWithRootViewController:[[UpdateUserInfoViewController alloc] init]];
            break;
        case 5:
            self.sidePanelController.centerPanel=[[UINavigationController alloc] initWithRootViewController:[[UpdatePasswordViewController alloc] init]];
            break;
        case 6:
            self.sidePanelController.centerPanel=[[UINavigationController alloc] initWithRootViewController:[[AboutUsViewController alloc] init]];
            break;
        case 7:
        {
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:logoutalert delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            [alert setTag:4321];
            [alert show];
            break;
        }
        default:
            break;
    }
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
                NSLog(@"appdelegate.SC = %@",appdelegate.SC);
                
                objLogoutRequest.SC=appdelegate.SC;
                objLogoutRequest.applicationType=@"M";
                objLogoutRequest.role=@"C";
                [self showHUD:logouthud];
                [serviceLogout logout:objLogoutRequest];
            }
            else
            {
                //  [appdelegate.navigationController popToViewController:[[appdelegate.navigationController viewControllers] objectAtIndex:1] animated:NO];
            }
        }
        // [appdelegate logouts];
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


#pragma mark - Webservice handler -----------------------------------------------------------

-(void)logoutHandlers:(id)value
{
    //--------------- waiting ------------------
    [self killHUD];
    
	YPLogoutResponse* logoutResponse =[[YPLogoutResponse alloc] init];
    [logoutResponse parsingLogout:value];
    
	if(logoutResponse.statusCode == 0)
	{
		
        int viewcontrolleridentifire=0;
        
        for (UIViewController *controller in [self.navigationController viewControllers])
        {
            if ([controller isKindOfClass:[Login class]])
            {
                
                [self.navigationController popToViewController:controller animated:NO];
                viewcontrolleridentifire=0;
                
                break;
            }
            viewcontrolleridentifire=1;
        }
        if(viewcontrolleridentifire==1)
        {
            Login *objlolgin=[[Login alloc]init];
            [self.navigationController pushViewController:objlolgin animated:NO];
        }
        
    }
    else{
        NSLog(@"hello");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
