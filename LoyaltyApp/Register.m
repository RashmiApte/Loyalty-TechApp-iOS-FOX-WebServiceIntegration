//
//  Register.m
//  LoyaltyApp
//
//  Created by Ajeet Sharma on 3/10/14.
//
//

#import "Register.h"
#import "Constant.h"
#import "CAppDelegate.h"
#import "DataBase.h"
#import "NewAddNewCardInWalletViewController.h"
#import "WebserviceOperation.h"

@interface Register ()

@end

@implementation Register
@synthesize txtConfermPassword,txtEmailId,txtFirstName,txtLastName,txtPassword,scrollViewRegister,imgProfilePic,lblBorderFirstName,lblBorderConfermPassword,lblBorderEmailId,lblBorderLastName,lblBorderPassword,viewPickerView,datePicker,btnClosePicker,btnDonePicker,lblBorderDOB,lblBorderGender,txtGender,txtDOB,pickerGender;

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
    
    lblBorderFirstName.layer.borderColor=[UIColor clearColor].CGColor;
    lblBorderFirstName.layer.borderWidth=1.0;
    lblBorderFirstName.layer.cornerRadius=5.0;
    
    lblBorderLastName.layer.borderColor=[UIColor clearColor].CGColor;
    lblBorderLastName.layer.borderWidth=1.0;
    lblBorderLastName.layer.cornerRadius=5.0;
    
    lblBorderEmailId.layer.borderColor=[UIColor clearColor].CGColor;
    lblBorderEmailId.layer.borderWidth=1.0;
    lblBorderEmailId.layer.cornerRadius=5.0;
    
    lblBorderPassword.layer.borderColor=[UIColor clearColor].CGColor;
    lblBorderPassword.layer.borderWidth=1.0;
    lblBorderPassword.layer.cornerRadius=5.0;
    
    lblBorderConfermPassword.layer.borderColor=[UIColor clearColor].CGColor;
    lblBorderConfermPassword.layer.borderWidth=1.0;
    lblBorderConfermPassword.layer.cornerRadius=5.0;
    
    lblBorderDOB.layer.borderColor=[UIColor clearColor].CGColor;
    lblBorderDOB.layer.borderWidth=1.0;
    lblBorderDOB.layer.cornerRadius=5.0;
    
    lblBorderGender.layer.borderColor=[UIColor clearColor].CGColor;
    lblBorderGender.layer.borderWidth=1.0;
    lblBorderGender.layer.cornerRadius=5.0;
    
    datePicker.datePickerMode=UIDatePickerModeDate;
    
    
    //---------------------- Back button -----------------------------
    
	btnBack=  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"button_home_60_29.png"] forState:UIControlStateNormal];
	[btnBack addTarget:self action:@selector(backToHome:) forControlEvents:UIControlEventTouchUpInside];
    btnBack.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(14.0)];
    [btnBack.titleLabel setTextColor:btntextColor];
    [btnBack setTitle:@"Back" forState:UIControlStateNormal];
	[btnBack setFrame:CGRectMake(5,7, 60, 29)];
    
    
    //---------------------- Back button -----------------------------
    
    btnRegister =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRegister setBackgroundImage:[UIImage imageNamed:@"button_home_60_29.png"]forState:UIControlStateNormal];
    [btnRegister addTarget:self action:@selector(RegisterUser) forControlEvents:UIControlEventTouchUpInside];
    [btnRegister setFrame:CGRectMake(255, 7, 60, 29)];
    btnRegister.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(14.0)];
    [btnRegister.titleLabel setTextColor:btntextColor];
    [btnRegister setTitle:@"Submit" forState:UIControlStateNormal];
    
    
    //--------------------- Design heder of This screen -----------------------------//
    
    UIImageView* imgNavBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_back.png"]];
    [imgNavBack setFrame:CGRectMake(0, 0, 325, 53)];
    
    UILabel *lblHeading =[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 320, 36)];
    lblHeading.text=@"Signup";
    lblHeading.textAlignment=NSTextAlignmentCenter;
    [lblHeading setTextColor:headertitletextColor];
    lblHeading.font = [UIFont fontWithName:labelregularFont size:(22.0)];
    lblHeading.backgroundColor=[UIColor clearColor];
    
    [self.view addSubview:imgNavBack];
    [self.view addSubview:lblHeading];
    [self.view addSubview:btnBack];
    [self.view addSubview:btnRegister];
    
    //----------------------------------------------------------------------------//
    
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openImagePicker:)];
    tapped.numberOfTapsRequired = 1;
    imgProfilePic.userInteractionEnabled=YES;
    [imgProfilePic addGestureRecognizer:tapped];
    //----------------------------------------------------------------------------//
    
    [scrollViewRegister setContentSize:CGSizeMake(0, 600)];
    
    imgProfilePic.layer.masksToBounds = YES;
    imgProfilePic.contentMode = UIViewContentModeScaleAspectFit;
    //[imgProfilePic sizeToFit];
    imgProfilePic.layer.cornerRadius=4.0;
    imgProfilePic.layer.borderWidth=1.0;
    imgProfilePic.backgroundColor=[UIColor blackColor];
    imgProfilePic.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    viewPickerView.backgroundColor=[UIColor clearColor];
    if ([UIScreen mainScreen].bounds.size.height==568) {
        scrollViewRegister.frame=CGRectMake(0, 53, 320, 568-53);
        viewPickerView.frame=CGRectMake(0, 568, 320, 170);
        
    }
    else{
        scrollViewRegister.frame=CGRectMake(0, 53, 320, 480-53);
        viewPickerView.frame=CGRectMake(0, 480, 320, 170);
    }
    
    [self.view addSubview:viewPickerView];
    
    arrayGender=[[NSMutableArray alloc] initWithObjects:@"Male",@"Female", nil];
    arrayPickerView=[[NSMutableArray alloc] init];
    pickerGender.frame=CGRectMake(10, 42, 305, 179);
    // datePicker.frame=CGRectMake(-8, 37, 340, 183);
    
    txtFirstName.keyboardAppearance = (SYSTEM_VERSION_LESS_THAN(@"7.0") ? UIKeyboardAppearanceAlert : UIKeyboardAppearanceDark);
    txtLastName.keyboardAppearance = (SYSTEM_VERSION_LESS_THAN(@"7.0") ? UIKeyboardAppearanceAlert : UIKeyboardAppearanceDark);
    txtEmailId.keyboardAppearance = (SYSTEM_VERSION_LESS_THAN(@"7.0") ? UIKeyboardAppearanceAlert : UIKeyboardAppearanceDark);
    txtPassword.keyboardAppearance = (SYSTEM_VERSION_LESS_THAN(@"7.0") ? UIKeyboardAppearanceAlert : UIKeyboardAppearanceDark);
    txtConfermPassword.keyboardAppearance = (SYSTEM_VERSION_LESS_THAN(@"7.0") ? UIKeyboardAppearanceAlert : UIKeyboardAppearanceDark);
    txtDOB.keyboardAppearance = (SYSTEM_VERSION_LESS_THAN(@"7.0") ? UIKeyboardAppearanceAlert : UIKeyboardAppearanceDark);
    txtGender.keyboardAppearance = (SYSTEM_VERSION_LESS_THAN(@"7.0") ? UIKeyboardAppearanceAlert : UIKeyboardAppearanceDark);
    
    btnRegister.alpha=0.5;
    btnRegister.userInteractionEnabled=NO;
    
    //    btnRegister.hidden=YES;

}
-(void)viewWillAppear:(BOOL)animated{
    
    [self performSelector:@selector(setNavigationFrame) withObject:nil afterDelay:0.01];
    
}

