/*
 *
 * Copyright -Year _Company Name_.  All rights reserved.
 *
 * File Name       : DataBase.m
 *
 * Created Date    : 10/05/10
 *
 * Description     :
 *
 * Modification History:
 *
 * Date            Name                Description
 * ------------------------------------------------
 * 10/05/10	   Nirmal Patidar
 *
 * Bug History:
 *
 * Date            Id                Description
 * ------------------------------------------------
 *
 
 
 */


#import "DataBase.h"
#import "UserInfoData.h"
#import "CardDetailsData.h"
#import "LoginData.h"
#import "WalletAlertsData.h"
#import "updateDateTimeStampData.h"

sqlite3 *database;
NSString *databaseName;
NSString *databasePath;


@implementation DataBase

+(BOOL)OpenDataBase{
	
		if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK )
			
		{
			//  NSAssert(0, @"Database failed to open.");
			NSLog(@"Database open.");
			return TRUE;
			
		}
		else{
			NSLog(@"Database Failed to open");
			return FALSE;
		}
	
	//return sqlite3_open([databasePath UTF8String], &database);
}

+(void)CloseDataBase{
	NSLog(@"DataBase Closed");
	sqlite3_close(database);
}

+(void)CheckDataBase
{
	NSLog(@"Check Data Base");
	// Setup some globals
	databaseName = @"WalletApp.sqlite";
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	//[databasePath retain];
	// Execute the "checkAndCreateDatabase" function
	[DataBase checkAndCreateDatabase];
    NSLog(@"data base path is %@",databasePath);
	
}

+(void) checkAndCreateDatabase{
	// Check if the SQL database has already been saved to the users phone, if not then copy it over
	
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath =  [documentsDirectory stringByAppendingPathComponent:@"WalletApp-2.sqlite"];
	
	if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
		//NSLog(@"Removed wallet app 2");
		[[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
	}
	
	NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory1 = [paths1 objectAtIndex:0];
	NSString *filePath1 =  [documentsDirectory1 stringByAppendingPathComponent:@"WalletApp-3.sqlite"];
	
	if([[NSFileManager defaultManager] fileExistsAtPath:filePath1]){
	//	NSLog(@"Removed wallet app 3");
		[[NSFileManager defaultManager] removeItemAtPath:filePath1 error:nil];
	}
	
		
	NSFileManager *fileManager = [NSFileManager defaultManager];
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];

	// Check if the database has already been created in the users filesystem
	//success = [fileManager fileExistsAtPath:databasePath];// comment because memeory leak (value stored to 'success' is never read)
	NSLog(@"Database Path is: %@",databasePath);
	
   // Copy the database from the package to the users filesystem
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
 	//[fileManager release];
	
	//To get App Version from Info.plist
	
	NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
 	
	NSString *build = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
 	
	NSString *versionString = [NSString stringWithFormat:@"%@",build];
	NSLog(@"App Version in Info.plist is : %@",versionString);
	/**/
	
	NSString *upadteQuery = @"UPDATE VersionTable set appversion =";
	//upadteQuery = [upadteQuery stringByAppendingString:[NSString stringWithFormat:@"'%@'",@"1.0"]];
	upadteQuery = [upadteQuery stringByAppendingString:[NSString stringWithFormat:@"'%@'",versionString]];
	[DataBase UpadteTable:upadteQuery];
	
	
}


+(void)InsertIntoTable:(NSString *)insertquery{
	if([DataBase OpenDataBase])
	{	
		sqlite3_stmt *addStmt = nil;

		if(addStmt == nil) {
			const char *sql = [insertquery UTF8String];
			if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
		}
		if(SQLITE_DONE != sqlite3_step(addStmt))
			NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));

		sqlite3_reset(addStmt);
		[DataBase CloseDataBase];
	}
	else {
		NSLog(@"Can not open Data Base");
	}

}

+(void)deleteDataFromTable:(NSString*)deleteQuery
{
	if([DataBase OpenDataBase])
	{	
		sqlite3_stmt *addStmt = nil;
		
		if(addStmt == nil) {
			const char *sql = [deleteQuery UTF8String];
			if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
		}
		if(SQLITE_DONE != sqlite3_step(addStmt))
			NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
		
		sqlite3_reset(addStmt);
		[DataBase CloseDataBase];
	}
	else {
		NSLog(@"Can not open Data Base");
	}
	
	
}


+(void)UpadteTable:(NSString *)updatequery{
	if([DataBase OpenDataBase])
	{	
		sqlite3_stmt *addStmt = nil;
		
		if(addStmt == nil) {
			const char *sql = [updatequery UTF8String];
			if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
				NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
		}
		if(SQLITE_DONE != sqlite3_step(addStmt))
			NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
		
		sqlite3_reset(addStmt);
			[DataBase CloseDataBase];
	}
	else {
		NSLog(@"Can not open Data Base");
	}

}



+(NSMutableArray *) getAllCountryList {
	
	NSMutableArray *arrItems = [[NSMutableArray alloc] initWithObjects:nil];
	sqlite3_stmt *selectStmt=nil;
	
	if ([DataBase OpenDataBase]) {
		
		const char *sql = "SELECT * from CountryDetails order by countryname";
		
		if (sqlite3_prepare_v2(database, sql, -1, &selectStmt, NULL)!= SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		} // if
		
		while (sqlite3_step(selectStmt) == SQLITE_ROW) {
			
			NSMutableDictionary *tempData = [[NSMutableDictionary alloc]
										  initWithObjectsAndKeys:
										  [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStmt,0)],@"countryCode",
										  [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStmt, 1)],@"countryName",
										   nil];
			[arrItems addObject:tempData];
            
		}
	}
	sqlite3_reset(selectStmt);
	[DataBase CloseDataBase];
	return arrItems;
}

+(NSMutableArray *)getAllCurrencyList{
	
	NSMutableArray *arrItems = [[NSMutableArray alloc] initWithObjects:nil];
	sqlite3_stmt *selectStatement=nil;
	if([DataBase OpenDataBase])
	{
		
		const char *sql = "SELECT * FROM CurrencyCode order by currencyname";
		
		if (sqlite3_prepare_v2(database, sql, -1, &selectStatement, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		} // if
		
		// Bind the query variables.
		//sqlite3_bind_int(selectStatement, 1, iItemID);
		
		while (sqlite3_step(selectStatement) == SQLITE_ROW) {
			
			//Store the data in local variables from the sqlite database 
			NSMutableDictionary *tempData = [[NSMutableDictionary alloc]
											  initWithObjectsAndKeys:  
											  [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)], @"currencyCode", 
											  [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)], @"currencyAlphaCode", 
											  [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)], @"currencyName",
                                             [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 3)], @"status",
											  nil];
			//NSLog(@"VAlue from databaseeeeeeeee%@",[tempData objectForKey:@"currencyName"]);
			[arrItems addObject:tempData];
			//NSLog(@"Records in  databaseeeeeeeee%d",[arrItems count]);
		} // while
	} 
	
	//if(SQLITE_DONE != sqlite3_step(selectStatement))
	//	NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
	sqlite3_reset(selectStatement);
	[DataBase CloseDataBase];
	return arrItems;
}  



