//
//  DiaryChangeViewController.h
//  HelpPW
//
//  Created by BurNIng on 16/2/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "BaseViewController.h"

@class DiaryModel;

typedef void(^passDiaryBlock)(DiaryModel *diary);

@interface DiaryChangeViewController : BaseViewController
@property (nonatomic, strong) DiaryModel *diaryM;
@property (nonatomic, copy) passDiaryBlock passdiary;

@end
