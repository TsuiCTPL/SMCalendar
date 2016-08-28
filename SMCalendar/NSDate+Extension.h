//
//  NSDate+Extension.h
//  日历
//
//  Created by Tsui on 16/7/22.
//  Copyright © 2016年 net.evecom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 *  计算日期对应的月份的第一天是周几
 */
- (NSInteger)firstWeekdayInMonth:(NSDate *)date;

/**
 * 计算日期对应的月份有多少天
 */
- (NSInteger)totaldaysInMonth:(NSDate *)date;


/**
 *  返回上个月的今天对应的日期
 */
- (NSDate *)lastMonth:(NSDate *)date;

/**
 *  返回下个月的今天对应的日期
 */
- (NSDate*)nextMonth:(NSDate *)date;

/**
 *  NSDate转NSString
 */
+ (NSString *)stringFromNSDate: (NSDate *)date andDateFormat:(NSString *)format;

/**
 *  返回去年的今天对应的日期
 */
- (NSDate *)lastYear:(NSDate *)date;

/**
 *  返回明年的今天对应的日期
 */
- (NSDate *)nextYear:(NSDate *)date;


@end
