//
//  Help.m
//  YesPayCardHolderWallet
//
//  Created by ankit on 12/14/13.
//
//

#import "Help.h"
#import "Constant.h"

@interface Help ()

@end

@implementation Help
@synthesize question1lbl,question2lbl,question3lbl,question4lbl,question5lbl;
@synthesize ans1lbl,ans2lbl,ans3lbl,ans4lbl,ans5lbl;
@synthesize signuplbl;


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
    float fontsize=15.0;
    [signuplbl setTextColor:labeltextColor];
    signuplbl.font=[UIFont fontWithName:labelmediumFont size:fontsize+4];
    question1lbl.font=[UIFont fontWithName:labelmediumFont size:fontsize];
    question1lbl.frame=CGRectMake(10, 20, 300, 41);
    [question1lbl setTextColor:labeltextColor];
    ans1lbl.font=[UIFont fontWithName:labelregularFont size:fontsize];
    ans1lbl.frame=CGRectMake(10,45, 300,72);
    [ans1lbl setTextColor:labeltextColor];
    question2lbl.font=[UIFont fontWithName:labelmediumFont size:fontsize];
    question2lbl.frame=CGRectMake(10,115, 300, 47);
    [question2lbl setTextColor:labeltextColor];
    ans2lbl.font=[UIFont fontWithName:labelregularFont size:fontsize];
    [ans2lbl setTextColor:labeltextColor];
    ans2lbl.frame=CGRectMake(10,160,300,41);
    question3lbl.font=[UIFont fontWithName:labelmediumFont size:fontsize];
    question3lbl.frame=CGRectMake(10,200, 300,62);
    [question3lbl setTextColor:labeltextColor];
    ans3lbl.font=[UIFont fontWithName:labelregularFont size:fontsize];
    [ans3lbl setTextColor:labeltextColor];
    ans3lbl.frame=CGRectMake(10,248,300,49);
    question4lbl.font=[UIFont fontWithName:labelmediumFont size:fontsize];
    [question4lbl setTextColor:labeltextColor];
    ans4lbl.font=[UIFont fontWithName:labelregularFont size:fontsize];
    [ans4lbl setTextColor:labeltextColor];
    question5lbl.font=[UIFont fontWithName:labelmediumFont size:fontsize];
    [question5lbl setTextColor:labeltextColor];
    ans5lbl.font=[UIFont fontWithName:labelregularFont size:fontsize];
    [ans5lbl setTextColor:labeltextColor];
    
    if ([UIScreen mainScreen].bounds.size.height==568) {
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
            question4lbl.frame=CGRectMake(10,300,300,45);
            ans4lbl.frame=CGRectMake(10,315,300,165);
            question5lbl.frame=CGRectMake(10,455, 300,48);
            ans5lbl.frame=CGRectMake(10,500,300,67);
        }
        else
        {
            question4lbl.frame=CGRectMake(10,300,300,45);
            ans4lbl.frame=CGRectMake(10,325,300,165);
            question5lbl.frame=CGRectMake(10,470, 300,48);
            ans5lbl.frame=CGRectMake(10,515,300,67);
        }
    }
    else{
        question4lbl.frame=CGRectMake(10,300,300,45);
        ans4lbl.frame=CGRectMake(10,325,310,165);
        question5lbl.frame=CGRectMake(10,470, 300,48);
        ans5lbl.frame=CGRectMake(10,510,300,67);
    }
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
    tittlelable.text=@"Help";
    //---------------------  Back button --------------------------------------------
	UIButton *btnBack =  [UIButton buttonWithType:UIButtonTypeCustom];
	[btnBack setBackgroundImage:[UIImage imageNamed:@"button_back_60_29.png"] forState:UIControlStateNormal];
    [btnBack setTitle:@"Back" forState:UIControlStateNormal];
	[btnBack addTarget:self action:@selector(BacktoView) forControlEvents:UIControlEventTouchUpInside];
	[btnBack setFrame:CGRectMake(9, 7, 60, 29)];
    btnBack.titleLabel.font=[UIFont fontWithName:labelregularFont size:15];
    [self.view addSubview:btnBack];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)BacktoView
{
	[self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