-(void)setNavigationFrame{
    
    [self.view addSubview:scrollViewRegister];
    [self.view bringSubviewToFront:viewPickerView];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        
        CGRect viewBounds = [self.navigationController.view bounds];
        viewBounds.origin.y = 20;
        self.navigationController.view.frame = viewBounds;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIScrollview delegates --------------------------------------------

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"%f",scrollViewRegister.contentOffset.y);
    
    
    
}




#pragma mark - Other methods -----------------------------------------------------

-(void)createScrollview{
    
    
    
}
-(BOOL)validation{
    
    
    NSLog(@"Register user");
    
    if ([txtFirstName.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0){
        //----- Enter first name -----
        
        return NO;
        //        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Message:" message:firstnameentr delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        //        [alertView show];
        
    }
    if ([txtLastName.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0){
        //----- Enter first name -----
        
        return NO;
        //        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Message:" message:firstnameentr delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        //        [alertView show];
        
    }
    else if ([txtEmailId.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0){
        //----- Enter email id -----------
        
        return NO;
        
        //        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Message:" message:emailentr delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        //        [alertView show];
        
        
    }
    
    else if ([txtPassword.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0){
        
        //----- Enter password -------------
        return NO;
        
        //        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Message:" message:enterpwd delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        //        [alertView show];
    }
    
    else if ([txtConfermPassword.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0){
        //----- Enter conferm password -----------------
        return NO;
        
        
        //        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Message:" message:reenterpwd delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        //        [alertView show];
    }
    
    return YES;
    
}

- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}
-(BOOL)validPassword:(NSString*)password{
    
    //    NSString *scPattern = @"[a-z]";
    NSString *cPattern = @"[A-Z]";
    NSString *sPattern = @"[!%&';]";
    NSString *nPattern = @"[0-9]";
    
    BOOL capsCheck,symbolCheck,digitCheck;
    
    //--------- check for at least one caps
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:cPattern options:0 error:nil];
    NSArray *matches = [regex matchesInString:password options:0 range:NSMakeRange(0, password.length)];
    capsCheck=matches.count>0;
    //----------
    
    //--------- check for disallow of some symbols
    regex = [NSRegularExpression regularExpressionWithPattern:sPattern options:0 error:nil];
    matches = [regex matchesInString:password options:0 range:NSMakeRange(0, password.length)];
    symbolCheck=matches.count>0;
    //----------
    
    //--------- check for atleast one digit
    regex = [NSRegularExpression regularExpressionWithPattern:nPattern options:0 error:nil];
    matches = [regex matchesInString:password options:0 range:NSMakeRange(0, password.length)];
    digitCheck=matches.count>0;
    //----------
    
    if (!capsCheck) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Message:" message:passwordAtleastOneCaps delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
        return YES;
        
        
    }
    else if (symbolCheck){
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Message:" message:specialcharacterpwd delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
        return YES;
        
    }
    else if (!digitCheck){
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Message:" message:alphanumericvalueinPWd delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
        return YES;
        
    }
    
    
    
    
    
    return NO;
    
}

#pragma mark - UIActionsheet  delegates ----------------------------------

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    
    imagePicker.delegate = self;
    
    if (buttonIndex!=2) {
        
        [self.scrollViewRegister removeFromSuperview];
        
        if (buttonIndex==0) {
            imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        }
        else if (buttonIndex==1){
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera
                ;
            }
            else{
                //                UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Message:" message:@"Camera is not availabel" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                //                [alertView show];
                //
                
            }
            
        }
        
        CAppDelegate *appdelegate=(CAppDelegate*)[UIApplication sharedApplication].delegate;
        // NSLog(@"---- -- -- - %@",NSStringFromCGRect(appdelegate.window.frame));
        imagePicker.allowsEditing=YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    
}


#pragma mark - UIButton methods --------------------------------------------------

-(IBAction)openDatePicker:(id)sender{
    
    [self.view endEditing:YES];
    [txtFirstName resignFirstResponder];
    [txtLastName resignFirstResponder];
    [txtEmailId resignFirstResponder];
    [txtPassword resignFirstResponder];
    [txtConfermPassword resignFirstResponder];
    [txtDOB resignFirstResponder];
    [txtGender resignFirstResponder];
    
    datePicker.hidden=NO;
    pickerGender.hidden=YES;
    
    
    NSLog(@"Animate view 2");
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25f];
    [viewPickerView setFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height-225,320,210)];
    [UIView commitAnimations];
    
    
}
-(IBAction)openGenderPicker:(id)sender{
    
    [self.view endEditing:YES];
    
    datePicker.hidden=YES;
    pickerGender.hidden=NO;
    
    arrayPickerView=arrayGender;
    [pickerGender reloadAllComponents];
    
    NSLog(@"Animate view 3");
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25f];
    [viewPickerView setFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height-225,320,210)];
    [UIView commitAnimations];
    
    
    
}

