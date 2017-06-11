//
//  AKOthers.m
//  AKIRPManage
//
//  Created by 李亚坤 on 2017/4/24.
//  Copyright © 2017年 李亚坤. All rights reserved.
//

#import "AKOthers.h"

@interface AKOthers()

@property (nonatomic,strong) AKOthers *others;

@end
@implementation AKOthers

+(instancetype)shareOthersManager{
    static dispatch_once_t onece = 0;
    static AKOthers *othersManager = nil;
    dispatch_once(&onece, ^(void){
        othersManager = [[self alloc]init];
    });
    return othersManager;
}

//动画跳动方法
- (void)viewJumpAnimationWith:(UIView *)view Number:(int)n Height:(float)height Frame:(CGRect)frame Num:(float)num Duration:(CGFloat)duration{
    
    //view 需要添加动画的视图
    //n 跳动次数
    //height 跳动高度
    //frame 视图位置
    //num 辅参数 与n相同
    
    
    if (n<0) {
        
        return;
    }
    
    n = n-1;
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        view.frame = CGRectMake(frame.origin.x, frame.origin.y-((n%2)?0:(n+2)*(height/num)), frame.size.width, frame.size.height);
    } completion:^(BOOL finished) {
        
        [self viewJumpAnimationWith:view Number:n Height:height Frame:frame Num:num Duration:duration];
    }];
}



@end
