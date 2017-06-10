//
//  AKScoreOrderView.m
//  AKIRPManage
//
//  Created by 李亚坤 on 2016/10/17.
//  Copyright © 2016年 李亚坤. All rights reserved.
//

#import "AKScoreOrderView.h"
#import "AKScoreOrderModel.h"

@interface AKScoreOrderView ()

@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic,strong) NSMutableArray *urlArray;
@property (nonatomic,strong) NSMutableArray *imgArray;
@property (nonatomic,strong) NSMutableArray *scoreArray;
@property (nonatomic) NSInteger count;

@end

@implementation AKScoreOrderView

- (NSMutableArray *)titleArray{
    
    if (!_titleArray){
        
        _titleArray = [NSMutableArray array];
    }
    
    return _titleArray;
}

- (NSMutableArray *)urlArray{
    
    if (!_urlArray){
        
        _urlArray = [NSMutableArray array];
    }
    
    return _urlArray;
}

- (NSMutableArray *)imgArray{
    
    if (!_imgArray){
        
        _imgArray = [NSMutableArray array];
    }
    
    return _imgArray;
}

- (NSMutableArray *)scoreArray{
    
    if (!_scoreArray){
        
        _scoreArray = [NSMutableArray array];
    }
    
    return _scoreArray;
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self){
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = GROUNDSAME(248, 1);
        self.bounces = NO;
        [self scoreOrderInitSetting];
        [self obtainDataFromNet];
    }
    
    return self;
}


#pragma mark ***数据初始化***
- (void)scoreOrderInitSetting{
    
    _titleArray = [NSMutableArray array];
    _urlArray = [NSMutableArray array];
    _imgArray = [NSMutableArray array];
    _scoreArray = [NSMutableArray array];
    
    _transScoreV = ^(float f1){
        //NSLog(@"Scroe 参数已传递:%f",f1);
    };
}

#pragma mark ***获取网络数据***
- (void)obtainDataFromNet{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@token=%@&dateType=1",API_USERRANK,@"1111111111"]];

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
               
        if (dict){
            NSArray *tempArray = [AKScoreOrderModel mj_objectArrayWithKeyValuesArray:dict];
//            
//            MyLog(@"+++++++++=====%@",dict);
        
            for (AKScoreOrderModel *model in tempArray) {
                
                [_titleArray addObject:model.truename];
                [_imgArray addObject:model.defaultUserPic];
                [_scoreArray addObject:model.sumscore];
            }
            
          
            //传递视图大小
            if (_titleArray.count > 0){
                
                _transScoreV((float)(_titleArray.count/4 + 1) * (SCREEN_WIDTH/4));
                self.frame = CGRectMake(0, 0, SCREEN_WIDTH, (float)(_titleArray.count/4 + 1) * (SCREEN_WIDTH/4));
                [self setButtonForScoreOrderView];
            }else{
                
                _transScoreV(0);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Error:%@",error);
    }];
}

#pragma mark ***内容布局***
- (void)setButtonForScoreOrderView{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSInteger count = 4;
    _count = count;
    float width;
    float widthY;
    float widthX;
    int x = 0;
    int y = 0;
    NSInteger indexA = _titleArray.count;
    if ((_titleArray.count%count)/count == 0){
        
        indexA = indexA + (count - _titleArray.count%count);
    }
    for (int i = 0;i<indexA;i++){
        
        width = SCREEN_WIDTH/_count;
        widthY = (i/_count) * width + i/_count;
        widthX = x * width;
        x++;
        if (x == _count){
            
            x = 0;
        }
        if (y == _count){
            y = 0;
        }
        
        btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(widthX + y  ,  widthY , width, width);
        y++;
        btn.backgroundColor = [UIColor whiteColor];
        if (i < _titleArray.count){
            [btn setTitle:[NSString stringWithFormat:@"%@",_titleArray[i]] forState:UIControlStateNormal];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(-SCREEN_HEIGHT * 10, -SCREEN_HEIGHT * 10, 0, 0)];
            
            UILabel *labelScore = [[UILabel alloc]initWithFrame:CGRectMake(0, width * 0.6, width, width * 0.2)];
            labelScore.text = _scoreArray[i];
            labelScore.textAlignment = ALIG_CENTER;
            labelScore.font = FONT_S(9);
            [labelScore setTextColor:BLUE_LOW];
            
            UILabel *labelB = [[UILabel alloc]init];
            labelB.frame = CGRectMake(0, width * 0.7, width, width *0.3);
            labelB.text = _titleArray[i];
            labelB.textAlignment = NSTextAlignmentCenter;
            [labelB setFont:[UIFont systemFontOfSize:15]];
            [labelB setTextColor:GROUNDSAME(130, 1)];
            
            UIImageView *imgB = [[UIImageView alloc]initWithFrame:CGRectMake(width/2 - 25,width * 0.15, 45, 45)];
            
            [imgB sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@&token=%@",API_MAIN,_imgArray[i],@"1111111111"]] placeholderImage:[UIImage imageNamed:@"male"]];
            imgB.layer.cornerRadius = 45/2;
            
            imgB.layer.masksToBounds = YES;
            
            [btn addSubview:labelScore];
            [btn addSubview:imgB];
            [btn addSubview:labelB];
        }
        
        [self addSubview:btn];
    }
}


@end
