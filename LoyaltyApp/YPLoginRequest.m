/*
	YPLoginRequest.h
	The implementation of properties and methods for the YPLoginRequest object.
	Generated by SudzC.com
*/
#import "YPLoginRequest.h"

@implementation YPLoginRequest
	@synthesize applicationType = _applicationType;
	@synthesize mobileIdentificationNumber = _mobileIdentificationNumber;
	@synthesize password = _password;
	@synthesize role = _role;
	@synthesize userName = _userName;
	@synthesize valid = _valid;
    @synthesize versionID = _versionID;


	- (id) init
	{
		if(self = [super init])
		{
			self.applicationType = nil;
			self.mobileIdentificationNumber = nil;
			self.password = nil;
			self.role = nil;
			self.userName = nil;
            self.versionID = nil;

		}
		return self;
	}

	
@end