//
//  BaikeCollectionViewCell.m
//  HelpPW
//
//  Created by BurNIng on 16/3/2.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "BaikeCollectionViewCell.h"

@implementation BaikeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-25)];
        [self.contentView addSubview:self.imageV];
        
        self.labelL = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imageV.frame.origin.y+self.imageV.frame.size.height+5, self.frame.size.height, 20)];
        [self.contentView addSubview:self.labelL];
        self.labelL.font = [UIFont systemFontOfSize:15];
        self.labelL.lineBreakMode = NSLineBreakByTruncatingMiddle;
        self.labelL.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
@end
