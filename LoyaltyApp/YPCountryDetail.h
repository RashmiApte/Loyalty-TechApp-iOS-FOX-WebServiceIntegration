//
//  CountryDetail.h
//  LoyaltyApp
//
//  Created by Ajeet Sharma on 2/21/14.
//
//

#import <Foundation/Foundation.h>

@interface YPCountryDetail : NSObject
{
	NSString* _countryCode;
	NSString* _countryName;
	BOOL _valid;
	
}

@property (strong, nonatomic) NSString* countryCode;
@property (strong, nonatomic) NSString* countryName;
@property BOOL valid;

@end

