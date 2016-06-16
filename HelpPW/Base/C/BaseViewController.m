//
//  BaseViewController.m
//  HelpPW
//
//  Created by BurNIng on 16/1/26.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "BaseViewController.h"
#import "RESideMenu.h"
@interface BaseViewController ()
@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIBarButtonItem *leftBarButton;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.backgroundColor = [UIColor qianweise];
    
    self.leftBarButton = [[UIBarButtonItem alloc]
                          initWithImage:[[UIImage imageNamed:@"yonghu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
//    self.leftBarButton.tintColor = [UIColor orangeColor];
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
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
