//
//  FoodMenuTableViewCell.h
//  HelpPW
//
//  Created by 何亚运 on 16/3/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FoodMenuDelegate <NSObject>

- (void)passFoodInfo:(NSDictionary *)dict;

@end

@interface FoodMenuTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, assign) id<FoodMenuDelegate>delegate;
@end
