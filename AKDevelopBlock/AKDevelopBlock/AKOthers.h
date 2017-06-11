//
//  AKOthers.h
//  AKIRPManage
//
//  Created by 李亚坤 on 2017/4/24.
//  Copyright © 2017年 李亚坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKOthers : NSObject

+(instancetype)shareOthersManager;

- (void)viewJumpAnimationWith:(UIView *)view Number:(int)n Height:(float)height Frame:(CGRect)frame Num:(float)num Duration:(CGFloat)duration;

@end
