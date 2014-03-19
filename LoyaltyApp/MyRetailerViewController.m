//
//  MyRetailerViewController.m
//  LoyaltyApp
//
//  Created by ankit on 2/27/14.
//
//

#import "MyRetailerViewController.h"
#import "MyRetailerCell.h"
#import "UIViewController+JASidePanel.h"
#import "Constant.h"
#import "JASidePanelController.h"
#import "CampainViewController.h"

@interface MyRetailerViewController ()

@end

@implementation MyRetailerViewController
@synthesize tableMyRetailer,btnSenderView;

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
    //--------------- header --------------------------------------------------------
    CGRect re= CGRectMake(0, 0, 320, 53);
    UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_back.png"]];
    
    UILabel *tittlelable =[[UILabel alloc]init];
    tittlelable.text=@"Retailer";
    
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
    
    //----------------------------Drawerleftbutn-Added by Ankit jain 3 Mar 2014----------------------
    
    btndrawerleft = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btndrawerleft.frame = CGRectMake(15,5,32, 32);
    btndrawerleft.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [btndrawerleft addTarget:self action:@selector(_addRightTapped:) forControlEvents:UIControlEventTouchUpInside];
    [btndrawerleft setBackgroundImage:[UIImage imageNamed:@"drawer.png"] forState:UIControlStateNormal];
    [self.view addSubview:btndrawerleft];
	//-------------------------------------------------------------------------------
    //--------------------SetFrameForIphone4AndIphone5-----------------
    if ([UIScreen mainScreen].bounds.size.height==568) {
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
            
            self.tableMyRetailer.frame=CGRectMake(0,50, 320, 564);
        }
        else{
            self.tableMyRetailer.frame=CGRectMake(0,48, 320, 541);
        }
    }
    else{
        NSLog(@"value of active campagin");
    }
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TableView Functions --------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyRetailerCell *cell=[[MyRetailerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lblretailername.text=@"Retailername";
    
    cell.imgretailerlogo.image=[UIImage imageNamed:@"noimage.png"];
    [cell.btnremoveretailer addTarget:self action:@selector(customActionPressed:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnremoveretailer.tag=indexPath.row+501;
   
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CampainViewController *campaginview=[[CampainViewController alloc]initWithNibName:@"CampainViewController" bundle:nil];
    [self.navigationController pushViewController:campaginview animated:YES];
    
}

#pragma mark -other Methode------------------------------------------------------

- (void)_addRightTapped:(id)sender {
    NSLog(@"tapp me");
    
    [self.sidePanelController toggleLeftPanel:sender];
    [self.view endEditing:YES];
}

-(void)customActionPressed:(UIButton*)sender
{
    NSLog(@"button pressed %ld",(long)sender.tag);
    
    NSLog(@"button pressed %ld",(long)sender.tag);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Are you sure you want to  remove retailer."message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
    btnSenderView = sender;
    NSArray *subviews = [self.btnSenderView subviews];
    NSLog(@"value of sub view is %@",subviews);
    [alertView show];
    [alertView setTag:201];
    alertView.delegate=self;
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(alertView.tag==201)
    {
        if(buttonIndex==0)
        {
            [btnSenderView setTitle:@"Removed" forState:UIControlStateNormal];
            btnSenderView.userInteractionEnabled=NO;
        }
        else{
            NSLog(@"Cancel");
        }
        
    }
	
	
}










@end
