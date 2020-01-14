//
//  YJNAppDelegateManager.h
//  YJNAppEntranceManagerDemo
//
//  Created by yinjn on 2018/10/18.
//  Copyright © 2018年 yinjn. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
@protocol  YJNModuleAppDelegate<UIApplicationDelegate, UNUserNotificationCenterDelegate>

@end

NS_ASSUME_NONNULL_BEGIN

@interface YJNAppDelegateManager : NSObject<UIApplicationDelegate, UNUserNotificationCenterDelegate>
@property (nonatomic, strong,readonly) NSMutableArray<id<YJNModuleAppDelegate>> *modules;

+ (instancetype)sharedInstance;

//注册
- (void)loadRegister:(NSArray<Class> *)classList;
@end

NS_ASSUME_NONNULL_END
