//
//  YunQSPTableViewCell.m
//  HelpPW
//
//  Created by 何亚运 on 16/3/3.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "YunQSPTableViewCell.h"

@implementation YunQSPTableViewCell

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
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, kWidth/6, kWidth/6)];
        [self.contentView addSubview:_imageV];
        self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(10+_imageV.frame.size.width, _imageV.frame.origin.y, self.frame.size.width-_imageV.frame.size.width-15, _imageV.frame.size.height/2)];
        [self.contentView addSubview:_titleL];
        
        self.desL = [[UILabel alloc] initWithFrame:CGRectMake(_titleL.frame.origin.x, _imageV.frame.origin.y+_imageV.frame.size.height/2, _titleL.frame.size.width, _titleL.frame.size.height)];
        self.desL.font = [UIFont systemFontOfSize:15];
        self.desL.alpha = 0.8;
        [self.contentView addSubview:_desL];
        
    }
    return self;
}
@end
