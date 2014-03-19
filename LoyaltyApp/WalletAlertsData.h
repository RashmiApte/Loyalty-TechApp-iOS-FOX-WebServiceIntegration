//
//  WalletAlertsData.h
//  YesPayCardHolderWallet
//
//  Created by Nirmal Patidar on 03/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WalletAlertsData : NSObject {
	NSString *message;
	NSString *updateDateTimeStamp;
}
@property (nonatomic, strong)NSString *message;
@property (nonatomic, strong)NSString *updateDateTimeStamp;
@end
