//
//  AKKonwTextViewController.m
//  AKDevelopBlock
//
//  Created by 李亚坤 on 2017/5/31.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "AKKonwTextViewController.h"
#import "AKTextView.h"

@interface AKKonwTextViewController ()

@end

@implementation AKKonwTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //文本视图
    AKTextView *textV = [AKTextView new];
    [self.view addSubview:textV];
    [textV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 300));
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left);
    }];

}


@end
