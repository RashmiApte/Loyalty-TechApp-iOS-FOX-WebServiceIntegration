//
//  DataBase.h
//  YesPayCardHolderWallet
//
//  Created by Nirmal Patidar on 10/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DataBase : NSObject {
	
}
+(BOOL)OpenDataBase;
+(void)CloseDataBase;
+(void)CheckDataBase;
+(void)InsertIntoTable:(NSString *)insertquery;
+(void)deleteDataFromTable:(NSString*)deleteQuery;
+(void)UpadteTable:(NSString *)updatequery;
+(int)getNumberOfRows:(NSString *)tablename;
+(int)getNumberOfRowsForQuery:(NSString *)query;

/////// Shailesh Tiwari 23/5/11
+(NSMutableArray *)getAllCurrencyList;
+(void)saveCurrencListInToDataBase:(NSString *)currCode:(NSString *)currAlphaCode:(NSString *)currName;


/// Added by Shailesh Tiwari 180811
+(NSMutableArray *)getAllCountryList;

+(NSMutableArray *)getUserInfoTableData:(NSString *)query;
+(NSMutableArray *)getPromotionTableData:(NSString *)query;
+(NSMutableArray *)getInstantDiscountTableData:(NSString *)query;
+(NSMutableArray *)getDiscountCouponsTableData:(NSString *)query;
+(NSMutableArray *)getCardDetailsTableData:(NSString *)query;
+(NSMutableArray *)getTransactionTableData:(NSString *)query;
+(NSMutableArray *)getLoginTableData:(NSString *)query;
+(NSMutableArray *)getTransactionSummaryTableData:(NSString *)query;
+(NSMutableArray *)getCardAccountInfoTableData:(NSString *)query;
+(NSMutableArray *)getCategoryWiseretailerTableData:(NSString *)query;
+(NSMutableArray *)getVirtualCardTableData:(NSString *)query;
+(NSMutableArray *)getMessageData:(NSString *)query;
+(NSMutableArray *)getWalletAlertsData:(NSString *)query;
+(NSMutableArray *)getDeliveryAddressData:(NSString *)query;
+(NSMutableArray *)getRetailerVisitedTableData:(NSString *)query;
+(NSMutableArray *)getTopretailerTableData:(NSString *)query;
+(NSMutableArray *)getUpdateDateTimeStampData:(NSString *)query;
+(NSMutableArray *)getContactUsData:(NSString *)query;
+(void)checkAndCreateDatabase;
@end
