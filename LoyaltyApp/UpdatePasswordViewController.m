//
//  UpdatePasswordViewController.m
//  YesPayCardHolderWallet
//
//  Created by Nirmal Patidar on 04/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UpdatePasswordViewController.h"
#import "CAppDelegate.h"
#import "Constant.h"
#import "Common.h"
#import "DataBase.h"
#import <CommonCrypto/CommonDigest.h>
#import "YPUpdatePasswordRequest.h"
#import "YPUpdatePasswordResponse.h"
#import "WebserviceOperation.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"

extern NSMutableDictionary *addObject;

#define kNumPadReturnButtonTag 500
@implementation UpdatePasswordViewController

@synthesize holdertextfield;
@synthesize imgOnline;
@synthesize txtConfirmPassword,txtNewPassword,txtOldPassword;
@synthesize lblBorderOldPassword,lblBorderNewPassword,lblBorderReEnterPassword;
@synthesize pwdchangeimage;





UIButton *doneButton;
BOOL emailFlag,passwordFlag;
BOOL isProcess;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */

#pragma mark - UIViewController Functions ------------------------

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    isProcess=YES;
    
	if([Common isNetworkAvailable])
	{
		//isNetwork.text= NSLocalizedString(@"NetWork Available", @"");
        imgOnline.image=[UIImage imageNamed:@"online.png"];
	}
	else {
        imgOnline.image=[UIImage imageNamed:@"offline.png"];
	}
	
	appdelegate = (CAppDelegate*)[[UIApplication sharedApplication] delegate];
	[self setTitle:@"Update Password"];
    
    //----------- set frames ----------------------------------------
    //added by Ankit jain 12/nov/2013
    CGRect textfieldframe=CGRectMake(3,7,283,36);
    holdertextfield = [[UITextField alloc] initWithFrame:textfieldframe];
    //----------------------------------------------------------------
	
    
    
    
    
    //--------------------- Submit button ---------------------------
    
	UIButton *btnSubmit =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSubmit setBackgroundImage:[UIImage imageNamed:@"button_home_60_29.png"] forState:UIControlStateNormal];
	[btnSubmit addTarget:self action:@selector(UpdatePassword) forControlEvents:UIControlEventTouchUpInside];
    [btnSubmit setTitle:@"Submit" forState:UIControlStateNormal];
	[btnSubmit setFrame:CGRectMake(253,7,60,29)];//0, 0, 76, 44
    btnSubmit.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(14.0)];
    [btnSubmit.titleLabel setTextColor:btntextColor];
    
    
    //----------------------------------------------------------------
  
    
    //--------------------- Design heder of This screen --------------
    
    CGRect re= CGRectMake(0, 0, 320, 53);
    UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_back.png"]];
    UILabel *lbl =[[UILabel alloc]init];
    CGRect lblrect= CGRectMake(80, 8, 180, 23);// 73, 10, 142, 23
    lbl.frame=lblrect;
    lbl.text=@"Change Password";
    [lbl setTextColor:headertitletextColor];
    lbl.font = [UIFont fontWithName:labelregularFont size:(22.0)];
    lbl.backgroundColor=[UIColor clearColor];
    [img addSubview:lbl];
    img.frame=re;
    
    //----------- set delegate to textfield objects ----------------
    
    [holdertextfield setDelegate:self];
    
    //----------------------------------------------------------------
    
    
    
    lbl.backgroundColor=[UIColor clearColor];
    
    img.frame=re;
    [self.view addSubview:img];
    [img addSubview:lbl];
    [self.view addSubview:btnSubmit];
    //-------------------------------------------------------------
    
    if ([UIScreen mainScreen].bounds.size.height != 568)
    {
        
        imgOnline.frame=CGRectMake(260, 445, 42, 9);
    }
    
    /******************* New code *************************/
    
    [txtOldPassword setKeyboardAppearance:UIKeyboardAppearanceAlert];
    txtOldPassword.font=[textFieldnewTextFont];
    [txtOldPassword setTextColor:textFieldTextColor];
    [txtOldPassword setValue:placeholdertexfield];
    
    [txtNewPassword setKeyboardAppearance:UIKeyboardAppearanceAlert];
    txtNewPassword.font=[textFieldnewTextFont];
    [txtNewPassword setTextColor:textFieldTextColor];
    [txtNewPassword setValue:placeholdertexfield];
    
    [txtConfirmPassword setKeyboardAppearance:UIKeyboardAppearanceAlert];
    txtConfirmPassword.font=[textFieldnewTextFont];
    [txtConfirmPassword setTextColor:textFieldTextColor];
    [txtConfirmPassword setValue:placeholdertexfield];
    
    
    
    /******************************************************/
    
    //----------------------------Drawerleftbutn-Added by Ankit jain 3 Mar 2014----------------------
    
    btndrawerleft = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btndrawerleft.frame = CGRectMake(15,5,32, 32);
    btndrawerleft.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [btndrawerleft addTarget:self action:@selector(_addRightTapped:) forControlEvents:UIControlEventTouchUpInside];
    [btndrawerleft setBackgroundImage:[UIImage imageNamed:@"drawer.png"] forState:UIControlStateNormal];
    [self.view addSubview:btndrawerleft];
	//-------------------------------------------------------------------------------
    
    
    
    lblBorderOldPassword.layer.borderColor=[UIColor clearColor].CGColor;
    lblBorderOldPassword.layer.borderWidth=1.0;
    lblBorderOldPassword.layer.cornerRadius=5.0;
    
    lblBorderNewPassword.layer.borderColor=[UIColor clearColor].CGColor;
    lblBorderNewPassword.layer.borderWidth=1.0;
    lblBorderNewPassword.layer.cornerRadius=5.0;
 
    
    lblBorderReEnterPassword.layer.borderColor=[UIColor clearColor].CGColor;
    lblBorderReEnterPassword.layer.borderWidth=1.0;
    lblBorderReEnterPassword.layer.cornerRadius=5.0;
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tgr.delegate = self;
    [self.pwdchangeimage addGestureRecognizer:tgr]; // or [self.view addGestureRecognizer:tgr];
    
   
        
    
}

