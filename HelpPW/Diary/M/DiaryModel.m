//
//  DiaryModel.m
//  HelpPW
//
//  Created by BurNIng on 16/1/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DiaryModel.h"

@implementation DiaryModel
- (instancetype)initWithTitle:(NSString *)title Content:(NSString *)content Time:(NSString *)time PhotoData1:(NSData *)data1 PhotoData2:(NSData *)data2 PhotoData3:(NSData *)data3 {
    self = [super init];
    if (self) {
        self.title = title;
        self.content = content;
        self.time = time;
        self.photoData1 = data1;
        self.photoData2 = data2;
        self.photoData3 = data3;
        self.image1 = [UIImage imageWithData:data1];
        self.image2 = [UIImage imageWithData:data2];
        self.image3 = [UIImage imageWithData:data3];
    }
    return self;
}
@end
