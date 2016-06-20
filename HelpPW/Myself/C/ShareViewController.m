//
//  ShareViewController.m
//  helpQQ
//
//  Created by 何威亚 on 16/2/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ShareViewController.h"
#import "RESideMenu.h"
#import "BMKMapComponent.h"

@interface ShareViewController ()<BMKMapViewDelegate>
@property (nonatomic, strong) BMKMapView *mapView;
@end

@implementation ShareViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor qianweise];
    self.navigationItem.title = @"分享给好友";
    // 设置标题为白色
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.view.backgroundColor = [UIColor cloudsColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStyleDone target:self action:@selector(presentLeftMenuViewController:)];
    
//    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"暂不支持第三方，敬请期待恩ing  (*^__^*) 嘻嘻……" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好哒" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    }];
//    [alertC addAction:action];
//    [self presentViewController:alertC animated:YES completion:nil];
    
    // 上面注释掉，为了写一个地图
    BMKMapView *mapView = [[BMKMapView alloc] initWithFrame:self.view.frame];
    self.mapView = mapView;
    self.view = mapView;
    
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
