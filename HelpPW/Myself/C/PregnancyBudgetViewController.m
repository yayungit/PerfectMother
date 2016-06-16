//
//  PregnancyBudgetViewController.m
//  HelpPW
//
//  Created by 何亚运 on 16/1/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PregnancyBudgetViewController.h"
#import "UIColor+AddColor.h"
#import "AppDelegate.h"
//#import "BaikeViewController.h"
//#import "DiaryViewController.h"
//#import "RemindViewController.h"
#import "HomeViewController.h"
#import "LeftViewController.h"
#import "RESideMenu.h"
@interface PregnancyBudgetViewController ()<RESideMenuDelegate>
@property (nonatomic, strong) UILabel *label; // 显示计算结果
@property (nonatomic, strong) UIButton *button; // 开始计算按钮
@property (nonatomic, strong) UIDatePicker *picker; // 选取日期
@property (nonatomic, strong) UIButton *completeB; // 完成按钮
@property (nonatomic, strong) UIDatePicker *datePicker; // 显示日期
@property (nonatomic, strong) UIView *myView;
//@property (nonatomic, assign) NSTimeInterval timeCha;
//@property (nonatomic, assign) int result;
//@property (nonatomic, assign) BOOL yes;
@end
@implementation PregnancyBudgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"预产期估算";
    self.navigationController.navigationBar.barTintColor = [UIColor qianweise];
    // 设置标题为白色
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    self.view.backgroundColor = [UIColor qianweise];
    self.myView = [[UIView alloc] initWithFrame:CGRectMake(15, 80, kWidth-30, kHeigth*3/4)];
    self.myView.backgroundColor = [UIColor cloudsColor];
    [self.view addSubview:self.myView];
    self.myView.layer.masksToBounds = YES;
    self.myView.layer.cornerRadius = 10;
    [self setTitleL];
    [self setDatePicker];
    [self setBeginB];
    [self setCompleteB];
    [self setShowLabel];
    if (self.yesOrNo == YES) {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStyleDone target:self action:@selector(presentLeftMenuViewController:)];
    }

}

//  最上层字体Label
- (void)setTitleL {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, self.myView.bounds.size.width-60, 30)];
    label.text = @"请选择您的末次月经时间";
    [self.myView addSubview:label];
}

//  创建datePicker
- (void)setDatePicker{
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(15, 40, self.myView.bounds.size.width-30, 160)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"Chinese"];
    [self.myView addSubview:self.datePicker];
    [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
}

//  开始计算按钮
- (void)setBeginB {
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.frame = CGRectMake(15, self.datePicker.frame.origin.y+160, 100, 30);
    [self.button setTitle:@"开始计算" forState:UIControlStateNormal];
    [self.myView addSubview:self.button];
    self.button.backgroundColor = [UIColor tanguolu];
    self.button.layer.masksToBounds = YES;
    self.button.layer.cornerRadius = 10;
    [self.button addTarget:self action:@selector(affirmDate:)forControlEvents:UIControlEventTouchUpInside];
}
//  完成按钮
- (void)setCompleteB{
    self.completeB = [UIButton buttonWithType:UIButtonTypeSystem];
    self.completeB.frame = CGRectMake(self.myView.bounds.size.width-115, self.button.frame.origin.y, 100, 30);
    self.completeB.backgroundColor = [UIColor tanguolu];
    self.completeB.layer.masksToBounds = YES;
    self.completeB.layer.cornerRadius = 10;
    [self.completeB setTitle:@"确认保存" forState:UIControlStateNormal];
    [self.myView addSubview:self.completeB];
    [self.completeB addTarget:self action:@selector(completeAff:)forControlEvents:UIControlEventTouchUpInside];
}

//  显示计算结果的label
- (void)setShowLabel{
    UILabel *labelT = [[UILabel alloc] initWithFrame:CGRectMake(15, self.button.frame.origin.y+30, self.myView.bounds.size.width-60, 30)];
    labelT.text = @"您的预产期是:";
    labelT.font = [UIFont systemFontOfSize:15];
    [self.myView addSubview:labelT];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.myView.bounds.size.width/4, self.button.frame.origin.y+60, self.myView.bounds.size.width/2, 30)];
//    self.label.font = [UIFont systemFontOfSize:20];
    self.label.textColor = [UIColor redColor];
    self.label.layer.masksToBounds = YES;
    self.label.layer.cornerRadius = 10;
    self.label.textAlignment = NSTextAlignmentCenter;
