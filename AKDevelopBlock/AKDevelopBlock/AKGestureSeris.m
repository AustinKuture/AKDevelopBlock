//
//  AKGestureSeris.m
//  AKDevelopBlock
//
//  Created by 李亚坤 on 2017/6/11.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "AKGestureSeris.h"
#import "XLSphereView.h"
#import "NSObject+AKGesture.h"

@interface AKGestureSeris ()

@property (nonatomic,strong) XLSphereView *sphereView;

@end

@implementation AKGestureSeris

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.bounces = NO;
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT + 20)];
    img.image = [UIImage imageNamed:@"sky_star"];
 
    [self.view addSubview:img];
    
    [self addGestureRecognizerInToView:self.tableView];
}


- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = NO;
}

@end
