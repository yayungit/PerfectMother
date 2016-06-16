//
//  ChanJSJTableViewCell.m
//  HelpPW
//
//  Created by 何亚运 on 16/3/2.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ChanJSJTableViewCell.h"

@implementation ChanJSJTableViewCell

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
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth, 3)];
        label.backgroundColor = [UIColor qianweise];
        label.alpha = 0.8;
        [self.contentView addSubview:label];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, kWidth/12, kWidth/12)];
        imageV.image = [UIImage imageNamed:@"xin.png"];
        [self.contentView addSubview:imageV];
        
        self.timeL = [[UILabel alloc] initWithFrame:CGRectMake(kWidth/12+10, 5, kWidth/3, kWidth/12)];
        [self.contentView addSubview:self.timeL];
        
        self.frequencyL = [[UILabel alloc] initWithFrame:CGRectMake(kWidth-5-kWidth/3, 5, kWidth/3, kWidth/12)];
        self.frequencyL.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.frequencyL];
        
        self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(5, imageV.frame.origin.y+imageV.frame.size.height+5, kWidth-10, 30)];
        [self.contentView addSubview:self.titleL];
        
        self.desL = [[UILabel alloc] initWithFrame:CGRectMake(5, self.titleL.frame.origin.y+self.titleL.frame.size.height+5, kWidth-10, 80)];
        self.desL.numberOfLines = 0;
        self.desL.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.desL];
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}


@end
