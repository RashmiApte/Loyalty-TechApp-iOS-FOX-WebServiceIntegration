//
//  Common.m
//  Trivia
//
//  Created by InfoBeans on 5/11/09.
//  Copyright 2009 InfoBeans Systems India Pvt Ltd. All rights reserved.
//


#import "Common.h"
#import "Reachability.h"
BOOL isNetwork=NO;
@implementation Common

// Show alert for a given messgae
+(void) ShowAlert:(NSString *)messageString alertTitle:(NSString *)title
{
	
	/*CustomAlertView *alert= [[CustomAlertView alloc]initWithTitle:title message:messageString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];*/
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:messageString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

+ (NSString *) doHTTPRequest:(NSString *)myRequestString url:(NSString *)_url
{
	////NSLog(@"URL :%@",myRequestString);
	//NSString *myRequestString =[NSString stringWithFormat:@"<root><uid>%d</uid><qid>%d</qid><oid>%d</oid><rid>%d</rid><score>%d</score><il>%d</il><tta>%d</tta><date>%@</date></root>",oTrivia.uid,oTrivia.qID,oTrivia.oID,oTrivia.rid,oTrivia.score,oTrivia.il,oTrivia.tta,[NSDate date]];
	NSData *myRequestData = [ NSData dataWithBytes: [ myRequestString UTF8String ] length: [ myRequestString length ] ];
	NSString *contentType = [NSString stringWithFormat:@"text/xml"];
	
	NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] initWithURL: [ NSURL URLWithString: _url]]; //requestInsertInUQR ] ]; 
	[request addValue:contentType forHTTPHeaderField: @"Content-Type"];
	[ request setHTTPMethod: @"POST" ];
	[ request setHTTPBody: myRequestData ];
	
	NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
	NSString *result = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
	////NSLog(@"Result :%@",result);
	return result;
}

+ (BOOL) isNetworkAvailable
{
	if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable) 
	{
		NSLog(@"NO INTERNET CONNECTION ");
		isNetwork =NO;
	}
	
	else {
		
		NSLog(@"INTERNET CONNECTION AVAILABLE");
		isNetwork =YES;
	}
	return isNetwork;
	
	
	//Commented By Varun
	/*[[Reachability sharedReachability] setAddress:@"69.64.65.43"];
	NetworkStatus remoteHostStatus;
	NetworkStatus internetConnectionStatus;
	NetworkStatus localWiFiConnectionStatus;
	
	remoteHostStatus=[[Reachability sharedReachability] remoteHostStatus];
	internetConnectionStatus=[[Reachability sharedReachability] internetConnectionStatus];
	localWiFiConnectionStatus=[[Reachability sharedReachability] localWiFiConnectionStatus];
	
	if (remoteHostStatus == NotReachable && internetConnectionStatus == NotReachable && localWiFiConnectionStatus == NotReachable )
	{
		return FALSE;
	} else {
		return TRUE;
	}*/
}


+ (UIImage*)imageWithImage:(UIImage*)image  scaledToSize:(CGSize)newSize
{
	UIGraphicsBeginImageContext( newSize );
	[image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newImage;
}

+ (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
	
    return [emailTest evaluateWithObject:candidate];
}

+ (BOOL) validateNumber: (NSString *) number
{
	NSString *numberRegEx = @"[0-9]*";
	NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
	return [numberTest evaluateWithObject:number];
}

+ (NSString *) formatDate:(NSDate *)date formatPattern:(NSString *)format
{
	NSString *str = @"";
	if(date != nil)
	{
		NSDateFormatter* formatter = [[NSDateFormatter alloc] init] ;
		[formatter setDateFormat:format];
		str = [formatter stringFromDate:date];
		//found leak in date
	}
	
	return str;
}

+ (NSDate *) addDate:(NSDate *)date noofdays:(NSInteger)days
{
	NSDate *newDate = nil;
	if(date!=nil)
	{
		////// Add by Shailesh Tiwari on 07/1/11
	    newDate = [date dateByAddingTimeInterval:(days*24*60*60)];
	//	newDate = [date addTimeInterval:(days*24*60*60)];   ///////// 'addTimeInterval:' is deprecated:
	}
	
	return newDate;
}



@end
