//
//  CountryDetail.m
//  LoyaltyApp
//
//  Created by Ajeet Sharma on 2/21/14.
//
//

#import "YPCountryDetail.h"

@implementation YPCountryDetail

@synthesize countryCode = _countryCode;
@synthesize countryName = _countryName;
@synthesize valid = _valid;

- (id) init
{
    if(self = [super init])
    {
        self.countryCode = nil;
        self.countryName = nil;
        
    }
    return self;
}




@end
