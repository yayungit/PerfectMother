//
//  DiaryChangeViewController.m
//  HelpPW
//
//  Created by BurNIng on 16/2/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DiaryChangeViewController.h"
#import "DiaryModel.h"
#import "DiaryHandle.h"

@interface DiaryChangeViewController () <UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITextField *titleTF;
@property (nonatomic, strong) UITextView *textV;
@property (nonatomic, assign) NSInteger buttonTag;
@property (nonatomic, strong) UIButton *addB; // 添加图片按钮
@property (nonatomic, strong) NSMutableArray *pictureArr; // 图片数组
@property (nonatomic, strong) NSMutableArray *buttonArr; // 按钮  
@end

@implementation DiaryChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor cloudsColor];
    
    self.titleTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, kWidth-40, 30)];
    self.titleTF.text = self.diaryM.title;
    self.titleTF.borderStyle = UITextBorderStyleRoundedRect;
    self.titleTF.textAlignment = NSTextAlignmentCenter;
    self.titleTF.placeholder = @"写点什么呢";
    self.titleTF.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.titleTF];
    

    self.textV = [[UITextView alloc] initWithFrame:CGRectMake(20, self.titleTF.frame.origin.y+self.titleTF.frame.size.height+10, kWidth-40, kHeigth/3)];
    self.textV.delegate = self;
    self.textV.text = self.diaryM.content;
    self.textV.layer.cornerRadius = 10;
    self.textV.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:self.textV];
    
    /*
    UITapGestureRecognizer *tapGR1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePhoto:)];
    UITapGestureRecognizer *tapGR2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePhoto:)];
    UITapGestureRecognizer *tapGR3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePhoto:)];
    
    self.photoB = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(self.textV.frame.origin.x+10, self.textV.frame.origin.y+self.textV.frame.size.height + 20, kWidth/4, kWidth/4)];
    if (self.diaryM.image1) {
        self.imageV1.image = self.diaryM.image1;
        [self.imageV1 addGestureRecognizer:tapGR1];
        self.imageV1.userInteractionEnabled = YES;
        [self.view addSubview:self.imageV1];
    } else {
        self.photoB.frame = CGRectMake(self.textV.frame.origin.x+10, self.textV.frame.origin.y+self.textV.frame.size.height+20, kWidth/4, kWidth/4);
        [self.photoB setImage:[UIImage imageNamed:@"addPhoto"] forState:UIControlStateNormal];
        [self.photoB addTarget:self action:@selector(chosePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.photoB];
    }

    self.imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(10+self.imageV1.frame.origin.x+self.imageV1.frame.size.width, self.textV.frame.origin.y+self.textV.frame.size.height + 20, kWidth/4, kWidth/4)];
    if (self.diaryM.image2) {
        self.imageV2.image = self.diaryM.image2;
        [self.imageV2 addGestureRecognizer:tapGR2];
        self.imageV2.userInteractionEnabled = YES;
        [self.view addSubview:self.imageV2];
    } else {
        self.photoB.frame = CGRectMake(10+self.imageV1.frame.origin.x+self.imageV1.frame.size.width, self.textV.frame.origin.y+self.textV.frame.size.height + 20, kWidth/4, kWidth/4);
        [self.photoB setImage:[UIImage imageNamed:@"addPhoto"] forState:UIControlStateNormal];
        [self.photoB addTarget:self action:@selector(chosePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.photoB];
    }
    
    self.imageV3 = [[UIImageView alloc] initWithFrame:CGRectMake(10+self.imageV2.frame.origin.x+self.imageV2.frame.size.width, self.textV.frame.origin.y+self.textV.frame.size.height + 20, kWidth/4, kWidth/4)];
    if (self.diaryM.image3) {
        self.imageV3.image = self.diaryM.image3;
        [self.imageV3 addGestureRecognizer:tapGR3];
        self.imageV3.userInteractionEnabled = YES;
        [self.view addSubview:self.imageV3];
    } else {
        self.photoB.frame = CGRectMake(10+self.imageV2.frame.origin.x+self.imageV2.frame.size.width, self.textV.frame.origin.y+self.textV.frame.size.height + 20, kWidth/4, kWidth/4);
        [self.photoB setImage:[UIImage imageNamed:@"addPhoto"] forState:UIControlStateNormal];
        [self.photoB addTarget:self action:@selector(chosePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.photoB];
    }
    
    */
    
    self.pictureArr = [NSMutableArray arrayWithCapacity:0];
    if (self.diaryM.image1) {
        [self.pictureArr addObject:self.diaryM.image1];
    }
    if (self.diaryM.image2) {
        [self.pictureArr addObject:self.diaryM.image2];
    }
    if (self.diaryM.image3) {
        [self.pictureArr addObject:self.diaryM.image3];
    }
    
    
    self.buttonArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < self.pictureArr.count; i++) {
        UIButton *imageB = [UIButton buttonWithType:UIButtonTypeCustom];
        imageB.tag = 2000+i;
        imageB.frame = CGRectMake(self.textV.frame.origin.x+(kWidth/4+20)*i, self.textV.frame.origin.y+self.textV.frame.size.height+10, kWidth/4, kWidth/4);
        [imageB setImage:self.pictureArr[i] forState:UIControlStateNormal];
        [imageB addTarget:self action:@selector(changePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArr addObject:imageB];
        [self.view addSubview:imageB];
    }
    
    self.addB = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self.pictureArr.count != 3) {
        self.addB.tag = 2500;
        self.addB.frame = CGRectMake(self.textV.frame.origin.x+(kWidth/4+20)*self.pictureArr.count, self.textV.frame.origin.y+self.textV.frame.size.height+10, kWidth/4, kWidth/4);
        [self.addB setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
        [self.addB addTarget:self action:@selector(addPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.addB];
    }
    
    
    //  左返回按钮
    UIBarButtonItem *leftBack = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(doBack:)];
    self.navigationItem.leftBarButtonItem = leftBack;
    //  右保存按钮
    UIBarButtonItem *rightSave = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(doSave:)];
    self.navigationItem.rightBarButtonItem = rightSave;
    
    
}

