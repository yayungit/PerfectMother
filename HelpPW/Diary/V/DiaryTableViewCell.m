//
//  DiaryTableViewCell.m
//  HelpPW
//
//  Created by BurNIng on 16/2/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DiaryTableViewCell.h"
#import "DiaryModel.h"

@interface DiaryTableViewCell ()
@property (nonatomic, strong) UILabel *dayL;
@property (nonatomic, strong) UILabel *dateL;
@property (nonatomic, strong) UILabel *textL;
@property (nonatomic, strong) UILabel *timeL;
@property (nonatomic, strong) UIImageView *imageV;

@end

@implementation DiaryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.dayL = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, kWidth/11, kWidth/11)];
        self.dayL.font = [UIFont systemFontOfSize:20];
//        self.dayL.backgroundColor = [UIColor redColor];
        self.dayL.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.dayL];
        
        self.dateL = [[UILabel alloc] initWithFrame:CGRectMake(10, self.dayL.frame.origin.y+self.dayL.frame.size.height, kWidth/6, 20)];
        self.dateL.font = [UIFont systemFontOfSize:16];
//        self.dateL.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:self.dateL];
        
        UIImageView *shuxianV = [[UIImageView alloc] initWithFrame:CGRectMake(self.dateL.frame.origin.x+self.dateL.frame.size.width+10, 0, 1.2, 110)];
        shuxianV.backgroundColor = [UIColor qianweise];
        [self.contentView addSubview:shuxianV];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(shuxianV.frame.origin.x-6, 25, 12, 12)];
        label.layer.cornerRadius = 12;
        label.layer.masksToBounds = YES;
        label.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:label];
        
        
        UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(shuxianV.frame.origin.x+shuxianV.frame.size.width+10, 10, kWidth-(shuxianV.frame.origin.x+shuxianV.frame.size.width+15), 100)];
        backV.backgroundColor = [UIColor whiteColor];
        
//        self.textL = [[UILabel alloc] initWithFrame:CGRectMake(shuxianV.frame.origin.x+shuxianV.frame.size.width+10, 10, kWidth-(shuxianV.frame.origin.x+shuxianV.frame.size.width+10)-100, 75)];
        self.textL = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, backV.frame.size.width - 100, 75)];
        self.textL.numberOfLines = 0;
        [backV addSubview:self.textL];
//        [self.contentView addSubview:self.textL];
        
//        self.timeL = [[UILabel alloc] initWithFrame:CGRectMake(self.textL.frame.origin.x, self.textL.frame.origin.y+self.textL.frame.size.height, self.textL.frame.size.width, 15)];
        self.timeL = [[UILabel alloc] initWithFrame:CGRectMake(5, self.textL.frame.origin.y+self.textL.frame.size.height+5, self.textL.frame.size.width, 15)];
        self.timeL.font = [UIFont systemFontOfSize:14];
        [backV addSubview:self.timeL];
//        [self.contentView addSubview:self.timeL];
        
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(self.textL.frame.size.width+self.textL.frame.origin.x+10, 10, 80, 80)];
//        [self.contentView addSubview:self.imageV];
        [backV addSubview:self.imageV];
        
        [self.contentView addSubview:backV];
    }
    return self;
}

- (void)setDiaryM:(DiaryModel *)diaryM {
    _diaryM = diaryM;
    self.dayL.text = [diaryM.time substringWithRange:NSMakeRange(8, 2)];
    self.dateL.text = [diaryM.time substringToIndex:7];
    [self.dateL sizeToFit];
    self.timeL.text = [diaryM.time substringFromIndex:11];
    if (![diaryM.content isEqualToString:@""]) {
        self.textL.text = diaryM.content;
        self.textL.alpha = 1.0;
    } else if (![diaryM.title isEqualToString:@""] && [diaryM.content isEqualToString:@""]) {
        self.textL.text = diaryM.title;
         self.textL.alpha = 1.0;
    } else {
        self.textL.text = @"重点是看图~~";
        self.textL.alpha = 0.5;
    }
    self.imageV.image = diaryM.image1;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
