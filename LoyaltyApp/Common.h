//
//  Common.h
//  Trivia
//
//  Created by InfoBeans on 5/11/09.
//  Copyright 2009 InfoBeans Systems India Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Common : NSObject {
	

	
}

+ (NSString *) doHTTPRequest:(NSString *)myRequestString url:(NSString *)_url;


+(void) ShowAlert:(NSString *)messageString alertTitle:(NSString *)title;

+ (BOOL) isNetworkAvailable;
+ (UIImage*)imageWithImage:(UIImage*)image  scaledToSize:(CGSize)newSize;
+ (BOOL) validateEmail: (NSString *) candidate;
+ (BOOL) validateNumber: (NSString *) number;
+ (NSString *) formatDate:(NSDate *)date formatPattern:(NSString *)format;
+ (NSDate *) addDate:(NSDate *)date noofdays:(NSInteger)days;
@end
