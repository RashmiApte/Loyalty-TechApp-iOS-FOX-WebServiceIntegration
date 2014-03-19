//
//  ActiveCampaginViewController.m
//  LoyaltyApp
//
//  Created by ankit on 2/28/14.
//
//

#import "ActiveCampaginViewController.h"
#import "CampaginDetailViewController.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"
#import "Constant.h"
#import "Activecell.h"

@interface ActiveCampaginViewController ()

@end
@implementation ActiveCampaginViewController
@synthesize tableActivecampagin,arryShowActiveCampagin;


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
    //design Header
    CGRect re= CGRectMake(0, 0, 320,53);
    UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_back.png"]];//create_new_ac_back.png
    UILabel *lbl =[[UILabel alloc]init];
    CGRect lblrect= CGRectMake(96, 10, 180, 23);// 73, 10, 142, 23
    lbl.frame=lblrect;
    lbl.text=@"Active Campaign";
    lbl.backgroundColor=[UIColor clearColor];
    [lbl setTextColor:headertitletextColor];
    lbl.font = [UIFont fontWithName:labelregularFont size:(22.0)];
    img.frame=re;
    [img addSubview:lbl];
    [self.view  addSubview:img];
    
    self.arryShowActiveCampagin=[[NSMutableArray alloc]initWithObjects:@"ActiveCampagin1",@"ActiveCampagin2",@"ActiveCampagin3",@"ActiveCampagin4",@"ActiveCampagin5",@"ActiveCampagin6" ,@"ActiveCampagin7",@"ActiveCampagin8",nil];
    // Do any additional setup after loading the view from its nib.
    
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
            
            tableActivecampagin.frame=CGRectMake(0,50, 320, 564);
        }
        else{
            tableActivecampagin.frame=CGRectMake(0,48, 320, 564);
        }
    }
    else{
        NSLog(@"value of active campagin");
    }
    
    
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
    return 90;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Activecell *cell=[[Activecell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lblActivecampaginname.text=@"Active Campaign";
    // cell.lblActivecampaginname.font=[UIFont fontWithName:labelregularFont size:(18.0)];
    cell.lblActivecampaginstartdate.text=@"24/02/2014   to";
    cell.lblActivecampaginenddate.text=@"28/02/2014";
    cell.imgactivecampagin.image=[UIImage imageNamed:@"noimage.png"];
    cell.imgArrow.image=[UIImage imageNamed:@"arrow.png"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CampaginDetailViewController *objCampaginvidew=[[CampaginDetailViewController alloc]initWithNibName:@"CampaginDetailViewController" bundle:nil];
    [self.navigationController pushViewController:objCampaginvidew animated:YES];
    
}


#pragma mark - Drawerback ------------------------------------------------------

- (void)_addRightTapped:(id)sender {
    NSLog(@"tapp me");
    
    [self.sidePanelController toggleLeftPanel:sender];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
