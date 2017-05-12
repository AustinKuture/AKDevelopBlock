//
//  SDCollectionViewCell.h
//  SDCycleScrollView
//
//  Created by 李亚坤 on 16/5/12.
//  Copyright © 2016年 李亚坤. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface SDCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) UIImageView *imageView;
@property (copy, nonatomic) NSString *title;

@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIFont *titleLabelTextFont;
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
@property (nonatomic, assign) CGFloat titleLabelHeight;

@property (nonatomic, assign) BOOL hasConfigured;

@end
