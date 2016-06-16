//
//  InforChangeTableViewCell.m
//  HelpPW
//
//  Created by 何亚运 on 16/2/26.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "InforChangeTableViewCell.h"
#import "FetalModel.h"

@interface InforChangeTableViewCell ()
//@property (nonatomic, strong) UIImageView *imageV;
//@property (nonatomic, strong) UILabel *titleL;
//@property (nonatomic, strong) UILabel *desL;
@end


@implementation InforChangeTableViewCell
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
        UILabel *bgL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth, 5)];
        bgL.backgroundColor = [UIColor qianweise];
        bgL.alpha = 0.6;
        [self.contentView addSubview:bgL];
        
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kWidth/12, kWidth/12)];
//        self.imageV.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.imageV];
       self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(self.imageV.frame.origin.x+self.imageV.bounds.size.width+10, self.imageV.frame.origin.y, kWidth-30-self.imageV.bounds.size.width, self.imageV.bounds.size.height)];
//        self.titleL.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.titleL];
        
        self.desL = [[UILabel alloc] initWithFrame:CGRectMake(self.imageV.frame.origin.x, self.imageV.frame.origin.y+self.imageV.bounds.size.height+10, kWidth-20, 150)];
//        self.desL.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.desL];
        
    }
    return self;
}

- (void)setModel:(FetalModel *)model {
    _model = model;
   
}
- (void)layoutSubviews {
    self.desL.frame = CGRectMake(self.imageV.frame.origin.x, self.imageV.frame.origin.y+self.imageV.bounds.size.height+10, kWidth-20, 150);
    self.desL.font = [UIFont systemFontOfSize:15];
     self.titleL.textColor = [UIColor qianweise];
    self.desL.numberOfLines = 0;
    [self.desL sizeToFit];
}


@end
