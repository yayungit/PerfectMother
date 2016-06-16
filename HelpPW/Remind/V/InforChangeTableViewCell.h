//
//  InforChangeTableViewCell.h
//  HelpPW
//
//  Created by 何亚运 on 16/2/26.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FetalModel;
@interface InforChangeTableViewCell : UITableViewCell
@property (nonatomic, strong) FetalModel *model;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *desL;
@end
