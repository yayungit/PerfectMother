//
//  RemindViewController.m
//  HelpPW
//
//  Created by BurNIng on 16/1/26.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RemindViewController.h"
#import "PregnancyBudgetViewController.h"
#import "FetalChangeImageTableViewCell.h"
#import "FetalModel.h"
#import "InforChangeTableViewCell.h"
#import "FoodMenuTableViewCell.h"
#import "FoodDetaiViewController.h"

@interface RemindViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDataSource,UITableViewDelegate,FoodMenuDelegate>
@property (nonatomic, strong) UIPickerView *cyclePickerV; // 周期选择
@property (nonatomic, strong) UIView *cycleView;
@property (nonatomic, assign) BOOL yesOrNo;
@property (nonatomic, strong) UILabel *centerLabel; // 显示孕期
@property (nonatomic, strong) NSMutableArray *arr; // 保存孕期
@property (nonatomic, strong) UITableView *tableV; // 显示胎儿周期变化信息
@property (nonatomic, strong) NSMutableArray *modelArr; // 存放胎儿变化信息的model
@property (nonatomic, copy) NSString *string; // 获取预产期日期转化成字符串
@property (nonatomic, assign) NSInteger week; // 存储当前是第几周
@property (nonatomic, assign) NSInteger days; // 当前是第几天
@property (nonatomic, assign) NSInteger i;
@property (nonatomic, strong) NSMutableArray *foodArr;

@end

@implementation RemindViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.centerLabel.text = self.centerLabel.text = [NSString stringWithFormat:@"%ld",self.week+1];
    [self.tableV reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults *uf = [NSUserDefaults standardUserDefaults];
//    [uf setBool:NO forKey:@"haveDate"];

    self.navigationController.navigationBar.barTintColor = [UIColor qianweise];
    self.navigationController.navigationBar.translucent = NO;
    self.yesOrNo = YES;
    self.arr = [NSMutableArray array];
    for (int i = 1; i <= 40; i++) {
        [self.arr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    // 获取预产期的时间
    NSDate *date = [uf objectForKey:@"overDate"];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy年MM月dd日"];
    self.string = [f stringFromDate:date];
    // 获取末次月经时间
    NSDate *beginTime = [uf objectForKey:@"beginDate"];
    
//    NSLog(@"*****%@",beginTime);
    // 获取当前时间
    NSDate *nowTime = [NSDate date];
    // 计算当前时间与末次月经时间差
    NSTimeInterval time = [nowTime timeIntervalSinceDate:beginTime];
    self.week = time/60/60/24/7;
    self.days = time/3600/24;
    if (self.week>39) {
        self.week = 39;
    }
    if (self.week<0) {
        self.week = 0;
    }
    if (self.days>279) {
        self.days = 279;
    }
    if (self.days<0) {
        self.days=-1;
    }
    
    
    // 创建titleBar
    [self creatBar];
    
    self.foodArr = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"每周食谱" ofType:@"plist"];
    self.foodArr = [NSMutableArray arrayWithContentsOfFile:path];
    
    // 创建tableView
    [self creatTableView];
    // 获取model类
    [self gainModel];
    // 添加滑动手势
    UISwipeGestureRecognizer *leftsg = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(lastW:)];
    leftsg.direction =
    
    UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:leftsg];
    UISwipeGestureRecognizer *rightsg = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextW:)];
    rightsg.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:rightsg];
}



//  创建上面的导航条
- (void)creatBar {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(kWidth/4, 0, kWidth/2, 44)];
    self.navigationItem.titleView = titleView;
//    titleView.backgroundColor = [UIColor redColor];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 5, 30, 34);
    leftButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_previous@2x.png"]];
    [titleView addSubview:leftButton];
    [leftButton addTarget:self action:@selector(lastWeek:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(titleView.bounds.size.width-30, 5, 40, 34);
    rightButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_next@2x.png"]];
    [titleView addSubview:rightButton];
    [rightButton addTarget:self action:@selector(nextWeek:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    centerButton.frame = CGRectMake(40, 5, titleView.bounds.size.width-80, 34);
    [titleView addSubview:centerButton];
    [centerButton addTarget:self action:@selector(center:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, centerButton.bounds.size.width/3, 34)];
    leftLabel.text = @"孕";
    leftLabel.font = [UIFont systemFontOfSize:20];
    leftLabel.textColor = [UIColor whiteColor];
    [centerButton addSubview:leftLabel];
    leftLabel.textAlignment = NSTextAlignmentCenter;
    
    // 显示孕期的label
    self.centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(centerButton.bounds.size.width/3, 0, centerButton.bounds.size.width/3, 34)];
//    _centerLabel.backgroundColor = [UIColor cyanColor];
    self.centerLabel.textAlignment = NSTextAlignmentCenter;
    self.centerLabel.textColor = [UIColor greenColor];
    _centerLabel.font = [UIFont systemFontOfSize:20];
    

    self.centerLabel.text = [NSString stringWithFormat:@"%ld",self.week+1];
    
    
    [centerButton addSubview:_centerLabel];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(centerButton.bounds.size.width/3*2, 0, centerButton.bounds.size.width/3, 34)];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.text = @"周";
    rightLabel.font = [UIFont systemFontOfSize:20];
    rightLabel.textColor = [UIColor whiteColor];
    [centerButton addSubview:rightLabel];
    
    // 创建分享按钮
    UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(kWidth/4*3+kWidth/12, 20, kWidth/12, kWidth/12)];
    UIButton *shareBu = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBu.frame = CGRectMake(0, 0, kWidth/12, kWidth/12);
    [shareBu setBackgroundImage:[UIImage imageNamed:@"baishare@2x.png"] forState:UIControlStateNormal];
    [shareBu addTarget:self action:@selector(thirdShare:) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:shareBu];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareView];
    
 
}

