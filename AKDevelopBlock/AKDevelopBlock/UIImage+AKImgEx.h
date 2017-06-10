//
//  UIImage+AKImgEx.h
//  AKIRPManage
//
//  Created by 李亚坤 on 2017/3/2.
//  Copyright © 2017年 李亚坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AKImgEx)

//图像尺寸拉伸
+ (instancetype)resizeWithImageName:(NSString *)imgName;

+ (UIImage*)createImageWithColor:(UIColor*)color RectSize:(CGSize)rectSize CornerRadius:(float)cornerRadius;

+ (UIImage *)createImageWithColor:(UIColor *)color RectSize:(CGSize)rectSize Title:(NSString *)title TitleColor:(UIColor *)titleColor CornerRadius:(float) cornerRadius;

//图像添加模糊蒙版
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

@end
