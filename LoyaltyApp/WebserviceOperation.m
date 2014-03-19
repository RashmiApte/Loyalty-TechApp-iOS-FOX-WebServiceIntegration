
//  WebserviceOperation.m

//  Created by Praveen Tripathi on 26/12/10.
//  Copyright 2010 PKTSVITS. All rights reserved.
//  testwallet@test.com/yespay123
//  test@local.com/yespay123

#import "WebserviceOperation.h"
#import "CAppDelegate.h"
#import "XMLReader.h"
#import "YPLoginRequest.h"
#import "YPLogoutRequest.h"
#import "YPLogoutRequest.h"
#import "SoapFault.h"
//#import "JSON/JSON.h"



@implementation WebserviceOperation
@synthesize	_delegate;
@synthesize _callback;
@synthesize strURL=_strURL;




-(id)initWithDelegate:(id)delegate callback:(SEL)callback{
	if (self = [super init]) {
		self._delegate = delegate;
		self._callback = callback;
        
       _strURL=[[NSUserDefaults standardUserDefaults] objectForKey:@"FinalURL"];
        
	}
	return self;
}

#pragma mark - URLConnection delegate --------------------------------


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
   // NSLog(@"response =%@",response);
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"didFailWithError error code = %ld",error.code);
    
        NSLog(@"%@", [NSString stringWithFormat:@"Connection failed! Error code: %d - %@ %@", error.code, error.localizedDescription, [error.userInfo objectForKey:NSURLErrorFailingURLStringErrorKey]]);
    
	if ([self._delegate respondsToSelector:self._callback]) {
		[self._delegate performSelector:self._callback withObject:error];
	}else {
		NSLog(@"Callback is not responding.");
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
   NSLog(@"----- - - - - %@",responseString);
    
    
    /* //######## ------------------------- JSON parsing ---------------------------- ##########
    
     NSError *error;
     NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error: &error];
     NSLog(@"----%@",jsonDict);
  
    //########//########//########//########//########//########//########//########//######## */
    
    NSError *error=nil;
    
    
    
  // NSLog(@"dict = %@",[[[[[[XMLReader dictionaryForXMLString:responseString error:error] valueForKey:@"soapenv:Envelope"] valueForKey:@"soapenv:Body"] valueForKey:@"getCountryListResponse"] valueForKey:@"getCountryListReturn"] valueForKey:@"statusCode"]);
    NSDictionary *dictResponse=[[[XMLReader dictionaryForXMLString:responseString error:error] valueForKey:@"soapenv:Envelope"] valueForKey:@"soapenv:Body"];
    if ([dictResponse valueForKey:@"soapenv:Fault"]!=nil) {

        SoapFault *objSoapFault=[[SoapFault alloc] init];
        
        [objSoapFault parsingSoapFault:dictResponse];
        
        NSLog(@"soap detail = %@",objSoapFault.detail);
        NSLog(@"soap faultcode = %@",objSoapFault.faultCode);
        NSLog(@"soap faultstring = %@",objSoapFault.faultString);
        
        [self._delegate performSelector:self._callback withObject:objSoapFault];
        
    }
    else{
    
        [self._delegate performSelector:self._callback withObject:dictResponse];
    
    }
   
 //  NSLog(@"----------- dictResponse = %@",dictResponse);
    
    
    
}


#pragma mark - Webservice methods


