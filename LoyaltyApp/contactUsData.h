//
//  contactUsData.h
//  YesPayCardHolderWallet
//
//  Created by Nirmal Patidar on 28/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface contactUsData : NSObject {
	NSString *email1;
	NSString *email2;
	NSString *email3;
	NSString *phone1;
	NSString *phone2;
	NSString *phone3;
	NSString *country;
    NSString *message;
}
@property (nonatomic,strong) NSString *email1;
@property (nonatomic,strong) NSString *email2;
@property (nonatomic,strong) NSString *email3;
@property (nonatomic,strong) NSString *phone1;
@property (nonatomic,strong) NSString *phone2;
@property (nonatomic,strong) NSString *phone3;
@property (nonatomic,strong) NSString *country;
@property (nonatomic,strong) NSString *message;
@end
