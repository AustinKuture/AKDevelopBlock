//
//  AKWeatherView.m
//  AKIRPManage
//
//  Created by 李亚坤 on 16/9/26.
//  Copyright © 2016年 李亚坤. All rights reserved.
//

#import "AKWeatherView.h"
#import "AKPlusBtnController.h"
#import "CoreLocation/CoreLocation.h"

@interface AKWeatherView ()<CLLocationManagerDelegate>

@property (nonatomic,copy) NSString *dateD;
@property (nonatomic,copy) NSString *skyType;
@property (nonatomic,copy) NSString *averTemper;
@property (nonatomic,copy) NSString *temperLabel;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) CLGeocoder *geoCoder;

@end

@implementation AKWeatherView

#pragma mark ***定位初始化***
- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self){
        
        self.locationManager = [[CLLocationManager alloc]init];
        self.geoCoder = [[CLGeocoder alloc]init];
        _locationManager.delegate = self;
        _cityName = [[NSString alloc]init];
        _detailLocation = [[NSString alloc]init];
        
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
            
            [_locationManager requestWhenInUseAuthorization];
        }
        [_locationManager startUpdatingLocation];
    }
    
    return self;
}

#pragma mark ***获取当前经纬度***
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    [self obtainLatitude:coordinate.latitude Longtitude:coordinate.longitude];
    [_locationManager stopUpdatingLocation];
}

#pragma mark ***根据当前经纬度进行地理反编码取得地理信息***
- (void)obtainLatitude:(CLLocationDegrees)latitude Longtitude:(CLLocationDegrees)longtitude{
    
    CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude longitude:longtitude];
    [_geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
        CLPlacemark *placeMark = [placemarks firstObject];
        
        if (placeMark.addressDictionary){
            
            _detailLocation = placeMark.addressDictionary[@"FormattedAddressLines"][0];
        }else{
            
            _detailLocation = @"北京";
        }
        
        NSString *sTr = [NSString stringWithFormat:@"%@",placeMark.addressDictionary[@"City"]];
        
        if ([sTr rangeOfString:@"市"].location == NSNotFound){
            
            _cityName = @"北京";
        }else{
           _cityName = [sTr stringByReplacingOccurrencesOfString:@"市" withString:@""];
        }
        
        NSLog(@"-====-=--=-%@=====",_detailLocation);
//        [self weatherView];
    }];
}

#pragma mark ***重写***
- (NSString *)WeatherSTR:(NSString *)Str{
    
    self.WeatherSTR = [[NSString alloc]init];
    self.WeatherSTR = Str;
    
    return self.WeatherSTR;
}

#pragma mark ***天气视图的编写***
- (void)weatherView{
    
    NSString *cityA;
    NSURL *url;
    NSData *data;
    
    cityA = [_cityName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    url = [NSURL URLWithString:[NSString stringWithFormat:@"http://wthrcdn.etouch.cn/weather_mini?city=%@",cityA]];
    data = [NSData dataWithContentsOfURL:url];
    
    _skyType = @"晴";
    _averTemper = @"18˚";
    _temperLabel = @"15/22˚";
    
    if (data){
        
        NSDictionary *arrayM = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *weatherA = [arrayM objectForKey:@"data"];
        NSDictionary *weatherB = [weatherA objectForKey:@"forecast"];
        MyLog(@"============Weather:%@",weatherB);
        if (weatherB){
            
            NSArray *arryReal = [NSArray arrayWithObject:weatherB];
            NSDictionary *dataArray = arryReal[0][0];
            
            NSString *dateD = [dataArray objectForKey:@"date"];
            NSString *lowTemper = [dataArray objectForKey:@"low"];
            NSString *highTemper = [dataArray objectForKey:@"high"];
            NSString *lowT = [self lowAndHighTemper:lowTemper];
            NSString *highT = [self lowAndHighTemper:highTemper];
            NSString *skyType = [dataArray objectForKey:@"type"];
            NSString *averTemper = [NSString stringWithFormat:@"%.f˚",([lowT intValue] + [highT intValue]) * 0.5];
            NSString *temperLabel = [NSString stringWithFormat:@"%@/%@˚",lowT,highT];
            _dateD = dateD;
            _skyType = skyType;
            _averTemper = averTemper;
            _temperLabel = temperLabel;
        }
        
        
    }
    
    UILabel *currentTemper = [[UILabel alloc]init];
    currentTemper.textAlignment = NSTextAlignmentCenter;
    currentTemper.text = _averTemper;
    currentTemper.font = FONT_S(39);
    currentTemper.textColor = GROUNDSAME(150, 1);
    [self addSubview:currentTemper];
    [currentTemper mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(80, 45));
        make.left.equalTo(self.mas_left).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(- 80);
    }];
    
    UILabel *weatherLable = [[UILabel alloc]init];
    weatherLable.text = _skyType;
    weatherLable.font = FONT_S(15);
    weatherLable.textColor = GROUNDSAME(150, 1);
    [self addSubview:weatherLable];
    [weatherLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(25);
        make.left.equalTo(currentTemper.mas_right).offset(5);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(currentTemper.mas_top);
    }];
    
    UILabel *temperTT = [[UILabel alloc]init];
    temperTT.text = _temperLabel;
    temperTT.font = FONT_S(15);
    temperTT.textColor = GROUNDSAME(150, 1);
    [self addSubview:temperTT];
    [temperTT mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(25);
        make.left.equalTo(currentTemper.mas_right).offset(5);
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(currentTemper.mas_bottom);
    }];

    self.WeatherSTR = _dateD;
}

#pragma mark ***截取无用的字段信息***
- (NSString *)lowAndHighTemper:(NSString *)termper{
    
    NSString *resultS = [termper stringByReplacingOccurrencesOfString:@"低温" withString:@""];
    NSString *resultO = [resultS stringByReplacingOccurrencesOfString:@"高温" withString:@""];
    return [resultO stringByReplacingOccurrencesOfString:@"" withString:@"℃"];
}


@end