-(void)login:(YPLoginRequest*)loginRequest
{
    responseData=[[NSMutableData alloc] init];
    
    /*
     
     
     <?xml version="1.0" encoding="UTF-8"?>
     <soapenv:Envelope  xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" >
     <soapenv:Header/>
     <soapenv:Body>
     
     <LoginShopper>
     <UserID>John.Smith@yes-pay.com</ UserID >
     <Password>WorldPaytest123</Password>
     </LoginShopper>
     
     
     
     
     // ########### http://192.168.95.106:8055/loyalty/services/LoyaltyService?wsdl ############### //
     
     
     <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.loyalty.yes" xmlns:req="request.loyalty.yes">
     <soapenv:Header/>
     <soapenv:Body>
     <ser:login>
     <ser:loginRequest>
     <req:password>SumitPatel@gmail.com</req:password>
     <req:userName>abc1234</req:userName>
     <req:valid>true</req:valid>
     </ser:loginRequest>
     </ser:login>
     </soapenv:Body>
     </soapenv:Envelope>
     
     // ########### // ########### // ########### // ########### // ########### // ########### // ###########
     
     
     // ###########
     
     
     
     <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
     xmlns:ser="http://service.loyalty.yes" xmlns:req="request.loyalty.yes">
     <soapenv:Header/>
     <soapenv:Body>
     <ser:loginShopper>
     <ser:loginRequest>
     <req:password>Abc123456</req:password>
     <req:userID>sumit1@gmail.com</req:userID>
     <req:valid>true</req:valid>
     <req:versionID>100</req:versionID>
     </ser:loginRequest>
     </ser:loginShopper>
     </soapenv:Body>
     </soapenv:Envelope>
     
     */
    
    //    NSString *sSOAPMessage= [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"                        xmlns:ser=\"http://service.loyalty.yes\" xmlns:req=\"request.loyalty.yes\">\<soapenv:Header/><soapenv:Body><loginShopper><loginRequest><req:password>Abc123456</req:password><req:userID>sumit1@gmail.com</req:userID><req:valid>true</req:valid><req:versionID>100</req:versionID></ser:loginRequest></ser:loginShopper></soapenv:Body></soapenv:Envelope>"];
    
    
    NSString *sSOAPMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ser=\"http://service.loyalty.yes\" xmlns:req=\"request.loyalty.yes\"><soapenv:Header/><soapenv:Body><loginShopper><loginRequest><password>%@</password><userID>%@</userID><valid>true</valid><versionID>100</versionID></loginRequest></loginShopper></soapenv:Body></soapenv:Envelope>",loginRequest.password,loginRequest.userName];
    
    
    
    
    //    NSString *sSOAPMessage= [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"%@\"><soap:Body><login><loginRequest><userName>%@</userName><password>%@</password><valid>true</valid><versionID>100</versionID></loginRequest></login></soap:Body></soap:Envelope>",_strURL,loginRequest.userName,loginRequest.password];
    
    
    
    
    
    
    //sSOAPMessage= [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"%@\"><soap:Body><LoginShopper><UserID>John.Smith@yes-pay.com</UserID><Password>WorldPaytest123</Password></LoginShopper></soap:Body></soap:Envelope>",_strURL];
    
    NSLog(@"***************************************");
    
    NSLog(@"login_envelop = %@",sSOAPMessage);
    
    NSLog(@"***************************************");
    
    NSURL *sRequestURL = [NSURL URLWithString:_strURL];
    NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:sRequestURL];
    NSString *sMessageLength = [NSString stringWithFormat:@"%ld", [sSOAPMessage length]];
    
    [myRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [myRequest addValue: _strURL forHTTPHeaderField:@"SOAPAction"];
    [myRequest addValue: sMessageLength forHTTPHeaderField:@"Content-Length"];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setHTTPBody: [sSOAPMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc] initWithRequest:myRequest delegate:self];
    
}
-(void)getCountryList{

    responseData=[[NSMutableData alloc] init];
    
    NSString *sSOAPMessage= [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"%@\"><soap:Body><getCountryList><countryListRequest><valid>false</valid></countryListRequest></getCountryList></soap:Body></soap:Envelope>",_strURL];
    
    
    NSURL *sRequestURL = [NSURL URLWithString:_strURL];
    NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:sRequestURL];
    NSString *sMessageLength = [NSString stringWithFormat:@"%ld", [sSOAPMessage length]];
    
    [myRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [myRequest addValue: _strURL forHTTPHeaderField:@"SOAPAction"];
    [myRequest addValue: sMessageLength forHTTPHeaderField:@"Content-Length"];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setHTTPBody: [sSOAPMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc] initWithRequest:myRequest delegate:self];

}
-(void)getCurrencyList{

    responseData=[[NSMutableData alloc] init];
    
    NSString *sSOAPMessage= [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"%@\"><soap:Body><getCurrencyCodes><currencyCodesRequest><applicationType>M</applicationType><valid>true</valid></currencyCodesRequest></getCurrencyCodes></soap:Body></soap:Envelope>",_strURL];
    
    
    NSURL *sRequestURL = [NSURL URLWithString:_strURL];
    NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:sRequestURL];
    NSString *sMessageLength = [NSString stringWithFormat:@"%ld", [sSOAPMessage length]];
    
    [myRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [myRequest addValue: _strURL forHTTPHeaderField:@"SOAPAction"];
    [myRequest addValue: sMessageLength forHTTPHeaderField:@"Content-Length"];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setHTTPBody: [sSOAPMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc] initWithRequest:myRequest delegate:self];

}