//////////// Save Currency list Records   .....Shailesh Tiwari 24/05/11
+(void)saveCurrencListInToDataBase:(NSString *)currCode:(NSString *)currAlphaCode:(NSString *)currName{
	NSMutableDictionary *theDictionary = [[NSMutableDictionary alloc] init];
	if ([DataBase OpenDataBase]) {
		
		sqlite3_stmt *stmt=nil;
		//const char *insertsql = "UPDATE CurrencyCode SET currencycode = ?, currencyalphacode = ?,currencyname = ?";
		const char *insertsql = "INSERT INTO CurrencyCode (currencycode,currencyalphacode,currencyname,status) VALUES(?,?,?,?)";
		// NSLog(@"allCurrencyListArray.....%d",[allCurrencyListArray count]);
		//const char *insertsql;
		if (sqlite3_prepare_v2(database, insertsql, -1, &stmt, NULL)!= SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		} 	
		else {
			sqlite3_bind_text(stmt, 1,[currCode UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(stmt, 2,[currAlphaCode UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(stmt, 3,[currName UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 4,[@"yes" UTF8String], -1, SQLITE_TRANSIENT);
			//NSLog(@"saveCurrencListInToDataBase Records in  databaseeeeeeeee%@",currName);
		}
		
        
		if(SQLITE_DONE != sqlite3_step(stmt))
			NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
				sqlite3_reset(stmt);
		sqlite3_finalize(stmt);
		[DataBase CloseDataBase];
		
	}
	else {
		
	}	
	
}


+(int)getNumberOfRows:(NSString *)tablename{
	if([DataBase OpenDataBase])
	{
	
		int noofrows=0;
		NSString *sqlstatement=[NSString stringWithFormat:@"select * from %@",tablename];
		sqlite3_stmt *stmt=nil;
		if(stmt==nil){
			const char *sql=[sqlstatement UTF8String];
			if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) != SQLITE_OK){
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
			}else{
				noofrows=0;
				while(sqlite3_step(stmt) == SQLITE_ROW) {
					noofrows++;
				}
			}
		}
        else{
            NSLog(@"else part is called");
        }
			
		[DataBase CloseDataBase];
		return noofrows;
	}
	else {
		NSLog(@"Can not open Data Base");
		return 0;
	}	
	
}


+(NSMutableArray *)getLoginTableData:(NSString *)query{
	if([DataBase OpenDataBase])
	{
		NSMutableArray *dataarray=[[NSMutableArray alloc] init];
		sqlite3_stmt *stmt=nil;
		if(stmt==nil){
			const char *sql=[query UTF8String];
			if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) != SQLITE_OK){
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
			}else{
				// Loop through the results and add them to the feeds array
				while(sqlite3_step(stmt) == SQLITE_ROW) {
					// Read the data from the result row
					LoginData *t_pDatabaseRecord=[[LoginData alloc] init];
					
					int tempId=sqlite3_column_int(stmt, 0);
					t_pDatabaseRecord.uid=[NSString stringWithFormat:@"%d",tempId];
					t_pDatabaseRecord.username=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
					t_pDatabaseRecord.password=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
					
					//if(sqlite3_column_int(stmt, 3)!=0)
					//t_pDatabaseRecord.userid=[NSString stringWithFormat:@"%d",sqlite3_column_int(stmt, 3)];
					
					
					[dataarray addObject:t_pDatabaseRecord];
										
					
				}
				
			}
		}
		sqlite3_finalize(stmt);
		[DataBase CloseDataBase];
		return dataarray;
	}
	else {
		NSLog(@"Can not open Data Base");
		return nil;
	}
	
}


+(NSMutableArray *)getUserInfoTableData:(NSString *)query{
	if([DataBase OpenDataBase])
	{
		NSMutableArray *dataarray=[[NSMutableArray alloc] init];
		sqlite3_stmt *stmt=nil;
		if(stmt==nil){
			const char *sql=[query UTF8String];
			if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) != SQLITE_OK){
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
			}else{
				// Loop through the results and add them to the feeds array
				while(sqlite3_step(stmt) == SQLITE_ROW) {
					// Read the data from the result row
					UserInfoData *t_pDatabaseRecord=[[UserInfoData alloc] init];
					
					int tempId=sqlite3_column_int(stmt, 0);
					if(tempId != 0)
						t_pDatabaseRecord.userid=[NSString stringWithFormat:@"%d",tempId];
					if((char *)sqlite3_column_text(stmt, 1)!=NULL)
						t_pDatabaseRecord.username=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
					if((char *)sqlite3_column_text(stmt, 2)!=NULL)
						t_pDatabaseRecord.password=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
					if((char *)sqlite3_column_text(stmt, 3)!=NULL)
						t_pDatabaseRecord.firstname=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
					if((char *)sqlite3_column_text(stmt, 4)!=NULL)
                        t_pDatabaseRecord.middlename=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 4)];
					if((char *)sqlite3_column_text(stmt, 5)!=NULL)
                        t_pDatabaseRecord.lastname=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 5)];
					if((char *)sqlite3_column_text(stmt, 6)!=NULL)
                        t_pDatabaseRecord.dob=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 6)];
					if((char *)sqlite3_column_text(stmt, 7)!=NULL)
                        t_pDatabaseRecord.address1=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 7)];
					if((char *)sqlite3_column_text(stmt, 8)!=NULL)
                        t_pDatabaseRecord.address2=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 8)];
					if((char *)sqlite3_column_text(stmt, 9)!=NULL)
                        t_pDatabaseRecord.city=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 9)];
					if((char *)sqlite3_column_text(stmt, 10)!=NULL)
                        t_pDatabaseRecord.region=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 10)];
					if((char *)sqlite3_column_text(stmt, 11)!=NULL)
                        t_pDatabaseRecord.country=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 11)];
					if((char *)sqlite3_column_text(stmt, 12)!=NULL)
                        t_pDatabaseRecord.postcode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 12)];
					if((char *)sqlite3_column_text(stmt, 13)!=NULL)
                        t_pDatabaseRecord.mobileno=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 13)];
					if((char *)sqlite3_column_text(stmt, 14)!=NULL)
                        t_pDatabaseRecord.emailid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 14)];
					if((char *)sqlite3_column_text(stmt, 15)!=NULL)
                        t_pDatabaseRecord.sex=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 15)];
					if((char *)sqlite3_column_text(stmt, 16)!=NULL)
                        t_pDatabaseRecord.updatetimestamp=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 16)];
					
					
					[dataarray addObject:t_pDatabaseRecord];
					
					
				}
				
			}
		}
		sqlite3_finalize(stmt);
		[DataBase CloseDataBase];
		return dataarray;
	}
	else {
		NSLog(@"Can not open Data Base");
		return nil;
	}
    
}



+(int)getNumberOfRowsForQuery:(NSString *)query{
	if([DataBase OpenDataBase])
	{	
		
		int noofrows=0;
		//NSString *sqlstatement=[NSString stringWithFormat:@"select * from %@",tablename];
		sqlite3_stmt *stmt=nil;
		if(stmt==nil){
			const char *sql=[query UTF8String];
			if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) != SQLITE_OK){
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
			}else{
				noofrows=0;
				while(sqlite3_step(stmt) == SQLITE_ROW) {
					noofrows++;
				}
			}
		}
        else{
            NSLog(@"else statement is called");
        }
		
		
		[DataBase CloseDataBase];
		return noofrows;
	}
	else {
		NSLog(@"Can not open Data Base");
		return 0;
	}	
	
}





