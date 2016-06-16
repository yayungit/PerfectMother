//
//  HYYCalendar.h
//  Calendar
//
//  Created by 何亚运 on 16/1/27.
//  Copyright © 2016年 YaYunHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYYCalendarCollectionView.h"

@interface HYYCalendar : UIView
//  写一个初始化方法,供外界使用
- (instancetype)initWithCurrentDate:(NSDate *)currentDate andFrame:(CGRect)frame andDelegate:(id<calendarDisappearDelegate>)delegate;

@end
