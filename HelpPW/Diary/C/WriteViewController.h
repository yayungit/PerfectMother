//
//  WriteViewController.h
//  HelpPW
//
//  Created by BurNIng on 16/1/26.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^passBOOLBlock)(BOOL mark);

@class DiaryModel;
@interface WriteViewController : BaseViewController
@property (nonatomic, strong) DiaryModel *diaryM;
@property (nonatomic, copy) passBOOLBlock passBOOL;

@end
