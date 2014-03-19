//
//  CustumDate.m
//  TestPicker
//
//  Created by ankit on 12/17/13.
//  Copyright (c) 2013 ankit. All rights reserved.
//

#import "CustumDate.h"

@implementation CustumDate
NSInteger minYear = 2000;
NSInteger maxYear = 5000;
const NSInteger bigRowCount = 1;
@synthesize montharray,yeararray;
@synthesize dateFormatter;
@synthesize todayIndexPath;


-(void)createmonthyear
{
    self.montharray = [self nameOfMonths];
    self.yeararray = [self nameOfYears];
}
#pragma mark -othe methode
-(NSArray *)nameOfMonths
{
    NSDateFormatter *dateFormatter1 = [NSDateFormatter new];
    return [dateFormatter1 standaloneMonthSymbols];
}
-(NSArray *)nameOfYears
{
    NSMutableArray *years = [NSMutableArray array];
    
    for(NSInteger year = minYear; year <= maxYear; year++)
    {
        NSString *yearStr = [NSString stringWithFormat:@"%li", (long)year];
        [years addObject:yearStr];
    }
    return years;
}



@end
