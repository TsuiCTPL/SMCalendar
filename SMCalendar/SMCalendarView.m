//
//  SMCalendarView.m
//  日历
//
//  Created 2005，2016，by EVECOM Technology Co.,Ltd.
//  All rights reserved.

/**
 * Description: 日历view
 * @Author:Moris
 * @Date:16/7/22.
 */

#import "SMCalendarView.h"
#import "NSDate+Extension.h"

/** 所有控件统一宽度 */
#define SMAllWidth self.size.width / 7
/** weekBar高度 */
#define SMTopLabelHeight 40
/** 日期高度 */
#define SMTopTimeHeight 40
/** RGB定义颜色 */
#define SMRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0];

@interface SMCalendarView()

/** 记录周一到周日 */
@property (nonatomic, strong) NSArray *weekdays;

/** 整块日历Frame */
@property (nonatomic, assign) CGSize size;

/** 记录下个月的今天日期 */
@property (nonatomic, strong) NSDate *nextMonthDate;

/** 记录上个月的今天日期 */
@property (nonatomic, strong) NSDate *lastMonthDate;

/** 记录今天日期 */
@property (nonatomic, strong) NSDate *currentDate;

/** 记录明年的今天日期 */
@property (nonatomic, strong) NSDate *nextYearDate;

/** 记录去年的今天日期  */
@property (nonatomic, strong) NSDate *lastYearDate;

@end


@implementation SMCalendarView

-(NSArray *)weekdays
{
    if (_weekdays == nil) {
        _weekdays = @[@"一", @"二", @"三", @"四", @"五", @"六", @"日"];
    }
    return _weekdays;
}

+(instancetype)calendarViewWithSize:(CGSize)size
{
    SMCalendarView *calendarView = [[SMCalendarView alloc] init];
    calendarView.backgroundColor = [UIColor whiteColor];
    calendarView.size = size;
    
    // 初始化星期bar
    [calendarView initWeekBar];
    NSDate *today = [NSDate date];
    // 初始化其他时间
    [calendarView initOtherTime:today];
    // 初始化日历view
    [calendarView initDayView:today];
    // 初始化当前时间标签
    [calendarView initTopTime];
    
    return calendarView;
}

- (void)initOtherTime: (NSDate *)today
{
    self.currentDate = today;
    self.nextMonthDate = [today nextMonth:today];
    self.lastMonthDate = [today lastMonth:today];
    self.nextYearDate = [today nextYear:today];
    self.lastYearDate = [today lastYear:today];
}

/**
 *  初始化当前时间标签
 */
- (void)initTopTime
{
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.backgroundColor = SMRGBColor(42, 186, 205);
    timeLabel.frame = CGRectMake(0, 0, self.size.width, SMTopTimeHeight);
    // @"yyyy-MM-dd HH:mm:ss"
    timeLabel.text = [NSDate stringFromNSDate:self.currentDate andDateFormat:@"yyyy-MM"];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textColor = [UIColor whiteColor];
    [self addSubview:timeLabel];

}

/**
 *  初始化星期bar
 */
- (void)initWeekBar
{
    for (int i=0; i<7; i++) {
        CGRect frame = CGRectMake(i * SMAllWidth, SMTopTimeHeight, SMAllWidth, SMTopLabelHeight);
        UIColor *color = SMRGBColor(42, 186, 205);
        [self initdayLabelWithTitle:self.weekdays[i] frame:frame font:[UIFont systemFontOfSize:14] color:color];
    }
}


/**
 *  初始化日历viewl
 *
 *  @param date 需要被计算的日期
 */
