//
//  Terms&ConditionViewController.m
//  LoyaltyApp
//
//  Created by Ajeet Sharma on 2/28/14.
//
//

#import "TermsConditionViewController.h"
#import "Common.h"
#import "Constant.h"
#import "SignUpViewController.h"
#import "Register.h"

BOOL isChecked;

@interface TermsConditionViewController ()

@end

@implementation TermsConditionViewController

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
    // Do any additional setup after loading the view from its nib.
    //--------------------- Next button ---------------------------
	 btnPushToSignup =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnPushToSignup setBackgroundImage:[UIImage imageNamed:@"button_home_60_29.png"] forState:UIControlStateNormal];
	[btnPushToSignup addTarget:self action:@selector(pushToSignup:) forControlEvents:UIControlEventTouchUpInside];
    [btnPushToSignup setTitle:@"Next" forState:UIControlStateNormal];
	[btnPushToSignup setFrame:CGRectMake(253,7,60,29)];//0, 0, 76, 44
    btnPushToSignup.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(14.0)];
    [btnPushToSignup.titleLabel setTextColor:btntextColor];
    btnPushToSignup.alpha=0.5;
    //----------------------------------------------------------------
    
    //---------------------- Back button -----------------------------
    
	UIButton *btnBack =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"button_home_60_29.png"] forState:UIControlStateNormal];
	[btnBack addTarget:self action:@selector(backToHome:) forControlEvents:UIControlEventTouchUpInside];
    btnBack.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(14.0)];
    [btnBack.titleLabel setTextColor:btntextColor];
    [btnBack setTitle:@"Back" forState:UIControlStateNormal];
    btnBack.titleLabel.font=[UIFont fontWithName:labelregularFont size:15];
    [btnBack setFrame:CGRectMake(5,7, 60, 29)];
    //--------------------- Design heder of This screen --------------
    
    CGRect re= CGRectMake(0, 0, 320, 53);
    UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_back.png"]];
    UILabel *lbl =[[UILabel alloc]init];
    CGRect lblrect= CGRectMake(72, 8, 180, 23);// 73, 10, 142, 23
    lbl.frame=lblrect;
    lbl.text=@"Terms & Conditions";
    [lbl setTextColor:headertitletextColor];
    lbl.font = [UIFont fontWithName:labelregularFont size:(22.0)];
    lbl.backgroundColor=[UIColor clearColor];
    [img addSubview:lbl];
    img.frame=re;
    
    //----------------------------------------------------------------
    
    lbl.backgroundColor=[UIColor clearColor];
    
    img.frame=re;
    [self.view addSubview:img];
    [img addSubview:lbl];
    [self.view addSubview:btnBack];
    [self.view addSubview:btnPushToSignup];
    //-------------------------------------------------------------
    
    //--------------------- label terms and conditions ----------------//
    
    lblTermsCondition=[[UILabel alloc] initWithFrame:CGRectMake(0, 80, 320, 100)];
    lblTermsCondition.numberOfLines=3;
    lblTermsCondition.text=[NSString stringWithFormat:@"Terms & Conditions \n (Coming soon) \n Below CheckBox should be checked to proceed."];
    lblTermsCondition.font=[UIFont fontWithName:labelregularFont size:15.0];
    lblTermsCondition.backgroundColor=[UIColor clearColor];
    lblTermsCondition.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:lblTermsCondition];
                                       
    
    
    //---------------------------------------------------------------
    
    
    //--------------------- Check button ---------------------------
    
	 btnCheck =  [UIButton buttonWithType:UIButtonTypeCustom];
	[btnCheck addTarget:self action:@selector(acceptTermsCondition:) forControlEvents:UIControlEventTouchUpInside];
    [btnCheck setBackgroundImage:[UIImage imageNamed:@"checkbox_unchecked.png"] forState:UIControlStateNormal];
    
    if ([UIScreen mainScreen].bounds.size.height==568)
    {
        [btnCheck setFrame:CGRectMake(30,500,30,30)];
    }
    else
    {
        [btnCheck setFrame:CGRectMake(30,400,30,30)];
    }
    btnCheck.backgroundColor=[UIColor clearColor];
    btnCheck.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(14.0)];
    [btnCheck.titleLabel setTextColor:btntextColor];
    [self.view addSubview:btnCheck];
    //----------------------------------------------------------------
    
    //--------------------- label terms and conditions ----------------//
    
    lblAccept=[[UILabel alloc] init];
    if ([UIScreen mainScreen].bounds.size.height==568)
    {
        [lblAccept setFrame:CGRectMake(40,500,100,30)];
    }
    else
    {
        [lblAccept setFrame:CGRectMake(40,400,100,30)];
    }
    lblAccept.numberOfLines=3;
    lblAccept.text=@"I Accept";
    lblAccept.font=[UIFont fontWithName:labelregularFont size:15.0];
    lblAccept.backgroundColor=[UIColor clearColor];
    lblAccept.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:lblAccept];
    
    //---------------------------------------------------------------


}
-(void)viewWillAppear:(BOOL)animated{

    isChecked=NO;
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushToSignup:(id)sender
{
    
    if (isChecked) {
        Register *objRegister=[[Register alloc] init];
        [self.navigationController pushViewController:objRegister animated:YES];
    }
    
}
-(void)backToHome:(id)sender{

    
    [self.navigationController popViewControllerAnimated:YES];
    
    

}
-(void)acceptTermsCondition:(id)sender{

    if (isChecked) {
        isChecked=NO;
                btnPushToSignup.alpha=0.5;
        [btnCheck setBackgroundImage:[UIImage imageNamed:@"checkbox_unchecked.png"] forState:UIControlStateNormal];
    }
    else{
        btnPushToSignup.alpha=1.0;
        [btnCheck setBackgroundImage:[UIImage imageNamed:@"checkbox_checked.png"] forState:UIControlStateNormal];
        isChecked=YES;
    
    }
    
    

}

#pragma mark - Status bar ------------------------------------------------------

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}



@end
