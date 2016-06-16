//
//  PhotoViewController.m
//  HelpPW
//
//  Created by BurNIng on 16/1/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollV;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, assign) BOOL mark;
@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTapDismiss:)];
    [tapGR setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapGR];
    
    UITapGestureRecognizer *doubleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doDoubleTap:)];
    [doubleTapGR setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTapGR];
    
    [tapGR requireGestureRecognizerToFail:doubleTapGR];
    
    self.mark = YES;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeigth)];
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, (kHeigth-image.size.height*kWidth/image.size.width)/2, kWidth, image.size.height*kWidth/image.size.width)];
    self.scrollV.bounces = NO;
    self.scrollV.delegate = self;
    self.scrollV.minimumZoomScale = 1;
    self.scrollV.maximumZoomScale = 3;
    self.imageV.image = image;
    [self.scrollV addSubview:self.imageV];
    [self.view addSubview:self.scrollV];
}

- (void)doTapDismiss:(UITapGestureRecognizer *)tapGR {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doDoubleTap:(UITapGestureRecognizer *)doubleTap {
    if (self.mark == YES) {
        CGFloat y = kHeigth-self.image.size.height*kWidth/self.image.size.width*2;
        if (y < 0) {
            y = 0;
        }
        self.imageV.frame = CGRectMake(0, y/2, kWidth*2, self.image.size.height*kWidth/self.image.size.width*2);
        self.scrollV.contentSize = CGSizeMake(kWidth*2, self.image.size.height*kWidth/self.image.size.width*2);
        self.mark = NO;
    } else {
        CGFloat y = kHeigth-self.image.size.height*kWidth/self.image.size.width;
        if (y < 0) {
            y = 0;
        }
        self.imageV.frame = CGRectMake(0, y/2, kWidth, self.image.size.height*kWidth/self.image.size.width);
        self.scrollV.contentSize = CGSizeMake(kWidth, self.image.size.height*kWidth/self.image.size.width);
        self.mark = YES;
    }
}

#pragma mark - UIScrollViewDelegate
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return scrollView.subviews[0];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    CGFloat y = kHeigth-self.image.size.height*kWidth/self.image.size.width*scale;
    if (y < 0) {
        y = 0;
    }
    self.imageV.frame = CGRectMake(0, y/2, kWidth*scale, self.image.size.height*kWidth/self.image.size.width*scale);
    self.scrollV.contentSize = CGSizeMake(kWidth*scale, self.image.size.height*kWidth/self.image.size.width*scale);
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
