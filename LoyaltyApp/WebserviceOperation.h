//
//  WebserviceOperation.h

//
//  Created by Praveen Tripathi on 26/12/10.
//  Copyright 2010 PKTSVITS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPLoginRequest.h"
#import "YPLogoutRequest.h"
#import "YPRegisterRequest.h"
#import "YPAddCardRequest.h"
#import "YPUpdatePasswordRequest.h"
#import "YPUserInfoRequest.h"
#import "YPUpdateUserInfoRequest.h"
#import "YPGetCardsInWalletDetailedRequest.h"
#import "YPRemoveCardRequest.h"



@interface WebserviceOperation : NSObject<NSURLConnectionDelegate> {
    NSURLConnection *conn;
    
	NSMutableData *responseData;
	id _delegate;
	SEL _callback;
    NSString *strURL;
    
}

@property(nonatomic, retain) 	id _delegate;
@property(nonatomic, assign) 	SEL _callback;
@property(nonatomic, assign) NSString *strURL;


-(id)initWithDelegate:(id)delegate callback:(SEL)callback;


-(void)registerUser:(YPRegisterRequest*)registerRequest;
-(void)addNewCard:(YPAddCardRequest*)addCardRequest;
-(void)login:(YPLoginRequest*)loginRequest;
-(void)logout:(YPLogoutRequest*)logoutRequest;
-(void)updatePassword:(YPUpdatePasswordRequest*)updatePasswordRequest;
-(void)getUserInfo:(YPUserInfoRequest*)userInfoRequest;
-(void)updateUserInfo:(YPUpdateUserInfoRequest*)updateUserInfoRequest;
-(void)getAllCards:(YPGetCardsInWalletDetailedRequest*)getAllCardsRequest;
-(void)deleteCard:(YPRemoveCardRequest*)deleteCard;


-(void)getCountryList;

-(void)getCurrencyList;



                                                                     
@end