- (void)doBack:(UIBarButtonItem *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doSave:(UIBarButtonItem *)button {
    
    [self.view endEditing:YES];
    
    NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:3];
    for (int i = 0; i < self.pictureArr.count; i++) {
        NSData *data = [NSData data];
        if (UIImagePNGRepresentation(self.pictureArr[i])) {
            data = UIImagePNGRepresentation(self.pictureArr[i]);
        } else {
            data = UIImageJPEGRepresentation(self.pictureArr[i], 1);
        }
        [dataArr addObject:data];
    }
    for (int i = (int)self.pictureArr.count ; i < 3; i++) {
        NSData *data = [NSData data];
        [dataArr addObject:data];
    }
    
    DiaryModel *diary = [[DiaryModel alloc] initWithTitle:self.titleTF.text Content:self.textV.text Time:self.diaryM.time PhotoData1:dataArr[0] PhotoData2:dataArr[1] PhotoData3:dataArr[2]];
    [DiaryHandle updateDiaryByTime:diary.time WithDiary:diary];
    _passdiary(diary);
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UITextViewDelegate
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

//  改变图片事件
- (void)changePhoto:(UIButton *)button {
    self.buttonTag = button.tag;
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"选取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *pickerC = [[UIImagePickerController alloc] init];
        pickerC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerC.delegate = self;
        pickerC.allowsEditing = self;
        [self.navigationController presentViewController:pickerC animated:YES completion:nil];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [button removeFromSuperview];
        [self.buttonArr removeObjectAtIndex:button.tag%2000];
        [self.pictureArr removeObjectAtIndex:button.tag%2000];
        for (int i = 0; i < self.pictureArr.count; i++) {
            UIButton *imageB = self.buttonArr[i];
            imageB.tag = 2000+i;
            imageB.frame = CGRectMake(self.textV.frame.origin.x+(kWidth/4+20)*i, self.textV.frame.origin.y+self.textV.frame.size.height+10, kWidth/4, kWidth/4);
            [imageB setImage:self.pictureArr[i] forState:UIControlStateNormal];
            [imageB addTarget:self action:@selector(changePhoto:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        if (self.pictureArr.count != 3) {
            self.addB.tag = 2500;
            self.addB.frame = CGRectMake(self.textV.frame.origin.x+(kWidth/4+20)*self.pictureArr.count, self.textV.frame.origin.y+self.textV.frame.size.height+10, kWidth/4, kWidth/4);
            [self.addB setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
            [self.addB addTarget:self action:@selector(addPhoto:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.addB];
        }
        
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertC addAction:action1];
    [alertC addAction:action2];
    [alertC addAction:action3];
    [self presentViewController:alertC animated:YES completion:nil];
}

//  相册
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0) {
    if(self.buttonTag != 2500) {
        UIButton *button = [self.view viewWithTag:self.buttonTag];
        [button setImage:image forState:UIControlStateNormal];
        [self.pictureArr replaceObjectAtIndex:button.tag%2000 withObject:image];
        [picker dismissViewControllerAnimated:YES completion:^{
        }];
    } else {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 2000+self.buttonArr.count;
        [button addTarget:self action:@selector(changePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArr addObject:button];
        [self.pictureArr addObject:image];
        button.frame = self.addB.frame;
        [button setImage:image forState:UIControlStateNormal];
        [self.view addSubview:button];
        //  当添加到三张图时 移除添加照片按钮
        if (self.buttonArr.count == 3) {
            [self.addB removeFromSuperview];
        } else {
            self.addB.frame = CGRectMake(button.frame.origin.x+button.frame.size.width+20, button.frame.origin.y, kWidth/4, kWidth/4);
        }
        [picker dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

//  添加图片事件
- (void)addPhoto:(UIButton *)button {
    self.buttonTag = button.tag;
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