-(void)logout:(YPLogoutRequest*)logoutRequest{
    
    
    responseData=[[NSMutableData alloc] init];
    
    //    NSString *sSOAPMessage= [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"%@\"><soap:Body><logout><logoutRequest><SC></SC><applicationType>%@</applicationType><role>%@</role><userName>%@</userName><valid>true</valid></logoutRequest></logout></soap:Body></soap:Envelope>",_strURL,logoutRequest.applicationType,logoutRequest.role,logoutRequest.userName];
    
    /*<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.loyalty.yes" xmlns:req="request.loyalty.yes">
     <soapenv:Header/>
     <soapenv:Body>
     <ser:logoutShopper>
     <ser:logoutRequest>
     <req:SC>?</req:SC>
     <req:userID>?</req:userID>
     <req:valid>?</req:valid>
     <req:versionID>?</req:versionID>
     </ser:logoutRequest>
     </ser:logoutShopper>
     </soapenv:Body>
     </soapenv:Envelope>*/
    
    
    
    //New Implementation for logout added by Sumit
    
    CAppDelegate *appDelegate = (CAppDelegate*)[UIApplication sharedApplication].delegate;
    
    NSString * sSOAPMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ser=\"http://service.loyalty.yes\" xmlns:req=\"request.loyalty.yes\"><soapenv:Header/><soapenv:Body> <ser:logoutShopper><ser:logoutRequest><req:SC>%@</req:SC><req:userID>%@</req:userID><req:valid>true</req:valid><req:versionID>100</req:versionID></ser:logoutRequest></ser:logoutShopper></soapenv:Body></soapenv:Envelope>",appDelegate.SC,logoutRequest.userName];
    
    NSLog(@"****************LOGOUT REQUEST***********************");
    NSLog(@"%@",sSOAPMessage);
    NSLog(@"****************LOGOUT REQUEST***********************");
    
    NSURL *sRequestURL = [NSURL URLWithString:_strURL];
    NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:sRequestURL];
    NSString *sMessageLength = [NSString stringWithFormat:@"%ld", [sSOAPMessage length]];
    
    
    [myRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [myRequest addValue: _strURL forHTTPHeaderField:@"SOAPAction"];
    [myRequest addValue: sMessageLength forHTTPHeaderField:@"Content-Length"];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setHTTPBody: [sSOAPMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc] initWithRequest:myRequest delegate:self];
    
    
}

