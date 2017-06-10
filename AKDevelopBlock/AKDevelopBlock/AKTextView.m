//
//  AKTextView.m
//  AKDevelopBlock
//
//  Created by 李亚坤 on 2017/5/31.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "AKTextView.h"
#import "AKGuessCell.h"
#import "AKDateTrans.h"
#import "AKNewHotModel.h"
#import "AKNewHotCell.h"


@interface AKTextView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *personName;
@property (nonatomic,strong) NSMutableArray *comitTime;
@property (nonatomic,strong) NSMutableArray *partment;
@property (nonatomic,strong) NSMutableArray *projectTitle;
@property (nonatomic,strong) NSMutableArray *urlNewHot;

@end

@implementation AKTextView

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]){
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
        [self mutableArrayInitting];
        [self obtainDataFromNetWork];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.bounces = NO;
        self.delegate = self;
        self.dataSource = self;
    }
    
    return self;
}

- (void)mutableArrayInitting{
    
    _personName = [NSMutableArray array];
    _partment = [NSMutableArray array];
    _comitTime = [NSMutableArray array];
    _projectTitle = [NSMutableArray array];
    _urlNewHot = [NSMutableArray array];
}

#pragma mark -- 网络解析
- (void)obtainDataFromNetWork{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@token=%@",API_GUSS,@"1111111114"]];
    
    AKNetPackegeAFN *packNet = [AKNetPackegeAFN shareHttpManager];
    [packNet netWorkType:AKNetWorkPOST Signature:IRP_SIGNATURE API:url.absoluteString Parameters:nil RequestTimes:TIMES_OUT Success:^(id json) {
        
        MyLog(@"TextView=====%@",json);
        
        NSArray *newHotDic = [AKNewHotModel mj_objectArrayWithKeyValuesArray:json];
        AKDateTrans *dateT = [[AKDateTrans alloc]init];
        
        for (AKNewHotModel *model in newHotDic) {
            
            [_personName addObject:model.cruser];
            [_partment addObject:model.chnldesc];
            [dateT dateWithString:model.docpubtime DateTrans:^(NSString *s1) {
                
                [_comitTime addObject:s1];
            }];
            [_projectTitle addObject:model.doctitle];
            [_urlNewHot addObject:[NSString stringWithFormat:@"%@token=%@&docid=%@",API_DETAIL,USERTOKEN,model.docid]];
        }

        [self reloadData];
        
    } Fail:^(NSError *error) {
        
        NSLog(@"Error:%@",error);
    }];
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
    AKGuessCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell){
        
        cell = [[AKGuessCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    cell.projName.text = _projectTitle[indexPath.row];
    cell.partment.text = _partment[indexPath.row];
    cell.person.text = _personName[indexPath.row];
    cell.timeLabel.text = _comitTime[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
    [defaults setValue:@"" forKey:@"webUrlStr"];
    [defaults setValue:_urlNewHot[indexPath.row] forKey:@"webUrlStr"];
    [defaults synchronize];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"WEBURLPUBLICK" object:nil];
}
@end
