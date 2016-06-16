//
//  BaikeViewController.m
//  HelpPW
//
//  Created by BurNIng on 16/1/26.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "BaikeViewController.h"
#import "BaikeCollectionViewCell.h"
#import "PregnantKnowledgeBaseViewController.h"
#import "TableBaseViewController.h"
#import "ChanJTimeViewController.h"
#import "YunQSPViewController.h"
#import "YunQZXViewController.h"
#import "XZViewController.h"
@interface BaikeViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollV;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) NSArray *nameArr; // 妈妈相关
@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) NSArray *labelArr; // 宝宝相关
@property (nonatomic, strong) NSArray *photoAyy;

@end

@implementation BaikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"妈妈相关";
    self.navigationController.navigationBar.barTintColor = [UIColor qianweise];
    // 设置标题为白色
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    self.scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeigth-64)];
    
    //  妈妈相关
    UICollectionViewFlowLayout *layout1 = [[UICollectionViewFlowLayout alloc] init];
    layout1.itemSize = CGSizeMake(kWidth/5, kWidth/5);
    layout1.sectionInset = UIEdgeInsetsMake(20, kWidth/5, 50, kWidth/5);
    layout1.minimumLineSpacing = 30;
    UICollectionView *CV1 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeigth-64-49) collectionViewLayout:layout1];
    CV1.tag = 6000;
    CV1.dataSource = self;
    CV1.delegate = self;
    [CV1 registerClass:[BaikeCollectionViewCell class] forCellWithReuseIdentifier:@"baike"];
    CV1.showsVerticalScrollIndicator = NO;
    CV1.backgroundColor = [UIColor cloudsColor];
    [self.scrollV addSubview:CV1];
    
    //  宝宝相关
    UICollectionViewFlowLayout *layout2 = [[UICollectionViewFlowLayout alloc] init];
    layout2.itemSize = CGSizeMake(kWidth/5, kWidth/5);
    layout2.sectionInset = UIEdgeInsetsMake(20, kWidth/5, 50, kWidth/5);
    layout2.minimumLineSpacing = 30;
    UICollectionView *CV2 = [[UICollectionView alloc] initWithFrame:CGRectMake(kWidth, 0, kWidth, kHeigth-64-49) collectionViewLayout:layout2];
    CV2.tag = 6001;
    CV2.dataSource = self;
    CV2.delegate = self;
    [CV2 registerClass:[BaikeCollectionViewCell class] forCellWithReuseIdentifier:@"baike"];
    CV2.showsVerticalScrollIndicator = NO;
    CV2.backgroundColor = [UIColor cloudsColor];
    [self.scrollV addSubview:CV2];
    
    //  点
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kHeigth-49-30-64, kWidth, 20)];
    self.pageControl.numberOfPages = 2;
    self.pageControl.currentPageIndicatorTintColor = [UIColor qianweise];
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    [self.pageControl addTarget:self action:@selector(doTapPageC:) forControlEvents:UIControlEventValueChanged];
    
    
    self.scrollV.showsHorizontalScrollIndicator = NO;
    self.scrollV.delegate = self;
    self.scrollV.contentSize = CGSizeMake(kWidth*2, 0);
    self.scrollV.pagingEnabled = YES;
    [self.view addSubview:self.scrollV];
    [self.view addSubview:self.pageControl];
    
    self.titleArr = [NSMutableArray arrayWithObjects:@"孕妇注意事项", @"孕检指南", @"产后月子护理指南", @"产前准备", @"母乳喂养", @"宝宝胎教", @"宝宝起名", @"宝宝用品", @"辟谣", nil];
    self.nameArr = @[@"孕妇注意", @"孕检指南", @"月子护理", @"产前准备", @"母乳喂养", @"孕期食谱", @"产检时间", @"孕妇知识", @"孕期资讯"];
    self.imageArr = @[@"zhuyiy", @"yunjzn.png", @"yuezzn", @"chanqzhunbei.png", @"weiyang.png", @"shipuy.png", @"shikebiao.png", @"zhishiku.png", @"zixun.png"];
    self.labelArr = @[@"宝宝胎教", @"宝宝起名", @"宝宝服装",@"辟谣", @"星座性格"];
    self.photoAyy = @[@"jiaoyu.png", @"mingzi.png", @"yifu.png", @"piyao", @"xingzuo.png"];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == 6000) {
        return 9;
    } else {
        return 5;
    }
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BaikeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"baike" forIndexPath:indexPath];
    if (collectionView.tag == 6000) {
        cell.imageV.image = [UIImage imageNamed:self.imageArr[indexPath.item]];
        cell.labelL.text = self.nameArr[indexPath.item];
    }else {
        cell.imageV.image = [UIImage imageNamed:self.photoAyy[indexPath.item]];
        cell.labelL.text = self.labelArr[indexPath.item];
    }

    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TableBaseViewController *tablebaseVC = [[TableBaseViewController alloc] init];
    // 妈妈相关点击进入
    if (collectionView.tag == 6000) {
        if (indexPath.item == 7) {
            PregnantKnowledgeBaseViewController *knowledegVC = [[PregnantKnowledgeBaseViewController alloc] init];
            [self.navigationController pushViewController:knowledegVC animated:YES];
        } else if (indexPath.item < 5) {
            NSString *path = [[NSBundle mainBundle] pathForResource:self.titleArr[indexPath.item] ofType:@"plist"];
            NSArray *array = [NSArray arrayWithContentsOfFile:path];
            NSMutableArray *dictArr = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *dic in array) {
                [dictArr addObject:dic];
            }
            tablebaseVC.naviTitle = self.titleArr[indexPath.item];
            tablebaseVC.dictArr = dictArr;
            [self.navigationController pushViewController:tablebaseVC animated:YES];
        } else if (indexPath.item == 5) { // 孕期食谱
            YunQSPViewController *yunVC = [[YunQSPViewController alloc] init];
            
            [self.navigationController pushViewController:yunVC animated:YES];
        }else if (indexPath.item == 6){// 孕检时间表
            ChanJTimeViewController *chanjVC = [[ChanJTimeViewController alloc] init];
            [self.navigationController pushViewController:chanjVC animated:YES];
        }else if (indexPath.item == 8) {
            YunQZXViewController *yunQVC = [[YunQZXViewController alloc] init];
            [self.navigationController pushViewController:yunQVC animated:YES];
        }
    } else { // 宝宝相关点击进入
        if (indexPath.item < 4) {
        NSString *path = [[NSBundle mainBundle] pathForResource:self.titleArr[indexPath.item+5] ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *dictArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in array) {
            [dictArr addObject:dic];
        }
        tablebaseVC.naviTitle = self.titleArr[indexPath.item+5];
        tablebaseVC.dictArr = dictArr;
        [self.navigationController pushViewController:tablebaseVC animated:YES];
        
        }else{
            XZViewController *xzVC = [[XZViewController alloc] init];
            [self.navigationController pushViewController:xzVC animated:YES];
        }
    }
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == 0) {
        self.navigationItem.title = @"妈妈相关";
    } else {
        self.navigationItem.title = @"宝宝相关";
    }
    self.pageControl.currentPage = scrollView.contentOffset.x / kWidth;
}

//  pageControl方法
- (void)doTapPageC:(UIPageControl *)pageC {
    self.scrollV.contentOffset = CGPointMake(pageC.currentPage * kWidth, 0);
    if (pageC.currentPage == 0) {
        self.navigationItem.title = @"妈妈相关";
    } else {
        self.navigationItem.title = @"宝宝相关";
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