-(IBAction)pickerClosePicker:(id)sender{
    
    NSLog(@"Close Picker");
    
    [self.scrollViewRegister setContentOffset:CGPointMake(0, 0) animated:YES];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25f];
    [viewPickerView setFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height,320,210)];
    [UIView commitAnimations];
    
}
-(IBAction)pickerDonePicker:(id)sender{
    
    NSLog(@"Done Picker");
    
    [self.scrollViewRegister setContentOffset:CGPointMake(0, 0) animated:YES];
    
    
    if (datePicker.isHidden)
    {
        
        
        txtGender.text=[arrayPickerView objectAtIndex:[pickerGender selectedRowInComponent:0]];
        NSLog(@"Animate view 1");
        
        
        
        
    }
    else
    {
        
        NSLog(@"Done Action datePicker.date==>%@",datePicker.date);
        
        NSArray *arrayDOB=[[ NSString stringWithFormat:@"%@", datePicker.date ] componentsSeparatedByString:@" "];
        NSArray *arrayDate=[[NSString stringWithFormat:@"%@",[arrayDOB objectAtIndex:0]] componentsSeparatedByString:@"-"];
        NSString *strDOB=[NSString stringWithFormat:@"%@/%@/%@",[arrayDate objectAtIndex:2],[arrayDate objectAtIndex:1],[arrayDate objectAtIndex:0]];
        txtDOB.text=strDOB;
        
        
        
        
    }
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25f];
    [viewPickerView setFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height,320,210)];
    [UIView commitAnimations];
    
    
    
}

