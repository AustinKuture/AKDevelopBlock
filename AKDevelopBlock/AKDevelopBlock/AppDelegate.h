//
//  AppDelegate.h
//  AKDevelopBlock
//
//  Created by 李亚坤 on 2017/5/13.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

