//
//  ViewController.m
//  AKDevelopBlock
//
//  Created by 李亚坤 on 2017/5/31.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+alvertVC.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *typeTableView;

@property (nonatomic,strong) NSArray *typeArray;
@property (nonatomic,strong) NSArray *classTypeArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self parmatersInitSetting];
    [self mutilTypeAndModel];
}

#pragma mark ***数据初始化***
- (void)parmatersInitSetting{
    
    _typeArray = @[@"知识类图文视图",@"知识类文本视图",@"图像嵌入文本类视图",@"图像浏览与动画加载类视图",@"登陆类视图样式一",@"登陆类视图样式二",@"无限轮播类视图",@"控制器内内弹窗",@"图像比例拉伸",@"图像蒙版",@"生成指定颜色图片",@"色彩渐变",@"微博功能按钮",@"缓存扫描及清理",@"快捷视图窗口",@"缩放旋转及拖动手势",@"3D标签"];
    _classTypeArray = @[@"AKViewAndTextViewController",@"AKKonwTextViewController",@"AKPhotoAndTextViewController",@"AKPhotoAndAnimationController",@"AKLoginTableView",@"AKLoginTableViewTwo",@"AKSDCycleViewController",@"",@"AKImgResizeOne",@"AKPicBlurViewController",@"AKColorsImageView",@"AKColorFade",@"AKWeiblogToolBar",@"AKCacheClean",@"AKPlusBtnController",@"AKGestureSeris",@"AK3DLabelView"];
}

#pragma mark ***类型与模块**
- (void)mutilTypeAndModel{
    
    _typeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _typeTableView.delegate = self;
    _typeTableView.dataSource = self;
    [self.view addSubview:_typeTableView];
}

#pragma mark ***实现tableview代理***
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _typeArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TypeCellID"];
    if (!cell){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TypeCellID"];
    }
    
    cell.textLabel.text = _typeArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"block_%ld",indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 7){
        
        [self alvertVCWithTitle:@"弹窗提示" message:@"控制器内弹窗" style:UIAlertControllerStyleAlert confirmBlock:^(UIAlertController *alvertVC) {
            
            
        } cancelBlock:^(UIAlertController *alvertVC) {
            
            [self alvertTipLabelWithString:@"弹窗成功提示" completeBLock:nil];
        } completeBlock:^{
            
            
        } leftCancelTitle:@"状态提示窗口" rightConfirmTitle:@"完成"];
    }else if (indexPath.row == 14){
        
        UIViewController *tabVC = [[NSClassFromString(_classTypeArray[indexPath.row]) alloc]init];
        
        tabVC.title = _typeArray[indexPath.row];
        [self presentViewController:tabVC animated:YES completion:nil];
        
    }else{
        
        UITableViewController *tabVC = [[NSClassFromString(_classTypeArray[indexPath.row]) alloc]init];
        
        tabVC.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tabVC.title = _typeArray[indexPath.row];
        
        [self.navigationController pushViewController:tabVC animated:YES];
    }
    
    
    
}
























@end
