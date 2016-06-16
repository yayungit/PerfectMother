//
//  DiaryDetailViewController.m
//  HelpPW
//
//  Created by BurNIng on 16/1/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DiaryDetailViewController.h"
#import "DiaryModel.h"
#import "PhotoViewController.h"
#import "DiaryChangeViewController.h"
#import "DiaryHandle.h"

@interface DiaryDetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIScrollView *scrollV;
@property (nonatomic, strong) UIImageView *imageV1;
@property (nonatomic, strong) UIImageView *imageV2;
@property (nonatomic, strong) UIImageView *imageV3;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *contentL;
@property (nonatomic, strong) UILabel *dateL;
@property (nonatomic, strong) UILabel *timeL;
@property (nonatomic, strong) UIScrollView *photoSV;
@property (nonatomic, strong) UITapGestureRecognizer *tapGR1;
@property (nonatomic, strong) UITapGestureRecognizer *tapGR2;
@property (nonatomic, strong) UITapGestureRecognizer *tapGR3;

@end

@implementation DiaryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cloudsColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor qianweise];
    
    UIBarButtonItem *leftBack = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(doBack:)];
    self.navigationItem.leftBarButtonItem = leftBack;
    
//  修改按钮
//    UIBarButtonItem *changeB = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(changeDiary:)];
//    self.navigationItem.rightBarButtonItem = changeB;
    
    //  创建按钮视图，放两个按钮。一个删除，一个编辑。
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //  日记按钮
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 8, 30, 30);
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(doDelete:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:button1];
    //  日历按钮
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(60, 8, 30, 30);
    [button2 setImage:[UIImage imageNamed:@"bianji"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(changeDiary:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:button2];
    //  添加到右边按钮上
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonView];
    
    
    
    
    self.scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeigth-64)];
    
//  滚动照片
    NSMutableArray *photoArr = [NSMutableArray arrayWithCapacity:0];
    if (self.diary.image1) {
        [photoArr addObject:self.diary.image1];
    }
    if (self.diary.image2) {
        [photoArr addObject:self.diary.image2];
    }
    if (self.diary.image3) {
        [photoArr addObject:self.diary.image3];
    }
    
    self.photoSV = [[UIScrollView alloc] init];
    if (photoArr.count > 0) {
        self.photoSV.frame = CGRectMake(0, 0, kWidth, kHeigth/3);
        self.photoSV.contentSize = CGSizeMake(kWidth*photoArr.count, kHeigth/3);
        self.photoSV.pagingEnabled = YES;
        self.photoSV.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:self.photoSV];
    }
    
    self.tapGR1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPhoto1:)];
    self.tapGR2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPhoto2:)];
    self.tapGR3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPhoto3:)];
    
    self.imageV1 = [[UIImageView alloc] init];
    if (self.diary.image1) {
        self.imageV1.frame = CGRectMake(0, 0, kWidth, self.diary.image1.size.height*(kWidth)/self.diary.image1.size.width);
        self.imageV1.userInteractionEnabled = YES;
        [self.imageV1 addGestureRecognizer:self.tapGR1];
        self.imageV1.image = self.diary.image1;
    }
    [self.photoSV addSubview:self.imageV1];
    
    self.imageV2 = [[UIImageView alloc] init];
    if (self.diary.image2) {
        self.imageV2.frame = CGRectMake(kWidth, 0, kWidth, self.diary.image2.size.height*(kWidth)/self.diary.image2.size.width);
        self.imageV2.userInteractionEnabled = YES;
        [self.imageV2 addGestureRecognizer:self.tapGR2];
        self.imageV2.image = self.diary.image2;
    }
    [self.photoSV addSubview:self.imageV2];
    
    self.imageV3 = [[UIImageView alloc] init];
    if (self.diary.image3) {
        self.imageV3.frame = CGRectMake(kWidth*2, 0, kWidth, self.diary.image3.size.height*(kWidth)/self.diary.image3.size.width);
        self.imageV3.userInteractionEnabled = YES;
        [self.imageV3 addGestureRecognizer:self.tapGR3];
        self.imageV3.image = self.diary.image3;
    }
    [self.photoSV addSubview:self.imageV3];
    
    [self.scrollV addSubview:self.photoSV];
    
    self.dateL = [[UILabel alloc] initWithFrame:CGRectMake(10, self.photoSV.frame.origin.y+self.photoSV.frame.size.height+10, 100, 20)];
    self.dateL.text = [self.diary.time substringToIndex:10];
    self.dateL.font = [UIFont systemFontOfSize:18];
    [self.dateL sizeToFit];
    self.dateL.alpha = 0.7;
    [self.scrollV addSubview:self.dateL];
    
    self.timeL = [[UILabel alloc] initWithFrame:CGRectMake(self.dateL.frame.origin.x+self.dateL.frame.size.width+10, self.photoSV.frame.origin.y+self.photoSV.frame.size.height+11, 100, 20)];
    self.timeL.text = [self.diary.time substringFromIndex:11];
    self.timeL.font = [UIFont systemFontOfSize:15];
    [self.timeL sizeToFit];
    self.timeL.alpha = 0.7;
    [self.scrollV addSubview:self.timeL];
    
    self.titleL = [[UILabel alloc] init];
    if (![self.diary.title isEqualToString:@""]) {
        self.titleL.text = self.diary.title;
        self.titleL.frame = CGRectMake(20, self.dateL.frame.origin.y+self.dateL.frame.size.height+10, kWidth-40, 20);
    } else {
        self.titleL.frame = CGRectMake(20, self.dateL.frame.origin.y+self.dateL.frame.size.height+10, kWidth-40, 0);
    }
    self.titleL.font = [UIFont systemFontOfSize:20];
    self.titleL.adjustsFontSizeToFitWidth = YES;
    self.titleL.textAlignment = NSTextAlignmentCenter;
    [self.scrollV addSubview:self.titleL];
    
    
    self.contentL = [[UILabel alloc] init];
    self.contentL.frame = CGRectMake(10, self.titleL.frame.origin.y+self.titleL.frame.size.height+10, kWidth-20, 0);
    self.contentL.text = self.diary.content;
    self.contentL.numberOfLines = 0;
    [self.contentL sizeToFit];
    [self.scrollV addSubview:self.contentL];
    
    
    self.scrollV.contentSize = CGSizeMake(kWidth, self.contentL.frame.origin.y+self.contentL.frame.size.height+10);
    
    [self.view addSubview:self.scrollV];
    
}
//  左返回按钮事件
- (void)doBack:(UIBarButtonItem *)button {
    _passBOOL(YES);
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

//  删除按钮
- (void)doDelete:(UIButton *)button {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认删除？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [DiaryHandle removeDiaryByTime:self.diary.time];
        _passBOOL(YES);
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }];
    [alert addAction:action];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];

}

