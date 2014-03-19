/*
	YPCurrencyCodesResponse.h
	The implementation of properties and methods for the YPCurrencyCodesResponse object.
	Generated by SudzC.com
*/
#import "YPCurrencyCodesResponse.h"

#import "YPCurrencyCodeDetails.h"


@implementation YPCurrencyCodesResponse
	@synthesize currencyCodeList = _currencyCodeList;
	@synthesize responseMessage = _responseMessage;
	@synthesize statusCode = _statusCode;
	@synthesize valid = _valid;

	- (id) init
	{
		if(self = [super init])
		{
			self.currencyCodeList = [[NSMutableArray alloc] init];
			self.responseMessage = nil;

		}
		return self;
	}
-(void)parsingCurrencyList:(NSDictionary*)dictResponse{
    
    NSLog(@"parsingCurrencyList = %@",dictResponse);
    
    
    NSMutableArray *arrayCurrencyList=[[[[dictResponse valueForKey:@"getCurrencyCodesResponse"] valueForKey:@"getCurrencyCodesReturn"] valueForKey:@"currencyCodeList"] valueForKey:@"currencyCodeDetails"];
    
   _statusCode=[[[[[dictResponse valueForKey:@"getCurrencyCodesResponse"] valueForKey:@"getCurrencyCodesReturn"] valueForKey:@"statusCode"] valueForKey:@"text"] intValue];
    _responseMessage=[[[[dictResponse valueForKey:@"getCurrencyCodesResponse"] valueForKey:@"getCurrencyCodesReturn"] valueForKey:@"responseMessage"] valueForKey:@"text"];
    
    _valid=[[[[dictResponse valueForKey:@"getCurrencyCodesResponse"] valueForKey:@"getCurrencyCodesReturn"] valueForKey:@"valid"] valueForKey:@"text"];
    
    
    for (int i=0; i<arrayCurrencyList.count; i++)
    {
        
        YPCurrencyCodeDetails *objCurrencyCodeDetails=[[YPCurrencyCodeDetails alloc] init];
        
        objCurrencyCodeDetails.currencyAlphaCode=[[[arrayCurrencyList objectAtIndex:i]valueForKey:@"currencyAlphaCode"] valueForKey:@"text"];
        
        objCurrencyCodeDetails.currencyCode=[[[arrayCurrencyList objectAtIndex:i]valueForKey:@"currencyCode"] valueForKey:@"text"];
        objCurrencyCodeDetails.currencyName=[[[arrayCurrencyList objectAtIndex:i]valueForKey:@"currencyName"] valueForKey:@"text"];
        
        NSLog(@"****** %@",[arrayCurrencyList objectAtIndex:i]);
        

        [_currencyCodeList addObject:objCurrencyCodeDetails];
    }
    
    NSLog(@"Stop");
    
    
    
    
}

@end
