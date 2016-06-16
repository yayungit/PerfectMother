//
//  FetalChangeImageTableViewCell.m
//  HelpPW
//
//  Created by 何亚运 on 16/2/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "FetalChangeImageTableViewCell.h"
//#import "UIColor+AddColor.h"
#import "FetalModel.h"
@interface FetalChangeImageTableViewCell ()

@property (nonatomic, strong) UIImageView *fetalImageV;
@property (nonatomic, strong) UILabel *todayLabel; // 今日时间
@property (nonatomic, strong) UILabel *cutDownLabel; // 倒计时
@property (nonatomic, strong) UILabel *beforehandTime; // 预产期

@end

@implementation FetalChangeImageTableViewCell

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
        self.fetalImageV = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth/4, 10, kWidth/2, kHeigth/5)];
        self.fetalImageV.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:self.fetalImageV];
        
        UILabel *today = [[UILabel alloc] initWithFrame:CGRectMake(0, _fetalImageV.frame.origin.y+_fetalImageV.bounds.size.height+5, kWidth/3, 20)];
        today.text = @"本周";
        today.font = [UIFont systemFontOfSize:15];
        today.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:today];
        
        self.todayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, today.frame.origin.y+today.bounds.size.height, kWidth/3, 30)];
        _todayLabel.textAlignment = NSTextAlignmentCenter;
        
       
        _todayLabel.textColor = [UIColor grayColor];
        _todayLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_todayLabel];
        
        UILabel *center = [[UILabel alloc] initWithFrame:CGRectMake(kWidth/3, _fetalImageV.frame.origin.y+_fetalImageV.bounds.size.height+5, kWidth/3, 15)];
        center.font = [UIFont systemFontOfSize:13];
        center.text = @"倒计时";
        center.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:center];
        self.cutDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth/3, center.frame.origin.y+center.bounds.size.height, kWidth/3, 35)];
        _cutDownLabel.textAlignment = NSTextAlignmentCenter;
        
        _cutDownLabel.font = [UIFont systemFontOfSize:20];
        _cutDownLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:_cutDownLabel];
        
        UILabel *right = [[UILabel alloc] initWithFrame:CGRectMake(kWidth/3*2, _fetalImageV.frame.origin.y+_fetalImageV.bounds.size.height+5, kWidth/3, 20)];
        right.text = @"预产期";
        right.font = [UIFont systemFontOfSize:15];
        right.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:right];
        
        self.beforehandTime = [[UILabel alloc] initWithFrame:CGRectMake(kWidth/3*2, today.frame.origin.y+today.bounds.size.height, kWidth/3, 30)];
        _beforehandTime.textAlignment = NSTextAlignmentCenter;
        _beforehandTime.textColor = [UIColor grayColor];
        _beforehandTime.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_beforehandTime];
        
        
    }
    return self;
}

- (void)setStr:(NSString *)str {
    _str = str;
    _beforehandTime.text = _str;
}
- (void)setNumWeek:(NSInteger)numWeek {
    _numWeek = numWeek;
     _todayLabel.text = [NSString stringWithFormat:@"第 %ld 周",self.numWeek+1];
}
- (void)setNumday:(NSInteger)numday {
    _numday = numday;
    _cutDownLabel.text = [NSString stringWithFormat:@"%ld天", 280-self.numday-1];
}

-(void)setModel:(FetalModel *)model {
    _model = model;
    _fetalImageV.image = [UIImage imageNamed:model.image];
}

@end
