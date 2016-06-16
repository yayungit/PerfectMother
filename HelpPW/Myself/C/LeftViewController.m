//
//  LeftViewController.m
//  helpQQ
//
//  Created by 何威亚 on 16/2/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "LeftViewController.h"
#import "FristViewController.h"
#import "AboutUsViewController.h"
#import "ServerViewController.h"
#import "ShareViewController.h"
#import "AboutUsViewController.h"
#import "RESideMenu.h"
#import "PregnancyBudgetViewController.h"
static NSString * const kYCLeftViewControllerCellReuseId = @"kYCLeftViewControllerCellReuseId";

@interface LeftViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) NSInteger previousRow;
@property (nonatomic, assign) BOOL yes;
@end

@implementation LeftViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.yes = YES;
    // Do any additional setup after loading the view.
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"image.jpg"];
    [self.view addSubview:imageView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kHeigth/6, kWidth-10, kHeigth*5/6) style:UITableViewStylePlain];
    //    self.tableView.frame = self.view.bounds;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 设置分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    

}
//设置状态栏
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor purpleColor];
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"首页";
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"免责声明";
    }else if (indexPath.row  == 2){
        cell.textLabel.text = @"关于我们";
    }else if (indexPath.row == 3){
        cell.textLabel.text = @"意见反馈";
    }else if (indexPath.row == 4){
        cell.textLabel.text = @"分享给好友";
    }else if (indexPath.row == 5){
        cell.textLabel.text = @"计算预产期";
    }
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     UIViewController *center;
    if (indexPath.row == 0) {
        center = self.sideMenuViewController.mainController;
    }else if(indexPath.row == 1){
        FristViewController *fristVC = [[FristViewController alloc ] init];
        center = [[UINavigationController alloc] initWithRootViewController:fristVC];
    }else if(indexPath.row == 2){
        AboutUsViewController *serverVC = [[AboutUsViewController alloc ] init];
        center = [[UINavigationController alloc] initWithRootViewController:serverVC];
        
    }else if(indexPath.row == 4){
        ShareViewController *setting = [[ShareViewController alloc ] init];
        center = [[UINavigationController alloc] initWithRootViewController:setting];
    }else if (indexPath.row == 3){
        ServerViewController *about = [[ServerViewController alloc ] init];
        center = [[UINavigationController alloc] initWithRootViewController:about];
    }else if (indexPath.row == 5){
        PregnancyBudgetViewController *preVC = [[PregnancyBudgetViewController alloc] init];
        preVC.yesOrNo = self.yes;
        center = [[UINavigationController alloc] initWithRootViewController:preVC];
    }
    [self.sideMenuViewController setContentViewController:center
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
    self.previousRow = indexPath.row;
}
//      返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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