-(void)registerUser:(YPRegisterRequest*)registerRequest{

    responseData=[[NSMutableData alloc] init];
    
    
    /*
  //  <?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns="https://194.72.158.228/cardholder/services/CardHolderService"><soap:Body><registerUser><registerRequest><DOB>16081987</DOB><cardInfo><CVV>083</CVV><cardName>3D visa card</cardName><cardNumber>4012001037141112</cardNumber><expiryDate>0214</expiryDate><valid>false</valid></cardInfo><city>indore</city><country>826</country><emailAddress>email@gmail.com</emailAddress><firstName>ajit</firstName><lastName>sharma</lastName><middleName>kumar</middleName><mobilePhoneNumber>9009241741</mobilePhoneNumber><password>abc123</password><postCode>155</postCode><region>LIG</region><sex>Male</sex><streetAddress1>16</streetAddress1><streetAddress2>street 2</streetAddress2><userName>ajit@gmail.com</userName><valid>true</valid></registerRequest></registerUser></soap:Body></soap:Envelope>
    
//    NSString *sSOAPMessage= [NSString stringWithFormat:@"<?xml version=\"1.0\"encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"xmlns=\"%@\"><soap:Body><registerUser><registerRequest><DOB>%@</DOB><cardInfo><CVV>%@</CVV><cardName>%@</cardName><cardNumber>%@</cardNumber><expiryDate>%@</expiryDate><valid>false</valid></cardInfo><city>%@</city><country>%@</country><emailAddress>%@</emailAddress><firstName>%@</firstName><lastName>%@</lastName><middleName>%@</middleName><mobilePhoneNumber>%@</mobilePhoneNumber><password>%@</password><postCode>%@</postCode><region>%@</region><sex>%@</sex><streetAddress1>%@</streetAddress1><streetAddress2>%@</streetAddress2><userName>%@</userName><valid>true</valid></registerRequest></registerUser></soap:Body></soap:Envelope>",_strURL,registerRequest.DOB,registerRequest.cardInfo.CVV,registerRequest.cardInfo.cardName,registerRequest.cardInfo.cardNumber,registerRequest.cardInfo.expiryDate,registerRequest.city,registerRequest.country,registerRequest.emailAddress,registerRequest.firstName,registerRequest.lastName,registerRequest.middleName,registerRequest.mobilePhoneNumber,registerRequest.password,registerRequest.postCode,registerRequest.region,registerRequest.sex,registerRequest.streetAddress1,registerRequest.streetAddress2,registerRequest.userName];
    
    
    /*
     
     <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.loyalty.yes" xmlns:req="request.loyalty.yes">
     <soapenv:Header/>
     <soapenv:Body>
     <ser:registerShopper>
    
     <ser:registerRequest>
    
     <req:DOB></req:DOB>
     <req:firstName>ajit</req:firstName>
     <req:gender>M</req:gender>
     <req:lastName>sharma</req:lastName>
     <req:password>Abc123456</req:password>
     <req:profilePicture></req:profilePicture>
     <req:profilePictureName></req:profilePictureName>
     <req:userID>sumit1@gmail.com</req:userID>
     <req:valid>true</req:valid>
     <req:versionID>100</req:versionID>
     
     </ser:registerRequest>
     
     </ser:registerShopper>
     
     
     </soapenv:Body>
     </soapenv:Envelope>
     
     */
   
    
    //NSString *sSOAPMessage= [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"%@\"><soap:Body><registerUser><registerRequest><DOB>%@</DOB><cardInfo><CVV>%@</CVV><cardName>%@</cardName><cardNumber>%@</cardNumber><expiryDate>%@</expiryDate><valid>false</valid></cardInfo><city>%@</city><country>%@</country><emailAddress>%@</emailAddress><firstName>%@</firstName><lastName>%@</lastName><middleName>%@</middleName><mobilePhoneNumber>%@</mobilePhoneNumber><password>%@</password><postCode>%@</postCode><region>%@</region><sex>%@</sex><streetAddress1>%@</streetAddress1><streetAddress2>%@</streetAddress2><userName>%@</userName><valid>true</valid></registerRequest></registerUser></soap:Body></soap:Envelope>",_strURL,registerRequest.DOB,registerRequest.cardInfo.CVV,registerRequest.cardInfo.cardName,registerRequest.cardInfo.cardNumber,registerRequest.cardInfo.expiryDate,registerRequest.city,registerRequest.country,registerRequest.emailAddress,registerRequest.firstName,registerRequest.lastName,registerRequest.middleName,registerRequest.mobilePhoneNumber,registerRequest.password,registerRequest.postCode,registerRequest.region,registerRequest.sex,registerRequest.streetAddress1,registerRequest.streetAddress2,registerRequest.userName];
    
   // NSString *sSOAPMessage= [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"%@\"><soap:Body><registerShopper><registerRequest><DOB>160887</DOB><firstName>ajit</firstName><profilePicture></profilePicture><profilePictureName></profilePictureName><password>Abc123456</password><gender>M</gender><userID>ajit2@gmail.com</userID><valid>true</valid><versionID>100</versionID></registerRequest></registerShopper></soap:Body></soap:Envelope>",_strURL];
    
    
    NSString *sSOAPMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ser=\"http://service.loyalty.yes\" xmlns:req=\"request.loyalty.yes\"><soapenv:Header/><soapenv:Body><registerShopper><registerRequest><DOB>%@</DOB><firstName>%@</firstName><gender>%@</gender><lastName>%@</lastName><password>%@</password><userID>%@</userID><valid>true</valid><versionID>%@</versionID></registerRequest></registerShopper></soapenv:Body></soapenv:Envelope>",registerRequest.DOB,registerRequest.firstName,registerRequest.gender,registerRequest.lastName,registerRequest.password,registerRequest.userID,registerRequest.versionID];
    
    
   /*
    
    NSString *sSOAPMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"><soapenv:Body><registerShopper><registerRequest>"];
    
    if (registerRequest.DOB.length>0) {
        sSOAPMessage=[NSString stringWithFormat:@"%@<DOB>%@</DOB>",sSOAPMessage,registerRequest.DOB];
    }
    sSOAPMessage=[NSString stringWithFormat:@"%@<firstName>%@</firstName>",sSOAPMessage,registerRequest.firstName];
    if (registerRequest.gender.length>0) {
        sSOAPMessage=[NSString stringWithFormat:@"%@<gender>%@</gender>",sSOAPMessage,registerRequest.gender];
    }
    sSOAPMessage=[NSString stringWithFormat:@"%@<lastName>%@</lastName><password>%@</password>",sSOAPMessage,registerRequest.lastName,registerRequest.password];
    sSOAPMessage=[NSString stringWithFormat:@"%@<profilePictureName>%@</profilePictureName>",sSOAPMessage,registerRequest.profilePictureName];
    if (registerRequest.profilePic.length>0) {
        sSOAPMessage=[NSString stringWithFormat:@"%@<profilePicture>%@</profilePicture>",sSOAPMessage,registerRequest.profilePic];
    }
    sSOAPMessage=[NSString stringWithFormat:@"%@<userID>%@</userID><valid>true</valid><versionID>%@</versionID></registerRequest></registerShopper></soapenv:Body>",sSOAPMessage,registerRequest.userID,registerRequest.versionID];
    
    */
    
    NSLog(@"ssoap message - %@",sSOAPMessage);
    
    NSURL *sRequestURL = [NSURL URLWithString:_strURL];
    NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:sRequestURL];
    NSString *sMessageLength = [NSString stringWithFormat:@"%ld", [sSOAPMessage length]];
   
    NSLog(@"length -- %@",sMessageLength);

    [myRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [myRequest addValue: _strURL forHTTPHeaderField:@"SOAPAction"];
    [myRequest addValue: sMessageLength forHTTPHeaderField:@"Content-Length"];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setHTTPBody: [sSOAPMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc] initWithRequest:myRequest delegate:self];


    
}

