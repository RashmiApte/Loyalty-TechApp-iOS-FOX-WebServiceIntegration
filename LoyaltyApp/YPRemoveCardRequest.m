/*
	YPRemoveCardRequest.h
	The implementation of properties and methods for the YPRemoveCardRequest object.
	Generated by SudzC.com
*/
#import "YPRemoveCardRequest.h"

@implementation YPRemoveCardRequest
	@synthesize SC = _SC;
	@synthesize applicationType = _applicationType;
	@synthesize cardName = _cardName;
	@synthesize cardReference = _cardReference;
	@synthesize userName = _userName;
	@synthesize valid = _valid;

	- (id) init
	{
		if(self = [super init])
		{
			self.SC = nil;
			self.applicationType = nil;
			self.cardName = nil;
			self.cardReference = nil;
			self.userName = nil;

		}
		return self;
	}

	

@end
