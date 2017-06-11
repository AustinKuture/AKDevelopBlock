//
//  AKColorFade.m
//  AKDevelopBlock
//
//  Created by 李亚坤 on 2017/6/11.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "AKColorFade.h"
#import "AKanimationView.h"

@interface AKColorFade ()

@property (nonatomic,strong) UIView *fadeV;
@property (nonatomic,strong) AKanimationView *aniV;

@end

@implementation AKColorFade

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _aniV = [AKanimationView sharedAKanimationView];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 - 100, 20,200, 50)];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn setTitle:@"随机" forState:UIControlStateNormal];
    [btn setTitleColor:COLORS_WHITE forState:UIControlStateNormal];
    btn.backgroundColor = COLORS_BLUE;
    
    _fadeV = [_aniV fadeViewWithBeginColor:COLORS_RANDOM(1) MidelColor:COLORS_RANDOM(1) EndColor:COLORS_RANDOM(1) Frame:CGRectMake(20,70 , SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.7)];
    _fadeV.layer.cornerRadius = 5;
    _fadeV.layer.masksToBounds = YES;
    
    [btn addTarget:self action:@selector(setupColorsFade:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    [self.view addSubview:_fadeV];
}

- (void)setupColorsFade:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    if (btn.selected){
        
        [_fadeV removeFromSuperview];
        
    }else{
        
        _fadeV = [_aniV fadeViewWithBeginColor:COLORS_RANDOM(1) MidelColor:COLORS_RANDOM(1) EndColor:COLORS_RANDOM(1) Frame:CGRectMake(20,70 , SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.7)];
        _fadeV.layer.cornerRadius = 5;
        _fadeV.layer.masksToBounds = YES;
        
       [self.view addSubview:_fadeV];
    }
    
    
}




















@end
