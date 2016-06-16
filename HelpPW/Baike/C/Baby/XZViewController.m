//
//  XZViewController.m
//  helpQQ
//
//  Created by 何威亚 on 16/3/3.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "XZViewController.h"
#import "BabyXZ.h"
#import "XZCollectionViewCell.h"
#import "XZDetailViewController.h"
#define kWdith [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
@interface XZViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BabyXZ *baby;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation XZViewController

- (NSMutableArray *)array{
    if (!_array) {
        self.array = [NSMutableArray array];
    }
    return _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    self.navigationItem.title = @"星座性格";
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kWdith / 2 - 20, kWdith / 3 - 20);
    layout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWdith, kHeight - 64) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor cloudsColor];
//    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[XZCollectionViewCell class] forCellWithReuseIdentifier:@"view"];
    
    
    // ==========
    [self getHandle];
}

//  获取数据
- (void)getHandle{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"星座宝宝性格" ofType:@"plist"];
    
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    
    for (NSDictionary *dic in arr) {
        self.baby = [[BabyXZ alloc] init];
        [self.baby setValuesForKeysWithDictionary:dic];
        [self.array addObject:self.baby];
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XZCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"view" forIndexPath:indexPath];
    cell.baby = self.array[indexPath.row];
    cell.backgroundColor = [UIColor colorWithRed:254.0/255.0 green:248.0/255.0 blue:218.0/255.0 alpha:1.0];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        XZDetailViewController *detailVC = [[XZDetailViewController alloc] init];
        BabyXZ *baby = self.array[indexPath.item];
        detailVC.babyDes = baby;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:detailVC];
     [self.navigationController presentViewController:nav animated:YES completion:^{
         
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
