//
//  UIApplication+YJNExtension.m
//  YJNAppEntranceManagerDemo
//
//  Created by yinjn on 2019/6/17.
//  Copyright © 2019 yinjn. All rights reserved.
//

#import "UIApplication+YJNExtension.h"
#import <objc/message.h>
#import "YJNAppDelegateExtesion.h"

@implementation UIApplication (YJNExtension)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 交换 setDelegate 方法
        Method oldInstanceMethod =class_getInstanceMethod([self class],@selector(setDelegate:));
        Method newInstanceMethod =class_getInstanceMethod([self class], @selector(yjn_setDelegate:));
        method_exchangeImplementations(oldInstanceMethod, newInstanceMethod);
    });
}

- (void)yjn_setDelegate:(id)delegate{
    [self yjn_setDelegate:delegate];
    
    // 当前delegate
    Class class = [delegate class];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /*********** UIApplication相关 ***********/
        // didFinishLaunchingWithOptions
        [self swizzleInstanceMethodSEL:@selector(application:didFinishLaunchingWithOptions:) withSEL:@selector(yjn_application:didFinishLaunchingWithOptions:) class:class  error:nil];
        
        // applicationWillResignActive
        [self swizzleInstanceMethodSEL:@selector(applicationWillResignActive:) withSEL:@selector(yjn_applicationWillResignActive:) class:class  error:nil];
        
        // applicationDidEnterBackground
        [self swizzleInstanceMethodSEL:@selector(applicationDidEnterBackground:) withSEL:@selector(yjn_applicationDidEnterBackground:) class:class  error:nil];
        
        //applicationWillEnterForeground
        [self swizzleInstanceMethodSEL:@selector(applicationWillEnterForeground:) withSEL:@selector(yjn_applicationWillEnterForeground:) class:class  error:nil];
        
        //applicationDidBecomeActive
        [self swizzleInstanceMethodSEL:@selector(applicationDidBecomeActive:) withSEL:@selector(yjn_applicationDidBecomeActive:) class:class  error:nil];
        
        //applicationWillTerminate
        [self swizzleInstanceMethodSEL:@selector(applicationWillTerminate:) withSEL:@selector(yjn_applicationWillTerminate:) class:class  error:nil];
        
        
        /*********** push相关 ***********/
        //didRegisterForRemoteNotificationsWithDeviceToken
        [self swizzleInstanceMethodSEL:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:) withSEL:@selector(yjn_application:didRegisterForRemoteNotificationsWithDeviceToken:) class:class  error:nil];
        
        //注册token失败
        [self swizzleInstanceMethodSEL:@selector(application:didFailToRegisterForRemoteNotificationsWithError:) withSEL:@selector(yjn_application:didFailToRegisterForRemoteNotificationsWithError:) class:class  error:nil];
        
        //iOS7以前会调用的方法
        [self swizzleInstanceMethodSEL:@selector(application:didReceiveRemoteNotification:) withSEL:@selector(yjn_application:didReceiveRemoteNotification:) class:class  error:nil];
        
        //iOS10以后会调用的方法，如果实现了这个方法，旧方法不会被调用
        [self swizzleInstanceMethodSEL:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:) withSEL:@selector(yjn_application:didReceiveRemoteNotification:fetchCompletionHandler:) class:class  error:nil];
        
        //iOS10以后 前台收到推送消息
        [self swizzleInstanceMethodSEL:@selector(userNotificationCenter:willPresentNotification:withCompletionHandler:) withSEL:@selector(yjn_userNotificationCenter:willPresentNotification:withCompletionHandler:) class:class  error:nil];
        
        //iOS10以后 通知栏上的交互
        [self swizzleInstanceMethodSEL:@selector(userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:) withSEL:@selector(yjn_userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:) class:class  error:nil];
        
        /*********** schemes跳转 ***********/
        //iOS9以前的schemes跳转
        [self swizzleInstanceMethodSEL:@selector(application:handleOpenURL:) withSEL:@selector(yjn_application:handleOpenURL:) class:class  error:nil];
        
        //iOS9以后的schemes跳转
        [self swizzleInstanceMethodSEL:@selector(application:openURL:options:) withSEL:@selector(yjn_application:openURL:options:) class:class  error:nil];
        
        /*********** 其他方法 ***********/
        [self swizzleInstanceMethodSEL:@selector(applicationDidReceiveMemoryWarning:) withSEL:@selector(yjn_applicationDidReceiveMemoryWarning:) class:class  error:nil];
    });
}

