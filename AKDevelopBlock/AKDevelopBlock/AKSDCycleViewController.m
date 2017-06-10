//
//  AKSDCycleViewController.m
//  AKDevelopBlock
//
//  Created by 李亚坤 on 2017/5/31.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "AKSDCycleViewController.h"
#import "SDCycleScrollView.h"
#import "AKNewHotModel.h"

@interface AKSDCycleViewController ()<SDCycleScrollViewDelegate>

@end

@implementation AKSDCycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self scycleScrollView];
}

#pragma mark ***无限轮播***
- (void)scycleScrollView{
    
    UIScrollView *scrolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.3)];
    scrolView.backgroundColor = GROUNDSAME(242, 1);
    
    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, SCREEN_HEIGHT * 0.3) delegate:self placeholderImage:nil];
    cycleView.placeholderImage = [UIImage imageNamed:STR_RANDOM(@"rand", 7, 0)];
    cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    cycleView.pageControlAliment = SDCycleScrollViewPageContolStyleClassic;
    cycleView.autoScrollTimeInterval = 2.5;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@token=%@",API_NEW,@"1111111114"]];
    //    NSLog(@"URL:%@",url.absoluteString);
    
    AKNetPackegeAFN *packNet = [AKNetPackegeAFN shareHttpManager];
    [packNet netWorkType:AKNetWorkGET Signature:IRP_SIGNATURE API:url.absoluteString Parameters:nil RequestTimes:TIMES_OUT Success:^(id json) {
        
        NSArray *modelArray = [AKNewHotModel mj_objectArrayWithKeyValuesArray:json];
        NSMutableArray *titleArrayM = [NSMutableArray array];
        NSMutableArray *sdImgUrlArray = [NSMutableArray array];
        
        for (AKNewHotModel *model in modelArray) {
            
            [titleArrayM addObject:model.doctitle];
            [sdImgUrlArray addObject:[NSString stringWithFormat:@"%@%@",API_MAIN,model.docpuburl]];
//            [_sdCycleUrlArray addObject:[NSString stringWithFormat:@"%@token=%@&docid=%@",API_DETAIL,USERTOKEN,model.docid]];
        }
        
        cycleView.titlesGroup = titleArrayM;
        cycleView.imageURLStringsGroup = sdImgUrlArray;
//        [self mainKingInitSetting];
        
    } Fail:^(NSError *error) {
        
        NSLog(@"NetWork Error:%@",error);
    }];
    
    [scrolView addSubview:cycleView];
    self.tableView.tableHeaderView = scrolView;
}

//- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
//    
//    NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
//    [defaults setValue:@"" forKey:@"webUrlStr"];
//    [defaults setValue:_sdCycleUrlArray[index] forKey:@"webUrlStr"];
//    [defaults synchronize];
//    
//    
//    if (self.webUrlClick){
//        
//        self.webUrlClick(_sdCycleUrlArray[index]);
//    }
//    
//    MyLog(@"ShouYELunBo TestTing:=====%@",_sdCycleUrlArray[index]);
//}



@end