+(NSMutableArray *)getUpdateDateTimeStampData:(NSString *)query
{
	if([DataBase OpenDataBase])
	{
		NSMutableArray *dataarray=[[NSMutableArray alloc] init];
		sqlite3_stmt *stmt=nil;
		if(stmt==nil){
			const char *sql=[query UTF8String];
			if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) != SQLITE_OK){
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
			}else{
				// Loop through the results and add them to the feeds array
				while(sqlite3_step(stmt) == SQLITE_ROW) {
					// Read the data from the result row
					updateDateTimeStampData *t_pDatabaseRecord=[[updateDateTimeStampData alloc] init];
					
					if((char *)sqlite3_column_text(stmt, 0)!=NULL)
						t_pDatabaseRecord.updateDateTime=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
					
					[dataarray addObject:t_pDatabaseRecord];
				
					
					
				}
				
			}
		}
		sqlite3_finalize(stmt);
		[DataBase CloseDataBase];
		return dataarray;
	}
	else {
		NSLog(@"Can not open Data Base");
		return nil;
	}
	
}

+(NSMutableArray *)getCardDetailsTableData:(NSString *)query{
	if([DataBase OpenDataBase])
	{
		NSMutableArray *dataarray=[[NSMutableArray alloc] init];
		sqlite3_stmt *stmt=nil;
		if(stmt==nil){
			const char *sql=[query UTF8String];
			if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) != SQLITE_OK){
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
			}else{
				// Loop through the results and add them to the feeds array
				while(sqlite3_step(stmt) == SQLITE_ROW) {
					// Read the data from the result row
					CardDetailsData *t_pDatabaseRecord=[[CardDetailsData alloc] init];
					
					int tempId=sqlite3_column_int(stmt, 0);
					t_pDatabaseRecord.cardReferance=[NSString stringWithFormat:@"%d",tempId];
					t_pDatabaseRecord.cardnumber=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
					t_pDatabaseRecord.cardname=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
					
					if((char *)sqlite3_column_text(stmt, 3)!=NULL)
                        t_pDatabaseRecord.address1=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
					if((char *)sqlite3_column_text(stmt, 4)!=NULL)
						t_pDatabaseRecord.address2=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 4)];
					
					if((char *)sqlite3_column_text(stmt, 5)!=NULL)
                        t_pDatabaseRecord.address3=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 5)];
					if((char *)sqlite3_column_text(stmt, 6)!=NULL)
						t_pDatabaseRecord.city=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 6)];
					if((char *)sqlite3_column_text(stmt, 7)!=NULL)
						t_pDatabaseRecord.postcode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 7)];
					if((char *)sqlite3_column_text(stmt, 8)!=NULL)
						t_pDatabaseRecord.phone1=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 8)];
					if((char *)sqlite3_column_text(stmt, 9)!=NULL)
						t_pDatabaseRecord.fax1=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 9)];
					if((char *)sqlite3_column_text(stmt, 10)!=NULL)
						t_pDatabaseRecord.email1=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 10)];
                    
                    t_pDatabaseRecord.issuerName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 11)];
					if((char *)sqlite3_column_text(stmt, 12)!=NULL)
						t_pDatabaseRecord.startdate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 12)];
					if((char *)sqlite3_column_text(stmt, 13)!=NULL)
						t_pDatabaseRecord.expiryDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 13)];
					if((char *)sqlite3_column_text(stmt, 14)!=NULL)
						t_pDatabaseRecord.cardissuenumber=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 14)];
                    
                    
					
					if((char *)sqlite3_column_text(stmt, 16)!=NULL)
						t_pDatabaseRecord.cardBalance=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 16)];
                    
					if((char *)sqlite3_column_text(stmt, 18)!=NULL)
						t_pDatabaseRecord.cardStatus=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 18)];
					if((char *)sqlite3_column_text(stmt, 19)!=NULL)
						t_pDatabaseRecord.imageName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 19)];
					if((char *)sqlite3_column_text(stmt, 20)!=NULL)
						t_pDatabaseRecord.fundtransferallowed=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 20)];
					t_pDatabaseRecord.cardholdername=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 21)];
					if((char *)sqlite3_column_text(stmt, 22)!=NULL)
						t_pDatabaseRecord.country=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 22)];
					
					
					
					[dataarray addObject:t_pDatabaseRecord];
					
					
					
				}
				
			}
		}
		sqlite3_finalize(stmt);
		[DataBase CloseDataBase];
		return dataarray;
	}
	else {
		NSLog(@"Can not open Data Base");
		return nil;
	}
	
}


