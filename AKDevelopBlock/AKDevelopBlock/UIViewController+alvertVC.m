//
//  UIViewController+alvertVC.m
//  xytxwNewlyMall
//
//  Created by Kuture on 16/12/14.
//  Copyright © 2016年 Kuture. All rights reserved.
//

#import "UIViewController+alvertVC.h"

static id _instance;

@implementation UIViewController (alvertVC)

-(void)alvertVCWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style confirmBlock:(confirmBlock)confirmB cancelBlock:(cancelBlock)cancelB  completeBlock:(completionBlock)completeB leftCancelTitle:(NSString *)leftTitle rightConfirmTitle:(NSString *)rightTitle{
    
    
    UIAlertController *alvertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    if (confirmB) {
        
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle: rightTitle ? rightTitle : @"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            confirmB(alvertVC);
        }];
        
        [alvertVC addAction:confirmAction];
    }
    
    if (cancelB) {
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:leftTitle ? leftTitle : @"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            cancelB(alvertVC);
        }];
        
        [alvertVC addAction:cancelAction];
    }
    

    [self presentViewController:alvertVC animated:YES completion:completeB];
    
}
-(void)alvertTipLabelWithString:(NSString *)contenString completeBLock:(void (^)())alvertCompleteBlock{
    
    static dispatch_once_t onceToken;
    
    /**
     dispatch_once  一次性执行
     它是安全的，系统已经自动帮我们加了锁，所以在多个线程抢夺同一资源的时候，也是安全的
     */
    
    dispatch_once(&onceToken, ^{
        NSLog(@"---once---");
        
        // 这里也会调用到 allocWithZone 方法
        _instance = [UILabel new];
    });

    
    UILabel *confirmLabel = (UILabel *)_instance;
    
//    UILabel *confirmLabel =[UILabel new];
    
    confirmLabel.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.8];
    
    confirmLabel.text = contenString;
    
    [[UIApplication sharedApplication].keyWindow addSubview:confirmLabel];
    
//    [confirmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.centerX.equalTo([UIApplication sharedApplication].keyWindow.mas_centerX).with.offset(0);
//        
//        make.bottom.equalTo([UIApplication sharedApplication].keyWindow.mas_bottom).with.offset(-69);
//    }];
    
    confirmLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.1*0.5, [UIScreen mainScreen].bounds.size.height-80, [UIScreen mainScreen].bounds.size.width*0.9, 50);
    
    confirmLabel.textAlignment = NSTextAlignmentCenter;
    
    
    confirmLabel.alpha = 1;
    
    [UIView animateWithDuration:2 animations:^{
        
        confirmLabel.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        if (alvertCompleteBlock) {
            
            alvertCompleteBlock();
        }
        
        
    }];

}

-(void)alvertVCWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style confirmBlock:(confirmBlock)confirmB cancelBlock:(cancelBlock)cancelB  completeBlock:(completionBlock)completeB {

    [self alvertVCWithTitle:title message:message style:style confirmBlock:confirmB cancelBlock:cancelB completeBlock:completeB leftCancelTitle:nil rightConfirmTitle:nil];

}

// 实现创建单例对象的类方法
+ (instancetype)sharedAudioPlayTool {
    
    static dispatch_once_t onceToken;
    
    /**
     dispatch_once  一次性执行
     它是安全的，系统已经自动帮我们加了锁，所以在多个线程抢夺同一资源的时候，也是安全的
     */
    
    dispatch_once(&onceToken, ^{
        NSLog(@"---once---");
        
        // 这里也会调用到 allocWithZone 方法
        _instance = [[self alloc] init];
    });
    return _instance;
}
@end
