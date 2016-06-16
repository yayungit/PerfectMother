//
//  HYYCalendar.m
//  Calendar
//
//  Created by 何亚运 on 16/1/27.
//  Copyright © 2016年 YaYunHe. All rights reserved.
//
//#define kWidth [UIScreen mainScreen].bounds.size.width
#define cellWidth self.frame.size.width/7


#import "HYYCalendar.h"
//#import "HYYCalendarCollectionView.h"


@interface HYYCalendar ()<UIScrollViewDelegate>
@property (nonatomic, assign) BOOL yesOrNo;
@property (nonatomic, strong) NSDate *date; // 接收外界传来的日期,在下面用
@property (nonatomic, strong) UIView *titleView; // 最上层红色view
 @property (nonatomic, strong) UIButton *titleButton; // 显示年月的button
@property (nonatomic, strong) UIDatePicker *datePicker; // 选取日期
@property (nonatomic, strong) UIView *datePickerHeaderView; //放确定和取消按钮的view
@property (nonatomic, strong) UIView *backView; // 背景view
@property (nonatomic, strong) UIDatePicker *picker; // 用来接收选取的日期
@property (nonatomic, strong) HYYCalendarCollectionView *centerCollectionV;
@end

@implementation HYYCalendar
- (instancetype)initWithCurrentDate:(NSDate *)currentDate andFrame:(CGRect)frame andDelegate:(id<calendarDisappearDelegate>)delegate{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor cloudsColor];
        self.yesOrNo = YES;
        self.picker = [[UIDatePicker alloc] init];
        self.picker.date = [NSDate date]; // 给一个初始值
        self.date = currentDate;
        self.frame = frame;
        [self createDatePicker];
        [self createTitleView];
        self.centerCollectionV = [[HYYCalendarCollectionView alloc] initWithFrame:CGRectMake(0, self.titleView.frame.origin.y+self.titleView.bounds.size.height, self.frame.size.width, cellWidth*6)];
        self.centerCollectionV.delegate = delegate;
        [self addSubview:self.centerCollectionV];
        [self createWeekView];
        [self setCurrentDate:self.date];
        
    }

    return self;
}

// 创建titleView
- (void)createTitleView {
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    self.titleView.backgroundColor = [UIColor qianweise];
    [self addSubview:self.titleView];
    // 中间button
    self.titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.titleButton.frame = CGRectMake(kWidth/4, 5, kWidth/2, 30);
    [self.titleView addSubview:self.titleButton];
    // 进来给titlebutton 一个当前日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString *str = [formatter stringFromDate:self.picker.date];
    [self.titleButton setTitle:str forState:UIControlStateNormal];
    self.titleButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleButton addTarget:self action:@selector(showDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.frame = CGRectMake(10, 0, 40, 40);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"icon_previous@2x.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(previousMonth:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:leftButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.frame = CGRectMake(self.titleView.frame.size.width-50, 0, 40, 40);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"icon_next@2x.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(nextMonth:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:rightButton];
    
    UISwipeGestureRecognizer *leftGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(last:)];
    leftGR.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:leftGR];
    
    UISwipeGestureRecognizer *rightGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(next:)];
    rightGR.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:rightGR];

    
    
    
}
// 创建datePickerV
- (void)createDatePicker {
    // 背景view
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(self.titleView.frame.origin.x, self.titleView.frame.origin.y+40, self.frame.size.width, 400)];
    self.backView.backgroundColor = [UIColor whiteColor];
    
    // 存放 确定和取消Button的headerView
    self.datePickerHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.backView.frame.size.width, 40)];
    [self.backView addSubview:self.datePickerHeaderView];
    
    // 取消button
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.frame = CGRectMake(15, 5, 60, 30);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//    cancelButton.titleLabel.textColor = [UIColor redColor];
    [self.datePickerHeaderView addSubview:cancelButton];
        [cancelButton addTarget:self action:@selector(removeDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    // 确定button
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
    confirmButton.frame = cancelButton.frame;
    CGRect frame = cancelButton.frame;
    frame.origin.x = self.frame.size.width-75;
    confirmButton.frame = frame;
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.datePickerHeaderView addSubview:confirmButton];
    [confirmButton addTarget:self action:@selector(confirmButton:) forControlEvents:UIControlEventTouchUpInside];
    
    // 创建datePicker
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(30, cancelButton.frame.origin.y+40, self.frame.size.width-60, 200)];
    self.datePicker.backgroundColor = [UIColor cloudsColor];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"Chinese"];
    [self.backView addSubview:self.datePicker];
    [self.datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    self.backView.backgroundColor = [UIColor cloudsColor];
}

// 展示datePicker   title中间button
- (void)showDatePicker:(UIButton *)centerB {
    if (self.yesOrNo == YES) {
        [self addSubview:self.backView];
        self.yesOrNo = NO;
    }else {
        [self.backView removeFromSuperview];
        self.yesOrNo = YES;
    }
}

//  移除datePicker   取消button
- (void)removeDatePicker:(UIButton *)cancelButton {
    [self.backView removeFromSuperview];
    self.yesOrNo = YES;
}

// 移除datePicker   确定button
- (void)confirmButton:(UIButton *)confirmButton {
    [self.backView removeFromSuperview];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString *str = [formatter stringFromDate:self.picker.date];
    [self.titleButton setTitle:str forState:UIControlStateNormal];
    [self setCurrentDate:self.picker.date];
    self.yesOrNo = YES;
}

// 选择日期  datePicker
- (void)changeDate:(UIDatePicker *)datePicker {
    self.picker = datePicker;
}

//  创建weekView
- (void)createWeekView {
    UIView *weekV = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleView.frame.origin.y+self.titleView.frame.size.height, self.frame.size.width, 40)];
    NSArray *arr = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    for (int i = 0 ; i < 7; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0+i*self.frame.size.width/7, 0, self.frame.size.width/7, 40)];
        label.text = arr[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        if (i == 0 || i == 6) {
            label.textColor = [UIColor redColor];
        }
        [weekV addSubview:label];
    }
    [self addSubview:weekV];
}

//  左button
- (void)previousMonth:(UIButton *)button {
     [self setCurrentDate:[self.centerCollectionV previousMonthDate]];
}
- (void)nextMonth:(UIButton *)button {
    [self setCurrentDate:[self.centerCollectionV nextMonthDate]];
}

- (void)last:(UISwipeGestureRecognizer *)gr{
    [self setCurrentDate:[self.centerCollectionV previousMonthDate]];
}

- (void)next:(UISwipeGestureRecognizer *)gr{
    [self setCurrentDate:[self.centerCollectionV nextMonthDate]];
}

// 设置当前日期
- (void)setCurrentDate:(NSDate *)date {
    self.centerCollectionV.date = date;
    [self.titleButton setTitle:[self stringFromDate:date] forState:UIControlStateNormal];
}

// 日期转字符串
- (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString *str = [formatter stringFromDate:date];
    return str;
}









@end
