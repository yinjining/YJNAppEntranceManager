//
//  UIWindowScene+YJNExtension.m
//  YJNAppEntranceManagerDemo
//
//  Created by yinjn on 2020/1/6.
//  Copyright © 2020 yinjn. All rights reserved.
//

#import "UIWindowScene+YJNExtension.h"
#import <objc/message.h>
#import "YJNSceneDelegateManager.h"

@implementation UIWindowScene (YJNExtension)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *applicationSceneManifest = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"UIApplicationSceneManifest"];
        if (applicationSceneManifest == nil) {
            return ;
        }
        
        NSArray *array =  [[applicationSceneManifest objectForKey:@"UISceneConfigurations"] objectForKey:@"UIWindowSceneSessionRoleApplication"];
        for (NSDictionary *dic in array) {
            [[self class]  yjn_sceneDelegate:NSClassFromString([dic objectForKey:@"UISceneDelegateClassName"])];
        }
    });
}

+(void)yjn_sceneDelegate:(Class)delegateClass{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // willConnectToSession
        [self swizzleInstanceMethodSEL:@selector(scene:willConnectToSession:options:) withSEL:@selector(yjn_scene:willConnectToSession:options:) class:delegateClass  error:nil];
        [self swizzleInstanceMethodSEL:@selector(sceneDidDisconnect:) withSEL:@selector(yjn_sceneDidDisconnect:) class:delegateClass  error:nil];
        [self swizzleInstanceMethodSEL:@selector(sceneDidBecomeActive:) withSEL:@selector(yjn_sceneDidBecomeActive:) class:delegateClass  error:nil];
        [self swizzleInstanceMethodSEL:@selector(sceneWillResignActive:) withSEL:@selector(yjn_sceneWillResignActive:) class:delegateClass  error:nil];
        [self swizzleInstanceMethodSEL:@selector(sceneWillEnterForeground:) withSEL:@selector(yjn_sceneWillEnterForeground:) class:delegateClass  error:nil];
        [self swizzleInstanceMethodSEL:@selector(sceneDidEnterBackground:) withSEL:@selector(yjn_sceneDidEnterBackground:) class:delegateClass  error:nil];
        [self swizzleInstanceMethodSEL:@selector(scene:openURLContexts:) withSEL:@selector(yjn_scene:openURLContexts:) class:delegateClass  error:nil];
    });
}

-(void)yjn_scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions{
    [self yjn_scene:scene willConnectToSession:session options:connectionOptions];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"KCYJNSceneDelegateExtesion" object:nil];
    [[YJNSceneDelegateManager sharedInstance] scene:scene willConnectToSession:session options:connectionOptions];
}

- (void)yjn_sceneDidDisconnect:(UIScene *)scene {
    [self yjn_sceneDidDisconnect:scene];
    [[YJNSceneDelegateManager sharedInstance] sceneDidDisconnect:scene];
}


- (void)yjn_sceneDidBecomeActive:(UIScene *)scene {
    [self yjn_sceneDidBecomeActive:scene];
    [[YJNSceneDelegateManager sharedInstance] sceneDidBecomeActive:scene];
}


- (void)yjn_sceneWillResignActive:(UIScene *)scene {
    [self yjn_sceneWillResignActive:scene];
    [[YJNSceneDelegateManager sharedInstance] sceneWillResignActive:scene];
}


- (void)yjn_sceneWillEnterForeground:(UIScene *)scene {
    [self yjn_sceneWillEnterForeground:scene];
    [[YJNSceneDelegateManager sharedInstance] sceneWillEnterForeground:scene];
}


- (void)yjn_sceneDidEnterBackground:(UIScene *)scene {
    [self yjn_sceneDidEnterBackground:scene];
    [[YJNSceneDelegateManager sharedInstance]sceneDidEnterBackground:scene];
}


- (void)yjn_scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts{
    [self yjn_scene:scene openURLContexts:URLContexts];
    [[YJNSceneDelegateManager sharedInstance] scene:scene openURLContexts:URLContexts];
}

//#pragma mark - 交换实例方法
+ (BOOL)swizzleInstanceMethodSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL class:(Class)class error:(NSError **)error{
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