-(void)addNewCard:(YPAddCardRequest*)addCardRequest{
    
    responseData=[[NSMutableData alloc] init];
    
    /*NSString *sSOAPMessage= [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"%@\"><soap:Body><addCard><addCardRequest><CVV>%@</CVV><SC>%@</SC><addressLine1>%@</addressLine1><addressLine2>%@</addressLine2><applicationType>%@</applicationType><cardName>%@</cardName><cardNumber>%@</cardNumber><cardholderName>%@</cardholderName><city>%@</city><country>%@</country><email1>%@</email1><expiryDate>%@</expiryDate><fax1>%@</fax1><phone1>%@</phone1><postCode>%@</postCode><userName>%@</userName><valid>true</valid></addCardRequest></addCard></soap:Body></soap:Envelope>",_strURL,addCardRequest.CVV,addCardRequest.SC,addCardRequest.addressLine1,addCardRequest.addressLine2,addCardRequest.applicationType,addCardRequest.cardName,addCardRequest.cardNumber,addCardRequest.cardholderName,addCardRequest.city,addCardRequest.country,addCardRequest.email1,addCardRequest.expiryDate,addCardRequest.fax1,addCardRequest.phone1,addCardRequest.postCode,addCardRequest.userName];*/
    
    
    
    /*NSString *sSOAPMessage= [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"%@\"><soap:Body><addCard><addCardRequest><SC>%@</SC><applicationType>%@</applicationType><cardName>%@</cardName><cardNumber>%@</cardNumber><userName>%@</userName><valid>true</valid></addCardRequest></addCard></soap:Body></soap:Envelope>",_strURL,addCardRequest.SC,addCardRequest.applicationType,addCardRequest.cardName,addCardRequest.cardNumber,addCardRequest.userName];*/
    
    
    
    /* if (addCardRequest.userName != nil) [str appendFormat: @"<userName>%@</userName>", [[addCardRequest.userName stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];*/
    
    
    
    /*  NSString *sSOAPMessage= [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ser=\"http://service.loyalty.yes\" xmlns:req=\"request.loyalty.yes\"><soapenv:Header/><soapenv:Body><addCard><addCardRequest><SC>%@</SC><userID>%@</userID><cardNumber>%@</cardNumber><cardName>%@</cardName><CVV>%@</CVV><addressLine1>%@</addressLine1><postCode>%@</postCode></addCardRequest></addCard></soapenv:Body></soapenv:Envelope>",addCardRequest.SC,addCardRequest.userName,addCardRequest.cardNumber,addCardRequest.cardName,addCardRequest.CVV,addCardRequest.addressLine1,addCardRequest.postCode];*/
    
    NSString *sSOAPMessage= [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ser=\"http://service.loyalty.yes\" xmlns:req=\"request.loyalty.yes\"><soapenv:Header/><soapenv:Body><addCard><addCardRequest><SC>%@</SC><userID>%@</userID><cardNumber>%@</cardNumber><cardName>%@</cardName></addCardRequest></addCard></soapenv:Body></soapenv:Envelope>",addCardRequest.SC,addCardRequest.userName,addCardRequest.cardNumber,addCardRequest.cardName];
    
    
    
    
    
    NSLog(@"addNewCard_envelop = %@",sSOAPMessage);
    NSURL *sRequestURL = [NSURL URLWithString:_strURL];
    NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:sRequestURL];
    NSString *sMessageLength = [NSString stringWithFormat:@"%ld", [sSOAPMessage length]];
    
    [myRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [myRequest addValue: _strURL forHTTPHeaderField:@"SOAPAction"];
    [myRequest addValue: sMessageLength forHTTPHeaderField:@"Content-Length"];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setHTTPBody: [sSOAPMessage dataUsingEncoding:NSUTF8StringEncoding]];
    conn = [[NSURLConnection alloc] initWithRequest:myRequest delegate:self];
    
    
}
-(void)updatePassword:(YPUpdatePasswordRequest*)updatePasswordRequest{

    responseData=[[NSMutableData alloc] init];
    
    NSString *sSOAPMessage= [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"%@\"><soap:Body><updatePassword><updatePasswordRequest><SC>%@</SC><applicationType>%@</applicationType><newPassword>%@</newPassword><oldPassword>%@</oldPassword><userName>%@</userName><valid>true</valid></updatePasswordRequest></updatePassword></soap:Body></soap:Envelope>",_strURL,updatePasswordRequest.SC,updatePasswordRequest.applicationType,updatePasswordRequest.nPassword,updatePasswordRequest.oldPassword,updatePasswordRequest.userName];
    
    NSURL *sRequestURL = [NSURL URLWithString:_strURL];
    NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:sRequestURL];
    NSString *sMessageLength = [NSString stringWithFormat:@"%ld", [sSOAPMessage length]];
    
    [myRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [myRequest addValue: _strURL forHTTPHeaderField:@"SOAPAction"];
    [myRequest addValue: sMessageLength forHTTPHeaderField:@"Content-Length"];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setHTTPBody: [sSOAPMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc] initWithRequest:myRequest delegate:self];



}

