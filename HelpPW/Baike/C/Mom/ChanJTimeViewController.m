//
//  ChanJTimeViewController.m
//  HelpPW
//
//  Created by 何亚运 on 16/3/2.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ChanJTimeViewController.h"
#import "ChanJSJTableViewCell.h"
#import "ChanJTDetailViewController.h"
@interface ChanJTimeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *array; // 存放产检时间表的数据
@property (nonatomic, strong) UITableView *tableV;
@end

@implementation ChanJTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cloudsColor];
    self.navigationItem.title = @"孕期产检时间表";
    NSString *path = [[NSBundle mainBundle] pathForResource:@"孕检时间表" ofType:@"plist"];
    self.array = [NSMutableArray arrayWithContentsOfFile:path];
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeigth-64) style:UITableViewStylePlain];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableV.showsVerticalScrollIndicator = NO;
    self.tableV.showsHorizontalScrollIndicator = NO;
    [self.view addSubview: self.tableV];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 16;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChanJSJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[ChanJSJTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    NSDictionary *dict = self.array[indexPath.row];
    cell.timeL.text = [dict objectForKey:@"time"];
    cell.frequencyL.text = [dict objectForKey:@"frequency"];
    cell.titleL.text = [dict objectForKey:@"title"];
    cell.desL.text = [[dict objectForKey:@"items"] stringByAppendingString:[dict objectForKey:@"warn"]];
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidth/12+55+80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ChanJTDetailViewController *attenVC = [[ChanJTDetailViewController alloc] init];
    attenVC.dict = self.array[indexPath.row];
    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:attenVC];
    [self presentViewController:naVC animated:YES completion:nil];
    
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
