//
//  SplasahScreen.m
//
//
//  Created by YESpay on 1/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SplashScreen.h"
#import <QuartzCore/QuartzCore.h>
#import "CAppDelegate.h"
#import "DataBase.h"
#import "Common.h"
#import "Constant.h"
#import "WebserviceOperation.h"
#import "YPCountryListResponse.h"
#import "YPCountryDetail.h"
#import "YPCurrencyCodesResponse.h"
#import "YPCurrencyCodeDetails.h"
#import "HomeViewController.h"

BOOL isServerTrip;

@implementation SplashScreen
@synthesize imgBackground;


#pragma mark - ViewController methods ----------------------------------------------------
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    isServerTrip=NO;
    
    appdelegate = (CAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.window setBackgroundColor:[UIColor blackColor]];
    
    //------------ set background image -----------------------------
    
    UIImageView *imgSplash=[[UIImageView alloc] init];
    if ([UIScreen mainScreen].bounds.size.height==568) {
        imgSplash.frame=CGRectMake(0, -20, 320, 568);
        [imgSplash setImage:[UIImage imageNamed:@"NewDefault-568h@2x.png"]];
    }
    else{
        [imgSplash setImage:[UIImage imageNamed:@"NewDefault.png"]];
        
        imgSplash.frame=CGRectMake(0, -20, 320, 480);
    }
    
    [self.view addSubview:imgSplash];
    //----------------------------------------------------------------
    
    
    [self showHUD:loadingaything];
    [self performSelector:@selector(moveToHome)];
	//[self performSelector:@selector(fetchCountryList)];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(void)fetchCountryList
{
    
    
    //-----------  fetching country List -------------------------------
 
    NSMutableArray *getCountryList =[DataBase getAllCountryList];
    
  //  NSLog(@"getCountryList = %@",getCountryList);
    
    
    if ([getCountryList count] <=0)
    {
        
        if ([Common isNetworkAvailable])
        {
            appdelegate = (CAppDelegate*)[[UIApplication sharedApplication] delegate];
            
            
            WebserviceOperation *serviceGetCountryList=[[WebserviceOperation alloc] initWithDelegate:self callback:@selector(getCountryListHandler:)];
            
            
            isServerTrip=YES;
            [self killHUD];
            [self showHUD:loadingaything];
            
            [serviceGetCountryList getCountryList];
            
            
        }
        else
        {
            [self performSelector:@selector(moveToHome)];
            
        }
        
    }
    
    else
    {
        [self performSelector:@selector(fetchCurrencyList)];
    }
    
    //------------------------------------------------------------------
    
    
    
}

-(void)fetchCurrencyList
{

    NSMutableArray *getCurrencyList=[DataBase getAllCurrencyList];
    
   // NSLog(@"getCurrencyList = %@",getCurrencyList);
    
    
    if ([getCurrencyList count]<=0)
    {
        
        NSLog(@" NO Resords in database Now fetching records from network");
        if([Common isNetworkAvailable])
        {
            
            WebserviceOperation *serviceGetCurrencyList = [[WebserviceOperation alloc]initWithDelegate:self callback:@selector(getCurrencyListHandler:)];
            
            isServerTrip=YES;
            [serviceGetCurrencyList getCurrencyList];
            
        }
        else {
            
            [self performSelector:@selector(moveToHome)];
        }
    }
    else
    {
        
        [self performSelector:@selector(moveToHome)];
        
    }
    
    
}

#pragma mark - Webservice Handler --------------------------------------------

-(void) getCountryListHandler: (id) value{
    
    
  //  [self killHUD];
    
    
    //Handle error
    if([value isKindOfClass:[NSError class]]) {
        
        NSLog(@"%@", value);
//        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
        [self performSelector:@selector(fetchCurrencyList)];
        return;
    }
    
    // Handle faults
    if([value isKindOfClass:[SoapFault class]]) {
        
        NSLog(@"%@", value);
//        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
        [self performSelector:@selector(fetchCurrencyList)];
        return;
    }
    

    
    
    YPCountryListResponse *objCountryListResponse=[[YPCountryListResponse alloc] init];
    
    [objCountryListResponse parsingCountryList:value];
    
    
    if (objCountryListResponse.statusCode==0)
    {
        
        if ([objCountryListResponse.countryList count] >0)
        {
            for (int i=0; i<[objCountryListResponse.countryList count]; i++) {
                
                YPCountryDetail *countryDetails = (YPCountryDetail *)[objCountryListResponse.countryList objectAtIndex:i];
                
                NSString *insertQuery = @"insert into CountryDetails(countrycode,countryname";
                NSString *insertQueryValues = @" values(";
                
               
                
                insertQueryValues = [insertQueryValues stringByAppendingString:
                                     [NSString stringWithFormat:@"'%@','%@'",countryDetails.countryCode,[countryDetails.countryName capitalizedString]]];
                
                insertQuery = [insertQuery stringByAppendingString:[NSString stringWithFormat:@")%@)",insertQueryValues]];
                
                [DataBase InsertIntoTable:insertQuery];
            }
        }
        [self performSelector:@selector(fetchCurrencyList)];
    }
    else{
        
        //GetCountryList error------------------
        /*UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Error code: %d",objCountryListResponse.statusCode] delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];*/
        
        //[alertView show];
        
        
        
    }
}