- (void)viewTapped:(UITapGestureRecognizer *)tgr
{
    NSLog(@"view tapped");
    // remove keyboard
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UIImageView class]]) {
        //[self.sidePanelController toggleLeftPanel:touch];
        [self.view endEditing:YES];
    }
    return YES; // do whatever u want here
}



-(void)viewDidAppear:(BOOL)animated
{
	CGFloat navBarHeight = 50.0f;
	CGRect frame = CGRectMake(0.0f, 20.0f, 320.0f, navBarHeight);
	[self.navigationController.navigationBar setFrame:frame];
	[super viewDidAppear:animated];
    [txtOldPassword becomeFirstResponder];
	
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


-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    
    //[txtOldPassword becomeFirstResponder];
    
    if([Common isNetworkAvailable])
    {
        imgOnline.image=[UIImage imageNamed:@"online.png"];
    }
    else {
        imgOnline.image=[UIImage imageNamed:@"offline.png"];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:networkconnectiontitle message:networkconnectionmessage  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert setTag:111];
        [alert show];
    }
    
    
}



-(void)viewWillDisappear:(BOOL)animated{
    [txtOldPassword resignFirstResponder];
    [txtNewPassword resignFirstResponder];
    [txtConfirmPassword resignFirstResponder];
    
    [self.navigationController setNavigationBarHidden:NO];
}
-(void)viewDidDisappear:(BOOL)animated
{
    
    
}



#pragma mark - Other method --------------------------------

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


#pragma mark - Button methods ------------------------------


