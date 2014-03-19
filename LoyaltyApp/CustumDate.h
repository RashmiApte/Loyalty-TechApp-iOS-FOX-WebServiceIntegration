//
//  CustumDate.h
//  TestPicker
//
//  Created by ankit on 12/17/13.
//  Copyright (c) 2013 ankit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustumDate : NSObject
@property(strong,nonatomic)NSArray *montharray;
@property(strong,nonatomic)NSArray *yeararray;
@property(strong,nonatomic)NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSIndexPath *todayIndexPath;
-(void)createmonthyear;

@end
