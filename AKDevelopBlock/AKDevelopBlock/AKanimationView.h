//
//  AKanimationView.h
//  AKLoadingGif
//
//  Created by 李亚坤 on 2017/1/22.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AKanimationView : UIView

@property (nonatomic,copy) void(^AniPicArray)(NSMutableArray *);

+ (instancetype)sharedAKanimationView;

//开始动画
- (void)startAKanimationView;

//停止动画
- (void)stopAKanimationView;

//动画设置
- (UIImageView *)animationViewFram:(CGRect)fram
                         ImageName:(NSString *)imageName
                        ImageCount:(NSInteger)imageCount
                     AnimationTime:(float)animationTime;

//原始动画的加载
- (UIActivityIndicatorView *)originalAnimationWithFrame:(CGRect)frame
                                 Style:(UIActivityIndicatorViewStyle)style
                                 Color:(UIColor *)aniColor;

#pragma mark ***图片浏览的封装***
- (UIScrollView *)browsePhotoWith:(NSMutableArray *)picArray Frame:(CGRect)frame Bounces:(BOOL)bounecs ExHeight:(CGFloat)exHeight;

/**
 * 颜色渐变
 */
- (UIView *)fadeViewWithBeginColor:(UIColor *)beginColor MidelColor:(UIColor *)midelColor EndColor:(UIColor *)endColor Frame:(CGRect)frame;

















@end
