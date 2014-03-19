//
//  UserInfoData.h
//  YesPayCardHolderWallet
//
//  Created by Chandra Prakash on 10/05/10.
//  Copyright 2010 InfoBeans. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserInfoData : NSObject {
	NSString *userid;
	NSString *username;
	NSString *password;
	NSString *firstname;
	NSString *middlename;
	NSString *lastname;
	NSString *dob;
	NSString *address1;
	NSString *address2;
	NSString *city;
	NSString *region;
	NSString *country;
	NSString *postcode;
	NSString *mobileno;
	NSString *emailid;
	NSString *sex;
	NSString *updatetimestamp;
	
}
@property(nonatomic,strong) NSString *userid;
@property(nonatomic,strong) NSString *username;
@property(nonatomic,strong) NSString *password;
@property(nonatomic,strong) NSString *firstname;
@property(nonatomic,strong) NSString *middlename;
@property(nonatomic,strong) NSString *lastname;
@property(nonatomic,strong) NSString *dob;
@property(nonatomic,strong) NSString *address1;
@property(nonatomic,strong) NSString *address2;
@property(nonatomic,strong) NSString *city;
@property(nonatomic,strong) NSString *region;
@property(nonatomic,strong) NSString *country;
@property(nonatomic,strong) NSString *postcode;
@property(nonatomic,strong) NSString *mobileno;
@property(nonatomic,strong) NSString *emailid;
@property(nonatomic,strong) NSString *sex;
@property(nonatomic,strong) NSString *updatetimestamp;
@end
