/*
	YPUpdatePasswordRequest.h
	The implementation of properties and methods for the YPUpdatePasswordRequest object.
	Generated by SudzC.com
*/
#import "YPUpdatePasswordRequest.h"

@implementation YPUpdatePasswordRequest
	@synthesize SC;
	@synthesize applicationType;
	@synthesize nPassword;
	@synthesize oldPassword;
	@synthesize userName;
	@synthesize valid;

	- (id) init
	{
		if(self = [super init])
		{
			self.SC = nil;
			self.applicationType = nil;
			self.nPassword = nil;
			self.oldPassword = nil;
			self.userName = nil;

		}
		return self;
	}



@end
