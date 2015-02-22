//
//  NSDate+Utils.m
//  Affirm
//
//  Created by Zhanserik Kenes on 23.09.14.
//  Copyright (c) 2014 Kenes. All rights reserved.
//

#import "NSDate+Utils.h"

@implementation NSDate (Utils)

- (BOOL) isEqualToDay: (NSDate *) date{

    
    NSDate *fdate = [self copy];
    NSDate *sdate = [date copy];
    
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDateComponents* fcomponents = [calendar components:flags fromDate:fdate];
    fdate = [calendar dateFromComponents:fcomponents];
    
    NSDateComponents* scomponents = [calendar components:flags fromDate:sdate];
    sdate = [calendar dateFromComponents:scomponents];
    
    return [fdate isEqualToDate:sdate];
}


- (BOOL) isToday{
    return [self isEqualToDay:[NSDate date]];
}
@end
