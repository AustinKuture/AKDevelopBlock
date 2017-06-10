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

@end

@implementation AKImgResizeOne

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    self.tableView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT );
    
    
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
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.1, 80 + SCREEN_HEIGHT * 0.3, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.3)];
    img1.backgroundColor = COLORS_BLUE;
    img1.layer.cornerRadius = 5;
    img1.layer.masksToBounds = YES;
    
    img1.image = [UIImage resizeWithImageName:@"beauty_00"];
    
    [self.view addSubview:img1];
    
}














@end