-(void)goBackToSettings
{
    
    [self.navigationController popViewControllerAnimated:YES];
        
}
-(int)alphanumericvalue
{
    
    int i;
    
    NSString *originalString = txtNewPassword.text;
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    while ([scanner isAtEnd] == NO) {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer])
        {
            i=0;
            
        }else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }
    NSMutableCharacterSet* testCharSet = [[NSMutableCharacterSet alloc] init];
    [testCharSet formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
    NSUInteger length = [originalString length];
    NSUInteger totalNonAlnumCharacters = length;
    for( NSUInteger i = 0; i < length; i++ ) {
        if( [testCharSet characterIsMember:[originalString characterAtIndex:i]] )
            totalNonAlnumCharacters--;
    }
    if (totalNonAlnumCharacters < length) {
        // passwordFlag = FALSE;
        i=1;
    }
    if(i==0)
    {
        NSRegularExpression *regex = [[NSRegularExpression alloc]
                                      initWithPattern:@"[a-zA-Z]" options:0 error:NULL];
        
        // Assuming you have some NSString `myString`.
        NSUInteger matches = [regex numberOfMatchesInString:txtNewPassword.text options:0
                                                      range:NSMakeRange(0, [txtNewPassword.text length])];
        
        if (matches > 0) {
            // `myString` contains at least one English letter.
            i=0;
        }
        else{
            i=2;
        }
        
        
    }
    else
    {
        i=1;
        
    }
    
    return i;
    
}
-(void)UpdatePassword
{
    isProcess=NO;
	emailFlag = FALSE;
    
	NSString *passwordStr;
    NSIndexPath *middleIndexPath;
	
	if([txtOldPassword.text stringByReplacingOccurrencesOfString:@" " withString:@""].length!=0)
	{
		if([txtNewPassword.text stringByReplacingOccurrencesOfString:@" " withString:@""].length!=0)
		{
            passwordStr = txtNewPassword.text;
            if ([passwordStr length] > 7 && [passwordStr length]<16)
            {
                int validatevalue=[self alphanumericvalue];
                
                
                if(validatevalue==1)
                {
                    isProcess=YES;
                  //  [tableUpdatePassword scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                    lblBorderNewPassword.layer.borderColor=[UIColor redColor].CGColor;
                    [txtNewPassword becomeFirstResponder];
                    
                    [self currenttextfield:txtNewPassword alerttitle:unabletoupdatecard alertmessage:alphanumericvalueinPWd];
                    
                }else{
                    if (validatevalue==2){
                        isProcess=YES;
                    //    [tableUpdatePassword scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                        lblBorderNewPassword.layer.borderColor=[UIColor redColor].CGColor;
                        [txtNewPassword becomeFirstResponder];
                        [self currenttextfield:txtNewPassword alerttitle:unabletoupdatecard alertmessage:alphanumericvalueinalphabet];
                    }
                    else {
                        if(validatevalue==0)
                        {
                            if([txtConfirmPassword.text stringByReplacingOccurrencesOfString:@" " withString:@""].length!=0)
                            {
                                
                                if([txtNewPassword.text isEqualToString:txtConfirmPassword.text])
                                {
                                    if([Common isNetworkAvailable])
                                    {
                                        [self showHUD:dataupdatinghud];
                                        
                                        lblBorderReEnterPassword.layer.borderColor=[UIColor clearColor].CGColor;
                                        lblBorderOldPassword.layer.borderColor=[UIColor clearColor].CGColor;
                                        lblBorderNewPassword.layer.borderColor=[UIColor clearColor].CGColor;
                                        
                                        
                                        WebserviceOperation *serviceUpdateOpertion=[[WebserviceOperation alloc] initWithDelegate:self callback:@selector(updatePasswordHandlers:)];
                                        YPUpdatePasswordRequest *updateRequest=[[YPUpdatePasswordRequest alloc] init];
                                        
                                        
                                        
                                        

                                        updateRequest.SC = appdelegate.SC;
                                        updateRequest.userName = appdelegate.userName;
                                        updateRequest.valid =TRUE;
                                        updateRequest.applicationType = @"M";
                                        updateRequest.oldPassword = txtOldPassword.text;
                                        updateRequest.nPassword= txtNewPassword.text;
                                        NSLog(@"password send succesfully..%@",txtNewPassword.text);
                                        [serviceUpdateOpertion updatePassword:updateRequest];
                                        
                                        
                                    }
                                    else {
                                        isProcess=YES;
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:networkconnectiontitle message:networkconnectionmessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                        [alert show];
                                        imgOnline.image=[UIImage imageNamed:@"offline.png"];
                                    }
                                }else{
                                    isProcess=YES;
                                    
                                //    [tableUpdatePassword scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                                    lblBorderNewPassword.layer.borderColor=[UIColor redColor].CGColor;
                                    [txtNewPassword  becomeFirstResponder];
                                    
                                    [self currenttextfield:txtNewPassword alerttitle:unabletoupdatecard alertmessage:bothpwdsame];
                                    
                                }
                            }
                            else{
                                isProcess=YES;
                               // [tableUpdatePassword scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                                lblBorderReEnterPassword.layer.borderColor=[UIColor redColor].CGColor;
                                [txtConfirmPassword becomeFirstResponder];
                                [self currenttextfield:txtConfirmPassword alerttitle:unabletoupdatecard alertmessage:reenternewpwd];
                            }
                        }
                    }
                }
                
            }
            else
            {
                isProcess=YES;
                
              //  [tableUpdatePassword scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                lblBorderNewPassword.layer.borderColor=[UIColor redColor].CGColor;
                [txtNewPassword becomeFirstResponder];
                [self currenttextfield:txtNewPassword alerttitle:unabletoupdatecard alertmessage:passwordminimunlegnth];
                txtNewPassword.text=NULL;
                txtConfirmPassword.text=NULL;
            }
			
		}
		else
		{
			isProcess=YES;
           // [tableUpdatePassword scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
            lblBorderNewPassword.layer.borderColor=[UIColor redColor].CGColor;
            [txtNewPassword becomeFirstResponder];
            [self currenttextfield:txtNewPassword alerttitle:unabletoupdatecard alertmessage:enternewpwd];
		}
	}
	else
	{
		isProcess=YES;
       // [tableUpdatePassword scrollToRowAtIndexPath:middleIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        lblBorderOldPassword.layer.borderColor=[UIColor redColor].CGColor;
        [txtOldPassword becomeFirstResponder];
        
        [self currenttextfield:txtOldPassword alerttitle:unabletoupdatecard alertmessage:enteroldpwd];
	}
    
}
//Added by Ankit jain 8/nov/2013
-(void)currenttextfield:(UITextField *)textfieldvalue alerttitle:(NSString *)alerttitlestr alertmessage:(NSString *)alertmessagestr
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alerttitlestr message:alertmessagestr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
//    double delayInSeconds = .2;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        [textfieldvalue becomeFirstResponder];
//        textfieldvalue.layer.borderWidth=1;
//        textfieldvalue.layer.borderColor = TextfieldErrorColor.CGColor;
//        if(textfieldvalue!=holdertextfield)
//        {
//            holdertextfield.layer.cornerRadius=5;
//            holdertextfield.layer.borderWidth=0;
//            holdertextfield=textfieldvalue;
//        }
//    });
    
}


