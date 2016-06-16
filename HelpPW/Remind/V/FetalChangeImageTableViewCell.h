//
//  FetalChangeImageTableViewCell.h
//  HelpPW
//
//  Created by 何亚运 on 16/2/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FetalModel;
@interface FetalChangeImageTableViewCell : UITableViewCell
@property (nonatomic, copy) NSString *str; // 接收预产期时间转化成的字符串
@property (nonatomic, assign) NSInteger numWeek; // 当前第几周
@property (nonatomic, assign) NSInteger numday; // 当前是第几天
@property (nonatomic, strong) FetalModel *model;
@end
