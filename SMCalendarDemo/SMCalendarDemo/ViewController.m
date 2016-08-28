//
//  ViewController.m
//  SMCalendarDemo
//
//  Created by Tsui on 16/8/28.
//  Copyright © 2016年 net.evecom. All rights reserved.
//

#import "ViewController.h"
#import "SMCalendarView.h"

@interface ViewController ()

@property (nonatomic, weak)  SMCalendarView *calendarView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = CGRectMake(10, 150, [UIScreen mainScreen].bounds.size.width - 2 * 10, [UIScreen mainScreen].bounds.size.width - 2 * 10 +50);
    SMCalendarView *calendarView = [SMCalendarView calendarViewWithSize:frame.size];
    calendarView.frame = frame;
    [self.view addSubview: calendarView];
    self.calendarView = calendarView;
    
}

- (IBAction)nextMonth:(id)sender {
    
    [self.calendarView nextMonth];
}

- (IBAction)lastMonth:(id)sender {
    
    [self.calendarView lastMonth];
}

- (IBAction)lastYear:(id)sender {
    [self.calendarView lastYear];
}

- (IBAction)nextYear:(id)sender {
    [self.calendarView nextYear];
}

@end
