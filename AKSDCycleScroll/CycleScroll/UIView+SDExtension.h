//
//  UIView+SDExtension.h
//  SDRefreshView
//
//  Created by 李亚坤 on 16/5/12.
//  Copyright © 2016年 李亚坤. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SDColorCreater(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]


@interface UIView (SDExtension)

@property (nonatomic, assign) CGFloat sd_height;
@property (nonatomic, assign) CGFloat sd_width;

@property (nonatomic, assign) CGFloat sd_y;
@property (nonatomic, assign) CGFloat sd_x;

@end
