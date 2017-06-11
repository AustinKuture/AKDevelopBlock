//
//  XLSphereView.h
//  XLSphereView
//
//  Created by 李亚坤 on 16/6/4.
//  Copyright © 2016年 Kuture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLSphereView : UIView

@property(nonatomic,assign) BOOL isTimerStart;

- (void)setItems:(NSArray *)items;

- (void)timerStart;

- (void)timerStop;


@end
