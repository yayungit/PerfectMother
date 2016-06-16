//
//  DiaryModel.h
//  HelpPW
//
//  Created by BurNIng on 16/1/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DiaryModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong) NSData *photoData1;
@property (nonatomic, strong) NSData *photoData2;
@property (nonatomic, strong) NSData *photoData3;
@property (nonatomic, strong) UIImage *image1;
@property (nonatomic, strong) UIImage *image2;
@property (nonatomic, strong) UIImage *image3;

- (instancetype)initWithTitle:(NSString *)title Content:(NSString *)content Time:(NSString *)time PhotoData1:(NSData *)data1 PhotoData2:(NSData *)data2 PhotoData3:(NSData *)data3;

@end
