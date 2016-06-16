//
//  XZCollectionViewCell.h
//  helpQQ
//
//  Created by 何威亚 on 16/3/3.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BabyXZ;
@interface XZCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *nameLabel;// 星座名字

@property (nonatomic, strong) UIImageView *image;// 星座图片

@property (nonatomic, strong) UILabel *dateLabel; // 日期


@property (nonatomic, strong) UILabel *desLabel; // 星座详情

@property (nonatomic, strong) BabyXZ *baby;


@end
