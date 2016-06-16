//
//  YunQSPViewController.m
//  HelpPW
//
//  Created by 何亚运 on 16/3/2.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "YunQSPViewController.h"
//#import "FoodCustomTableViewCell.h"
#import "FoodDetaiViewController.h"
#import "YunQSPTableViewCell.h"
@interface YunQSPViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *foodArr;
@property (nonatomic, assign) NSInteger week;
@property (nonatomic ,strong) UILabel *label;
@property (nonatomic ,strong) UITableView *tableV;
@end

@implementation YunQSPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cloudsColor];
    self.navigationItem.title = @"孕期食谱";
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 40)];
    view.backgroundColor = [UIColor silverColor];
    [self.view addSubview:view];
     NSUserDefaults *uf = [NSUserDefaults standardUserDefaults];

    // 获取末次月经时间
    NSDate *beginTime = [uf objectForKey:@"beginDate"];
    // 获取当前时间
    NSDate *nowTime = [NSDate date];
    // 计算当前时间与末次月经时间差
    NSTimeInterval time = [nowTime timeIntervalSinceDate:beginTime];
    self.week = time/60/60/24/7;
    if (self.week>39) {
        self.week = 39;
    }
    if (self.week<0) {
        self.week = 0;
    }
   
    UIView *centerButton = [[UIView alloc] initWithFrame:CGRectMake(kWidth/3, 0, kWidth/3, 40)];
    [view addSubview:centerButton];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, centerButton.bounds.size.width/3, 34)];
    leftLabel.text = @"孕";

    [centerButton addSubview:leftLabel];
    leftLabel.textAlignment = NSTextAlignmentCenter;
    
    // 显示孕期的label
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(centerButton.bounds.size.width/3, 0, centerButton.bounds.size.width/3, 34)];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.text = [NSString stringWithFormat:@"%ld",self.week+1];
    [centerButton addSubview:_label];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(centerButton.bounds.size.width/3*2, 0, centerButton.bounds.size.width/3, 34)];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.text = @"周";
    [centerButton addSubview:rightLabel];
    
    
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(kWidth/3-20, 0, 20, 40);
    [leftButton setImage:[UIImage imageNamed:@"last.png"] forState:UIControlStateNormal];
    [view addSubview:leftButton];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(kWidth/3*2, 0, 20, 40);
    [rightButton setImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    [view addSubview:rightButton];
    
    [leftButton addTarget:self action:@selector(lastW:) forControlEvents:UIControlEventTouchUpInside];
      [rightButton addTarget:self action:@selector(nextW:) forControlEvents:UIControlEventTouchUpInside];
    
    self.foodArr = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"每周食谱" ofType:@"plist"];
    self.foodArr = [NSMutableArray arrayWithContentsOfFile:path];
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, kWidth, kWidth/6*4+80) style:UITableViewStylePlain];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    self.tableV.backgroundColor = [UIColor cloudsColor];
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableV.showsVerticalScrollIndicator = NO;
    self.tableV.showsHorizontalScrollIndicator = NO;
    self.tableV.scrollEnabled = NO;
    [self.view addSubview:self.tableV];

    
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] init];
    left.direction = UISwipeGestureRecognizerDirectionLeft;
    [left addTarget:self action:@selector(nextZ:)];
    [self.view addGestureRecognizer:left];
    
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] init];
    right.direction = UISwipeGestureRecognizerDirectionRight;
    [right addTarget:self action:@selector(lastZh:)];
    [self.view addGestureRecognizer:right];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 左箭头按钮
- (void)lastW:(UIButton *)button {
    if ([self.label.text intValue] >1 && [self.label.text intValue] <= 40){
    self.label.text = [NSString stringWithFormat:@"%d", [self.label.text intValue] - 1];
    [self.tableV reloadData];
    }
}
// 右箭头按钮
- (void)nextW:(UIButton *)button {
    if ([self.label.text intValue] >=1 && [self.label.text intValue] < 40){
     self.label.text = [NSString stringWithFormat:@"%d", [self.label.text intValue] + 1];
    [self.tableV reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YunQSPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[YunQSPTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor cloudsColor];
    int a = [self.label.text intValue];
    NSArray *arr = self.foodArr[a - 1];
    NSDictionary *dict = arr[indexPath.row];
    cell.imageV.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
    cell.titleL.text = [dict objectForKey:@"name"];
    cell.desL.text = [dict objectForKey:@"effect"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FoodDetaiViewController *foodDetaiVC = [[FoodDetaiViewController alloc] init];
    int a = [self.label.text intValue];
    NSArray *arr = self.foodArr[a - 1];
    NSDictionary *dict = arr[indexPath.row];
    foodDetaiVC.dict = dict;
    [self presentViewController:foodDetaiVC animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidth/6+20;
}


// 左滑手势
- (void)nextZ:(UISwipeGestureRecognizer *)swip {
    if ([self.label.text intValue] >=1 && [self.label.text intValue] < 40){
        self.label.text = [NSString stringWithFormat:@"%d", [self.label.text intValue] + 1];
        [self.tableV reloadData];
    }
}

// 右滑手势
- (void)lastZh:(UISwipeGestureRecognizer *)swip {
    if ([self.label.text intValue] >1 && [self.label.text intValue] <= 40){
        self.label.text = [NSString stringWithFormat:@"%d", [self.label.text intValue] - 1];
        [self.tableV reloadData];
    }
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
