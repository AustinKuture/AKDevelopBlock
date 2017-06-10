//
//  ViewController.m
//  AKDevelopBlock
//
//  Created by 李亚坤 on 2017/5/31.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "ViewController.h"


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
    
    _typeArray = @[@"知识类图文视图",@"知识类文本视图",@"图像嵌入文本类视图",@"图像浏览与动画加载类视图",@"登陆类视图样式一",@"登陆类视图样式二",@"无限轮播类视图"];
    _classTypeArray = @[@"AKViewAndTextViewController",@"AKKonwTextViewController",@"AKPhotoAndTextViewController",@"AKPhotoAndAnimationController",@"AKLoginTableView",@"AKLoginTableViewTwo",@"AKSDCycleViewController"];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TypeCellID"];
    if (!cell){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TypeCellID"];
    }
    
    cell.textLabel.text = _typeArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewController *tabVC = [[NSClassFromString(_classTypeArray[indexPath.row]) alloc]init];
    
    tabVC.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabVC.title = _typeArray[indexPath.row];
    
    [self.navigationController pushViewController:tabVC animated:YES];
    
}
























@end