- (void)initDayView:(NSDate *)date
{
    
    NSInteger firstDay = [date firstWeekdayInMonth:date];
    NSInteger dayCount = [date totaldaysInMonth:date];
    
    // 第一行
    CGFloat dayWidth = SMAllWidth;
    CGFloat dayHeight = dayWidth;
    NSInteger leftCount = 7 - firstDay + 1;
    
    // 特殊处理：出现第一行大于7天的情况，强行添加label
    if (leftCount == 8) {
        UIColor *color = SMRGBColor(92, 92, 92);
        [self initdayLabelWithTitle:@"1" frame:CGRectMake(6 * SMAllWidth, SMTopLabelHeight + SMTopTimeHeight, dayWidth, dayHeight) font:[UIFont systemFontOfSize:15] color:color];
    }
    
    for (NSInteger i=0; i<leftCount; i++) {
        CGFloat dayY;
        if (leftCount == 8) {  // 如果第一行大于7天，那么真正的第一行高度 要加上第一天的高度
            dayY = SMTopLabelHeight + SMTopTimeHeight + dayHeight;
        }else{
            dayY = SMTopLabelHeight + SMTopTimeHeight;
        }
        CGFloat dayX = (i + firstDay - 1) * dayWidth;
        NSString *title = [NSString stringWithFormat:@"%zd", i+1];
        UIColor *color = SMRGBColor(92, 92, 92);
        [self initdayLabelWithTitle:title frame:CGRectMake(dayX, dayY, dayWidth, dayHeight)font:[UIFont systemFontOfSize:15] color:color];
    }
    
    // 第一行之后
    for (NSInteger i=leftCount; i<dayCount; i++) {
        NSInteger row = (i - leftCount) / 7;
        NSInteger col = (i - leftCount) % 7;
        CGFloat dayX = col * SMAllWidth;
        CGFloat dayY;
        if (leftCount == 8) {  // 和上述的一样
            dayY = (row + 1) * SMAllWidth + SMTopLabelHeight + SMTopTimeHeight + dayHeight;
        }else{
            dayY = (row + 1) * SMAllWidth + SMTopLabelHeight + SMTopTimeHeight;
        }
        NSString *title = [NSString stringWithFormat:@"%zd", i+1];
        UIColor *color = SMRGBColor(92, 92, 92);
        [self initdayLabelWithTitle:title frame:CGRectMake(dayX, dayY, dayWidth, dayHeight)font:[UIFont systemFontOfSize:15] color:color];
    }
    
}

/**
 *  创建单天的label
 */
- (void)initdayLabelWithTitle: (NSString *)title frame:(CGRect)frame font:(UIFont *)font color:(UIColor *)color
{
    NSDate *currentDate = [NSDate date];
    NSString *dayStr = [NSDate stringFromNSDate:currentDate andDateFormat:@"dd"];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = color;
    label.font = font;
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = frame;
    if ([title isEqualToString:dayStr]) {
        label.textColor = SMRGBColor(54, 129, 233);
    }
    [self addSubview:label];
}


- (void)nextMonth
{
    [self removeAllViewFromSuperView];
    
    [self initWeekBar];
    [self initDayView:self.nextMonthDate];
    
    // 更新所有日期
    self.lastMonthDate = self.currentDate;
    self.currentDate = self.nextMonthDate;
    self.nextMonthDate = [self.nextMonthDate nextMonth:self.currentDate];
    self.lastYearDate = [self.lastYearDate lastYear:self.currentDate];
    self.nextYearDate = [self.nextYearDate nextYear:self.currentDate];
    
    [self initTopTime];
}

- (void)lastMonth
{
    [self removeAllViewFromSuperView];
    
    [self initWeekBar];
    [self initDayView:self.lastMonthDate];
    
    // 更新所有日期
    self.nextMonthDate = self.currentDate;
    self.currentDate = self.lastMonthDate;
    self.lastMonthDate = [self.lastMonthDate lastMonth:self.currentDate];
    self.lastYearDate = [self.lastYearDate lastYear:self.currentDate];
    self.nextYearDate = [self.nextYearDate nextYear:self.currentDate];
    
    [self initTopTime];
}


- (void)nextYear
{
    [self removeAllViewFromSuperView];
    
    [self initWeekBar];
    [self initDayView:self.nextYearDate];
    
    // 更新所有日期
    self.lastYearDate = self.currentDate;
    self.currentDate = self.nextYearDate;
    self.nextYearDate = [self.nextYearDate nextYear:self.currentDate];
    self.lastMonthDate = [self.lastMonthDate lastYear:self.currentDate];
    self.nextMonthDate = [self.nextMonthDate nextMonth:self.currentDate];
    
    [self initTopTime];
}


- (void)lastYear
{
    [self removeAllViewFromSuperView];
    
    [self initWeekBar];
    [self initDayView:self.lastYearDate];
    
    // 更新所有日期
    self.nextYearDate = self.currentDate;
    self.currentDate = self.lastYearDate;
    self.lastYearDate = [self.lastYearDate lastYear:self.currentDate];
    self.lastMonthDate = [self.lastMonthDate lastYear:self.currentDate];
    self.nextMonthDate = [self.nextMonthDate nextMonth:self.currentDate];
    
    [self initTopTime];
}


- (void)removeAllViewFromSuperView
{
    for (UILabel *label in self.subviews) {
        [label removeFromSuperview];
    }
}


@end
