//
//  XZDetailViewController.m
//  helpQQ
//
//  Created by 何威亚 on 16/3/3.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "XZDetailViewController.h"
#import "UIColor+AddColor.h"
#define kWdith [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
@interface XZDetailViewController ()
@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UILabel *desLabel; // 星座详情

@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation XZDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置标题为白色
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, kWidth/12, kWidth/12);
    [backButton setImage:[UIImage imageNamed:@"back@2x.png"] forState:UIControlStateNormal];
    UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth/12, kWidth/12)];
    [backV addSubview:backButton];
    [backButton addTarget:self action:@selector(backC:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:backV];
    self.view.backgroundColor = [UIColor cloudsColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor qianweise];
    //====== 标题
    self.navigationItem.title = _babyDes.name;

    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWdith, kHeight / 7)];
    self.topView.backgroundColor = [UIColor silverColor];
    
    [self.view addSubview:self.topView];
    
    // ===========
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, kHeight / 7 - 5, kHeight / 7 - 5)];
    [self.topView addSubview:self.imageV];
    self.imageV.image = [UIImage imageNamed:_babyDes.icon];
    // ===========
    self.text = [[UILabel alloc] initWithFrame:CGRectMake(self.imageV.frame.origin.x+ self.imageV.bounds.size.width + 10, 0, self.topView.bounds.size.width - self.imageV.bounds.size.width, self.topView.bounds.size.height / 3)];
    self.text.text = [_babyDes.name stringByAppendingString:_babyDes.date];
    
    
    [self.topView addSubview:self.text];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.imageV.frame.origin.y+ 5 + self.imageV.bounds.size.height, kWdith, kHeight - self.imageV.bounds.size.height- 80)];
    
    [self.view addSubview:self.scrollView];
    
    
    self.desLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, kWdith - 10, kHeight)];
    self.desLabel.text = _babyDes.des;
    self.desLabel.numberOfLines = 0;
    [self.desLabel sizeToFit ];
//    self.desLabel.backgroundColor = [UIColor cyanColor];
    [self.scrollView addSubview:self.desLabel];
    
    self.scrollView.contentSize = CGSizeMake(kWdith, self.desLabel.frame.size.height);
    
    //===========
    
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.text.frame.origin.x, self.text.frame.origin.y + self.text.bounds.size.height, self.text.bounds.size.width, self.text.bounds.size.height)];
    label.textColor  = [UIColor jinjuse];
    label.font = [UIFont systemFontOfSize:15];
    [self.topView addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y + label.bounds.size.height, label.bounds.size.width,label.bounds.size.height)];
    [self.topView addSubview:label1];
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor = [UIColor jinjuse];
    NSString *string = @"属性：";
    NSString *string1 = @"主宰行星：";
    label.text = [string stringByAppendingString:_babyDes.sx];
    label1.text = [string1 stringByAppendingString:_babyDes.zhu];
    
}
// leftBarBUtton
- (void)backC:(UIButton *)bar {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
