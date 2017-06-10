//
//  AKDateTrans.m
//  AKIRPManage
//
//  Created by 李亚坤 on 2016/11/4.
//  Copyright © 2016年 李亚坤. All rights reserved.
//

#import "AKDateTrans.h"

@implementation AKDateTrans

- (void)dateWithString:(NSString *)dateS DateTrans:(dateTrans)datetrans{
    
    long long time=[dateS longLongValue];
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];//格式化
    [df setDateFormat:@"yyyy.MM.dd"];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ];
    NSString * timeStr =[df stringFromDate:d];
    
    datetrans(timeStr);
}

- (NSString *)dateParmaterWithString:(NSString *)dateS{
    
    long long time=[dateS longLongValue];
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];//格式化
    [df setDateFormat:@"MM-dd hh:mm"];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ];
    NSString * timeStr =[df stringFromDate:d];
    
    return timeStr;
}

@end
