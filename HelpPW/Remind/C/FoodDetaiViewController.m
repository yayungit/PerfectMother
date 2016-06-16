//
//  FoodDetaiViewController.m
//  HelpPW
//
//  Created by 何亚运 on 16/3/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "FoodDetaiViewController.h"

@interface FoodDetaiViewController ()

@end

@implementation FoodDetaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    titleV.backgroundColor = [UIColor qianweise];
    self.view.backgroundColor = [UIColor cloudsColor];
    [self.view addSubview:titleV];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 24, 30, 30);
    [backButton setImage:[UIImage imageNamed:@"back@2x.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backController:) forControlEvents:UIControlEventTouchUpInside];
    [titleV addSubview:backButton];
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(kWidth/4, 24, kWidth/2, 30)];
    titleL.text = @"孕期食谱";
    titleL.textColor = [UIColor whiteColor];
    titleL.textAlignment = NSTextAlignmentCenter;
    [titleV addSubview:titleL];
    // 创建scrollView
    [self creatScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 返回按钮
- (void)backController:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 创建scrollView
- (void)creatScrollView {
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeigth-64)];
    scrollV.showsHorizontalScrollIndicator = NO;
    scrollV.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollV];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth/4, 10, kWidth/2, kWidth/3)];

    imageV.image = [UIImage imageNamed:[_dict objectForKey:@"image"]];
    [scrollV addSubview:imageV];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(imageV.frame.origin.x, imageV.frame.origin.y+imageV.frame.size.height+5, imageV.frame.size.width, 30)];
    titleL.text = [_dict objectForKey:@"name"];
    titleL.textAlignment = NSTextAlignmentCenter;
    [scrollV addSubview:titleL];
    
    UILabel *gongx = [[UILabel alloc] initWithFrame:CGRectMake(10, titleL.frame.origin.y+40, kWidth-20, 20)];
    gongx.text = @"功效:";
    [scrollV addSubview:gongx];
    UILabel *gongxDes = [[UILabel alloc] initWithFrame:CGRectMake(10, gongx.frame.origin.y+25, kWidth-20, 40)];
    gongxDes.font = [UIFont systemFontOfSize:15];
    gongxDes.alpha = 0.7;
    gongxDes.text = [_dict objectForKey:@"effect"];
    gongxDes.numberOfLines = 0;
    [gongxDes sizeToFit];
    [scrollV addSubview:gongxDes];
    
    UILabel *cailiao = [[UILabel alloc] initWithFrame:CGRectMake(10, gongxDes.frame.origin.y+gongxDes.bounds.size.height+10, kWidth-20, 20)];
    cailiao.text = @"食材:";
    [scrollV addSubview:cailiao];
    UILabel *shicai = [[UILabel alloc] initWithFrame:CGRectMake(10, cailiao.frame.origin.y+cailiao.bounds.size.height+5, kWidth-20, 40)];
    shicai.font = [UIFont systemFontOfSize:15];
    shicai.alpha = 0.7;
    shicai.text = [_dict objectForKey:@"material"];
    shicai.numberOfLines = 0;
    [shicai sizeToFit];
    [scrollV addSubview:shicai];
    
    UILabel *fangfa = [[UILabel alloc] initWithFrame:CGRectMake(10, shicai.frame.origin.y+shicai.bounds.size.height+10, kWidth-20, 20)];
    fangfa.text = @"制作方法:";
    [scrollV addSubview:fangfa];
    UILabel *fangfaDes = [[UILabel alloc] initWithFrame:CGRectMake(10, fangfa.frame.origin.y+fangfa.bounds.size.height+5, kWidth-20, 40)];
    fangfaDes.font = [UIFont systemFontOfSize:15];
    fangfaDes.alpha = 0.7;
    fangfaDes.text = [_dict objectForKey:@"create"];
    fangfaDes.numberOfLines = 0;
    [fangfaDes sizeToFit];
    [scrollV addSubview:fangfaDes];
    
    scrollV.contentSize = CGSizeMake(kWidth, fangfaDes.frame.origin.y+fangfaDes.frame.size.height);
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
