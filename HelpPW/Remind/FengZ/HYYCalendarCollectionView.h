//
//  HYYCalendarCollectionView.h
//  Calendar
//
//  Created by 何亚运 on 16/1/28.
//  Copyright © 2016年 YaYunHe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol calendarDisappearDelegate <NSObject>

- (void)disappearView:(NSString *)timeStr;

@end

@interface HYYCalendarCollectionView : UIView
@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) id<calendarDisappearDelegate>delegate;
//  获取下个月日期
- (NSDate *)nextMonthDate;
//  获取上个月日期
- (NSDate *)previousMonthDate;

@end
