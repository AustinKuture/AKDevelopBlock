//
//  AKLoginTableViewTwo.m
//  AKDevelopBlock
//
//  Created by 李亚坤 on 2017/5/31.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "AKLoginTableViewTwo.h"
#import "AKLoginViewTwo.h"

@interface AKLoginTableViewTwo ()

@end

@implementation AKLoginTableViewTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AKLoginViewTwo *loginV = [[AKLoginViewTwo alloc]initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:loginV];
}

@end
