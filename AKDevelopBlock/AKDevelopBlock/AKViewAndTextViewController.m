//
//  AKViewAndTextViewController.m
//  AKDevelopBlock
//
//  Created by 李亚坤 on 2017/5/31.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "AKViewAndTextViewController.h"
#import "AKNewHotView.h"

@interface AKViewAndTextViewController ()

@end

@implementation AKViewAndTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //图文视图
    AKNewHotView *viewText = [AKNewHotView new];
    [self.view addSubview:viewText];
    [viewText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 300));
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
    }];

}

@end
