//
//  HomeViewController.m
//  helpQQ
//
//  Created by 何威亚 on 16/2/24.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "HomeViewController.h"
#import "RemindViewController.h"
#import "BaikeViewController.h"
#import "DiaryViewController.h"
//#import "UIView+SHCZExt.h"
#import "LeftViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    RemindViewController *remindVC = [[RemindViewController alloc] init];
    [self addChildViewController:remindVC title:@"提醒" image:@"remind.png" selectedImage:@"tixing.png"];
    
    DiaryViewController *diaryVC = [[DiaryViewController alloc] init];
    [self addChildViewController:diaryVC title:@"日记" image:@"diary.png" selectedImage:@"xie.png"];
    
    BaikeViewController *baikeVC = [[BaikeViewController alloc] init];
    [self addChildViewController:baikeVC title:@"百科" image:@"baike.png" selectedImage:nil];
   
   
//    [self addRecognizer];
   
//    NSLog(@"------%@------",self.view.subviews);

}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    childController.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:image];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    // tabbar未被点击的字体颜色
    textAttrs[NSForegroundColorAttributeName] = [UIColor qianweise];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    // 点击时的字体颜色
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor purpleColor];
    
    [childController.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:navi];
}
//// 添加手势
//- (void)addRecognizer{
//    //      添加拖拽
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanEvent:)];
//    [self.view addGestureRecognizer:pan];
//}
// 实现拖拽
/*
- (void)didPanEvent:(UIPanGestureRecognizer *)recognizer{
    
    // 1. 获取手指拖拽的时候平移的值
    CGPoint translation = [recognizer translationInView:[self.view.subviews objectAtIndex:1]];
    
    // 2. 让当前控件做相应的平移
    
    [self.view.subviews objectAtIndex:1].transform = CGAffineTransformTranslate([self.view.subviews objectAtIndex:1].transform, translation.x, 0);
    [self.view.subviews objectAtIndex:0].ttx = [self.view.subviews objectAtIndex: 1].ttx / 3;
    
    // 3. 每次平移手势识别完毕后，让平移的值不要累加
    [recognizer setTranslation:CGPointZero inView:[self.view.subviews objectAtIndex: 1]];
    
    //获取最右边范围
    CGAffineTransform  rightScopeTransform = CGAffineTransformTranslate(self.view.transform,[UIScreen mainScreen].bounds.size.width*0.75, 0);
    
    //    当移动到右边极限时
    if ([self.view.subviews objectAtIndex:1].transform.tx>rightScopeTransform.tx) {
        
        //        限制最右边的范围
        [self.view.subviews objectAtIndex:1].transform=rightScopeTransform;
        //        限制透明view最右边的范围
        [self.view.subviews objectAtIndex:0].ttx=[self.view.subviews objectAtIndex:1].ttx/3;
        
        //        当移动到左边极限时
    }else if ([self.view.subviews objectAtIndex:1].transform.tx<0.0){
        
        //        限制最左边的范围
        [self.view.subviews objectAtIndex:1].transform=CGAffineTransformTranslate(self.view.transform,0, 0);
        //    限制透明view最左边的范围
        [self.view.subviews objectAtIndex:0].ttx=[self.view.subviews objectAtIndex:1].ttx/3;
        
    }
    //    当托拽手势结束时执行
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:0.2 animations:^{
            
            if ([self.view.subviews objectAtIndex:1].x >[UIScreen mainScreen].bounds.size.width*0.5) {
                
                [self.view.subviews objectAtIndex:1].transform=rightScopeTransform;
                
                [self.view.subviews objectAtIndex:0].ttx=[self.view.subviews objectAtIndex:1].ttx/3;
                
            }else{
                
                [self.view.subviews objectAtIndex:1].transform = CGAffineTransformIdentity;
                
                [self.view.subviews objectAtIndex:0].ttx=[self.view.subviews objectAtIndex:1].ttx/3;
            }
        }];
    }
    
}
*/
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
