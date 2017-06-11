//
//  AKImgResizeOne.m
//  AKDevelopBlock
//
//  Created by Kuture on 2017/6/11.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "AKImgResizeOne.h"
#import "UIImage+AKImgEx.h"

@interface AKImgResizeOne ()

@property (nonatomic,strong) UIImageView *img1;
@property (nonatomic,strong) UIImageView *img2;

@end

@implementation AKImgResizeOne

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0,SCREEN_HEIGHT + 100, 0);
    [self normalPicResize];
}

#pragma mark ***普通图像拉伸***
- (void)normalPicResize{
    
    UIButton *imgO = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.1, 60, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.3)];
    imgO.layer.borderColor = COLORS_BLUE.CGColor;
    imgO.layer.borderWidth = 1;
    imgO.layer.cornerRadius = 5;
    imgO.layer.masksToBounds = YES;
    [imgO setImage:[UIImage imageNamed:@"beauty_00"] forState:UIControlStateNormal];
    
    [self.view addSubview:imgO];
    
    //拉伸
    _img1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5, 80 + SCREEN_HEIGHT * 0.3, 0, 0)];
    
    _img1.alpha = 0;
    _img1.backgroundColor = COLORS_BLUE;
    _img1.layer.cornerRadius = 5;
    _img1.layer.masksToBounds = YES;
    _img1.image = [UIImage resizeWithImageName:@"beauty_00"];
    
    //拉伸标注
    UILabel *strachL = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 35)];
    strachL.text = @"比例拉伸视图";
    strachL.textColor = COLORS_BLUE;
    
    [_img1 addSubview:strachL];
    [self.view addSubview:_img1];
    
 
    //正常视图
    _img2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5, 80 + SCREEN_HEIGHT * 0.3, 0, 0)];
    
    _img2.alpha = 0;
    _img2.backgroundColor = COLORS_BLUE;
    _img2.layer.cornerRadius = 5;
    _img2.layer.masksToBounds = YES;
    _img2.image = [UIImage imageNamed:@"beauty_00"];
    
    //填充标注
    UILabel *strachL0 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 35)];
    strachL0.text = @"完全填充视图";
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
    
    [imgO addTarget:self action:@selector(strachCureenPicture:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)strachCureenPicture:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    
    
    if (btn.selected){
        
        [UIView animateWithDuration:1 animations:^{
            
            _img1.frame = CGRectMake(SCREEN_WIDTH * 0.1, 80 + SCREEN_HEIGHT * 0.3, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.3);
            _img1.alpha = 1;
            
            _img2.frame = CGRectMake(SCREEN_WIDTH * 0.5, 80 + SCREEN_HEIGHT * 0.3, 0, 0);
            _img2.alpha = 0;
        }];
    }else{
        
        [UIView animateWithDuration:1 animations:^{
            
            _img1.frame = CGRectMake(SCREEN_WIDTH * 0.5, 80 + SCREEN_HEIGHT * 0.3, 0, 0);
            _img1.alpha = 0;
            
            _img2.frame = CGRectMake(SCREEN_WIDTH * 0.1, 80 + SCREEN_HEIGHT * 0.3, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.3);
            _img2.alpha = 1;
        }];
    }
    
    
}












@end
