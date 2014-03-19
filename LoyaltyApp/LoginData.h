//
//  LoginData.h
//  YesPayCardHolderWallet
//
//  Created by Chandra Prakash on 11/05/10.
//  Copyright 2010 InfoBeans. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LoginData : NSObject {

	NSString *uid;
	NSString *username;
	NSString *password;
	NSString *userid;
	
}
@property(nonatomic,strong) NSString *uid;
@property(nonatomic,strong) NSString *username;
@property(nonatomic,strong) NSString *password;
@property(nonatomic,strong) NSString *userid;
@end
