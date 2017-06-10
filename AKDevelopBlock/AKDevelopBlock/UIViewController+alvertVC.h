//
//  UIViewController+alvertVC.h
//  xytxwNewlyMall
//
//  Created by Kuture on 16/12/14.
//  Copyright © 2016年 Kuture. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^confirmBlock)(UIAlertController *alvertVC);

typedef void(^cancelBlock)(UIAlertController *alvertVC);

typedef void(^completionBlock)();

@interface UIViewController (alvertVC)
-(void)alvertVCWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style confirmBlock:(confirmBlock)confirmB cancelBlock:(cancelBlock)cancelB  completeBlock:(completionBlock)completeB leftCancelTitle:(NSString *)leftTitle rightConfirmTitle:(NSString *)rightTitle;
-(void)alvertVCWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style confirmBlock:(confirmBlock)confirmB cancelBlock:(cancelBlock)cancelB  completeBlock:(completionBlock)completeB;
-(void)alvertTipLabelWithString:(NSString *)contenString completeBLock:(void (^)())alvertCompleteBlock;
@end
