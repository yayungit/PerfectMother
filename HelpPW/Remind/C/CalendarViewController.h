//
//  CalendarViewController.h
//  HelpPW
//
//  Created by 何亚运 on 16/1/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^passDateBlock)(NSString *date);

@interface CalendarViewController : UIViewController
@property (nonatomic, copy) passDateBlock passDate;

@end
