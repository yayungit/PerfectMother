//
//  HYYCalendarCollectionView.m
//  Calendar
//
//  Created by 何亚运 on 16/1/28.
//  Copyright © 2016年 YaYunHe. All rights reserved.
//

#import "HYYCalendarCollectionView.h"
#import "HYYCalendarCustomCell.h"
#import "DiaryHandle.h"
#import "DiaryModel.h"

@interface HYYCalendarCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *haveTimeArr;
@property (nonatomic, strong) NSMutableArray *diaryArr;
@end
static NSInteger i = 1;
static NSInteger j = 1;
@implementation HYYCalendarCollectionView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.diaryArr = [DiaryHandle selectDiarySqlite]; // 获取所有的日记
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = frame.size.width/64;
        layout.minimumLineSpacing = frame.size.height/49;
        layout.itemSize = CGSizeMake(frame.size.width/8, frame.size.height/7);
        layout.sectionInset = UIEdgeInsetsMake(frame.size.height/49, frame.size.width/64, frame.size.height/49, frame.size.width/64);
        self.collectionV = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        self.collectionV.backgroundColor = [UIColor cloudsColor];
        self.collectionV.delegate = self;
        self.collectionV.dataSource = self;
        [self.collectionV registerClass:[HYYCalendarCustomCell class] forCellWithReuseIdentifier:@"cell"];
        [self addSubview:self.collectionV];
        
    }
    return self;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 42;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HYYCalendarCustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cloudsColor];

    NSInteger firstDayOfMonthIndate = [self whereWeekOfFirstDayOfMonthIndate]; // 第一天星期几
    NSInteger totalDaysOfMonth = [self totalDaysInCurrrentDateMonth:self.date]; // 当前月的总天数
    NSInteger totalDaysOfLastMonth = [self totalDaysInCurrrentDateMonth:[self previousMonthDate]]; // 上个月的总天数
    // 当月
        if (indexPath.item >= firstDayOfMonthIndate && indexPath.item < firstDayOfMonthIndate+totalDaysOfMonth) {
            cell.dayLbale.text = [NSString stringWithFormat:@"%ld",(long)i++];
            cell.dayLbale.textColor = [UIColor blackColor];
            cell.markLabel.backgroundColor = [UIColor cloudsColor];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *dd = [NSDate dateWithTimeIntervalSinceNow:0];
            NSString *string = [formatter stringFromDate:dd];
            
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
            [formatter1 setDateFormat:@"yyyy-MM"];
            NSString *str = @"";
            // 判断如果拼接的当天的日期是一个单位数字，则多拼接一个0
            if ([cell.dayLbale.text intValue] <10) {
                 str = [[formatter1 stringFromDate:self.date] stringByAppendingString:[NSString stringWithFormat:@"-0%@",cell.dayLbale.text]];
            }else {
           str = [[formatter1 stringFromDate:self.date] stringByAppendingString:[NSString stringWithFormat:@"-%@",cell.dayLbale.text]];
            }

            
            if ([string isEqualToString:str] ) {
                cell.dayLbale.textColor = [UIColor redColor];
//                cell.dayLbale.backgroundColor = [UIColor greenColor];
            }
            // 添加日记标记
            NSMutableArray *timeArr = [NSMutableArray array]; // 保存所有创建日记的时间
            for (DiaryModel *model in _diaryArr) {
                if (model) {
                    [timeArr addObject:model.time];
                }
            }
            NSMutableArray *arr = [NSMutableArray array]; // 以字符串的形式用来保存日记的时间的年月日
            for (NSString *timeStr in timeArr) {
                [arr addObject:[[timeStr componentsSeparatedByString:@" "] firstObject]];
            }
            self.haveTimeArr = arr;
            if ([arr containsObject:str]) {
                cell.markLabel.backgroundColor = [UIColor magentaColor];
            }
        }
    // 下月
        if (indexPath.item>=firstDayOfMonthIndate+totalDaysOfMonth) {
             cell.dayLbale.text = [NSString stringWithFormat:@"%ld",(long)j++];
             cell.dayLbale.textColor = [UIColor grayColor];
            cell.markLabel.backgroundColor = [UIColor cloudsColor];
        }
    // 上月
        if (indexPath.item < firstDayOfMonthIndate) {
            cell.dayLbale.text = [NSString stringWithFormat:@"%d",totalDaysOfLastMonth-firstDayOfMonthIndate+indexPath.item+1];
            cell.dayLbale.textColor = [UIColor grayColor];
            cell.markLabel.backgroundColor = [UIColor cloudsColor];
        }
    return cell;
}

// 获取date当前月有多少天
- (NSInteger)totalDaysInCurrrentDateMonth:(NSDate *)date {
    NSRange range = [[NSCalendar currentCalendar]rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

// 获取date当前月的第一天是星期几
- (NSInteger)whereWeekOfFirstDayOfMonthIndate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1]; // 设定每一周从星期几开始，周日的话是一，周一开始传入2；
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.date];
    [components setDay:1]; // 第一天
    NSDate *firstDay = [calendar dateFromComponents:components];
    NSDateComponents *firstComponents = [calendar components:NSCalendarUnitWeekday fromDate:firstDay];
    return firstComponents.weekday-1;
}

//  获取下个月日期
- (NSDate *)nextMonthDate {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    NSDate *nextMonthDate = [[NSCalendar currentCalendar]dateByAddingComponents:components toDate:self.date options:NSCalendarMatchStrictly];
    return nextMonthDate;
}

//  获取上个月日期
- (NSDate *)previousMonthDate {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    NSDate *previousMonthDate = [[NSCalendar currentCalendar]dateByAddingComponents:components toDate:self.date options:NSCalendarMatchStrictly];
    return previousMonthDate;
}

// 重写date的setter方法
- (void)setDate:(NSDate *)date {
    _date = date;
    i = 1;
    j = 1;
    [self.collectionV reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"item::::%ld",indexPath.item);
//    NSLog(@"///////////%ld",[self whereWeekOfFirstDayOfMonthIndate]);
//    NSLog(@"********%ld",indexPath.item-[self whereWeekOfFirstDayOfMonthIndate]+1);
    
    // 点击带标记的cell进入日记
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM"];
    NSString *timeStr = [[formatter1 stringFromDate:self.date] stringByAppendingString:[NSString stringWithFormat:@"-%ld",indexPath.item-[self whereWeekOfFirstDayOfMonthIndate]+1]];;
    // 判断如果拼接的当天的日期是一个单位数字，则多拼接一个0
    if (indexPath.item - [self whereWeekOfFirstDayOfMonthIndate]+1 < 10 && indexPath.item - [self whereWeekOfFirstDayOfMonthIndate]+1 > 0) {
        timeStr = [[formatter1 stringFromDate:self.date] stringByAppendingString:[NSString stringWithFormat:@"-0%ld",indexPath.item-[self whereWeekOfFirstDayOfMonthIndate]+1]];
    }else {
        timeStr = [[formatter1 stringFromDate:self.date] stringByAppendingString:[NSString stringWithFormat:@"-%ld",indexPath.item-[self whereWeekOfFirstDayOfMonthIndate]+1]];
    }
    if ([self.haveTimeArr containsObject:timeStr]) {
        if (_delegate && [_delegate respondsToSelector:@selector(disappearView:)]) {
            [_delegate disappearView:timeStr];
        }
    }
    

}

@end
