//
//  AKColorsImageView.m
//  AKDevelopBlock
//
//  Created by 李亚坤 on 2017/6/11.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "AKColorsImageView.h"
#import "UIImage+AKImgEx.h"

@interface AKColorsImageView ()

@property (nonatomic,strong) UIImageView *colorImg;

@end

@implementation AKColorsImageView

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    [self setupColorsImg];
}

- (void)setupColorsImg{
    
    UIButton *colorBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 - 100, 100,200, 80)];
    colorBtn.layer.cornerRadius = 5;
    colorBtn.layer.masksToBounds = YES;
    colorBtn.backgroundColor = COLORS_RANDOM(1);
    [colorBtn setTitle:@"随机生成image" forState:UIControlStateNormal];
    [colorBtn setTitleColor:COLORS_RANDOM(1) forState:UIControlStateNormal];
    [colorBtn setTitleColor:COLORS_RANDOM(1) forState:UIControlStateSelected];
    
    [self.view addSubview:colorBtn];
    [colorBtn addTarget:self action:@selector(randomImgPic:) forControlEvents:UIControlEventTouchUpInside];
    
    //色彩图片
    UIImageView *colorImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.1, 30 + SCREEN_HEIGHT * 0.3, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.3)];
    colorImg.layer.cornerRadius = 5;
    colorImg.layer.masksToBounds = YES;
    _colorImg = colorImg;
    
    _colorImg.image = [UIImage createImageWithColor:COLORS_RANDOM(1) RectSize:CGSizeMake(SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.3) CornerRadius:5];
    [self.view addSubview:_colorImg];
}

- (void)randomImgPic:(UIButton *)btn{
    
    btn.backgroundColor = COLORS_RANDOM(1);
    [btn setTitleColor:COLORS_RANDOM(1) forState:UIControlStateNormal];
    [btn setTitleColor:COLORS_RANDOM(1) forState:UIControlStateSelected];

    _colorImg.image = [UIImage createImageWithColor:COLORS_RANDOM(1) RectSize:CGSizeMake(SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.3) CornerRadius:5];
   
}















@end
