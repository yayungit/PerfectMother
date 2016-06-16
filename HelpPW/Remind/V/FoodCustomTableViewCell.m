//
//  FoodCustomTableViewCell.m
//  HelpPW
//
//  Created by 何亚运 on 16/3/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "FoodCustomTableViewCell.h"

@implementation FoodCustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, kWidth/8, kWidth/8)];
        [self.contentView addSubview:_imageV];
        self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(10+kWidth/8, 5, self.frame.size.width-kWidth/8-15, kWidth/16)];
        self.titleL.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleL];
        
        self.desL = [[UILabel alloc] initWithFrame:CGRectMake(_titleL.frame.origin.x, _imageV.frame.origin.y+_imageV.frame.size.height/2, _titleL.frame.size.width-40, _titleL.frame.size.height)];
        self.desL.font = [UIFont systemFontOfSize:13];
        self.desL.textColor = [UIColor grayColor];
        [self.contentView addSubview:_desL];
        
    }
    return self;
}
@end
