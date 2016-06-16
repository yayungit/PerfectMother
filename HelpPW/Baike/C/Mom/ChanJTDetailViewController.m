//
//  ChanJTDetailViewController.m
//  HelpPW
//
//  Created by 何亚运 on 16/3/2.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ChanJTDetailViewController.h"

@interface ChanJTDetailViewController ()

@end

@implementation ChanJTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianweise];
    // 设置标题为白色
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor qianweise];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, kWidth/12, kWidth/12);
    [backButton setImage:[UIImage imageNamed:@"back@2x.png"] forState:UIControlStateNormal];
    UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth/12, kWidth/12)];
    [backV addSubview:backButton];
    [backButton addTarget:self action:@selector(backC:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:backV];
    
    
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeigth-64)];
    scrollV.backgroundColor = [UIColor cloudsColor];
    scrollV.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollV];
    self.navigationItem.title = [_dict objectForKey:@"title"];
    UILabel *desL = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kWidth-10, 30)];
    desL.text = [[[_dict objectForKey:@"items"] stringByAppendingFormat:@"\n"] stringByAppendingString:[_dict objectForKey:@"warn"]];
    desL.numberOfLines = 0;
    [desL sizeToFit];
    [scrollV addSubview:desL];
    scrollV.contentSize = CGSizeMake(kWidth-10, desL.frame.origin.y+desL.frame.size.height);
}

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