-(void)getUserInfo:(YPUserInfoRequest*)userInfoRequest{


    
    responseData=[[NSMutableData alloc] init];
    
    //<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns="https://194.72.158.228/cardholder/services/CardHolderService"><soap:Body><getUserInfo><userInfoRequest><SC>1137BEC4211FA9A5427229D164B4911B382A58E5</SC><userName>rd@gmail.com</userName><valid>true</valid></userInfoRequest></getUserInfo></soap:Body></soap:Envelope>
    
    NSString *sSOAPMessage= [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"%@\"><soap:Body><getUserInfo><userInfoRequest><SC>%@</SC><userName>%@</userName><valid>true</valid></userInfoRequest></getUserInfo></soap:Body></soap:Envelope>",_strURL,userInfoRequest.SC,userInfoRequest.userName];
    
    NSURL *sRequestURL = [NSURL URLWithString:_strURL];
    NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:sRequestURL];
    NSString *sMessageLength = [NSString stringWithFormat:@"%ld", [sSOAPMessage length]];
    
    [myRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [myRequest addValue: _strURL forHTTPHeaderField:@"SOAPAction"];
    [myRequest addValue: sMessageLength forHTTPHeaderField:@"Content-Length"];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setHTTPBody: [sSOAPMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc] initWithRequest:myRequest delegate:self];




}