//  分享按钮
- (void)thirdShare:(UINavigationItem *)bar {
//    NSLog(@"第三方分享");
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"暂不支持第三方，敬请期待恩ing  (*^__^*) 嘻嘻……" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好哒" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertC addAction:action];
    [self presentViewController:alertC animated:YES completion:nil];

}



//  左箭头按钮
- (void)lastWeek:(UIButton *)button {
//    NSLog(@"上一周");
    if ([self.centerLabel.text intValue] >1 && [self.centerLabel.text intValue] <= 40) {
        self.centerLabel.text = [NSString stringWithFormat:@"%d",[self.centerLabel.text intValue] - 1];
        [self.tableV reloadData];
    }

}
//  左滑手势
- (void)lastW:(UISwipeGestureRecognizer *)sg {
    if ([self.centerLabel.text intValue] >1 && [self.centerLabel.text intValue] <= 40) {
        self.centerLabel.text = [NSString stringWithFormat:@"%d",[self.centerLabel.text intValue] - 1];
        [self.tableV reloadData];
    }
}
//  右箭头按钮
- (void)nextWeek:(UIButton *)button {
//    NSLog(@"下一周");
    if ([self.centerLabel.text intValue] >=1 && [self.centerLabel.text intValue] < 40) {
        self.centerLabel.text = [NSString stringWithFormat:@"%d",[self.centerLabel.text intValue] + 1];
        [self.tableV reloadData];
    }
}
//  右滑手势
- (void)nextW:(UISwipeGestureRecognizer *)sg {
    if ([self.centerLabel.text intValue] >=1 && [self.centerLabel.text intValue] < 40) {
        self.centerLabel.text = [NSString stringWithFormat:@"%d",[self.centerLabel.text intValue] + 1];
        [self.tableV reloadData];
    }
}

//  中间的周期变化
- (void)center:(UIButton *)button {
//    NSLog(@"周期选择");
    if (self.yesOrNo == YES) {
        [self creatView];

        [self.view addSubview:self.cycleView];
        self.yesOrNo = NO;
    }else {
        [self.cycleView removeFromSuperview];
        self.yesOrNo = YES;
    }

}

//  创建周期选择的view和PickerView
- (void)creatView {
    self.cycleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeigth/5+70)];
    self.cycleView.backgroundColor = [UIColor grayColor];
    self.cycleView.alpha = 0.9;
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.frame = CGRectMake(0, 10, kWidth/3, 30);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.cycleView addSubview:cancelButton];
    [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *ensureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    ensureButton.frame = CGRectMake(kWidth/3*2, 10, kWidth/3, 30);
    [ensureButton setTitle:@"确定" forState:UIControlStateNormal];
    [ensureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    ensureButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    ensureButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.cycleView addSubview:ensureButton];
    [ensureButton addTarget:self action:@selector(ensure:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cyclePickerV = [[UIPickerView alloc] initWithFrame:CGRectMake(self.cycleView.bounds.size.width/3, 50, self.cycleView.bounds.size.width/3, self.cycleView.bounds.size.height-60)];
    self.cyclePickerV.delegate = self;
    [self.cycleView addSubview:self.cyclePickerV];
    UILabel *y = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, self.cycleView.bounds.size.width/3, self.cycleView.bounds.size.height-60)];
    y.text = @"孕";
    y.font = [UIFont systemFontOfSize:20];
    y.textColor = [UIColor whiteColor];
    y.textAlignment = NSTextAlignmentRight;
    [self.cycleView addSubview:y];
    
    UILabel *w = [[UILabel alloc] initWithFrame:CGRectMake(self.cycleView.bounds.size.width/3*2, 50, self.cycleView.bounds.size.width/3, self.cycleView.bounds.size.height-60)];
    w.text = @"周";
    w.font = [UIFont systemFontOfSize:20];
    w.textColor = [UIColor whiteColor];
    w.textAlignment = NSTextAlignmentLeft;
    [self.cycleView addSubview:w];
    // 设置pickerView默认选中值
    [self.cyclePickerV selectRow:[self.centerLabel.text intValue]-1 inComponent:0 animated:NO];
}

