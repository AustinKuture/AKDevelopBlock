//
//  AKNewHotView.m
//  AKIRPManage
//
//  Created by 李亚坤 on 2016/10/17.
//  Copyright © 2016年 李亚坤. All rights reserved.
//

#import "AKNewHotView.h"
#import "AKNewHotCell.h"
#import "AKNewHotModel.h"
#import "AKDateTrans.h"

@interface AKNewHotView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *personName;
@property (nonatomic,strong) NSMutableArray *comitTime;
@property (nonatomic,strong) NSMutableArray *partment;
@property (nonatomic,strong) NSMutableArray *projectTitle;
@property (nonatomic,strong) NSMutableArray *urlNewHot;
@property (nonatomic,strong) NSMutableArray *imgUrl;


@end

@implementation AKNewHotView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self){
        
//        self.separatorStyle = UITableViewCellSeparatorStyleNone;
//        self.bounces = NO;
        
        self.delegate = self;
        self.dataSource = self;
        [self mutableArrayInitting];
        [self obtainDataFromNetWork];
    }
    
    return self;
}

#pragma mark ***数组初始化***
- (void)mutableArrayInitting{
    
    _personName = [NSMutableArray array];
    _partment = [NSMutableArray array];
    _comitTime = [NSMutableArray array];
    _projectTitle = [NSMutableArray array];
    _urlNewHot = [NSMutableArray array];
    _imgUrl = [NSMutableArray array];

    _transHotV = ^(float s2){
        NSLog(@"NewHot 参数已传递:%f",s2);
    };
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _personName.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid = @"cellID";
    AKNewHotCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell){
        
        cell = [[AKNewHotCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    [cell.picView sd_setImageWithURL:_imgUrl[indexPath.row] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"rand%d",arc4random_uniform(7)]]];
    cell.projName.text = _projectTitle[indexPath.row];
    cell.partment.text = _partment[indexPath.row];
    cell.person.text = _personName[indexPath.row];
    cell.timeLabel.text = _comitTime[indexPath.row];
    
    
    return cell;
}

#pragma mark ***tableView点击方法***
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark  -- 解析网络数据并判断网络是否开启
- (void)obtainDataFromNetWork{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@token=%@",API_NEWHOT,@"1111111114"]];
    MyLog(@"=======URL:%@",url);
    
    AKNetPackegeAFN *packNet = [AKNetPackegeAFN shareHttpManager];
    [packNet netWorkType:AKNetWorkGET Signature:IRP_SIGNATURE API:url.absoluteString Parameters:nil RequestTimes:TIMES_OUT Success:^(id json) {
        
        MyLog(@"=====%@",json);
        
        NSArray *newHotDic = [AKNewHotModel mj_objectArrayWithKeyValuesArray:json];
        AKDateTrans *dateT = [[AKDateTrans alloc]init];
        
        for (AKNewHotModel *model in newHotDic) {
            
            [_personName addObject:model.cruser];
            [_partment addObject:model.chnldesc];
            [dateT dateWithString:model.docpubtime DateTrans:^(NSString *s1) {
                
                [_comitTime addObject:s1];
            }];
            
            [_projectTitle addObject:model.doctitle];
            [_imgUrl addObject:[NSString stringWithFormat:@"%@%@",API_MAIN,model.docpuburl]];
            [_urlNewHot addObject:[NSString stringWithFormat:@"%@token=%@&docid=%@",API_DETAIL,@"1111111114",model.docid]];
        }
        
        //                _transHotV((float)_personName.count * 60);
        //                self.frame = CGRectMake(0, 0, SCREEN_WIDTH, (float)_personName.count * 60);
        
        [self reloadData];
        
    } Fail:^(NSError *error) {
        
        NSLog(@"Error:%@",error);
    }];
    
}






@end