-(void)getCurrencyListHandler: (id) value {
	
    
    //Handle error
    if([value isKindOfClass:[NSError class]]) {
        
        NSLog(@"%@", value);
        //        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
        [self performSelector:@selector(moveToHome)];
        return;
    }
    
    // Handle faults
    if([value isKindOfClass:[SoapFault class]]) {
        
        NSLog(@"%@", value);
        //        UIAlertView *alert = [[UIAlertView  alloc]initWithTitle:nil message:problemoccuratserver delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
        [self performSelector:@selector(moveToHome)];
        return;
    }
    
    YPCurrencyCodesResponse *objCurrencyCodesResponse=[[YPCurrencyCodesResponse alloc] init];
    
    [objCurrencyCodesResponse parsingCurrencyList:value];
    
    
    
    
    NSLog(@"response message = %@   status code = %d valid = %x",objCurrencyCodesResponse.responseMessage,objCurrencyCodesResponse.statusCode,objCurrencyCodesResponse.valid);
    
    if (objCurrencyCodesResponse.statusCode==0)
    {
        
        if ([objCurrencyCodesResponse.currencyCodeList count] >0)
        {
            
            
            NSMutableArray *getCurrencyList=[DataBase getAllCurrencyList];
            
            if ([getCurrencyList count]>0)
            {
                NSString *deleteQuery = @"Delete from CurrencyCode";
                [DataBase deleteDataFromTable:deleteQuery];
            }
            
            for (int i=0; i<[objCurrencyCodesResponse.currencyCodeList count]; i++)
            {
                
                YPCurrencyCodeDetails *codeDetail= (YPCurrencyCodeDetails*)[objCurrencyCodesResponse.currencyCodeList objectAtIndex:i];
                
                NSLog(@"code - %@ aplhacode  = %@  currencyName = %@",codeDetail.currencyCode,codeDetail.currencyAlphaCode,[codeDetail.currencyName capitalizedString]);
                
                [DataBase saveCurrencListInToDataBase:codeDetail.currencyCode :codeDetail.currencyAlphaCode :[codeDetail.currencyName capitalizedString]];
                
            }
            
        }
        
        [self performSelector:@selector(moveToHome)];

    }
    else{
        
        //GetCountryList error------------------
       // UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Error code: %d",objCurrencyCodesResponse.statusCode] delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
       // [alertView show];
        
        [self performSelector:@selector(moveToHome)];
        
        
    }
    
    NSLog(@"----------------------------------------------");
    
    //	// Handle errors
    //	if([value isKindOfClass:[NSError class]]) {
    //        [self performSelector:@selector(moveToHome)];
    //
    //	}
    //	else if([value isKindOfClass:[SoapFault class]]) {
    //        [self performSelector:@selector(moveToHome)];
    //
    //	}
    //    else{
    //
    //        YPCurrencyCodesResponse *ypResponse= (YPCurrencyCodesResponse*)value;
    //
    //        if ([ypResponse.currencyCodeList count] > 0)
    //        {
    //            NSMutableArray *getCurrencyList=[DataBase getAllCurrencyList];
    //            if ([getCurrencyList count]>0)
    //            {
    //                 NSString *deleteQuery = @"Delete from CurrencyCode";
    //                [DataBase deleteDataFromTable:deleteQuery];
    //            }
    //            for (int i=0;i<[ypResponse.currencyCodeList count]-2; i++)
    //            {
    //                YPCurrencyCodeDetails *codeDetail= (YPCurrencyCodeDetails*)[ypResponse.currencyCodeList objectAtIndex:i];
    //
    //                NSString *strName=codeDetail.currencyName;
    //                strName=[strName capitalizedString];
    //                [DataBase saveCurrencListInToDataBase:codeDetail.currencyCode :codeDetail.currencyAlphaCode :strName];
    //            }
    //        }
    //        [self performSelector:@selector(moveToHome)];
    //    }
    
    
}

-(void)moveToHome
{
    
    if (isServerTrip) {
        
        [self performSelector:@selector(moveToHome2)];
        
    }
    else{
        
        [self performSelector:@selector(moveToHome2) withObject:nil afterDelay:3.0];
    }
    
    
    
}

-(void)moveToHome2
{
        CAppDelegate *appdelegate2=(((CAppDelegate*) [UIApplication sharedApplication].delegate));
        appdelegate2.window.backgroundColor=[UIColor blackColor];
    
       [self killHUD];
    
        HomeViewController *homeview;
        homeview=[[HomeViewController alloc]init];
    	[self.navigationController pushViewController:homeview animated:NO];
}

#pragma mark - HudView methods --------------------------------------------

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
        aHUD.viewBlack.hidden=YES;
        
        
        [self.navigationController.navigationBar setUserInteractionEnabled:NO];
		[self.view setUserInteractionEnabled:NO];
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		
	}
	
}

#pragma mark - Status bar effect -----------------------------------------------

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
@end
