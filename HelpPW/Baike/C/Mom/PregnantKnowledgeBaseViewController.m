//
//  PregnantKnowledgeBaseViewController.m
//  HelpPW
//
//  Created by 何亚运 on 16/3/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PregnantKnowledgeBaseViewController.h"

@interface PregnantKnowledgeBaseViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webV;
@end

@implementation PregnantKnowledgeBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"孕妇知识库";
    // 设置标题为白色
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.webV = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeigth-64)];
    self.webV.delegate = self;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://yfblqqhk.zhan.cnzz.net/fxb.html"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    [self.webV loadRequest:request];
    [self.view addSubview:self.webV];
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
