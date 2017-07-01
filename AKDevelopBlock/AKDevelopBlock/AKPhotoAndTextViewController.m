//
//  AKPhotoAndTextViewController.m
//  AKDevelopBlock
//
//  Created by 李亚坤 on 2017/5/31.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "AKPhotoAndTextViewController.h"
#import "AKScoreOrderView.h"

@interface AKPhotoAndTextViewController ()

@end

@implementation AKPhotoAndTextViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //图像嵌入文本类
    AKScoreOrderView *viewText = [AKScoreOrderView new];
    [self.view addSubview:viewText];
    [viewText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH / 4));
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
    }];

}


@end
