/*
	YPUserInfoResponse.h
	The interface definition of properties and methods for the YPUserInfoResponse object.
	Generated by SudzC.com
*/

#import <Foundation/Foundation.h>


@interface YPUserInfoResponse : NSObject
{
	NSString* _DOB;
	NSString* _city;
	NSString* _country;
	NSString* _emailAddress;
	NSString* _firstName;
	NSString* _geoLocationLatitude;
	NSString* _geoLocationLongitude;
	NSString* _lastName;
	NSString* _middleName;
	NSString* _mobilePhoneNumber;
	NSString* _postCode;
	NSString* _region;
	NSString* _responseMessage;
	NSString* _sex;
	int _statusCode;
	NSString* _streetAddress1;
	NSString* _streetAddress2;
	BOOL _valid;
	
}
		
	@property (strong, nonatomic) NSString* DOB;
	@property (strong, nonatomic) NSString* city;
	@property (strong, nonatomic) NSString* country;
	@property (strong, nonatomic) NSString* emailAddress;
	@property (strong, nonatomic) NSString* firstName;
	@property (strong, nonatomic) NSString* geoLocationLatitude;
	@property (strong, nonatomic) NSString* geoLocationLongitude;
	@property (strong, nonatomic) NSString* lastName;
	@property (strong, nonatomic) NSString* middleName;
	@property (strong, nonatomic) NSString* mobilePhoneNumber;
	@property (strong, nonatomic) NSString* postCode;
	@property (strong, nonatomic) NSString* region;
	@property (strong, nonatomic) NSString* responseMessage;
	@property (strong, nonatomic) NSString* sex;
	@property int statusCode;
	@property (strong, nonatomic) NSString* streetAddress1;
	@property (strong, nonatomic) NSString* streetAddress2;
	@property BOOL valid;

-(void)parsingUserInfo:(NSDictionary*)dictResponse;

@end