/********** UIApplication相关 **********/
- (BOOL)yjn_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BOOL success = [self yjn_application:application didFinishLaunchingWithOptions:launchOptions];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"KCYJNAppDelegateExtesion" object:nil];
    [[YJNAppDelegateManager sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    return success;
}
- (void)yjn_applicationWillResignActive:(UIApplication *)application{
    [[YJNAppDelegateManager sharedInstance] applicationWillResignActive:application];
    [self yjn_applicationWillResignActive:application];
}
- (void)yjn_applicationDidEnterBackground:(UIApplication *)application {
    [[YJNAppDelegateManager sharedInstance] applicationDidEnterBackground:application];
    [self yjn_applicationDidEnterBackground:application];
}
- (void)yjn_applicationWillEnterForeground:(UIApplication *)application {
    [[YJNAppDelegateManager sharedInstance]applicationWillEnterForeground:application];
    [self yjn_applicationWillEnterForeground:application];
}
- (void)yjn_applicationDidBecomeActive:(UIApplication *)application {
    [[YJNAppDelegateManager sharedInstance] applicationDidBecomeActive:application];
    [self yjn_applicationDidBecomeActive:application];
}
- (void)yjn_applicationWillTerminate:(UIApplication *)application {
    [[YJNAppDelegateManager sharedInstance] applicationWillTerminate:application];
    [self yjn_applicationWillTerminate:application];
}


/*********** push相关 ***********/
-(void)yjn_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken{
    [self yjn_application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    [[YJNAppDelegateManager sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}
- (void)yjn_application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    [self yjn_application:application didFailToRegisterForRemoteNotificationsWithError:error];
    [[YJNAppDelegateManager sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
}
-(void)yjn_application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [self yjn_application:application didReceiveRemoteNotification:userInfo];
    [[YJNAppDelegateManager sharedInstance] application:application didReceiveRemoteNotification:userInfo];
}
-(void)yjn_application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [self yjn_application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
    [[YJNAppDelegateManager sharedInstance] application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}
- (void)yjn_userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler API_AVAILABLE(ios(10.0)){
    [self yjn_userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
    [[YJNAppDelegateManager sharedInstance] userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
}
- (void)yjn_userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    [self yjn_userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
    [[YJNAppDelegateManager sharedInstance]userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
}

/*********** schemes跳转 ***********/
-(BOOL)yjn_application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    [[YJNAppDelegateManager sharedInstance] application:application handleOpenURL:url];
    return [self yjn_application:application handleOpenURL:url];
}

- (BOOL)yjn_application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options API_AVAILABLE(ios(9.0)){
    [[YJNAppDelegateManager sharedInstance] application:app openURL:url options:options];
    return [self yjn_application:app openURL:url options:options];
}


/*********** 其他方法 ***********/
- (void)yjn_applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [[YJNAppDelegateManager sharedInstance] applicationDidReceiveMemoryWarning:application];
    [self yjn_applicationDidReceiveMemoryWarning:application];
}



#pragma mark - 交换实例方法
- (BOOL)swizzleInstanceMethodSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL class:(Class)class error:(NSError **)error{
    if (originalSEL && swizzledSEL) {
        Method exchangeM = class_getInstanceMethod(class, swizzledSEL);
        
        BOOL isSuccess = class_addMethod(class, swizzledSEL, class_getMethodImplementation([self class], swizzledSEL),method_getTypeEncoding(exchangeM));
        
        if (isSuccess) {
            // 将刚添加的动态方法，进行方法交换
            Method newInstanceMethod = class_getInstanceMethod(class, swizzledSEL);
            Method oldInstanceMethod = class_getInstanceMethod(class, originalSEL);
            
            method_exchangeImplementations(oldInstanceMethod, newInstanceMethod);
            return YES;
        }
    }
    return NO;
}

@end

