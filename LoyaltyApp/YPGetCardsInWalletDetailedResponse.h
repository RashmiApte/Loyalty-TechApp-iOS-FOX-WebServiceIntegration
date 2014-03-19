/*
	YPGetCardsInWalletDetailedResponse.h
	The interface definition of properties and methods for the YPGetCardsInWalletDetailedResponse object.
	Generated by SudzC.com
*/

#import <Foundation/Foundation.h>

//@class YPCardDetailedList;

@interface YPGetCardsInWalletDetailedResponse : NSObject
{
	NSMutableArray* _cardDetailedList;
	NSString* _responseMessage;
	int _statusCode;
	NSString* _updateDatetimestamp;
	BOOL _valid;
	
}
		
	@property (strong, nonatomic) NSMutableArray* cardDetailedList;
	@property (strong, nonatomic) NSString* responseMessage;
	@property int statusCode;
	@property (strong, nonatomic) NSString* updateDatetimestamp;
	@property BOOL valid;

-(void)parsingGetCards:(NSDictionary*)dictResponse;


@end
