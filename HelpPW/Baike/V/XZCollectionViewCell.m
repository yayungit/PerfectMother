//
//  XZCollectionViewCell.m
//  helpQQ
//
//  Created by 何威亚 on 16/3/3.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "XZCollectionViewCell.h"
#import "BabyXZ.h"
@implementation XZCollectionViewCell




- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 星座名字
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height / 4)];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.font = [UIFont systemFontOfSize:18];
//        self.nameLabel.backgroundColor = [UIColor orangeColor];
        
        // 星座图片
        self.image = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/ 2 - 30, self.nameLabel.bounds.size.height +self.nameLabel.frame.origin.y, 50, frame.size.height / 2 )];
        
//        self.image.backgroundColor = [UIColor orangeColor];
        
        // 星座日期
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.image.bounds.size.height + self.image.frame.origin.y, frame.size.width, frame.size.height/4)];
        self.dateLabel.font = [UIFont systemFontOfSize:14];
        self.dateLabel.textAlignment = NSTextAlignmentRight;
//        self.dateLabel.backgroundColor = [UIColor redColor];
        
        // 星座详情

        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.image];
        [self.contentView addSubview:self.dateLabel];
    }
    return self;
}
- (void)setBaby:(BabyXZ *)baby{
    _baby = baby;
    self.nameLabel.text = baby.name;
    self.image.image = [UIImage imageNamed:baby.icon];
    self.dateLabel.text = baby.date;
}

@end