-(void)backToHome:(id)sender{
    
    
    NSLog(@"back To Home");
    
    NSArray *arrayViewcontroller=[self.navigationController viewControllers];
    
    NSInteger arraySize=[[self.navigationController viewControllers] count];
    
    [self.navigationController popToViewController:[arrayViewcontroller objectAtIndex:arraySize-3] animated:YES];
    
    
    
    
}

-(void)RegisterUser
{
    
    NSLog(@"Register user");
    
    
    
     
     // validation --------
     if ([txtFirstName.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0){
     //----- Enter first name ---------
      lblBorderFirstName.layer.borderColor=[UIColor redColor].CGColor;
     
     UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Message:" message:firstnameentr delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
     [alertView show];
     
     }
     else  if ([txtLastName.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0){
         //----- Enter last name ---------
          lblBorderLastName.layer.borderColor=[UIColor redColor].CGColor;
         
         UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Message:" message:lastnameentr delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
         [alertView show];
         
     }
     else if ([txtEmailId.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0){
     //----- Enter email id -----------
       lblBorderEmailId.layer.borderColor=[UIColor redColor].CGColor;
     UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Message:" message:emailentr delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
     [alertView show];
     
     
     }
     else if (![self validateEmail:txtEmailId.text]){
     
     //------ Invalid email id ---------
     
      lblBorderEmailId.layer.borderColor=[UIColor redColor].CGColor;
     [txtEmailId becomeFirstResponder];
     UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Message:" message:validemailid delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
     [alertView show];
     
     }
     else if ([txtPassword.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0){
     
     //----- Enter password -------------
       lblBorderPassword.layer.borderColor=[UIColor redColor].CGColor;
     
     UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Message:" message:enterpwd delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
     [alertView show];
     }
     
     else if ([txtPassword.text stringByReplacingOccurrencesOfString:@" " withString:@""].length<8){
     //----- min 8 character in  password -----------
       lblBorderPassword.layer.borderColor=[UIColor redColor].CGColor;
     
     UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Message:" message:passwordminimunlegnth delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
     [alertView show];
     
     }
     else if ([self validPassword:txtPassword.text]){
     
     // not valid----
     
    lblBorderPassword.layer.borderColor=[UIColor redColor].CGColor;
     
     
     
     }
     else if ([txtConfermPassword.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0){
     //----- Enter conferm password -----------------
     
      lblBorderConfermPassword.layer.borderColor=[UIColor redColor].CGColor;
     
     UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Message:" message:reenterpwd delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
     [alertView show];
     }
     else if (![txtPassword.text isEqualToString:txtConfermPassword.text]){
     
      lblBorderPassword.layer.borderColor=[UIColor redColor].CGColor;
     
     UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Message:" message:bothpwdsame delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
     [alertView show];
     }
     
     else{
     
     NSData *dataForImage1;
     UIImage *image1=imgProfilePic.image;
     dataForImage1 = UIImageJPEGRepresentation(image1, 1.0);
     NSString  *strImageProfile=[self performSelector:@selector(Base64Encode:) withObject:dataForImage1];
     
     strImageProfile=@"";
         
  
     //  NSLog(@"strImageProfile = %@",strImageProfile);
     
     
     WebserviceOperation *service=[[WebserviceOperation alloc] initWithDelegate:self callback:@selector(registerHandler:)];
     
     YPRegisterRequest *serviceRegister=[[YPRegisterRequest alloc] init];
         
         if (txtDOB.text.length>0) {
             NSString *strDOB=txtDOB.text;
             strDOB=[strDOB stringByReplacingOccurrencesOfString:@"/" withString:@""];
             serviceRegister.DOB=strDOB;
         }
         else{
         txtDOB.text=@"";
         }
         
         serviceRegister.firstName=txtFirstName.text;
         if ([txtGender.text isEqualToString:@"Male"]) {
             serviceRegister.gender=@"M";
         }
         else if ([txtGender.text isEqualToString:@"Female"]){
             serviceRegister.gender=@"F";
         }
         else{
         serviceRegister.gender=@"";
         }
         serviceRegister.lastName=txtLastName.text;
         serviceRegister.password=txtPassword.text;
         serviceRegister.profilePic=strImageProfile;
         serviceRegister.profilePictureName=@"ProfilePic";
         serviceRegister.userID=txtEmailId.text;
         serviceRegister.valid=true;
         serviceRegister.versionID=@"100";
         
         [service registerUser:serviceRegister];
     
     
     
     }
    
    
    
    
    
    /*
     
     WebserviceOperation *service=[[WebserviceOperation alloc] initWithDelegate:self callback:@selector(registerHandler:)];
     
     YPAddCardRequest *obj=[[YPAddCardRequest alloc] init];
     
     [service registerUser:obj];
     
     */
    
  //  NewAddNewCardInWalletViewController *objAddNewCard=[[NewAddNewCardInWalletViewController alloc] init];
   // [self.navigationController pushViewController:objAddNewCard animated:YES];
    
}
-(void)registerHandler:(id)value{
    
    
    NSLog(@"registerHandler");
    
    
}

-(void)openImagePicker:(id) sender
{
    [self.view endEditing:YES];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25f];
    [viewPickerView setFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height,320,210)];
    [UIView commitAnimations];
    
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Profile pic" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Photo from album",@"Capture Photo",nil];
    popup.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    [popup setBackgroundColor:[UIColor whiteColor]];
    [popup showInView:self.view];
}

#pragma mark - UITextfield delegates -------------------------------------
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //    if (textField==txtDOB || textField==txtGender)
    //    {
    //        return NO;
    //    }
    //
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField==txtDOB)
    {
        [self performSelector:@selector(hideKeyboard) withObject:nil afterDelay:0.000001];
        
        datePicker.hidden=NO;
        pickerGender.hidden=YES;
        
        if ([UIScreen mainScreen].bounds.size.height!=568) {
            [self.scrollViewRegister setContentOffset:CGPointMake(0, 121) animated:YES];
        }
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25f];
        [viewPickerView setFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height-225,320,210)];
        [UIView commitAnimations];
    }
    else if (textField==txtGender){
        
        [self performSelector:@selector(hideKeyboard) withObject:nil afterDelay:0.000001];
        
        if ([UIScreen mainScreen].bounds.size.height!=568) {
            [self.scrollViewRegister setContentOffset:CGPointMake(0, 121) animated:YES];
        }
        else{
            [self.scrollViewRegister setContentOffset:CGPointMake(0, 28) animated:YES];
            
            
        }
        datePicker.hidden=YES;
        pickerGender.hidden=NO;
        arrayPickerView=arrayGender;
        [pickerGender reloadAllComponents];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25f];
        [viewPickerView setFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height-225,320,210)];
        [UIView commitAnimations];
        
    }
    
    else{
        
        if (txtConfermPassword==textField) {
            if ([UIScreen mainScreen].bounds.size.height!=568) {
                [self.scrollViewRegister setContentOffset:CGPointMake(0, 37) animated:YES];
            }
        }
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25f];
        [viewPickerView setFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height,320,210)];
        [UIView commitAnimations];
        
    }
    
    
}

