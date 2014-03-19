/*
 SoapFault.m
 Implementation that constructs a fault object from a SOAP fault when the
 web service returns an error.
 
 Author:	Jason Kichline, andCulture - Harrisburg, Pennsylvania USA
*/

#import "SoapFault.h"

@implementation SoapFault

@synthesize faultCode, faultString, faultActor, detail, hasFault;


    - (id) init
	{
		if(self = [super init])
		{
			self.faultCode = nil;
			self.faultString = nil;
			self.faultActor = nil;
			self.detail = nil;
			self.hasFault = nil;
            
		}
		return self;
	}

-(void)parsingSoapFault:(NSDictionary *)dicFault{


    NSLog(@"%@",dicFault);
    
    self.faultCode=[[[dicFault valueForKey:@"soapenv:Fault"] valueForKey:@"faultcode"] valueForKey:@"text"];
    self.faultString=[[[dicFault valueForKey:@"soapenv:Fault"] valueForKey:@"faultstring"] valueForKey:@"text"];
    self.detail=[[[[dicFault valueForKey:@"soapenv:Fault"] valueForKey:@"detail"] valueForKey:@"ns1:hostname"] valueForKey:@"text"];
 

}

@end
