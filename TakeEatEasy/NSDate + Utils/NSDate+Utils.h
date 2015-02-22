//
//  NSDate+Utils.h
//  Affirm
//
//  Created by Zhanserik Kenes on 23.09.14.
//  Copyright (c) 2014 Kenes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utils)

- (BOOL) isToday;
- (BOOL) isEqualToDay: (NSDate *) date;
@end
