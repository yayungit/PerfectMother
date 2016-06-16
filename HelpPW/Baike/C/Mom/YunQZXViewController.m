//
//  YunQZXViewController.m
//  HelpPW
//
//  Created by 何亚运 on 16/3/3.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "YunQZXViewController.h"

@interface YunQZXViewController ()

@end

@implementation YunQZXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"孕期资讯";
    UIWebView *webV = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeigth-64)];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://baby.sina.cn/hyq?vt=4&cid=73384"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    [webV loadRequest:request];
    [self.view addSubview:webV];
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
