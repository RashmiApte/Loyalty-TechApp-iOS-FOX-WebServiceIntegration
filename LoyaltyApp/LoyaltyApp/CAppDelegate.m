//
//  CAppDelegate.m
//  LoyaltyApp
//
//  Created by Ajeet Sharma on 2/20/14.
//
//http://192.168.95.106:8055/loyalty/services/AdminService?wsdl

#import "CAppDelegate.h"
#import "SplashScreen.h"
#import "DataBase.h"
#import "Constant.h"
#import "Login.h"

@implementation CAppDelegate
@synthesize dictionaryForImageCacheing;
@synthesize navigationWindow;
@synthesize userID;
@synthesize SC;
@synthesize userName;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"Final URL in app launch ------ %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"FinalURL"]);
    //------------------------Set Webservice URL when first time launch app --------------------------
    NSString *strFinalURL=[[NSUserDefaults standardUserDefaults] objectForKey:@"FinalURL"];
    if (strFinalURL.length==0 || strFinalURL==nil || strFinalURL==NULL) {
        
        NSString *strFetchURL=NSLocalizedString(@"DomainURL",@"");
        [[NSUserDefaults standardUserDefaults] setObject:strFetchURL forKey:@"FinalURL"];
        
    }
    //-------------------------------------------------------------------------------------------------
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        application.statusBarStyle = UIStatusBarStyleLightContent;
        
        
        
        //self.window.frame =  CGRectMake(0,20,self.window.frame.size.width,self.window.frame.size.height-20);
        
        //Added on 19th Sep 2013
        // self.window.bounds = CGRectMake(0, 20, self.window.frame.size.width, self.window.frame.size.height);
        
        
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        //NSLog(@"value of height is %f",self.window.frame.size.height );
        
        self.window.clipsToBounds = YES;
    }
    
    
    
    //----------- ChachDictionary used by AsyncImageView class which stored all data of Image url -------------
    
    dictionaryForImageCacheing = [[NSMutableDictionary alloc]init];
    
    //---------------------------------------------------------------------------------------------------------
    
    
    //----------- connection with Database -------------------------------------------------------------
    
	[DataBase CheckDataBase];
    
    //---------------------------------------------------------------------------------------------------------
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor blackColor];
    
    
    
    SplashScreen *objSplash=[[SplashScreen alloc] init];
    
    
    
    navigationWindow=[[UINavigationController alloc] initWithRootViewController:objSplash];
    
    navigationWindow.navigationBarHidden=YES;
    
    
    [self.window makeKeyAndVisible];
    [self.window setRootViewController:navigationWindow];
    
    
    
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        
        // [application setStatusBarStyle:UIStatusBarStyleLightContent];
        
        self.window.clipsToBounds =YES;
        
        // self.window.frame =  CGRectMake(0,20,self.window.frame.size.width,self.window.frame.size.height);
        
        CGRect viewBounds = [self.navigationWindow.view bounds];
        viewBounds.origin.y = 20;
        viewBounds.size.height = viewBounds.size.height - 20;
        self.navigationWindow.view.frame = viewBounds;
        
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(SessionExpiredMethod:)
                                                 name:@"SessionExpired"
                                               object:nil];
    
    
    
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)SessionExpiredMethod:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    //    if ([[notification name] isEqualToString:@"TestNotification"])
    
    NSLog (@"Successfully received the test notification!");
    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:nil message:sessionexpired delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    NSArray *arrayViewController=[navigationWindow viewControllers];
    
    NSLog(@"logout in  appdelegate ------ -- -- --   %@",arrayViewController);
    
    [navigationWindow popToViewController:[arrayViewController objectAtIndex:arrayViewController.count-2] animated:YES];
    
}

#pragma mark - Status bar ------------------------------------------------------

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end