-(void)updateUserInfo:(YPUpdateUserInfoRequest*)updateUserInfoRequest{

    responseData=[[NSMutableData alloc] init];
    
    //<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns="https://194.72.158.228/cardholder/services/CardHolderService"><soap:Body><updateUserInfo><updateUserInfoRequest><DOB>26121986</DOB><SC>1137BEC4211FA9A5427229D164B4911B382A58E5</SC><applicationType>M</applicationType><emailAddress>jit@gmail.com</emailAddress><firstName>rd</firstName><lastName>rd</lastName><middleName></middleName><postCode>14</postCode><sex></sex><streetAddress1>21</streetAddress1><userName>rd@gmail.com</userName><valid>true</valid></updateUserInfoRequest></updateUserInfo></soap:Body></soap:Envelope>
    
    NSString *sSOAPMessage= [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"%@\"><soap:Body><updateUserInfo><updateUserInfoRequest><DOB>%@</DOB><SC>%@</SC><applicationType>%@</applicationType><emailAddress>%@</emailAddress><firstName>%@</firstName><lastName>%@</lastName><middleName>%@</middleName><postCode>%@</postCode><sex>%@</sex><streetAddress1>%@</streetAddress1><userName>%@</userName><valid>true</valid></updateUserInfoRequest></updateUserInfo></soap:Body></soap:Envelope>",_strURL,updateUserInfoRequest.DOB,updateUserInfoRequest.SC,updateUserInfoRequest.applicationType,updateUserInfoRequest.emailAddress,updateUserInfoRequest.firstName,updateUserInfoRequest.lastName,updateUserInfoRequest.middleName,updateUserInfoRequest.postCode,updateUserInfoRequest.sex,updateUserInfoRequest.streetAddress1,updateUserInfoRequest.userName];
    
    NSURL *sRequestURL = [NSURL URLWithString:_strURL];
    NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:sRequestURL];
    NSString *sMessageLength = [NSString stringWithFormat:@"%ld", [sSOAPMessage length]];
    
    [myRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [myRequest addValue: _strURL forHTTPHeaderField:@"SOAPAction"];
    [myRequest addValue: sMessageLength forHTTPHeaderField:@"Content-Length"];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setHTTPBody: [sSOAPMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc] initWithRequest:myRequest delegate:self];
    


}


