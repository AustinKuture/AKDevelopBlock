//
//  AKDateTrans.h
//  AKIRPManage
//
//  Created by 李亚坤 on 2016/11/4.
//  Copyright © 2016年 李亚坤. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^dateTrans) (NSString *);
@interface AKDateTrans : NSObject

@property (nonatomic,copy) dateTrans datetrans;

- (void)dateWithString:(NSString *)dateS DateTrans:(dateTrans)datetrans;
- (NSString *)dateParmaterWithString:(NSString *)dateS;

@end
