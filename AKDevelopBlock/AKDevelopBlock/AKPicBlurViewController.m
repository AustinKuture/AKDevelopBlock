//
//  AKPicBlurViewController.m
//  AKDevelopBlock
//
//  Created by Kuture on 2017/6/11.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "AKPicBlurViewController.h"
#import "UIImage+AKImgEx.h"

@interface AKPicBlurViewController ()

@property (nonatomic,strong) UIImageView *img1;
@property (nonatomic,strong) UIImageView *img2;
@property (nonatomic,strong) UIButton *imgO;

@end

@implementation AKPicBlurViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self normalPicResize];
}

#pragma mark ***普通图像拉伸***
- (void)normalPicResize{
    
    _imgO = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.1, 60, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.3)];
    _imgO.layer.cornerRadius = 5;
    _imgO.layer.masksToBounds = YES;
    [_imgO setImage:[UIImage imageNamed:@"blur_00"] forState:UIControlStateNormal];
    
    [self.view addSubview:_imgO];
    
    //拉伸
    _img1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5, 80 + SCREEN_HEIGHT * 0.3, 0, 0)];
    
    _img1.alpha = 0;
    _img1.backgroundColor = COLORS_BLUE;
    _img1.layer.cornerRadius = 5;
    _img1.layer.masksToBounds = YES;
    _img1.image = [UIImage imageNamed:@"blur_00"];
    _img1.image = [UIImage blurryImage:_img1.image withBlurLevel:0.5];
    
    
    //拉伸标注
    UILabel *strachL = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 35)];
    strachL.text = @"图像蒙版一 模糊度:0.5";
    strachL.textColor = COLORS_BLUE;
    
    [_img1 addSubview:strachL];
    [self.view addSubview:_img1];
    
    
    //正常视图
    _img2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5, 80 + SCREEN_HEIGHT * 0.3, 0, 0)];
    
    _img2.alpha = 0;
    _img2.backgroundColor = COLORS_BLUE;
    _img2.layer.cornerRadius = 5;
    _img2.layer.masksToBounds = YES;
    _img2.image = [UIImage imageNamed:@"blur_01"];
    _img2.image = [UIImage blurryImage:_img2.image withBlurLevel:0.3];
    
    //填充标注
    UILabel *strachL0 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 35)];
    strachL0.text = @"图像蒙版二 模糊度:0.3";
    strachL0.textColor = COLORS_BLUE;
    
    [_img2 addSubview:strachL0];
    [self.view addSubview:_img2];
    
    //边框
    UILabel *borderL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.1, 80 + SCREEN_HEIGHT * 0.3, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.3)];
    borderL.layer.borderColor = COLORS_BLUE.CGColor;
    borderL.layer.borderWidth = 1;
    borderL.layer.cornerRadius = 5;
    borderL.layer.masksToBounds = YES;
    
    [self.view addSubview:borderL];
    
    [_imgO addTarget:self action:@selector(strachCureenPicture:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)strachCureenPicture:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    
    
    if (btn.selected){
        
        [UIView animateWithDuration:1 animations:^{
            
            [_imgO setImage:[UIImage imageNamed:@"blur_00"] forState:UIControlStateNormal];
            _img1.frame = CGRectMake(SCREEN_WIDTH * 0.1, 80 + SCREEN_HEIGHT * 0.3, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.3);
            _img1.alpha = 1;
            
            _img2.frame = CGRectMake(SCREEN_WIDTH * 0.5, 80 + SCREEN_HEIGHT * 0.3, 0, 0);
            _img2.alpha = 0;
        }];
    }else{
        
        [UIView animateWithDuration:1 animations:^{
            
            [_imgO setImage:[UIImage imageNamed:@"blur_01"] forState:UIControlStateNormal];
            _img1.frame = CGRectMake(SCREEN_WIDTH * 0.5, 80 + SCREEN_HEIGHT * 0.3, 0, 0);
            _img1.alpha = 0;
            
            _img2.frame = CGRectMake(SCREEN_WIDTH * 0.1, 80 + SCREEN_HEIGHT * 0.3, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.3);
            _img2.alpha = 1;
        }];
    }
    
    
}

























@end