// 取消按钮
- (void)cancel:(UIButton *)button {
    NSLog(@"回到当天");
    [self.cycleView removeFromSuperview];
    self.yesOrNo = YES;
}

// 确定按钮
- (void)ensure:(UIButton *)button {
    NSLog(@"跳转到选中的周期的资料");
    self.centerLabel.text = self.arr[self.i];
    [self.cycleView removeFromSuperview];
    [self.tableV reloadData];
    self.yesOrNo = YES;
}


#pragma mark - UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.arr.count;
}
#pragma mark - UIPickerViewDelegate

//- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED {
//    return self.arr[row];
//}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED{
    return 40;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.i = row;
}

// 设置PickerView的字体颜色
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = [[UILabel alloc] init];
    label.text = self.arr[row];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:25];
    label.textColor = [UIColor greenColor];
//    if (row == [self.centerLabel.text intValue]-1) {
//        label.textColor = [UIColor redColor];
//    }
    return label;
}

// 胎儿变化的各种信息的tableView
- (void)creatTableView {
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeigth-64) style:UITableViewStylePlain];
    self.tableV.backgroundColor = [UIColor cloudsColor];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableV.showsHorizontalScrollIndicator = NO;
    self.tableV.showsVerticalScrollIndicator = NO;
    [self.tableV registerClass:[FetalChangeImageTableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableV registerClass:[InforChangeTableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.tableV registerClass:[FoodMenuTableViewCell class] forCellReuseIdentifier:@"cell3"];
    [self.view addSubview:self.tableV];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int a = [self.centerLabel.text intValue];
    if (indexPath.row == 0) {
        FetalChangeImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[FetalChangeImageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell1"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.str = self.string;
        cell.numWeek = self.week;
        cell.numday = self.days;
        int a = [self.centerLabel.text intValue];
        FetalModel *model = self.modelArr[a-1];
        cell.model = model;
        return cell;
    }else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
        InforChangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[InforChangeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        FetalModel *model = self.modelArr[a-1];
        cell.model = model;
        NSArray *arr = @[@"icon_baby@2x.png",@"mother@2x.png",@"warn@2x.png",@"yingyang@2x.png"];
        cell.imageV.image = [UIImage imageNamed:arr[indexPath.row - 1]];
        NSArray *titleArr = @[@"胎儿变化信息",@"妈妈变化信息", @"温馨小提醒", @"饮食与营养"];
        cell.titleL.text = titleArr[indexPath.row - 1];
        if (indexPath.row == 1) {
            cell.desL.text = model.des;
        }else if (indexPath.row == 2){
            cell.desL.text = model.motherChange;
        }
        if (indexPath.row == 3){
            cell.desL.text = model.warn;
        }
        if (indexPath.row == 4) {
            NSArray *arr = self.foodArr[a-1];
            cell.desL.text = arr[4];
        }
        return cell;
    }else {
        FoodMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[FoodMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell3"];
        }
        cell.arr = self.foodArr[a-1];
        cell.delegate = self;
        return cell;
    }
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(kWidth-20, 20000);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName];
    int a = [self.centerLabel.text intValue];
    FetalModel *model = self.modelArr[a-1];
    if (indexPath.row == 0) {
        return kHeigth/5+70;
    }else if(indexPath.row == 1){

        CGRect rect = [model.des boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
            return rect.size.height+30+kWidth/12;
    }else if (indexPath.row == 2) {
        CGRect rect = [model.motherChange boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        return rect.size.height+30+kWidth/12;
    }else if (indexPath.row == 3) {
        CGRect rect = [model.warn boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        return rect.size.height+30+kWidth/12;
    }else if (indexPath.row == 4) {
        NSArray *arr = self.foodArr[a-1];
        CGRect rect = [arr[4] boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        return rect.size.height+30+kWidth/12;
    }else {
        return 60+kWidth/2 + kWidth/12;
    }
}

// model类
- (void)gainModel {
    self.modelArr = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"每周变化" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *dict in arr) {
        FetalModel *model = [[FetalModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [self.modelArr addObject:model];
    }
}

- (void)passFoodInfo:(NSDictionary *)dict {
    FoodDetaiViewController *foodDetaiVC = [[FoodDetaiViewController alloc] init];
    foodDetaiVC.dict = dict;
    [self presentViewController:foodDetaiVC animated:YES completion:nil];
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