#pragma mark Other Funtions ------------------------------

//handle the Response of updatePassword
-(void)updatePasswordHandlers:(id)value
{
    
    holdertextfield.layer.cornerRadius=5;
    holdertextfield.layer.borderWidth=0;
    
    [self killHUD];
    
    
    YPUpdatePasswordResponse *updatePasswordResponse=[[YPUpdatePasswordResponse alloc] init];
    
    [updatePasswordResponse parsingUpdatePassword:value];
    
    
    
    
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		isProcess=YES;
		UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:unabletoupdatecard message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
		return;
	}
	
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		isProcess=YES;
		NSLog(@"%@", value);
        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:unabletoupdatecard message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
		return;
	}
	
	
    
    
	// Do something with the YPLoginResponse* result
	if(updatePasswordResponse.statusCode == 0)
	{
		isProcess=YES;
        enString=[self sha256:txtNewPassword.text];
        
        
		NSString *updateQuery = @"Update Login set password = ";
		updateQuery = [updateQuery stringByAppendingString:[NSString stringWithFormat:@"'%@' where id = %@",enString,appdelegate.userID]];
		[DataBase UpadteTable:updateQuery];
		updateQuery = @"Update UserInfo set password = ";
		updateQuery = [updateQuery stringByAppendingString:[NSString stringWithFormat:@"'%@' where userid = %@",enString,appdelegate.userID]];
		[DataBase UpadteTable:updateQuery];
        
		
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:pwdupdatesuccessfully delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert setTag:123];
        [alert show];
        
	}
    
	else{
        isProcess=YES;
        [self cardholderalertmessages:updatePasswordResponse.statusCode message:updatePasswordResponse.responseMessage];
		
	}
}