/*


+(NSMutableArray *)getTransactionSummaryTableData:(NSString *)query{
	if([DataBase OpenDataBase])
	{	
		NSMutableArray *dataarray=[[NSMutableArray alloc] init];
		sqlite3_stmt *stmt=nil;
		if(stmt==nil){
			const char *sql=[query UTF8String];
			if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) != SQLITE_OK){
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
			}else{
				// Loop through the results and add them to the feeds array
				while(sqlite3_step(stmt) == SQLITE_ROW) {
					// Read the data from the result row
					TransactionSummaryData *t_pDatabaseRecord=[[TransactionSummaryData alloc] init];
					
					
					t_pDatabaseRecord.cardnumber=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
					
					t_pDatabaseRecord.cardholdernmae=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
					
					t_pDatabaseRecord.debittransactioncount=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
					t_pDatabaseRecord.debittransactionvalue=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
					t_pDatabaseRecord.credittransactioncount=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 4)];
					t_pDatabaseRecord.credittransactionvalue=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 5)];
					//Update by sarvesh
					//t_pDatabaseRecord.updatedatetimestamp=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 6)];
					if((char *)sqlite3_column_text(stmt, 6)!=NULL)
					t_pDatabaseRecord.updatedatetimestamp=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 6)];
					
					if((char *)sqlite3_column_text(stmt, 7)!=NULL)
						t_pDatabaseRecord.cardreference=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 7)];
					
                    if((char *)sqlite3_column_text(stmt, 9)!=NULL)
						t_pDatabaseRecord.currencyCode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 9)];
					if((char *)sqlite3_column_text(stmt, 10)!=NULL)
						t_pDatabaseRecord.strStartDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 10)];
                    if((char *)sqlite3_column_text(stmt, 11)!=NULL)
						t_pDatabaseRecord.strEndDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 11)];

                    
                    
					[dataarray addObject:t_pDatabaseRecord];
					[t_pDatabaseRecord release];
				}
			}
		}
		sqlite3_finalize(stmt);
		[DataBase CloseDataBase];
		return dataarray;
	}
	else {
		NSLog(@"Can not open Data Base");
		return nil;
	}
	
}


+(NSMutableArray *)getPromotionTableData:(NSString *)query{
	if([DataBase OpenDataBase])
	{	
		NSMutableArray *dataarray=[[NSMutableArray alloc] init];
		sqlite3_stmt *stmt=nil;
		if(stmt==nil){
			const char *sql=[query UTF8String];
			if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) != SQLITE_OK){
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
			}else{
				// Loop through the results and add them to the feeds array
				while(sqlite3_step(stmt) == SQLITE_ROW) {
					// Read the data from the result row
					PromotionsData *t_pDatabaseRecord=[[PromotionsData alloc] init];
					
					int tempId=sqlite3_column_int(stmt, 0);
					t_pDatabaseRecord.promotionid=[NSString stringWithFormat:@"%d",tempId];
					if((char *)sqlite3_column_text(stmt, 1)!=NULL)
						t_pDatabaseRecord.promotion=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
					if((char *)sqlite3_column_text(stmt, 2)!=NULL)
						t_pDatabaseRecord.startdate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
					if((char *)sqlite3_column_text(stmt, 3)!=NULL)
						t_pDatabaseRecord.enddate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
					if((char *)sqlite3_column_text(stmt, 4)!=NULL)
					t_pDatabaseRecord.merchantname=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 4)];
					if((char *)sqlite3_column_text(stmt, 5)!=NULL)
						t_pDatabaseRecord.storename=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 5)];
					
					if((char *)sqlite3_column_text(stmt, 6)!=NULL)
						t_pDatabaseRecord.updatedatetime=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 6)];
					if((char *)sqlite3_column_text(stmt, 8)!=NULL)
						t_pDatabaseRecord.promotionName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 8)];
					if((char *)sqlite3_column_text(stmt, 9)!=NULL)
						t_pDatabaseRecord.status=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 9)];
					if((char *)sqlite3_column_text(stmt, 10)!=NULL)
						t_pDatabaseRecord.createDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 10)];
					
					if((char *)sqlite3_column_text(stmt, 11)!=NULL)
						t_pDatabaseRecord.createTime=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 11)];
					
/////// Added by Shailesh 23/11/11
					
					if((char *)sqlite3_column_text(stmt, 12)!=NULL)
						t_pDatabaseRecord.address1=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 12)];
					
					if((char *)sqlite3_column_text(stmt, 13)!=NULL)
						t_pDatabaseRecord.address2=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 13)];
					
					if((char *)sqlite3_column_text(stmt, 14)!=NULL)
						t_pDatabaseRecord.city=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 14)];
					
					if((char *)sqlite3_column_text(stmt, 15)!=NULL)
						t_pDatabaseRecord.country=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 15)];
					
					if((char *)sqlite3_column_text(stmt, 16)!=NULL)
						t_pDatabaseRecord.postcode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 16)];
				
					if((char *)sqlite3_column_text(stmt, 17)!=NULL)
						t_pDatabaseRecord.state=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 17)];
				
					if((char *)sqlite3_column_text(stmt, 18)!=NULL)
						t_pDatabaseRecord.latt=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 18)];
					
					if((char *)sqlite3_column_text(stmt, 19)!=NULL)
						t_pDatabaseRecord.longn=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 19)];
                    if((char *)sqlite3_column_text(stmt, 20)!=NULL)
						t_pDatabaseRecord.merchantImageURL=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 20)];
                    
				    [dataarray addObject:t_pDatabaseRecord];
					[t_pDatabaseRecord release];
					
					
				}
				
			}
		}
		sqlite3_finalize(stmt);
		[DataBase CloseDataBase];
		return dataarray;
	}
	else {
		NSLog(@"Can not open Data Base");
		return nil;
	}
	
}


+(NSMutableArray *)getInstantDiscountTableData:(NSString *)query{
	if([DataBase OpenDataBase])
	{	
		NSMutableArray *dataarray=[[NSMutableArray alloc] init];
		sqlite3_stmt *stmt=nil;
		if(stmt==nil){
			const char *sql=[query UTF8String];
			if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) != SQLITE_OK){
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
			}else{
				// Loop through the results and add them to the feeds array
				while(sqlite3_step(stmt) == SQLITE_ROW) {
					// Read the data from the result row
					InstantDiscountData *t_pDatabaseRecord=[[InstantDiscountData alloc] init];
					
					int tempId=sqlite3_column_int(stmt, 0);
					t_pDatabaseRecord.couponid=[NSString stringWithFormat:@"%d",tempId];
					t_pDatabaseRecord.merchantname=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
					if((char *)sqlite3_column_text(stmt, 2)!=NULL)
					t_pDatabaseRecord.storename=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
					if((char *)sqlite3_column_text(stmt, 3)!=NULL)
					t_pDatabaseRecord.city=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
					if((char *)sqlite3_column_text(stmt, 4)!=NULL)
						t_pDatabaseRecord.state=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 4)];
					
					if((char *)sqlite3_column_text(stmt, 5)!=NULL)
					t_pDatabaseRecord.country=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 5)];
					if((char *)sqlite3_column_text(stmt, 6)!=NULL)
						t_pDatabaseRecord.postcode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 6)];
					if((char *)sqlite3_column_text(stmt, 7)!=NULL)
						t_pDatabaseRecord.geolatitude=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 7)];
					if((char *)sqlite3_column_text(stmt, 8)!=NULL)
						t_pDatabaseRecord.geolongitude=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 8)];
					if(sqlite3_column_int(stmt,9)!=0.0)
						t_pDatabaseRecord.discountpercent=[NSString stringWithFormat:@"%.2f",sqlite3_column_double(stmt,9)];
					if(sqlite3_column_int(stmt, 10)!=0)
						t_pDatabaseRecord.discountamount=sqlite3_column_int(stmt,10);
					if(sqlite3_column_int(stmt, 11)!=0)
						t_pDatabaseRecord.minimumspend=sqlite3_column_int(stmt,11);
					
					if((char *)sqlite3_column_text(stmt, 12)!=NULL)
						t_pDatabaseRecord.startdate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 12)];
					if((char *)sqlite3_column_text(stmt, 13)!=NULL)
						t_pDatabaseRecord.enddate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 13)];
					if((char *)sqlite3_column_text(stmt, 14)!=NULL)
						t_pDatabaseRecord.updatetimeinterval=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 14)];
					if((char *)sqlite3_column_text(stmt, 16)!=NULL)
						t_pDatabaseRecord.discountCouponName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 16)];
					if((char *)sqlite3_column_text(stmt, 17)!=NULL)
						t_pDatabaseRecord.discountPromotionMessage=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 17)];
					if(sqlite3_column_int(stmt, 18)!=0)
						t_pDatabaseRecord.minimumTransactionCount=[NSString stringWithFormat:@"%d",sqlite3_column_int(stmt,18)];
					if((char *)sqlite3_column_text(stmt, 19)!=NULL)
						t_pDatabaseRecord.status=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 19)];
					if((char *)sqlite3_column_text(stmt, 20)!=NULL)
						t_pDatabaseRecord.createDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 20)];
					if((char *)sqlite3_column_text(stmt, 21)!=NULL)
						t_pDatabaseRecord.createTime=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 21)];
					if((char *)sqlite3_column_text(stmt, 22)!=NULL)
						t_pDatabaseRecord.merchantImageURL=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 22)];
					
					[dataarray addObject:t_pDatabaseRecord];
					[t_pDatabaseRecord release];
					
					
				}
				
			}
		}
		sqlite3_finalize(stmt);
		[DataBase CloseDataBase];
		return dataarray;
	}
	else {
		NSLog(@"Can not open Data Base");
		return nil;
	}
	
}


+(NSMutableArray *)getDiscountCouponsTableData:(NSString *)query{
	if([DataBase OpenDataBase])
	{	
		NSMutableArray *dataarray=[[NSMutableArray alloc] init];
		sqlite3_stmt *stmt=nil;
		if(stmt==nil){
			const char *sql=[query UTF8String];
			if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) != SQLITE_OK){
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
			}else{
				// Loop through the results and add them to the feeds array
				while(sqlite3_step(stmt) == SQLITE_ROW) {
					// Read the data from the result row
					DiscountCouponsData *t_pDatabaseRecord=[[DiscountCouponsData alloc] init];
					
					int tempId=sqlite3_column_int(stmt, 0);
					t_pDatabaseRecord.couponid=[NSString stringWithFormat:@"%d",tempId];
					t_pDatabaseRecord.merchantname=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
					if((char *)sqlite3_column_text(stmt, 2)!=NULL)
						t_pDatabaseRecord.storename=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
					if((char *)sqlite3_column_text(stmt, 3)!=NULL)
						t_pDatabaseRecord.city=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
					if((char *)sqlite3_column_text(stmt, 4)!=NULL)
						t_pDatabaseRecord.state=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 4)];
					
					if((char *)sqlite3_column_text(stmt, 5)!=NULL)
						t_pDatabaseRecord.country=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 5)];
					if((char *)sqlite3_column_text(stmt, 6)!=NULL)
						t_pDatabaseRecord.postcode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 6)];
					if((char *)sqlite3_column_text(stmt, 7)!=NULL)
						t_pDatabaseRecord.geolatitude=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 7)];
					if((char *)sqlite3_column_text(stmt, 8)!=NULL)
						t_pDatabaseRecord.geolongitude=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 8)];
					if(sqlite3_column_int(stmt,9)!=0.0)
						t_pDatabaseRecord.discountpercent=[NSString stringWithFormat:@"%.2f",sqlite3_column_double(stmt,9)];
					if(sqlite3_column_int(stmt, 10)!=0)
						t_pDatabaseRecord.discountamount=sqlite3_column_int(stmt,10);
					if(sqlite3_column_int(stmt, 11)!=0)
					t_pDatabaseRecord.minimumspend=sqlite3_column_int(stmt,11);
					
					if((char *)sqlite3_column_text(stmt, 12)!=NULL)
						t_pDatabaseRecord.startdate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 12)];
					if((char *)sqlite3_column_text(stmt, 13)!=NULL)
						t_pDatabaseRecord.enddate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 13)];
					if((char *)sqlite3_column_text(stmt, 14)!=NULL)
						t_pDatabaseRecord.updatetimeinterval=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 14)];
					if((char *)sqlite3_column_text(stmt, 16)!=NULL)
						t_pDatabaseRecord.discountCouponName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 16)];
					if((char *)sqlite3_column_text(stmt, 17)!=NULL)
						t_pDatabaseRecord.discountPromotionMessage=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 17)];
					if(sqlite3_column_int(stmt, 18)!=0)
						t_pDatabaseRecord.minimumTransactionCount=[NSString stringWithFormat:@"%d",sqlite3_column_int(stmt,18)];
					if((char *)sqlite3_column_text(stmt, 19)!=NULL)
						t_pDatabaseRecord.status=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 19)];
					if((char *)sqlite3_column_text(stmt, 20)!=NULL)
						t_pDatabaseRecord.createDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 20)];
					if((char *)sqlite3_column_text(stmt, 21)!=NULL)
						t_pDatabaseRecord.createTime=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 21)];
                    
                    
					if((char *)sqlite3_column_text(stmt, 22)!=NULL)
						t_pDatabaseRecord.address1=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 22)];
					

					if((char *)sqlite3_column_text(stmt, 23)!=NULL)
						t_pDatabaseRecord.address2=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 23)];
					

					if((char *)sqlite3_column_text(stmt, 24)!=NULL)
						t_pDatabaseRecord.cardnumber=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 24)];
					
					if(sqlite3_column_int(stmt, 10)!=0)
						t_pDatabaseRecord.discountCoupanID=sqlite3_column_int(stmt,25);

					if((char *)sqlite3_column_text(stmt, 26)!=NULL)
						t_pDatabaseRecord.period=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 26)];
					
					if((char *)sqlite3_column_text(stmt, 27)!=NULL)
						t_pDatabaseRecord.tokenReference=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 27)];
					if((char *)sqlite3_column_text(stmt, 28)!=NULL)
						t_pDatabaseRecord.merchantImageURL=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 28)];
					
                    
					[dataarray addObject:t_pDatabaseRecord];
					[t_pDatabaseRecord release];
					
					
				}
				
			}
		}
		sqlite3_finalize(stmt);
		[DataBase CloseDataBase];
		return dataarray;
	}
	else {
		NSLog(@"Can not open Data Base");
		return nil;
	}
	
}


+(NSMutableArray *)getTransactionTableData:(NSString *)query{
	if([DataBase OpenDataBase])
	{	
		NSMutableArray *dataarray=[[NSMutableArray alloc] init];
		sqlite3_stmt *stmt=nil;
		if(stmt==nil){
			const char *sql=[query UTF8String];
			if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) != SQLITE_OK){
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
			}else{
				// Loop through the results and add them to the feeds array
				while(sqlite3_step(stmt) == SQLITE_ROW) {
					// Read the data from the result row
					TransactionData *t_pDatabaseRecord=[[TransactionData alloc] init];
					
					int tempId=sqlite3_column_int(stmt, 0);
					t_pDatabaseRecord.transactionnumber=[NSString stringWithFormat:@"%d",tempId];
					if((char *)sqlite3_column_text(stmt, 1)!=NULL)
						t_pDatabaseRecord.transactiontype=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
					if((char *)sqlite3_column_text(stmt, 2)!=NULL)
						t_pDatabaseRecord.transactiondate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
					if(sqlite3_column_int(stmt, 3)!=0)
						t_pDatabaseRecord.totalamount=sqlite3_column_int(stmt, 3);
					if((char *)sqlite3_column_text(stmt, 4)!=NULL)
						t_pDatabaseRecord.cardnumber=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 4)];
					if((char *)sqlite3_column_text(stmt, 5)!=NULL)
						t_pDatabaseRecord.merchantname=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 5)];
					if((char *)sqlite3_column_text(stmt, 6)!=NULL)
						t_pDatabaseRecord.storename=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 6)];
					if((char *)sqlite3_column_text(stmt, 7)!=NULL)
						t_pDatabaseRecord.terminalid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 7)];
					
					
					if((char *)sqlite3_column_text(stmt, 8)!=NULL)
						t_pDatabaseRecord.fcrnumber=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 8)];
					
					if((char *)sqlite3_column_text(stmt, 9)!=NULL)
						t_pDatabaseRecord.processingcode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 9)];
					
					if((char *)sqlite3_column_text(stmt, 10)!=NULL)
						t_pDatabaseRecord.settlementcode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 10)];
					
					if((char *)sqlite3_column_text(stmt, 11)!=NULL)
						t_pDatabaseRecord.transactiondescription=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 11)];
					
					if((char *)sqlite3_column_text(stmt, 12)!=NULL)
						t_pDatabaseRecord.transactionsource=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 12)];
					
					if((char *)sqlite3_column_text(stmt, 13)!=NULL)
						t_pDatabaseRecord.transactiontime=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 13)];
					
					if(sqlite3_column_int(stmt, 14)!=0)
						t_pDatabaseRecord.cashbackamount=sqlite3_column_int(stmt, 14);
				
					if((char *)sqlite3_column_text(stmt, 15)!=NULL)	
						t_pDatabaseRecord.currencycode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 15)];
					
					if((char *)sqlite3_column_text(stmt, 16)!=NULL)
						t_pDatabaseRecord.currencyname=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 16)];
					
					if((char *)sqlite3_column_text(stmt, 17)!=NULL)
						t_pDatabaseRecord.cardissuercode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 17)];
					
					
					if((char *)sqlite3_column_text(stmt, 18)!=NULL)
						t_pDatabaseRecord.cardissuername=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 18)];
					
					
					if((char *)sqlite3_column_text(stmt, 19)!=NULL)
						t_pDatabaseRecord.cardtype=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 19)];
					
					if((char *)sqlite3_column_text(stmt, 20)!=NULL)
						t_pDatabaseRecord.cardisseunumber=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 20)];
					if((char *)sqlite3_column_text(stmt, 21)!=NULL)
						t_pDatabaseRecord.cardexpirydate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 21)];
					
					if((char *)sqlite3_column_text(stmt, 22)!=NULL)
						t_pDatabaseRecord.authorisationcode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 22)];

					if((char *)sqlite3_column_text(stmt, 23)!=NULL)
						t_pDatabaseRecord.authorisationcode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 23)];
					
					
					if(sqlite3_column_int(stmt, 24)!=0)
						t_pDatabaseRecord.remittancecurrency=[NSString stringWithFormat:@"%d",sqlite3_column_int(stmt, 24)];

					if(sqlite3_column_int(stmt, 25)!=0)
						t_pDatabaseRecord.remittancecurrencycode=[NSString stringWithFormat:@"%d",sqlite3_column_int(stmt, 25)];
					
					if((char *)sqlite3_column_text(stmt, 26)!=NULL)
						t_pDatabaseRecord.remittancecurrencyname=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 26)];
					if((char *)sqlite3_column_text(stmt, 27)!=NULL)
						t_pDatabaseRecord.updatetimeinterval=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 27)];
					if((char *)sqlite3_column_text(stmt, 28)!=NULL)
						t_pDatabaseRecord.cardReference=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 28)];
					
                    if((char *)sqlite3_column_text(stmt, 32)!=NULL)
						t_pDatabaseRecord.merchantImageURL=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 32)];

                    
					[dataarray addObject:t_pDatabaseRecord];
					[t_pDatabaseRecord release];
					
					
				}
				
			}
		}
		sqlite3_finalize(stmt);
		[DataBase CloseDataBase];
		return dataarray;
	}
	else {
		NSLog(@"Can not open Data Base");
		return nil;
	}
	
}
 


//
//+(NSMutableArray *)getCardAccountInfoTableData:(NSString *)query{
//	if([DataBase OpenDataBase])
//	{	
//		NSMutableArray *dataarray=[[NSMutableArray alloc] init];
//		sqlite3_stmt *stmt=nil;
//		if(stmt==nil){
//			const char *sql=[query UTF8String];
//			if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) != SQLITE_OK){
//				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
//			}else{
//				// Loop through the results and add them to the feeds array
//				while(sqlite3_step(stmt) == SQLITE_ROW) {
//					// Read the data from the result row
//					Cardaccountinfodata *t_pDatabaseRecord=[[Cardaccountinfodata alloc] init];
//					
//					if(sqlite3_column_int(stmt, 0)!=0)
//					t_pDatabaseRecord.accountnumber=sqlite3_column_int(stmt, 0);
//					
//					if((char *)sqlite3_column_text(stmt, 1)!=NULL)
//						t_pDatabaseRecord.accountstatus=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
//					
//					
//					if(sqlite3_column_int(stmt, 2)!=0)
//						t_pDatabaseRecord.accountbalance=sqlite3_column_int(stmt, 2);
//					
//					if((char *)sqlite3_column_text(stmt, 3)!=NULL)
//						t_pDatabaseRecord.opendate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
//					
//					if(sqlite3_column_int(stmt, 4)!=0)
//						t_pDatabaseRecord.odcreditlimit=sqlite3_column_int(stmt, 4);
//					
//
//						t_pDatabaseRecord.updatedatetimestamp=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 5)];
//					
//					
//					
//					
//					[dataarray addObject:t_pDatabaseRecord];
//					[t_pDatabaseRecord release];
//					
//					
//				}
//				
//			}
//		}
//		sqlite3_finalize(stmt);
//		[DataBase CloseDataBase];
//		return dataarray;
//	}
//	else {
//		NSLog(@"Can not open Data Base");
//		return nil;
//	}
//	
//}

+(NSMutableArray *)getCategoryWiseretailerTableData:(NSString *)query{
	if([DataBase OpenDataBase])
	{	
		NSMutableArray *dataarray=[[NSMutableArray alloc] init];
		sqlite3_stmt *stmt=nil;
		if(stmt==nil){
			const char *sql=[query UTF8String];
			if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) != SQLITE_OK){
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
			}else{
				// Loop through the results and add them to the feeds array
				while(sqlite3_step(stmt) == SQLITE_ROW) {
					// Read the data from the result row
					CategoryWiseretailerData *t_pDatabaseRecord=[[CategoryWiseretailerData alloc] init];
					
					//Add by sarvesh(all if condition to check value is not null)
					
					if((char *)sqlite3_column_text(stmt, 0)!=NULL)
					t_pDatabaseRecord.category=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
					
					if((char *)sqlite3_column_text(stmt, 1)!=NULL)
					t_pDatabaseRecord.merchantname=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
					
					if((char *)sqlite3_column_text(stmt, 2)!=NULL)
						t_pDatabaseRecord.totaldebittransaction=sqlite3_column_int(stmt, 2);
					
					if((char *)sqlite3_column_text(stmt, 3)!=NULL)
						t_pDatabaseRecord.debittransactionamount=sqlite3_column_int(stmt, 3);
					
					if((char *)sqlite3_column_text(stmt, 4)!=NULL)
						t_pDatabaseRecord.totalcredittransaction=sqlite3_column_int(stmt, 4);
					
					if((char *)sqlite3_column_text(stmt, 5)!=NULL)
						t_pDatabaseRecord.credittransactionamount=sqlite3_column_int(stmt, 5);
					
					if((char *)sqlite3_column_text(stmt, 6)!=NULL)
					t_pDatabaseRecord.updatetimestamp=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 6)];
					if((char *)sqlite3_column_text(stmt, 9)!=NULL)
                        t_pDatabaseRecord.merchantImageURL=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 9)];
						
					
					
					
					[dataarray addObject:t_pDatabaseRecord];
					[t_pDatabaseRecord release];
					
					
				}
				
			}
		}
		sqlite3_finalize(stmt);
		[DataBase CloseDataBase];
		return dataarray;
	}
	else {
		NSLog(@"Can not open Data Base");
		return nil;
	}
	
}

+(NSMutableArray *)getRetailerVisitedTableData:(NSString *)query{
	if([DataBase OpenDataBase])
	{	
		NSMutableArray *dataarray=[[NSMutableArray alloc] init];
		sqlite3_stmt *stmt=nil;
		if(stmt==nil){
			const char *sql=[query UTF8String];
			if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) != SQLITE_OK){
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
			}else{
				// Loop through the results and add them to the feeds array
				while(sqlite3_step(stmt) == SQLITE_ROW) {
					// Read the data from the result row
					RetailerVisitedData *t_pDatabaseRecord=[[RetailerVisitedData alloc] init];
					
					t_pDatabaseRecord.merchantname=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
					t_pDatabaseRecord.storename=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
					
					if((char *)sqlite3_column_text(stmt, 2)!=NULL)
						t_pDatabaseRecord.address1=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
					
					if((char *)sqlite3_column_text(stmt, 3)!=NULL)
						t_pDatabaseRecord.address2=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
					
					
					if((char *)sqlite3_column_text(stmt, 4)!=NULL)
						t_pDatabaseRecord.city=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 4)];

					
					
	
					if((char *)sqlite3_column_text(stmt, 5)!=NULL)
						t_pDatabaseRecord.state=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 5)];
					
					if((char *)sqlite3_column_text(stmt, 6)!=NULL)
						t_pDatabaseRecord.country=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 6)];
					
					if((char *)sqlite3_column_text(stmt, 7)!=NULL)
						t_pDatabaseRecord.postcode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 7)];
					
					if((char *)sqlite3_column_text(stmt, 8)!=NULL)
						t_pDatabaseRecord.latitude=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 8)];
					
					if((char *)sqlite3_column_text(stmt, 9)!=NULL)
						t_pDatabaseRecord.longitude=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 9)];
					
					if((char *)sqlite3_column_text(stmt, 10)!=NULL)
						t_pDatabaseRecord.mobileno=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 10)];
					
					if((char *)sqlite3_column_text(stmt, 11)!=NULL)
						t_pDatabaseRecord.email=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 11)];
					
					if((char *)sqlite3_column_text(stmt, 12)!=NULL)
					t_pDatabaseRecord.updatetimestamp=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 12)];
					
					if((char *)sqlite3_column_text(stmt, 14)!=NULL)
                        t_pDatabaseRecord.merchantImageURL=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 14)];
					
					
					[dataarray addObject:t_pDatabaseRecord];
					[t_pDatabaseRecord release];
					
					
				}
				
			}
		}
		sqlite3_finalize(stmt);
		[DataBase CloseDataBase];
		return dataarray;
	}
	else {
		NSLog(@"Can not open Data Base");
		return nil;
	}
	
}

+(NSMutableArray *)getTopretailerTableData:(NSString *)query{
	if([DataBase OpenDataBase])
	{	
		NSMutableArray *dataarray=[[NSMutableArray alloc] init];
		sqlite3_stmt *stmt=nil;
		if(stmt==nil){
			const char *sql=[query UTF8String];
			if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) != SQLITE_OK){
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
			}else{
				// Loop through the results and add them to the feeds array
				while(sqlite3_step(stmt) == SQLITE_ROW) {
					// Read the data from the result row
					TopRetailerdata *t_pDatabaseRecord=[[TopRetailerdata alloc] init];
					
					t_pDatabaseRecord.merchantname=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
					
					if((char *)sqlite3_column_text(stmt, 1)!=NULL)
						t_pDatabaseRecord.storeid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
					
					//update by sarvesh
					//t_pDatabaseRecord.storename=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
					
					if((char *)sqlite3_column_text(stmt, 2)!=NULL)
						t_pDatabaseRecord.storename=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
					
				
					
					if((char *)sqlite3_column_text(stmt, 3)!=NULL)
						t_pDatabaseRecord.city=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
					
					
					if((char *)sqlite3_column_text(stmt, 4)!=NULL)
						t_pDatabaseRecord.state=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 4)];
					
					if((char *)sqlite3_column_text(stmt, 5)!=NULL)
						t_pDatabaseRecord.country=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 5)];
					
					if((char *)sqlite3_column_text(stmt, 6)!=NULL)
						t_pDatabaseRecord.postcode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 6)];
					
					if((char *)sqlite3_column_text(stmt, 7)!=NULL)
						t_pDatabaseRecord.latitude=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 7)];
					
					if((char *)sqlite3_column_text(stmt, 8)!=NULL)
						t_pDatabaseRecord.longitude=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 8)];
					
					
					t_pDatabaseRecord.debittransactioncount=sqlite3_column_int(stmt, 9);
					
					t_pDatabaseRecord.debittransactionvalue=sqlite3_column_int(stmt, 10);
					
					t_pDatabaseRecord.credittransactioncount=sqlite3_column_int(stmt, 11);
					
					t_pDatabaseRecord.credittransactionvalue=sqlite3_column_int(stmt, 12);
					
					
					if((char *)sqlite3_column_text(stmt, 13)!=NULL)
					t_pDatabaseRecord.updatetimestamp=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 13)];
					if((char *)sqlite3_column_text(stmt, 16)!=NULL)
                        t_pDatabaseRecord.merchantImageURL=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 16)];
					
					
					
					[dataarray addObject:t_pDatabaseRecord];
					[t_pDatabaseRecord release];
					
					
				}
				
			}
		}
		sqlite3_finalize(stmt);
		[DataBase CloseDataBase];
		return dataarray;
	}
	else {
		NSLog(@"Can not open Data Base");
		return nil;
	}
	
}


+(NSMutableArray *)getVirtualCardTableData:(NSString *)query{
	if([DataBase OpenDataBase])
	{	
		NSMutableArray *dataarray=[[NSMutableArray alloc] init];
		sqlite3_stmt *stmt=nil;
		if(stmt==nil){
			const char *sql=[query UTF8String];
			if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) != SQLITE_OK){
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
			}else{
				// Loop through the results and add them to the feeds array
				while(sqlite3_step(stmt) == SQLITE_ROW) {
					// Read the data from the result row
					VirtualCardData *t_pDatabaseRecord=[[VirtualCardData alloc] init];
					
					
					if((char *)sqlite3_column_text(stmt, 0)!=NULL)
						t_pDatabaseRecord.cardnumber=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
					
					
					
					
					if(sqlite3_column_int(stmt, 1)!=0)
						t_pDatabaseRecord.balance=sqlite3_column_int(stmt, 1);
					
					if((char *)sqlite3_column_text(stmt, 2)!=NULL)
						t_pDatabaseRecord.cardcurrency=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];

					
					if((char *)sqlite3_column_text(stmt, 3)!=NULL)
						t_pDatabaseRecord.expirydate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
					
					if((char *)sqlite3_column_text(stmt, 4)!=NULL)
						t_pDatabaseRecord.cvv2=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 4)];
					
										
					t_pDatabaseRecord.cardreference=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 5)];
					
					t_pDatabaseRecord.updatedatetimestamp=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 6)];
					
					if((char *)sqlite3_column_text(stmt, 7)!=NULL)
						t_pDatabaseRecord.postcode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 7)];
					if((char *)sqlite3_column_text(stmt, 9)!=NULL)
						t_pDatabaseRecord.cardName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 9)];
					if((char *)sqlite3_column_text(stmt, 10)!=NULL)
						t_pDatabaseRecord.cardStatus=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 10)];

					
					
					
					
					
					
					[dataarray addObject:t_pDatabaseRecord];
					[t_pDatabaseRecord release];
					
					
				}
				
			}
		}
		sqlite3_finalize(stmt);
		[DataBase CloseDataBase];
		return dataarray;
	}
	else {
		NSLog(@"Can not open Data Base");
		return nil;
	}
	
}

//+(NSMutableArray *)getMessageData:(NSString *)query{
//	if([DataBase OpenDataBase])
//	{	
//		NSMutableArray *dataarray=[[NSMutableArray alloc] init];
//		sqlite3_stmt *stmt=nil;
//		if(stmt==nil){
//			const char *sql=[query UTF8String];
//			if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) != SQLITE_OK){
//				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
//			}else{
//				// Loop through the results and add them to the feeds array
//				while(sqlite3_step(stmt) == SQLITE_ROW) {
//					// Read the data from the result row
//					Messagedata *t_pDatabaseRecord=[[Messagedata alloc] init];
//					
//					if((char *)sqlite3_column_text(stmt, 0)!=NULL)
//						t_pDatabaseRecord.message=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
//					
//					if((char *)sqlite3_column_text(stmt, 1)!=NULL)
//						t_pDatabaseRecord.messageDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
//					
//					if((char *)sqlite3_column_text(stmt, 2)!=NULL)
//						t_pDatabaseRecord.messageTime=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
//					
//					if((char *)sqlite3_column_text(stmt, 3)!=NULL)
//						t_pDatabaseRecord.updateTimeStamp=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
//					
//					
//					
//					
//					
//					[dataarray addObject:t_pDatabaseRecord];
//					[t_pDatabaseRecord release];
//					
//					
//				}
//				
//			}
//		}
//		sqlite3_finalize(stmt);
//		[DataBase CloseDataBase];
//		return dataarray;
//	}
//	else {
//		NSLog(@"Can not open Data Base");
//		return nil;
//	}
//	
//}


+(NSMutableArray *)getWalletAlertsData:(NSString *)query
{
	if([DataBase OpenDataBase])
	{	
		NSMutableArray *dataarray=[[NSMutableArray alloc] init];
		sqlite3_stmt *stmt=nil;
		if(stmt==nil){
			const char *sql=[query UTF8String];
			if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) != SQLITE_OK){
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
			}else{
				// Loop through the results and add them to the feeds array
				while(sqlite3_step(stmt) == SQLITE_ROW) {
					// Read the data from the result row
					WalletAlertsData *t_pDatabaseRecord=[[WalletAlertsData alloc] init];
					
					if((char *)sqlite3_column_text(stmt, 0)!=NULL)
						t_pDatabaseRecord.message=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
					if((char *)sqlite3_column_text(stmt, 1)!=NULL)
						t_pDatabaseRecord.updateDateTimeStamp=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
					
					
					
					[dataarray addObject:t_pDatabaseRecord];
					[t_pDatabaseRecord release];
					
					
				}
				
			}
		}
		sqlite3_finalize(stmt);
		[DataBase CloseDataBase];
		return dataarray;
	}
	else {
		NSLog(@"Can not open Data Base");
		return nil;
	}
	
}

+(NSMutableArray *)getDeliveryAddressData:(NSString *)query
{
	if([DataBase OpenDataBase])
	{	
		NSMutableArray *dataarray=[[NSMutableArray alloc] init];
		sqlite3_stmt *stmt=nil;
		if(stmt==nil){
			const char *sql=[query UTF8String];
			if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) != SQLITE_OK){
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
			}else{
				// Loop through the results and add them to the feeds array
				while(sqlite3_step(stmt) == SQLITE_ROW) {
					// Read the data from the result row
					DeliveryAddressData *t_pDatabaseRecord=[[DeliveryAddressData alloc] init];
					
					if((char *)sqlite3_column_text(stmt, 0)!=NULL)
						t_pDatabaseRecord.address1=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
					if((char *)sqlite3_column_text(stmt, 1)!=NULL)
						t_pDatabaseRecord.address2=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
					if((char *)sqlite3_column_text(stmt, 2)!=NULL)
						t_pDatabaseRecord.city=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
					if((char *)sqlite3_column_text(stmt, 3)!=NULL)
						t_pDatabaseRecord.region=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
					if((char *)sqlite3_column_text(stmt, 4)!=NULL)
						t_pDatabaseRecord.country=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 4)];
					if((char *)sqlite3_column_text(stmt, 5)!=NULL)
						t_pDatabaseRecord.postcode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 5)];
					if((char *)sqlite3_column_text(stmt, 6)!=NULL)
						t_pDatabaseRecord.mobile=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 6)];
					if((char *)sqlite3_column_text(stmt, 7)!=NULL)
						t_pDatabaseRecord.email=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 7)];
					
					
					
					[dataarray addObject:t_pDatabaseRecord];
					[t_pDatabaseRecord release];
					
					
				}
				
			}
		}
		sqlite3_finalize(stmt);
		[DataBase CloseDataBase];
		return dataarray;
	}
	else {
		NSLog(@"Can not open Data Base");
		return nil;
	}
	
}


+(NSMutableArray *)getContactUsData:(NSString *)query
{
	if([DataBase OpenDataBase])
	{	
		NSMutableArray *dataarray=[[NSMutableArray alloc] init];
		sqlite3_stmt *stmt=nil;
		if(stmt==nil){
			const char *sql=[query UTF8String];
			if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) != SQLITE_OK){
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
			}else{
				// Loop through the results and add them to the feeds array
				while(sqlite3_step(stmt) == SQLITE_ROW) {
					// Read the data from the result row
					contactUsData *t_pDatabaseRecord=[[contactUsData alloc] init];
					
					if((char *)sqlite3_column_text(stmt, 0)!=NULL)
						t_pDatabaseRecord.email1=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
					if((char *)sqlite3_column_text(stmt, 1)!=NULL)
						t_pDatabaseRecord.email2=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
					if((char *)sqlite3_column_text(stmt, 2)!=NULL)
						t_pDatabaseRecord.email3=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
					if((char *)sqlite3_column_text(stmt, 3)!=NULL)
						t_pDatabaseRecord.phone1=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
					if((char *)sqlite3_column_text(stmt, 4)!=NULL)
						t_pDatabaseRecord.phone2=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 4)];
					if((char *)sqlite3_column_text(stmt, 5)!=NULL)
						t_pDatabaseRecord.phone3=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 5)];
					if((char *)sqlite3_column_text(stmt, 6)!=NULL)
						t_pDatabaseRecord.country=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 6)];
					
					
					[dataarray addObject:t_pDatabaseRecord];
					[t_pDatabaseRecord release];
					
					
				}
				
			}
		}
		sqlite3_finalize(stmt);
		[DataBase CloseDataBase];
		return dataarray;
	}
	else {
		NSLog(@"Can not open Data Base");
		return nil;
	}
	
}*/

@end
