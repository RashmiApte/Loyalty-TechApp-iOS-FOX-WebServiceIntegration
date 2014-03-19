//
//  CampainViewController.m
//  Loyalty
//
//  Created by ankit on 2/21/14.
//  Copyright (c) 2014 Ebot. All rights reserved.
//

#import "CampainViewController.h"
#import "CampaginDetailViewController.h"
#import "CampaignCell.h"
#import "Constant.h"


@interface CampainViewController ()

@end

@implementation CampainViewController
@synthesize tableCampagin;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark UIViewController Methods ------------------------


- (void)viewDidLoad
{
    [super viewDidLoad];
    //--------------------- Design heder of This screen --------------
    
    CGRect re= CGRectMake(0, 0, 320, 53);
    UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_back.png"]];//create_new_ac_back.png
    UILabel *lbl =[[UILabel alloc]init];
    CGRect lblrect= CGRectMake(120, 8, 180, 23);// 73, 10, 142, 23
    lbl.frame=lblrect;
    lbl.text=@"Campaign";
    [lbl setTextColor:headertitletextColor];
    lbl.font = [UIFont fontWithName:labelregularFont size:(22.0)];
    lbl.backgroundColor=[UIColor clearColor];
    
    // lbl.textColor =[UIColor colorWithRed:01.0f/255.0f green:57.0f/255.0f blue:116.0f/255.0f alpha:1.0f];
    [img addSubview:lbl];
    img.frame=re;
    //---------------------- Back button -----------------------------
    
	UIButton *btnBack =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"button_home_60_29.png"] forState:UIControlStateNormal];
	[btnBack addTarget:self action:@selector(BacktoView) forControlEvents:UIControlEventTouchUpInside];
    btnBack.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(14.0)];
    [btnBack.titleLabel setTextColor:btntextColor];
    [btnBack setTitle:@"Back" forState:UIControlStateNormal];
	[btnBack setFrame:CGRectMake(5,7, 60, 29)];
    
    [self.view addSubview:img];
    [self.view addSubview:btnBack];
    //----------------------------------------------------------------
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)BacktoView
{
    [self.navigationController popViewControllerAnimated:YES];
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
    
    CampaignCell *cell=[[CampaignCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.lblCampaginName.text=@"Camapgin";
    cell.lblStartDate.text=@"24/03/2014    to";
    cell.lblEndDate.text  =@"28/03/2014";
    cell.imgCampagin.image=[UIImage imageNamed:@"noimage.png"];
    cell.imgArrow.image=[UIImage imageNamed:@"arrow.png"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CampaginDetailViewController *objCampagindetailvewcontroler=[[CampaginDetailViewController alloc]initWithNibName:@"CampaginDetailViewController" bundle:nil];
    [self.navigationController pushViewController:objCampagindetailvewcontroler animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
