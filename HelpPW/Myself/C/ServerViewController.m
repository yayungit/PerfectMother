//
//  ServerViewController.m
//  helpQQ
//
//  Created by 何威亚 on 16/2/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ServerViewController.h"
#import "RESideMenu.h"
@interface ServerViewController ()

@end

@implementation ServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor qianweise];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor cloudsColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStyleDone target:self action:@selector(presentLeftMenuViewController:)];
    
    self.navigationItem.title = @"意见反馈";
    // 设置标题为白色
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, kWidth-10, kHeigth-64)];
    label.backgroundColor = [UIColor cloudsColor];
    label.numberOfLines = 0;
    label.text = @"        完美妈妈将竭力为您和宝宝服务，如有感到用着不方便的或者不满意的地方，请给予您宝贵的意见！精灵们会尽快修复哒~~\n        邮箱:wanmeimama2016@163.com";
    [label sizeToFit];
    [self.view addSubview:label];
    
}
#pragma mark - Configuring the view’s layout behavior

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
