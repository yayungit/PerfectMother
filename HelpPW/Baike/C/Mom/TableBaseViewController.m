//
//  TableBaseViewController.m
//  HelpPW
//
//  Created by BurNIng on 16/3/2.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TableBaseViewController.h"
//#import "TableBaseViewCell.h"
#import "AttentionDetailViewController.h"

@interface TableBaseViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation TableBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.naviTitle;
    // 设置标题为白色
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor qianweise];
    self.view.backgroundColor = [UIColor cloudsColor];

    
    UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeigth-64) style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.backgroundColor = [UIColor cloudsColor];
    tableV.showsVerticalScrollIndicator = NO;
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableV];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dictArr.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dictArr[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cloudsColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = dict[@"title"];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AttentionDetailViewController *detailVC = [[AttentionDetailViewController alloc] init];
    detailVC.dict = self.dictArr[indexPath.row];
    UINavigationController *naviC = [[UINavigationController alloc] initWithRootViewController:detailVC];
    [self presentViewController:naviC animated:YES completion:^{
        
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
