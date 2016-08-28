# SMCalendar

> 日历view

## 效果图
![SMCalendar](/image/screenshot.png)

## 使用方法
> 通过类方法创建日历，添加到控制器view即可。可以自定义控制size

```
CGRect frame = CGRectMake(10, 150, [UIScreen mainScreen].bounds.size.width - 2 * 10, [UIScreen mainScreen].bounds.size.width - 2 * 10 +50);
SMCalendarView *calendarView = [SMCalendarView calendarViewWithSize:frame.size];
calendarView.frame = frame;
[self.view addSubview: calendarView];
```

## 提供接口
> 能够动态查看任何一个月的日历

```
/** 显示下一月日历 */
- (void)nextMonth;

/** 显示上个月日历 */
- (void)lastMonth;

/** 显示明年今天的日历 */
- (void)nextYear;

/** 显示去年今天的日历 */
- (void)lastYear;
```
