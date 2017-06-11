//
//  AK3DLabelView.m
//  AKDevelopBlock
//
//  Created by 李亚坤 on 2017/6/11.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "AK3DLabelView.h"
#import "XLSphereView.h"
#import "NSObject+AKGesture.h"

@interface AK3DLabelView ()

@property (nonatomic,strong) XLSphereView *sphereView;

@end

@implementation AK3DLabelView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.bounces = NO;
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT + 20)];
    img.image = [UIImage imageNamed:@"sky_star"];
    
    CGFloat sphereViewW = self.view.frame.size.width - 30 * 2;
    CGFloat sphereViewH = sphereViewW;
    
    _sphereView = [[XLSphereView alloc] initWithFrame:CGRectMake(30, 100, sphereViewW, sphereViewH)];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSInteger i = 0; i < 50; i ++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:[NSString stringWithFormat:@"🍎%ld", i] forState:UIControlStateNormal];
        btn.backgroundColor = COLORS_RANDOM(1);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:24.];
        btn.frame = CGRectMake(0, 0, 60, 30);
        btn.layer.cornerRadius = 3;
        btn.clipsToBounds = YES;
        
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [array addObject:btn];
        
        [_sphereView addSubview:btn];
    }
    [_sphereView setItems:array];
    
    [self.view addSubview:img];
    [self.view addSubview:_sphereView];
    
    [self addGestureRecognizerInToView:self.tableView];
    
}

- (void)buttonPressed:(UIButton *)btn{
    [_sphereView timerStop];
    
    [UIView animateWithDuration:0.3 animations:^{
        btn.transform = CGAffineTransformMakeScale(2., 2.);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            btn.transform = CGAffineTransformMakeScale(1., 1.);
        } completion:^(BOOL finished) {
            [_sphereView timerStart];
        }];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = NO;
}






















@end
