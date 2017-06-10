//
//  AKLoginTableView.m
//  AKDevelopBlock
//
//  Created by 李亚坤 on 2017/5/31.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "AKLoginTableView.h"
#import "AKLoginView.h"

@interface AKLoginTableView ()

@end

@implementation AKLoginTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AKLoginView *loginV = [[AKLoginView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:loginV];
}


@end
