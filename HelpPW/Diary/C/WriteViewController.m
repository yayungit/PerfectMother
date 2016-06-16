//
//  WriteViewController.m
//  HelpPW
//
//  Created by BurNIng on 16/1/26.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "WriteViewController.h"
#import "DiaryHandle.h"
#import "DiaryModel.h"

@interface WriteViewController () <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIButton *photoB; // 添加图片按钮
@property (nonatomic, strong) NSMutableArray *photoArr; // 保存图片
@property (nonatomic, strong) UITextField *titleTF; // 标题
@property (nonatomic, strong) UITextView *textV; // 正文
@property (nonatomic, strong) UILabel *dateLabel; // 时间
@end

@implementation WriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor qianweise];

    self.view.backgroundColor = [UIColor whiteColor];
//  左返回按钮
    UIBarButtonItem *leftBack = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(doBack:)];
    self.navigationItem.leftBarButtonItem = leftBack;
//  右保存按钮
    UIBarButtonItem *rightSave = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(doSave:)];
    self.navigationItem.rightBarButtonItem = rightSave;

    UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeigth-64)];
    backV.backgroundColor = [UIColor cloudsColor];
    
    
    self.titleTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 25, kWidth - 40, 30)];
//    self.titleTF.borderStyle = UITextBorderStyleRoundedRect;
    self.titleTF.placeholder = @"记录每天好心情";
    [backV addSubview:self.titleTF];
    
    
//  正文TV
   self.textV = [[UITextView alloc] initWithFrame:CGRectMake(self.titleTF.frame.origin.x, self.titleTF.frame.origin.y+self.titleTF.frame.size.height+20, kWidth-self.titleTF.frame.origin.x-20, kHeigth/2)];
    self.textV.font = [UIFont systemFontOfSize:17];
    self.textV.textAlignment = NSTextAlignmentLeft;
    self.textV.delegate = self;
//    self.textV.layer.borderWidth = 0.3;
    self.textV.layer.cornerRadius = 10;
    [backV addSubview:self.textV];
    
//  拍照功能
    self.photoB = [UIButton buttonWithType:UIButtonTypeCustom];
    self.photoB.frame = CGRectMake(self.textV.frame.origin.x+10, self.textV.frame.origin.y+self.textV.frame.size.height+20, kWidth/4, kWidth/4);
    [self.photoB setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
    [self.photoB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.photoB addTarget:self action:@selector(doPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [backV addSubview:self.photoB];
    
//  显示日期
    // 获取创建时日期
    NSDate *createData = [NSDate dateWithTimeIntervalSinceNow:0];
   
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *createStr = [formatter stringFromDate:createData];
    // 显示在Label上
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.textV.frame.origin.x, self.photoB.frame.origin.y+self.photoB.frame.size.height+10, kWidth/2, 30)];
    self.dateLabel.adjustsFontSizeToFitWidth = YES;
    self.dateLabel.alpha = 0.6;
    self.dateLabel.text = createStr;
    [backV addSubview:self.dateLabel];
    
    
    [self.view addSubview:backV];

//  初始化可变数组
    self.photoArr = [NSMutableArray arrayWithCapacity:0];
    
    
    
    
    
}

//  左返回按钮事件
- (void)doBack:(UIBarButtonItem *)button {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
//  右保存按钮
- (void)doSave:(UIBarButtonItem *)button {
    NSData *data1 = [NSData data];
    NSData *data2 = [NSData data];
    NSData *data3 = [NSData data];
    if (self.photoArr.count ==1) {
        data1 = self.photoArr[0];
    } else if (self.photoArr.count ==2) {
        data1 = self.photoArr[0];
        data2 = self.photoArr[1];
    } else if (self.photoArr.count ==3) {
        data1 = self.photoArr[0];
        data2 = self.photoArr[1];
        data3 = self.photoArr[2];
    }
    DiaryModel *diary = [[DiaryModel alloc] initWithTitle:self.titleTF.text Content:self.textV.text Time:self.dateLabel.text PhotoData1:data1 PhotoData2:data2 PhotoData3:data3];
    if ([diary.title isEqualToString:@""] && [diary.content isEqualToString:@""] && diary.image1 == nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定没有想说的？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"保持一个良好心情哦" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"还是去写点" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];

    } else {
        [DiaryHandle insectInfoDiary:diary];
        _passBOOL(YES);
        [self dismissViewControllerAnimated:YES completion:nil];
    }

    
}
//  拍照按钮
- (void)doPhoto:(UIButton *)button {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"选取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *pickerC = [[UIImagePickerController alloc] init];
        pickerC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerC.delegate = self;
        pickerC.allowsEditing = self;
        [self.navigationController presentViewController:pickerC animated:YES completion:nil];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *pickerC = [[UIImagePickerController alloc] init];
            pickerC.sourceType = UIImagePickerControllerSourceTypeCamera;
            pickerC.delegate = self;
            pickerC.allowsEditing = self;
            [self presentViewController:pickerC animated:YES completion:nil];
        }
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertC addAction:action1];
    [alertC addAction:action2];
    [alertC addAction:action3];
    [self presentViewController:alertC animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.photoB.frame];
    imageV.image = image;
    [self.view addSubview:imageV];
    if (UIImagePNGRepresentation(image)) {
        [self.photoArr addObject:UIImagePNGRepresentation(image)];
    } else {
        [self.photoArr addObject:UIImageJPEGRepresentation(image, 1)];
    }
    
    self.photoB.frame = CGRectMake(imageV.frame.origin.x+imageV.frame.size.width+20, imageV.frame.origin.y, kWidth/4, kWidth/4);
//  当添加到三张图时 移除添加照片按钮
    if (self.photoArr.count == 3) {
        [self.photoB removeFromSuperview];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - UITextViewDelegate
//  点击空白收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
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
