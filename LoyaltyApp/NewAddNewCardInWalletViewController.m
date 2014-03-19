//
//  NewAddNewCardInWalletViewController.m
//  LoyaltyApp
//
//  Created by ankit on 3/10/14.
//
//

#import "NewAddNewCardInWalletViewController.h"
#import "Constant.h"
#import "CAppDelegate.h"
#import "DataBase.h"
#import "Login.h"
#import "LeftPanelViewController.h"
#import "MyCardsViewController.h"

#import "JASidePanelController.h"
#import "AboutUsViewController.h"
//------------webservice calling and activity------------
#import "WebserviceOperation.h"
#import "YPAddCardRequest.h"
#import "YPAddCardResponse.h"
#import "HudView.h"
#import "Constant.h"
#import "Common.h"

@interface NewAddNewCardInWalletViewController ()

@end

@implementation NewAddNewCardInWalletViewController
@synthesize txtCardname,txtCardnumber,btnAddanother,btnSubmit;
@synthesize txtHolder,jaSidePanelobj,strbtnidentifire,strUserid;



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
    //---------------------- Back button -----------------------------
    
    btnBack =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"button_home_60_29.png"] forState:UIControlStateNormal];
	[btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    btnBack.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(14.0)];
    [btnBack.titleLabel setTextColor:btntextColor];
    [btnBack setTitle:@"Back" forState:UIControlStateNormal];
	[btnBack setFrame:CGRectMake(5,7, 60, 29)];
    
    
    btnSkip=  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSkip setBackgroundImage:[UIImage imageNamed:@"button_home_60_29.png"]forState:UIControlStateNormal];
    [btnSkip addTarget:self action:@selector(skip) forControlEvents:UIControlEventTouchUpInside];
    [btnSkip setFrame:CGRectMake(255, 7, 60, 29)];
    btnSkip.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(14.0)];
    [btnSkip.titleLabel setTextColor:btntextColor];
    [btnSkip setTitle:@"Skip" forState:UIControlStateNormal];
    
    //--------------------- Design heder of This screen -----------------------------//
    
    UIImageView* imgNavBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_back.png"]];
    [imgNavBack setFrame:CGRectMake(0, 0, 325, 53)];
    
    UILabel *lblHeading =[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 320, 36)];
    lblHeading.text=@"Add Card";
    lblHeading.textAlignment=NSTextAlignmentCenter;
    [lblHeading setTextColor:headertitletextColor];
    lblHeading.font = [UIFont fontWithName:labelregularFont size:(22.0)];
    lblHeading.backgroundColor=[UIColor clearColor];
    
    [self.view addSubview:imgNavBack];
    [self.view addSubview:lblHeading];
    
    //[self.view addSubview:btnBack];
    [self.view addSubview:btnSkip];
    //----------------------------------------------------------------------------//
    
    
    //for card nametext field
    txtCardname.layer.cornerRadius=5;
    txtCardname.layer.borderWidth=0;
    [txtCardname setValue:placeholdertexfield];
    [txtCardname  setTextColor:textFieldTextColor];
    [self texfieldpadding:txtCardname];
    txtCardname.font=[textFieldnewTextFont];
    
    
    //for card Numbertext field
    txtCardnumber.layer.cornerRadius=5;
    txtCardnumber.layer.borderWidth=0;
    [txtCardnumber setValue:placeholdertexfield];
    [txtCardnumber  setTextColor:textFieldTextColor];
    [self texfieldpadding:txtCardnumber];
    txtCardnumber.font=[textFieldnewTextFont];
    
    txtHolder=[[UITextField alloc]init];
    btnSubmit.hidden=YES;
    btnAddanother.hidden=YES;
    
    appdelegate=(CAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)texfieldpadding:(UITextField*)textfield
{
    UIView *emailpaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, textfield.frame.size.height)];
    textfield.leftView = emailpaddingView;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
-(void)skip{
    NSLog(@"Skip");
    appdelegate=(CAppDelegate*)[UIApplication sharedApplication].delegate;
    NSLog(@"value of view contrller array is %@",self.navigationController.viewControllers);
    Login *objLogin=[[Login alloc]initWithNibName:@"Login" bundle:nil];
    [self.navigationController pushViewController:objLogin animated:YES];
}
-(IBAction)submit:(id)sender{
    NSLog(@"Submit");
    [self clearTextfieldborder];
    if([self cardvalidation])
    {
        NSLog(@"Submit button ");
        if([self luhnCheck:txtCardnumber.text])
        {
            NSLog(@"Valide card");
            self.strbtnidentifire =@"Submit";
            [self calladdcardrequest];
            
        }
        else
        {
            [self currenttextfield:self.txtCardnumber alerttitle:unabletoaddnewcard alertmessage:Invalidecardnumber];
        }
        
    }
}