-(void)hideKeyboard{
    
    [self.view endEditing:YES];
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    if (textField==txtFirstName) {
        [txtLastName becomeFirstResponder];
        
    }
    else if (textField==txtLastName) {
        [txtEmailId becomeFirstResponder];
        
    }
    else if (textField==txtEmailId) {
        [txtPassword becomeFirstResponder];
        
    }
    else if (textField==txtPassword) {
        [txtConfermPassword becomeFirstResponder];
        
    }
    else if (textField==txtConfermPassword) {
        
        [txtDOB becomeFirstResponder];
        
        
    }
    else if (textField==txtDOB) {
        
        [txtGender becomeFirstResponder];
        
    }
    
    
    return YES;
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    [self performSelector:@selector(validationDelay) withObject:Nil afterDelay:0.2];
    
    
    if (textField==txtFirstName) {
        if ([string isEqualToString:@" "]) {
            //space not allowed in first name field -------
            return NO;
        }
        else if(txtFirstName.text.length==50){
            // maximum lenght of first name is 50 character ------
            return NO;
        }
        else{
            lblBorderFirstName.layer.borderColor=[UIColor clearColor].CGColor;
            lblBorderLastName.layer.borderColor=[UIColor clearColor].CGColor;
            lblBorderPassword.layer.borderColor=[UIColor clearColor].CGColor;
            lblBorderConfermPassword.layer.borderColor=[UIColor clearColor].CGColor;
            lblBorderEmailId.layer.borderColor=[UIColor clearColor].CGColor;
            
            return YES;
        }
    }
    if (textField==txtLastName) {
        if ([string isEqualToString:@" "]) {
            //space not allowed in last name field -------
            return NO;
        }
        else if(txtLastName.text.length==50){
            // maximum lenght of last name is 50 character ------
            return NO;
        }
        else{
            lblBorderFirstName.layer.borderColor=[UIColor clearColor].CGColor;
            lblBorderLastName.layer.borderColor=[UIColor clearColor].CGColor;
            lblBorderPassword.layer.borderColor=[UIColor clearColor].CGColor;
            lblBorderConfermPassword.layer.borderColor=[UIColor clearColor].CGColor;
            lblBorderEmailId.layer.borderColor=[UIColor clearColor].CGColor;
            return YES;
        }
    }
    
    if (textField==txtPassword) {
        if ([string isEqualToString:@" "]) {
            //space not allowed in password field -------
            return NO;
        }
        else if(txtPassword.text.length==15){
            // maximum lenght of password is 50 character ------
            return NO;
        }
        else{
        
            lblBorderFirstName.layer.borderColor=[UIColor clearColor].CGColor;
            lblBorderLastName.layer.borderColor=[UIColor clearColor].CGColor;
            lblBorderPassword.layer.borderColor=[UIColor clearColor].CGColor;
            lblBorderConfermPassword.layer.borderColor=[UIColor clearColor].CGColor;
            lblBorderEmailId.layer.borderColor=[UIColor clearColor].CGColor;
            return YES;
            
        }
    }
    
    if (textField==txtConfermPassword) {
        if ([string isEqualToString:@" "]) {
            //space not allowed in conferm password field -------
            return NO;
        }
        else if(txtConfermPassword.text.length==15){
            // maximum lenght of conferm password is 50 character ------
            return NO;
        }
        else{
            
            lblBorderFirstName.layer.borderColor=[UIColor clearColor].CGColor;
            lblBorderLastName.layer.borderColor=[UIColor clearColor].CGColor;
            lblBorderPassword.layer.borderColor=[UIColor clearColor].CGColor;
            lblBorderConfermPassword.layer.borderColor=[UIColor clearColor].CGColor;
            lblBorderEmailId.layer.borderColor=[UIColor clearColor].CGColor;
            return YES;
            
        }
    }
    
    if (textField==txtEmailId) {
        if ([string isEqualToString:@" "]) {
            //space not allowed in email id -------
            return NO;
        }
        else if(txtEmailId.text.length==50){
            // maximum lenght of email id is 50 character ------
           

            return NO;
        }
        else{
            lblBorderFirstName.layer.borderColor=[UIColor clearColor].CGColor;
            lblBorderLastName.layer.borderColor=[UIColor clearColor].CGColor;
            lblBorderPassword.layer.borderColor=[UIColor clearColor].CGColor;
            lblBorderConfermPassword.layer.borderColor=[UIColor clearColor].CGColor;
            lblBorderEmailId.layer.borderColor=[UIColor clearColor].CGColor;
            return YES;
            
        }
    }
    
    
    
    return YES;
    
    
}
-(void)validationDelay{
    
    if ([self validation]) {
        btnRegister.alpha=1;
        btnRegister.userInteractionEnabled=YES;
        
        
    }
    else{
        
        btnRegister.userInteractionEnabled=NO;
        
        btnRegister.alpha=0.5;
        
    }
    
}

