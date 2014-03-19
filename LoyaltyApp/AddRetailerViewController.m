//
//  AddRetailerViewController.m
//  LoyaltyApp
//
//  Created by ankit on 2/27/14.
//
//

#import "AddRetailerViewController.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"
#import "AddRetailerCell.h"
#import "Constant.h"

@interface AddRetailerViewController ()

@end

@implementation AddRetailerViewController
@synthesize tableAddretailer,btnSenderView;


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
            tableAddretailer.frame=CGRectMake(0,50, 320, 564);
        }
        else{
            tableAddretailer.frame=CGRectMake(0,48, 320, 564);
        }
    }
    else{
        NSLog(@"value of active campagin");
    }
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Drawerback ------------------------------------------------------

- (void)_addRightTapped:(id)sender {
    NSLog(@"tapp me");
    [self.sidePanelController toggleLeftPanel:sender];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
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
    return 90.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddRetailerCell *cell=[[AddRetailerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lblRetailername.text=@"Retailer name";
    cell.imgRetiler.image=[UIImage imageNamed:@"noimage.png"];
    [cell.btnAddRetailer addTarget:self action:@selector(customActionPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnAddRetailer setTitle:@"Add" forState:UIControlStateNormal];
    cell.btnAddRetailer.tag=indexPath.row+501;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)customActionPressed:(UIButton*)sender
{
    
    NSLog(@"button pressed %ld",(long)sender.tag);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Are you sure you want to  add retailer."message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
    btnSenderView = sender;
    NSArray *subviews = [self.btnSenderView subviews];
    NSLog(@"value of sub view is %@",subviews);
    // [sender setTitle:@"Added" forState:UIControlStateNormal];
    [alertView show];
    [alertView setTag:201];
    alertView.delegate=self;
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(alertView.tag==201)
    {
        if(buttonIndex==0)
        {
            
            [btnSenderView setTitle:@"Added" forState:UIControlStateNormal];
            btnSenderView.userInteractionEnabled=NO;
            
            
            
        }
        else{
            NSLog(@"Cancel");
        }
        
    }
	
	
}



@end
