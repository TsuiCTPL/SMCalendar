//
//  SMCalendarView.h
//  日历
//
//  Created 2005，2016，by EVECOM Technology Co.,Ltd.
//  All rights reserved.

/**
 * Description: 日历view
 * @Author:Moris
 * @Date:16/7/22.
 */

#import <UIKit/UIKit.h>

@interface SMCalendarView : UIView

+ (instancetype)calendarViewWithSize: (CGSize)size;

/** 显示下一月日历 */
- (void)nextMonth;

/** 显示上个月日历 */
- (void)lastMonth;

/** 显示明年今天的日历 */
- (void)nextYear;

/** 显示去年今天的日历 */
- (void)lastYear;

@end