//Added by Ankit jain 5/Dec/2013
-(void)cardholderalertmessages:(int)statuscodevalue message:(NSString *)responsemessage
{
    switch (statuscodevalue)
    {
        case 1:
            NSLog (@"zero");
            [self commonalert:unabletoupdatecard message:statuscode1];
            break;
        case 4:
            NSLog (@"one");
            [self commonalert:unabletoupdatecard message:statuscode4];
            break;
        case 6:
            NSLog (@"six");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SessionExpired" object:self];
            break;
        case 7:
            NSLog (@"seven");
            [self commonalert:unabletoupdatecard message:statuscode7];
            break;
        case 9:
            NSLog (@"nine");
            [self commonalert:unabletoupdatecard message:statuscode9];
            break;
        case 10:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SessionExpired" object:self];
            
            break;
            
        case 12:
            NSLog (@"tweleve");
            [self commonalert:nil message:statuscode12];
            break;
        case 15:
            NSLog (@"fifteen");
            [self commonalert:nil message:statuscode15];
            break;
        case 16:
            NSLog (@"sisxteen");
            [self commonalert:unabletoupdatecard message:statuscode16];
            break;
        case 17:
            NSLog (@"four");
            [self commonalert:unabletoupdatecard message:statuscode17];
            break;
        case 18:
            NSLog (@"five");
            [self commonalert:unabletoupdatecard message:statuscode18];
            break;
        case 21:
            NSLog (@"twenty one");
            [self commonalert:unabletoupdatecard message:statuscode21];
            break;
        case 27:
            NSLog (@"twenty seven");
            [self commonalert:unabletoupdatecard message:statuscode27];
            break;
        case 30:
            NSLog (@"thirty");
            [self commonalert:unabletoupdatecard message:statuscode30];
            break;
        case 33:
            NSLog (@"thirty three");
            [self commonalert:unabletoupdatecard message:statuscode33];
            break;
            
        default:
            NSLog (@"Integer out of range");
            [self commonalert:unabletoupdatecard message:[NSString stringWithFormat:@"%@\n[Error code:%d]",responsemessage,statuscodevalue]];
            break;
    }
    
}
-(void)commonalert:(NSString *)title message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}


#pragma mark - Alert view delegate ------------------------------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (alertView.tag == 123)
    {
		if(buttonIndex == 0)
		{
			isProcess=YES;
            if ([alertView.message isEqualToString:@"Your old password is incorrect"]) {
                txtOldPassword.text=@"";
                txtNewPassword.text=@"";
                txtConfirmPassword.text=@"";
            }
            else
            {
                appdelegate=(CAppDelegate*)[UIApplication sharedApplication].delegate;
                NSArray *arrayViewController=[appdelegate.navigationWindow viewControllers];
                NSLog(@"pop to ---%@",[arrayViewController objectAtIndex:arrayViewController.count-2]);
                [appdelegate.navigationWindow popToViewController:[arrayViewController objectAtIndex:arrayViewController.count-2] animated:YES];
                
              //  [appDelegate logout];
                //[self goBackToSettings];
            }
		}
	}
    
	if (alertView.tag == 610)
    {
		if (buttonIndex ==0) {
           // [appdelegate logout];
		}
	}
    
    if (alertView.tag==111) {
        if (buttonIndex ==0) {
            [self.navigationController popViewControllerAnimated:YES];
            
		}
    }
}




