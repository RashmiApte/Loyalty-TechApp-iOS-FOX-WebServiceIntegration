/*
	YPLogoutResponse.h
	The interface definition of properties and methods for the YPLogoutResponse object.
	Generated by SudzC.com
*/

#import <Foundation/Foundation.h>


@interface YPLogoutResponse : NSObject
{
	NSString* _responseMessage;
	int _statusCode;
	BOOL _valid;
	
}
		
	@property (strong, nonatomic) NSString* responseMessage;
	@property int statusCode;
	@property BOOL valid;

-(void)parsingLogout:(NSDictionary*)dictResponse;



@end