//  编辑按钮事件
- (void)changeDiary:(UIButton *)barButton {
    DiaryChangeViewController *diaryChangeVC = [[DiaryChangeViewController alloc] init];
    diaryChangeVC.diaryM = self.diary;
    
    __block DiaryDetailViewController *ddvc = self;
    diaryChangeVC.passdiary = ^void(DiaryModel *diary) {
        NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:0];
        if (diary.image1) {
            ddvc.photoSV.frame = CGRectMake(0, 0, kWidth, kHeigth/3);
            ddvc.photoSV.pagingEnabled = YES;
            ddvc.photoSV.showsHorizontalScrollIndicator = NO;
            ddvc.imageV1.frame = CGRectMake(0, 0, kWidth, diary.image1.size.height*(kWidth)/diary.image1.size.width);
            ddvc.imageV1.image = diary.image1;
            ddvc.imageV1.userInteractionEnabled = YES;
            [ddvc.imageV1 addGestureRecognizer:ddvc.tapGR1];
            [imageArr addObject:diary.image1];
        } else {
            ddvc.photoSV.frame = CGRectMake(0, 0, 0, 0);
        }
        
        if (diary.image2) {
            ddvc.imageV2.frame = CGRectMake(kWidth, 0, kWidth, diary.image2.size.height*(kWidth)/diary.image2.size.width);
            ddvc.imageV2.image = diary.image2;
            ddvc.imageV2.userInteractionEnabled = YES;
            [ddvc.imageV2 addGestureRecognizer:ddvc.tapGR2];
            [imageArr addObject:diary.image2];
        }

        if (diary.image3) {
            ddvc.imageV3.frame = CGRectMake(kWidth*2, 0, kWidth, diary.image3.size.height*(kWidth)/diary.image3.size.width);
            ddvc.imageV3.image = diary.image3;
            ddvc.imageV3.userInteractionEnabled = YES;
            [ddvc.imageV3 addGestureRecognizer:ddvc.tapGR3];
            [imageArr addObject:diary.image3];
        }
    
        ddvc.photoSV.contentSize = CGSizeMake(kWidth*imageArr.count, kHeigth/3);
        
        ddvc.dateL.frame = CGRectMake(10, ddvc.photoSV.frame.origin.y+ddvc.photoSV.frame.size.height+10, 100, 20);
        ddvc.timeL.frame = CGRectMake(ddvc.dateL.frame.origin.x+ddvc.dateL.frame.size.width+10, ddvc.photoSV.frame.origin.y+ddvc.photoSV.frame.size.height+11, 100, 20);
        if (![diary.title isEqualToString:@""]) {
            ddvc.titleL.text = diary.title;
            ddvc.titleL.frame = CGRectMake(20, ddvc.dateL.frame.origin.y+ddvc.dateL.frame.size.height+10, kWidth-40, 20);
        } else {
            ddvc.titleL.frame = CGRectMake(20, ddvc.dateL.frame.origin.y+ddvc.dateL.frame.size.height+10, kWidth-40, 0);
        }
        
        ddvc.contentL.frame = CGRectMake(10, ddvc.titleL.frame.origin.y+ddvc.titleL.frame.size.height+10, kWidth-20, 0);
        ddvc.contentL.text = diary.content;
        ddvc.contentL.numberOfLines = 0;
        [ddvc.contentL sizeToFit];
        ddvc.scrollV.contentSize = CGSizeMake(kWidth, ddvc.contentL.frame.origin.y+ddvc.contentL.frame.size.height+10);
        ddvc.diary = diary;
    };
    [self.navigationController pushViewController:diaryChangeVC animated:YES];
}

//  点击图片 放大全屏查看
- (void)showPhoto1:(UITapGestureRecognizer *)tapGR {
    PhotoViewController *photoVC = [[PhotoViewController alloc] init];
    [self presentViewController:photoVC animated:YES completion:^{
        photoVC.image = self.diary.image1;
    }];
}
- (void)showPhoto2:(UITapGestureRecognizer *)tapGR {
    PhotoViewController *photoVC = [[PhotoViewController alloc] init];
    [self presentViewController:photoVC animated:YES completion:^{
        photoVC.image = self.diary.image2;
    }];
}
- (void)showPhoto3:(UITapGestureRecognizer *)tapGR {
    PhotoViewController *photoVC = [[PhotoViewController alloc] init];
    [self presentViewController:photoVC animated:YES completion:^{
        photoVC.image = self.diary.image3;
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
