//
//  AKLoginViewTwo.h
//  AKDevelopBlock
//
//  Created by 李亚坤 on 2017/5/31.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AKLoginDelegate <NSObject>

@required

- (void)loginDidSelectedHelpInfo;
- (void)loginDidCallTelphone;

@end

@interface AKLoginViewTwo : UIView

@property (nonatomic,strong) id<AKLoginDelegate> delegate;

@end
