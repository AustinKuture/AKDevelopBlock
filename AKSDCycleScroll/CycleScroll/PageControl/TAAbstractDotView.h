//
//  TAAbstractDotView.h
//  TAPageControl
//
//  Created by 李亚坤 on 16/5/12.
//  Copyright © 2016年 李亚坤. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TAAbstractDotView : UIView


/**
 *  A method call let view know which state appearance it should take. Active meaning it's current page. Inactive not the current page.
 *
 *  @param active BOOL to tell if view is active or not
 */
- (void)changeActivityState:(BOOL)active;


@end

