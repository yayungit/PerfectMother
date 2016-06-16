//
//  DiaryViewController.m
//  HelpPW
//
//  Created by BurNIng on 16/1/26.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DiaryViewController.h"
#import "WriteViewController.h"
#import "DiaryHandle.h"
#import "DiaryModel.h"
#import "DiaryTableViewCell.h"
#import "DiaryDetailViewController.h"
#import "CalendarViewController.h"

@interface DiaryViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) NSMutableArray *diaryArr;
@property (nonatomic, strong) NSMutableArray *showArr;
@property (nonatomic, strong) UILabel *headerLabel;
@end

@implementation DiaryViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor qianweise];
    // 设置标题为白色
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;

    //  创建按钮视图，放两个按钮。一个日记，一个日历。
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //  日记按钮
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 8, 30, 30);
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"briji"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(doWriteDiary:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:button1];
    //  日历按钮
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(60, 8, 30, 30);
    [button2 setImage:[UIImage imageNamed:@"brili"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(doPushDate) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:button2];
    //  添加到右边按钮上
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonView];
    
    //  获取本地所有日记
    self.diaryArr = [NSMutableArray arrayWithArray:[DiaryHandle selectDiarySqlite]];
    self.showArr = [NSMutableArray arrayWithArray:self.diaryArr];
    //  显示日记
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeigth-64) style:UITableViewStylePlain];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableV.backgroundColor = [UIColor cloudsColor];
    [self.tableV registerClass:[DiaryTableViewCell class] forCellReuseIdentifier:@"diary"];
    
    
    self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -40, kWidth, 30)];
    self.headerLabel.textAlignment = NSTextAlignmentCenter;
    self.headerLabel.text = @"下拉加载所有日记";
    [self.tableV addSubview:self.headerLabel];
    
    
    [self.view addSubview:self.tableV];
    
}
//  写日记按钮事件
- (void)doWriteDiary:(UIButton *)button {
    WriteViewController *writeVC = [[WriteViewController alloc] init];
    __block DiaryViewController *seff = self;
    writeVC.passBOOL = ^(BOOL mark){
        if (mark == YES) {
            self.diaryArr = [NSMutableArray arrayWithArray:[DiaryHandle selectDiarySqlite]];
            self.showArr = [NSMutableArray arrayWithArray:self.diaryArr];
            [seff.tableV reloadData];
        }
    };
    UINavigationController *naviC = [[UINavigationController alloc] initWithRootViewController:writeVC];
    [self presentViewController:naviC animated:YES completion:^{
    }];
}
//  日历按钮事件
- (void)doPushDate {
    CalendarViewController *calendarVC = [[CalendarViewController alloc] init];
    calendarVC.passDate = ^ void (NSString *date) {
        self.showArr = [NSMutableArray arrayWithCapacity:0];
        for (DiaryModel *diary in self.diaryArr) {
            NSString *str = [diary.time substringToIndex:10];
            if ([date isEqualToString:str]) {
                [self.showArr addObject:diary];
            }
        }
        [self.tableV reloadData];
    };
    [self presentViewController:calendarVC animated:YES completion:nil];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.showArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiaryModel *diary = self.showArr[self.showArr.count - indexPath.row - 1];
    DiaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"diary" forIndexPath:indexPath];
    cell.diaryM = diary;
    cell.backgroundColor = [UIColor cloudsColor];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DiaryDetailViewController *diaryDetailVC = [[DiaryDetailViewController alloc] init];
    DiaryModel *diaryM = self.showArr[self.showArr.count - indexPath.row - 1];
    diaryDetailVC.diary = diaryM;
    __block DiaryViewController *seff = self;
    diaryDetailVC.passBOOL = ^(BOOL mark){
        if (mark == YES) {
            self.diaryArr = [NSMutableArray arrayWithArray:[DiaryHandle selectDiarySqlite]];
            self.showArr = [NSMutableArray arrayWithArray:self.diaryArr];
            [seff.tableV reloadData];
        }
    };
    UINavigationController *naviC = [[UINavigationController alloc] initWithRootViewController:diaryDetailVC];
    [self presentViewController:naviC animated:YES completion:^{
        
    }];
}

//  下拉加载所有日记
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float offset = self.tableV.contentOffset.y;
    if (offset < -90) {
        self.headerLabel.text = @"可以松手了";
    } else {
        self.headerLabel.text = @"下拉加载所有日记";
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    float offset = self.tableV.contentOffset.y;
    if (offset < -90) {
        self.diaryArr = [NSMutableArray arrayWithArray:[DiaryHandle selectDiarySqlite]];
        self.showArr = [NSMutableArray arrayWithArray:self.diaryArr];
        [self.tableV reloadData];
    }
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
