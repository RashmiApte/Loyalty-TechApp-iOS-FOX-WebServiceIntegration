//
//  CardDetailsData.h
//  YesPayCardHolderWallet
//
//  Created by Chandra Prakash on 11/05/10.
//  Copyright 2010 InfoBeans. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CardDetailsData : NSObject {

	NSString *cardReferance;
	NSString *cardnumber;
	NSString *cardname;
	NSString *cardholdername;
	NSString *address1;
	NSString *address2;
	NSString *address3;
	NSString *city;
	NSString *country;
	NSString *postcode;
	NSString *phone1;
	NSString *fax1;
	NSString *email1;
	NSString *issuerName;
	NSString *startdate;
	NSString *expiryDate;
	NSString *cardissuenumber;
	NSString *updatetimeinterval;
	NSString *cardBalance;
	NSString *cardStatus;
	NSString *imageName;
	NSString *fundtransferallowed;
    NSString *issuerImageURL;
}

@property(nonatomic,strong) NSString *issuerImageURL;
@property(nonatomic,strong) NSString *cardReferance;
@property(nonatomic,strong) NSString *fundtransferallowed;
@property(nonatomic,strong) NSString *cardnumber;
@property(nonatomic,strong) NSString *cardname;
@property(nonatomic,strong) NSString *cardholdername;
@property(nonatomic,strong) NSString *address1;
@property(nonatomic,strong) NSString *address2;
@property(nonatomic,strong) NSString *address3;
@property(nonatomic,strong) NSString *city;
@property(nonatomic,strong) NSString *country;
@property(nonatomic,strong) NSString *postcode;
@property(nonatomic,strong) NSString *phone1;
@property(nonatomic,strong) NSString *fax1;
@property(nonatomic,strong) NSString *email1;
@property(nonatomic,strong) NSString *issuerName;
@property(nonatomic,strong) NSString *startdate;
@property(nonatomic,strong) NSString *expiryDate;
@property(nonatomic,strong) NSString *cardissuenumber;
@property(nonatomic,strong) NSString *updatetimeinterval;
@property(nonatomic,strong) NSString *cardBalance;
@property(nonatomic,strong) NSString *cardStatus;
@property(nonatomic,strong) NSString *imageName;
@end
