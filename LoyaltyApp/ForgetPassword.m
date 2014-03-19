//
//  ForgetPassword.m
//  LoyaltyApp
//
//  Created by Ajeet Sharma on 2/24/14.
//
//

#import "ForgetPassword.h"
#import "Common.h"
#import "Constant.h"
#import <CommonCrypto/CommonDigest.h>

@interface ForgetPassword ()

@end

@implementation ForgetPassword
@synthesize imgBottomImage,imgOnline,txtEmailId;


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
    
    
   
    
    
    //--------------------- Done button ----------------------------------------
    
	UIButton *btnDone =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDone setBackgroundImage:[UIImage imageNamed:@"button_home_60_29.png"] forState:UIControlStateNormal];
	[btnDone addTarget:self action:@selector(Done:) forControlEvents:UIControlEventTouchUpInside];
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
   
    
	[btnDone setFrame:CGRectMake(250,7,60,29)];
    btnDone.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(14.0)];
    [btnDone.titleLabel setTextColor:btntextColor];
    
    
    //-----------------------------------------------------------------------------
    
    //---------------------- Back button ------------------------------------------
    
	UIButton *btnBack =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"button_home_60_29.png"] forState:UIControlStateNormal];
	[btnBack addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    btnBack.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(14.0)];
    [btnBack.titleLabel setTextColor:btntextColor];
    [btnBack setTitle:@"Back" forState:UIControlStateNormal];
    btnBack.titleLabel.font=[UIFont fontWithName:labelregularFont size:15];
    
	[btnBack setFrame:CGRectMake(10,7, 60, 29)];
    
    //--------------------- Design heder of This screen ---------------------------
    
    CGRect re= CGRectMake(0, 0, 320, 53);
    UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_back.png"]];
    UILabel *lbl =[[UILabel alloc]init];
    CGRect lblrect= CGRectMake(0, 8, 320, 23);// 73, 10, 142, 23
    lbl.frame=lblrect;
    lbl.text=@"Reset Password";
    [lbl setTextColor:headertitletextColor];
    lbl.font = [UIFont fontWithName:labelregularFont size:(22.0)];
    lbl.backgroundColor=[UIColor clearColor];
    [img addSubview:lbl];
    img.frame=re;
    
    //-----------------------------------------------------------------------------
    lbl.backgroundColor=[UIColor clearColor];
    lbl.textAlignment=NSTextAlignmentCenter;
    
    img.frame=re;
    [self.view addSubview:img];
    [img addSubview:lbl];
    [self.view addSubview:btnBack];
    [self.view addSubview:btnDone];
    //-----------------------------------------------------------------------------
    
    
    
    //--------------- Check condition for iPhone 4/ 4s and set frames -------------
    if ([[UIScreen mainScreen] bounds].size.height != 568)
    {
        imgBottomImage.frame=CGRectMake(0, 320, 320, 140);
        imgOnline.frame=CGRectMake(258, 375, 42, 9);

    }
    //------------------------------------------------------------------------------
}
-(void)viewWillAppear:(BOOL)animated{

    if([Common isNetworkAvailable])
	{
		
        imgOnline.image=[UIImage imageNamed:@"online.png"];
        
	}
	else {
		
        imgOnline.image=[UIImage imageNamed:@"offline.png"];
	}
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIButton methods -----------------------------------------
-(void)Done:(id)sender{

    
    

}


-(void)back:(id)sender{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


#pragma mark - Other methods  ------------------------------------------------


- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}


-(NSString*) sha256:(NSString *)cipherPassword
{
    const char *s=[cipherPassword cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData=[NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(keyData.bytes, keyData.length, digest);
    NSData *out=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}

#pragma mark - Status bar ------------------------------------------------------

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end
