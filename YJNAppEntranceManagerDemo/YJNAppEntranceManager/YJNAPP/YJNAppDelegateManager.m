//
//  YJNAppDelegateManager.m
//  YJNAppEntranceManagerDemo
//
//  Created by yinjn on 2018/10/18.
//  Copyright © 2018年 yinjn. All rights reserved.
//

#import "YJNAppDelegateManager.h"
@interface YJNAppDelegateManager ()

@property (nonatomic, strong) NSMutableArray<id<YJNModuleAppDelegate>> *modules;

@end

@implementation YJNAppDelegateManager

+ (instancetype)sharedInstance{
    static YJNAppDelegateManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (void)loadRegister:(NSArray<Class> *)classList{
    for (Class class in classList) {
        id<YJNModuleAppDelegate> module = [[class alloc] init];
        [self addModule:module];
    }
}

- (void)addModule:(id<YJNModuleAppDelegate>) module{
    if (![self.modules containsObject:module]) {
        [self.modules addObject:module];
    }
}

- (NSMutableArray<id<YJNModuleAppDelegate>> *)modules{
    if (!_modules) {
        _modules = [[NSMutableArray alloc]init];
    }
    return _modules;
}

#pragma mark - app生命周期
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    BOOL result = NO;
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            BOOL temp = [module application:application willFinishLaunchingWithOptions:launchOptions];
            result = (temp || result);
        }
    }
    return result;
}

//启动
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    BOOL result = NO;
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            BOOL temp = [module application:application didFinishLaunchingWithOptions:launchOptions];
            result = (temp || result);
        }
    }
    return result;
}

//已经进入前台
- (void)applicationDidBecomeActive:(UIApplication *)application{
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationDidBecomeActive:application];
        }
    }
}

//已经进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application{
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationDidEnterBackground:application];
        }
    }
}

//即将进入后台
- (void)applicationWillResignActive:(UIApplication *)application{
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationWillResignActive:application];
        }
    }
}

//即将进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application{
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationWillEnterForeground:application];
        }
    }
}

//即将退出
- (void)applicationWillTerminate:(UIApplication *)application{
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationWillTerminate:application];
        }
    }
}

#pragma mark - Remote Notification
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didFailToRegisterForRemoteNotificationsWithError:error];
        }
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler{
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
        }
    }
}

// 弃用 from iOS 10.0
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didReceiveRemoteNotification:userInfo];
        }
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)(void))completionHandler{
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo completionHandler:completionHandler];
        }
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)(void))completionHandler API_DEPRECATED("Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]", ios(9.0, 10.0)){
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo withResponseInfo:responseInfo completionHandler:completionHandler];
        }
    }
}

#pragma mark - Local Notification
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler API_AVAILABLE(ios(10.0)){
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
        }
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
        }
    }
}

// 弃用 from iOS 10.0
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didReceiveLocalNotification:notification];
        }
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)(void))completionHandler{
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application handleActionWithIdentifier:identifier forLocalNotification:notification completionHandler:completionHandler];
        }
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)(void))completionHandler API_DEPRECATED("Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]", ios(9.0, 10.0)){
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application handleActionWithIdentifier:identifier forLocalNotification:notification withResponseInfo:responseInfo completionHandler:completionHandler];
        }
    }
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didRegisterUserNotificationSettings:notificationSettings];
        }
    }
}

#pragma mark - 持续的用户活动和快速操作
- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType{
    BOOL result = NO;
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            BOOL temp = [module application:application willContinueUserActivityWithType:userActivityType];
            result = (temp || result);
        }
    }
    return result;
}

//通用链接
-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    BOOL result = NO;
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            BOOL temp = [module application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
            result = (temp || result);
        }
    }
    return result;
}

- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity{
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didUpdateUserActivity:userActivity];
        }
    }
}

- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error{
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didFailToContinueUserActivityWithType:userActivityType error:error];
        }
    }
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL succeeded))completionHandler API_AVAILABLE(ios(9.0)){
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
        }
    }
}

#pragma mark - schemes跳转
//iOS9以后的schemes跳转
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options API_AVAILABLE(ios(9.0)){
    BOOL result = NO;
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            BOOL temp = [module application:app openURL:url options:options];
            result = (temp || result);
        }
    }
    return result;
}
//iOS9以前的schemes跳转
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    BOOL result = NO;
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            BOOL temp = [module application:application handleOpenURL:url];
            result = (temp || result);
        }
    }
    return result;
}

#pragma mark - 其他
/** 程序收到内存警告 */
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    for (id<YJNModuleAppDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationDidReceiveMemoryWarning:application];
        }
    }
}
@end