-(void)addCardHandlers:(id)value
{
    
    [self killHUD];
    
    [self.view endEditing:YES];
	// Handle errors
    if([value isKindOfClass:[NSError class]]) {
        //[self performSelector:@selector(killHUD)];`
        NSLog(@"%@", value);
        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:unabletoaddnewcard message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    // Handle faults
    if([value isKindOfClass:[SoapFault class]]) {
        //[self performSelector:@selector(killHUD)];
        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:unabletoaddnewcard message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        NSLog(@"%@", value);
        return;
    }
    
    YPAddCardResponse *objCardResponse=[[YPAddCardResponse alloc] init];
    [objCardResponse parsingAddcard:value];
    
    
    if(objCardResponse.statusCode == 0)
    {
        NSLog(@"value of status code is %d",objCardResponse.statusCode);
        [[NSUserDefaults standardUserDefaults] setObject:@"addopration" forKey:@"operationfinder"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:successfullyaddcard  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert setTag:123];
        [alert show];
    }
    else
    {
        [self cardholderalertmessages:objCardResponse.statusCode message:objCardResponse.responseMessage];
        
    }
    
}


-(void)cardholderalertmessages:(int)statuscodevalue message:(NSString *)responsemessage
{
    switch (statuscodevalue)
    {
        case 1:
            NSLog (@"zero");
            [self commonalert:unabletoaddnewcard message:statuscode1];
            break;
        case 4:
            NSLog (@"one");
            [self commonalert:unabletoaddnewcard message:statuscode4];
            break;
        case 6:
            NSLog (@"six");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SessionExpired" object:self];
            break;
        case 7:
            NSLog (@"seven");
            [self commonalert:unabletoaddnewcard message:statuscode7];
            break;
        case 9:
            NSLog (@"nine");
            [self commonalert:unabletoaddnewcard message:statuscode9];
            break;
        case 10:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SessionExpired" object:self];
            break;
            
        case 12:
            NSLog (@"tweleve");
            [self commonalert:unabletoaddnewcard message:statuscode12];
            break;
        case 15:
            NSLog (@"fifteen");
            [self commonalert:unabletoaddnewcard message:statuscode15];
            break;
        case 16:
            NSLog (@"sisxteen");
            [self commonalert:unabletoaddnewcard message:statuscode16];
            break;
        case 17:
            NSLog (@"four");
            [self commonalert:unabletoaddnewcard message:statuscode17];
            break;
        case 18:
            NSLog (@"five");
            [self commonalert:unabletoaddnewcard message:statuscode18];
            break;
        case 21:
            NSLog (@"twenty one");
            [self commonalert:unabletoaddnewcard message:statuscode21];
            break;
        case 27:
            NSLog (@"twenty seven");
            [self commonalert:unabletoaddnewcard message:statuscode27];
            break;
        case 30:
            NSLog (@"thirty");
            [self commonalert:unabletoaddnewcard message:statuscode30];
            break;
        case 33:
            NSLog (@"thirty three");
            [self commonalert:unabletoaddnewcard message:statuscode33];
            break;
        default:
            NSLog (@"Integer out of range");
            [self commonalert:unabletoaddnewcard message:[NSString stringWithFormat:@"%@\n[Error code:%d]",responsemessage,statuscodevalue]];
            break;
    }
}
-(void)commonalert:(NSString *)title message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
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



#pragma mark - other methode -------------------------------------
-(BOOL)cardvalidation
{
    //validation --------
    BOOL returnvalue=YES;
    if ([self.txtCardname.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0){
        returnvalue=NO;
    }
    else
    {
        if ([txtCardnumber.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0)
        {
            returnvalue=NO;
            
        }
    }
    
    return returnvalue;
    
}
-(void)clearTextfieldborder
{
    txtHolder.layer.cornerRadius=5;
    txtHolder.layer.borderWidth=0;
}

#pragma mark - UITextfield delegates -------------------------------------
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    if (textField==txtCardname) {
        [txtCardnumber becomeFirstResponder];
        
    }
    return YES;
}

-(void)validationDelay{
    
    if ([self cardvalidation]) {
        btnSubmit.hidden=NO;
        btnAddanother.hidden=NO;
        NSLog(@"non hideen button");
    }
    else{
        NSLog(@"hiden button");
        btnSubmit.hidden=YES;
        btnAddanother.hidden=YES;
        [self clearTextfieldborder];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    [self performSelector:@selector(validationDelay) withObject:Nil afterDelay:0.2];
    
    if (textField==txtCardname || textField==txtCardnumber) {
        if ([string isEqualToString:@" "]) {
            //space not allowed in first name and last name field -------
            btnSubmit.hidden=YES;
            btnAddanother.hidden=YES;
            return NO;
        }
        else
        {
            
            if(textField==txtCardnumber)
            {
                if(txtCardnumber.text.length<=20)
                {
                    if(textField==txtCardnumber)
                    {
                        if (textField.keyboardType == UIKeyboardTypeNumbersAndPunctuation)
                        {
                            if ([string rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound)
                            {
                                // BasicAlert(@"", @"This field accepts only numeric entries.");
                                return NO;
                            }
                            else{
                                return YES;
                            }
                        }
                    }
                }
            }
        }
        
    }
    return YES;
    
}


//Luhn Check for card number Validation
-(BOOL) luhnCheck:(NSString *)stringToTest
{
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < [stringToTest length]; i++) {
        [array addObject:[NSString stringWithFormat:@"%C", [stringToTest characterAtIndex:i]]];
    }
    
    NSMutableArray *stringAsChars =[[NSMutableArray alloc] initWithArray:array];
    
    NSLog(@"value of string as character %@",stringAsChars);
    
    BOOL isOdd = YES;
    int oddSum = 0;
    int evenSum = 0;
    
    for (int i = [stringToTest length] - 1; i >= 0; i--) {
        
        int digit = [(NSString *)[stringAsChars objectAtIndex:i] intValue];
        
        if (isOdd)
            oddSum += digit;
        else
            evenSum += digit/5 + (2*digit) % 10;
        
        isOdd = !isOdd;
    }
    
    return ((oddSum + evenSum) % 10 == 0);
}

-(void)currenttextfield:(UITextField *)textfieldvalue alerttitle:(NSString *)alerttitlestr alertmessage:(NSString *)alertmessagestr
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alerttitlestr message:alertmessagestr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    double delayInSeconds = .2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [textfieldvalue becomeFirstResponder];
        textfieldvalue.layer.borderWidth=1;
        
        textfieldvalue.layer.borderColor = TextfieldErrorColor.CGColor;
        if(textfieldvalue!=txtHolder)
        {
            txtHolder.layer.cornerRadius=5;
            txtHolder.layer.borderWidth=0;
            txtHolder=textfieldvalue;
        }
    });
}
-(IBAction)addAnother:(id)sender{
    [self clearTextfieldborder];
    if([self cardvalidation])
    {
        NSLog(@"Submit button ");
        
        if([self luhnCheck:txtCardnumber.text])
        {
            self.strbtnidentifire =@"Addanotherbtn";
            /*self.txtCardname.text=@"";
             self.txtCardnumber.text=@"";
             self.btnAddanother.hidden=YES;
             self.btnSubmit.hidden=YES;*/
            [self calladdcardrequest];
            
        }
        else
        {
            [self currenttextfield:self.txtCardnumber alerttitle:unabletoaddnewcard alertmessage:Invalidecardnumber];
        }
    }
    
}
-(void)calladdcardrequest
{
    
    [self showHUD:generatingcard];
    WebserviceOperation *serviceAddnewcard = [[WebserviceOperation alloc] initWithDelegate:self callback:@selector(addCardHandlers:)];
    YPAddCardRequest *addCardRequest=[[YPAddCardRequest alloc] init];
    addCardRequest.cardNumber = txtCardnumber.text;
    addCardRequest.cardName = txtCardname.text;
    //addCardRequest.valid =TRUE;
    
    addCardRequest.userName =self.strUserid;
    addCardRequest.SC = appdelegate.SC;
    [serviceAddnewcard addNewCard:addCardRequest];
}

