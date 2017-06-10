//
//  AKNewHotView.h
//  AKIRPManage
//
//  Created by 李亚坤 on 2016/10/17.
//  Copyright © 2016年 李亚坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AKNewHotView : UITableView

@property (nonatomic,copy) void (^transHotV)(float f1);

@end