#pragma mark - UIImagepickerView  delegates ----------------------------------


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    NSLog(@"captured image size --- %@",NSStringFromCGSize(image.size));
    NSLog(@"imgProfilePic size --- %@",NSStringFromCGSize(imgProfilePic.frame.size));
    
    CGSize sizeOfimageview=CGSizeMake(imgProfilePic.frame.size.width*2, imgProfilePic.frame.size.height*2);
    
    
    //  [imgProfilePic setImage:[self imageWithImage:image convertToSize:sizeOfimageview]];
    
    [imgProfilePic setImage:[self imageWithImage:image scaledToWidth:sizeOfimageview.width]];
    
    NSLog(@"captured converted image size --- %@",NSStringFromCGSize(imgProfilePic.image.size));
    
    NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation((imgProfilePic.image), 0.5)];
    int imageSize = imageData.length;
    
    NSLog(@"SIZE OF IMAGE: %i ", imageSize);
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    
    
    //    NSLog(@"%@",NSStringFromCGRect(self.navigationController.view.frame));
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    
    if ([navigationController isKindOfClass:[UIImagePickerController class]]) {
        
        
        
        //       [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
}


#pragma mark - Image editing -------------------------------------------------------------

-(NSString *)Base64Encode:(NSData *)theData{
	
	const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] ;
    
}


- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

-(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - UIPicker view delegates ----------------------------------------------------



-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 300;
}



- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    //UILabel *label;
    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.frame=CGRectMake(25, 0, 280, 37);
    label.text= [arrayPickerView objectAtIndex:row];
    
    
    return label;
}



-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return [arrayPickerView count];
    
}


@end
