//
//  DiaryDetailViewController.h
//  HelpPW
//
//  Created by BurNIng on 16/1/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^passBOOLBlock)(BOOL mark);

@class DiaryModel;
@interface DiaryDetailViewController : BaseViewController
@property (nonatomic, strong) DiaryModel *diary;
@property (nonatomic, copy) passBOOLBlock passBOOL;

@end