#pragma mark - Hud view methods -------------------------------------------


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



#pragma mark - TextField Functions ------------------------------

//Numeric key pad : adding return button
- (void) addReturnButtonInNumPad
{
    
	// locate keyboard view
	UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
	UIView* keyboard;
	for(int i=0; i<[tempWindow.subviews count]; i++) {
		keyboard = [tempWindow.subviews objectAtIndex:i];
		
		// keyboard view found; add the custom button to it
		if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
		{
            doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
            doneButton.frame = CGRectMake(0, 163, 106, 53);
            doneButton.tag = kNumPadReturnButtonTag;
            doneButton.adjustsImageWhenHighlighted = NO;
            [doneButton setTitle:@"Done" forState:UIControlStateNormal];
            [doneButton addTarget:self action:@selector(onExitText) forControlEvents:UIControlEventTouchUpInside];
            [keyboard addSubview:doneButton];
		}
	}
}

- (void) removeReturnButtonFromNumPad
{
	UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
	UIView* keyboard;
	for(int i=0; i<[tempWindow.subviews count]; i++) {
		keyboard = [tempWindow.subviews objectAtIndex:i];
		// keyboard view found; add the custom button to it
		if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
		{
			UIView *button;
			for (int j=0; j<[keyboard.subviews count]; j++) {
				button = [keyboard.subviews objectAtIndex:j];
				if(button.tag == kNumPadReturnButtonTag)
				{
					[button removeFromSuperview];
				}
			}
		}
	}
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	
    if (textField == txtOldPassword) {
        
        lblBorderOldPassword.layer.borderColor=[UIColor clearColor].CGColor;
        
    }
    else if (textField == txtNewPassword){
        
        lblBorderNewPassword.layer.borderColor=[UIColor clearColor].CGColor;
        
    }else {
        
    lblBorderReEnterPassword.layer.borderColor=[UIColor clearColor].CGColor;
        
    }
    
    
    
    if([string length]>0)
	{
		string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		NSLog(@"string Space Chatacter trimm %@",string);
		
		if( textField == txtNewPassword || textField == txtConfirmPassword)
		{
            NSLog(@"string legnth %d",[textField.text length]);
            if([textField.text length]>15)
            {
                return NO;
                
            }
            else{
                for (int i = 0; i < [string length]; i++)
                {
                    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"%",@"&",@"'",@";",nil];
                    
                    
                    for(int j = 0; j<[arr count];j++)
                    {
                        NSString *strg = [arr objectAtIndex:j];
                        
                        NSCharacterSet *myCharSet =[NSCharacterSet characterSetWithCharactersInString:strg];
                        unichar c = [string characterAtIndex:i];
                        if ([myCharSet characterIsMember:c])
                        {
                            return NO;
                            
                        }
                    }
                }
                
                NSUInteger newLength = [textField.text length] + [string length] - range.length;
                
                if([string length]==0)
                {
                    return NO;
                }
                else
                {
                    BOOL is_chek = (newLength>=32)? NO : YES;
                    
                    if(is_chek ==NO && [string isEqualToString:@"\n"])
                    {
                        return YES;
                    }
                    else
                    {
                        return is_chek;
                    }
                    
                }
            }
		}
	}
	return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    if (textField == txtOldPassword) {
        lblBorderOldPassword.layer.borderColor=[UIColor clearColor].CGColor;

        
        [txtNewPassword becomeFirstResponder];
    }
    else if (textField == txtNewPassword){
        lblBorderNewPassword.layer.borderColor=[UIColor clearColor].CGColor;

        [txtConfirmPassword becomeFirstResponder];
    }
    lblBorderReEnterPassword.layer.borderColor=[UIColor clearColor].CGColor;

    return YES;
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