-(void)getAllCards:(YPGetCardsInWalletDetailedRequest*)getAllCardsRequest{


    responseData=[[NSMutableData alloc] init];
    
    
//    if ([getAllCardsRequest.updateDatetimestamp isEqualToString:()]) {
//        <#statements#>
//    }
    //<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns="https://194.72.158.228/cardholder/services/CardHolderService"><soap:Body><updateUserInfo><updateUserInfoRequest><DOB>26121986</DOB><SC>1137BEC4211FA9A5427229D164B4911B382A58E5</SC><applicationType>M</applicationType><emailAddress>jit@gmail.com</emailAddress><firstName>rd</firstName><lastName>rd</lastName><middleName></middleName><postCode>14</postCode><sex></sex><streetAddress1>21</streetAddress1><userName>rd@gmail.com</userName><valid>true</valid></updateUserInfoRequest></updateUserInfo></soap:Body></soap:Envelope>
    
    NSString *sSOAPMessage= [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"%@\"><soap:Body><getCardsInWalletDetailed><getCardsInWalletDetailedRequest><SC>%@</SC><applicationType>%@</applicationType><userName>%@</userName><valid>true</valid></getCardsInWalletDetailedRequest></getCardsInWalletDetailed></soap:Body></soap:Envelope>",_strURL,getAllCardsRequest.SC,getAllCardsRequest.applicationType,getAllCardsRequest.userName];
    
    NSLog(@"getAllCards_envelop=%@",sSOAPMessage);
    
    
    
    NSURL *sRequestURL = [NSURL URLWithString:_strURL];
    NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:sRequestURL];
    NSString *sMessageLength = [NSString stringWithFormat:@"%ld", [sSOAPMessage length]];
    
    [myRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [myRequest addValue: _strURL forHTTPHeaderField:@"SOAPAction"];
    [myRequest addValue: sMessageLength forHTTPHeaderField:@"Content-Length"];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setHTTPBody: [sSOAPMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc] initWithRequest:myRequest delegate:self];
    



}

-(void)deleteCard:(YPRemoveCardRequest*)deleteCard{

    
    responseData=[[NSMutableData alloc] init];

    NSString *sSOAPMessage= [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"%@\"><soap:Body><removeCard><removeCardRequest><SC>%@</SC><applicationType>%@</applicationType><cardReference>%@</cardReference><userName>%@</userName><valid>true</valid></removeCardRequest></removeCard></soap:Body></soap:Envelope>",_strURL,deleteCard.SC,deleteCard.applicationType,deleteCard.cardReference,deleteCard.userName];
    
    
    
    
    NSURL *sRequestURL = [NSURL URLWithString:_strURL];
    NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:sRequestURL];
    NSString *sMessageLength = [NSString stringWithFormat:@"%ld", [sSOAPMessage length]];
    
    [myRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [myRequest addValue: _strURL forHTTPHeaderField:@"SOAPAction"];
    [myRequest addValue: sMessageLength forHTTPHeaderField:@"Content-Length"];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setHTTPBody: [sSOAPMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc] initWithRequest:myRequest delegate:self];
    
    
    


}



@end
