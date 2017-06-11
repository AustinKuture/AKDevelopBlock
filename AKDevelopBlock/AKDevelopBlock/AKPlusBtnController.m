//
//  AKPlusBtnController.m
//  AKIRPManage
//
//  Created by 李亚坤 on 16/9/18.
//  Copyright © 2016年 李亚坤. All rights reserved.
//

#import "AKPlusBtnController.h"
#import "AKWeatherView.h"
//#import "AKWorkBenchController.h"
//#import "AKSignInController.h"

@interface AKPlusBtnController ()

@property (nonatomic,strong) UIImageView *outView;
@property (nonatomic,strong) UIView *btnView;
@property (nonatomic,copy) NSString *dateSStr;

@end

@implementation AKPlusBtnController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = COLORS_WHITE;
    [self weatehrView];
    [self outLittleView];
    [self fastBtnView];
}

#pragma mark ***天气视图***
- (void)weatehrView{
    
    AKWeatherView *wtV = [[AKWeatherView alloc]init];
    [self.view addSubview:wtV];
    [wtV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(self.view.mas_top).offset(50);
    }];
    
    UILabel *dateTT = [[UILabel alloc]init];
    NSString *dateSStr = [[NSString alloc]init];
    _dateSStr = dateSStr;

    //延时
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //过滤不用信息
//        for (int i = 0;i<=31;i++){
//            
//            _dateSStr = [wtV.WeatherSTR stringByReplacingOccurrencesOfString:@"日" withString:@""];
//            wtV.WeatherSTR = [_dateSStr stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%d",i] withString:@""];
//            _dateSStr = wtV.WeatherSTR;
//        }
        
        //日期标签
//        wtV.WeatherSTR == nil ?dateTT.text = @"":(dateTT.text = _dateSStr);
        dateTT.text = [self currentWeekData];
        dateTT.font = FONT_S(25);
        dateTT.textColor = GROUNDSAME(150, 1);
        [self.view addSubview:dateTT];
        [dateTT mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(100, 50));
            make.left.equalTo(wtV.mas_left).offset(20);
            make.bottom.equalTo(wtV.mas_top).offset(80);
        }];
        
        //城市Label
        UILabel *cityLabel = [[UILabel alloc]init];
        cityLabel.text = wtV.cityName;
        cityLabel.font = FONT_S(19);
        cityLabel.textColor = GROUNDSAME(150, 1);
        cityLabel.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:cityLabel];
        [cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(80, 50));
            make.right.equalTo(wtV.mas_right).offset(-25);
            make.bottom.equalTo(dateTT.mas_bottom);
        }];
    });
}

#pragma mark ***按钮视图***
- (void)fastBtnView{
    
    NSArray *btnA = @[@"scenery_00",@"scenery_01",@"scenery_02"];
    NSArray *labelA = @[@"风景",@"美",@"如画"];
    
    for (int i = 0;i<3;i++){
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * i + 1, SCREEN_HEIGHT * 0.35, SCREEN_WIDTH/3 -2, SCREEN_WIDTH/3 -1)];
        btn.tag = i;
        
        UIImageView *imageView = [[UIImageView alloc]init];
//        if (btn.tag == 1){
            
            imageView.layer.cornerRadius = (btn.bounds.size.width * 0.6) * 0.5;
            imageView.layer.masksToBounds = YES;
//        }
        
        [btn addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(btn.bounds.size.width * 0.6,btn.bounds.size.width * 0.6));
            make.centerX.equalTo(btn.mas_centerX);
            make.centerY.equalTo(btn.mas_centerY).offset(-20);
        }];
        
        UILabel *label = [[UILabel alloc]init];
        [btn addSubview:label];
        
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(70, 40));
            make.centerX.equalTo(btn.mas_centerX);
            make.top.equalTo(imageView.mas_bottom).offset(10);
        }];
        label.text = labelA[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = NO;
        [label setTextColor:GROUNDSAME(185, 1)];
        imageView.image = [UIImage imageNamed:btnA[i]];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC * (i + 1) * 0.2)), dispatch_get_main_queue(), ^{
            
            shootOutAnimationBTN(btn, 3, 80 - 30 * i , btn.frame, 3);
        });
        
    
        [self.view addSubview:btn];
    }
}

#pragma mark ***结束当前视图推出新视图***
- (void)clickBtn:(UIButton *)btn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ***底部视图***
- (void)outLittleView{
    
    UIButton *littleV = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    littleV.backgroundColor = GROUNDSAME(245, 1);
    [littleV addTarget:self action:@selector(dismissBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *outView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 - 15, 5, 30, 30)];
    outView.image = [UIImage imageNamed:@"080"];
    _outView = outView;
    
    shootOutAnimation(_outView, 2, 30, outView.frame, 2);
    [littleV addSubview:_outView];
    [self.view addSubview:littleV];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissBtn];
}

#pragma mark ***视图跳动动画***
void shootOutAnimation(UIView *view ,int n,float height,CGRect frame,float num) {
    
    //view,动画视图
    //n,跳动次数
    //height,跳动高度
    //fram,视图fram
    //num,参数与n保持一致
    
    if (n<0) {
        
        return;
    }
    
    n = n-1;
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        view.frame = CGRectMake(frame.origin.x, frame.origin.y-((n%2)?0:(n+2)*(height/num)), frame.size.width, frame.size.height);
        view.transform = CGAffineTransformMakeRotation(- n * M_PI_2);
    } completion:^(BOOL finished) {
        
        shootOutAnimation(view, n, height, frame, num);
    }];
}

void shootOutAnimationBTN(UIView *view ,int n,float height,CGRect frame,float num) {
    
    if (n<0) {
        
        return;
    }
    
    n = n-1;
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        view.frame = CGRectMake(frame.origin.x, frame.origin.y-((n%2)?0:(n+2)*(height/num)), frame.size.width, frame.size.height);
    } completion:^(BOOL finished) {
        
        shootOutAnimationBTN(view, n, height, frame, num);
    }];
}

#pragma mark ***推出方法***
- (void)dismissBtn{
    
    [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        _outView.transform = CGAffineTransformMakeRotation(-7 * M_PI_4);
    } completion:^(BOOL finished) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

//- (void)viewWillAppear:(BOOL)animated{
//    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
//}

#pragma mark ***日期设置***
- (NSString *)currentWeekData{
    
    NSArray *weekArray = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =  NSCalendarUnitWeekday ;
    
    now=[NSDate date];
    
    comps = [calendar components:unitFlags fromDate:now];
    
    return weekArray[[comps weekday] - 1];
}










@end