#pragma mark  - UIAlertview delegate --------------------------

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	
	if (buttonIndex ==0) {
		
		if (alertView.tag == 101) {
            //	[appDelegate logout];
		}
	}
	if(buttonIndex == 0)
	{
		if (alertView.tag == 123) {
            if([strbtnidentifire isEqualToString:@"Submit"])
            {
                self.jaSidePanelobj = [[JASidePanelController alloc] init];
                self.jaSidePanelobj.shouldDelegateAutorotateToVisiblePanel = NO;
                self.jaSidePanelobj.leftPanel = [[LeftPanelViewController alloc] init];
                self.jaSidePanelobj.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[AboutUsViewController alloc] init]];
                [self.navigationController pushViewController:self.jaSidePanelobj animated:YES];
            }
            else
            {
                if([self.strbtnidentifire isEqualToString:@"Addanotherbtn"])
                {
                    self.txtCardname.text=@"";
                    self.txtCardnumber.text=@"";
                    self.btnAddanother.hidden=YES;
                    self.btnSubmit.hidden=YES;
                    self.txtCardname.text=@"";
                    self.txtCardnumber.text=@"";
                    self.btnAddanother.hidden=YES;
                    self.btnSubmit.hidden=YES;
                }
                
                
            }
			
		}
        
	}
}



@end