//    self.label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"labelBG.jpg"]];
    self.label.backgroundColor = [UIColor tanguolu];
    [self.myView addSubview:self.label];
    UILabel *desL = [[UILabel alloc] initWithFrame:CGRectMake(15, self.label.frame.origin.y+40, self.myView.bounds.size.width-30, 30)];
    desL.font = [UIFont systemFontOfSize:15];
    desL.text = @"      结果仅供参考,真正分娩可能发生在预产期的前后两周内.如果您的月经周期不太规律,或者挤不太清楚末次月经的日期,请在妊娠早起根据妇科检查来推算.";
    desL.numberOfLines = 0;
    [desL sizeToFit];
    [self.myView addSubview:desL];
    self.myView.frame = CGRectMake(15, 80, kWidth-30, desL.frame.origin.y+desL.frame.size.height+20);
}



//  只要选取时间,此方法就会走动
- (void)dateChanged:(UIDatePicker *)sender {
    self.picker = (UIDatePicker *)sender;
}

//  开始计算的button
- (void)affirmDate:(id)sender {
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    // 如果没滑动datePicker的情况下给一个当前的时间
    if (!self.picker.date) {
        self.picker = [[UIDatePicker alloc] init];
        self.picker.date = [NSDate date] ;
    }
    // 依据末次月经计算预产期
    NSDate *date = [NSDate dateWithTimeInterval:280*24*60*60 sinceDate:[self.picker.date dateByAddingTimeInterval:8*60*60]];
    // 将输入的值存入本地,判断下次是否进入输入预产期界面
    NSUserDefaults *uf = [NSUserDefaults standardUserDefaults];
    
    [uf setObject:[self.picker.date dateByAddingTimeInterval:8*60*60] forKey:@"beginDate"];
    [uf setObject:date forKey:@"overDate"];
    [f setDateFormat:@"yyyy年MM月dd日"];
    NSString *str = [f stringFromDate:date];

    NSArray *arr = [str componentsSeparatedByString:@" "];
    self.label.text = arr[0];
//    NSDate *todayDate = [NSDate date];
    
//    self.timeCha = [todayDate timeIntervalSinceDate:self.datePicker.date];
//    NSString *str1 = [f stringFromDate:self.datePicker.date];
//    NSString *str2 = [f stringFromDate:todayDate];
//    self.result = [str2 compare:str1];
//     self.yes = [str1 isEqualToString:str2];
    
}

//  完成计算按钮
- (void)completeAff:(UIButton *)button {
    NSUserDefaults *uf = [NSUserDefaults standardUserDefaults];
//    int num = self.timeCha/24/60/60;
//    if (self.label.text != nil && abs(num) <= 280 && (self.result == 1 || self.yes == YES)) {
        [uf setBool:YES forKey:@"haveDate"];
        self.navigationController.navigationBar.backgroundColor = [UIColor cyanColor];
        
        UIApplication *app = [UIApplication sharedApplication];
        AppDelegate *appd = (AppDelegate *)app.delegate;
        

        HomeViewController *homeVC= [[HomeViewController alloc] init];
        LeftViewController *leftVC = [[LeftViewController alloc] init];
        
        RESideMenu *sideVC = [[RESideMenu alloc] initWithContentViewController:homeVC leftMenuViewController:leftVC rightMenuViewController:nil];
        // 设置主视图
        sideVC.mainController = homeVC;
        // 菜单首选状态栏样式
        sideVC.menuPreferredStatusBarStyle = 1;
        
        sideVC.delegate = self;
        // 内容视图阴影颜色
        sideVC.contentViewShadowColor = [UIColor whiteColor];
        // 内容视图影子 偏移量
        sideVC.contentViewShadowOffset = CGSizeMake(0, 0);
        // 内容视图影子透明度
        sideVC.contentViewShadowOpacity = 0.65;
        // 内容视图影子半径
        sideVC.contentViewShadowRadius = 12;
        // 内容视图影子是否启用
        sideVC.contentViewShadowEnabled = YES;
        appd.window.rootViewController = sideVC;
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
        }];
//    }else {
//        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入有效的末次月经的日期嗯ing  (*^__^*) 嘻嘻……" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好哒" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            self.label.text = nil;
//        }];
//        [alertC addAction:action];
//        [self presentViewController:alertC animated:YES completion:nil];
//    }
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
