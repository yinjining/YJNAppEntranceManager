//
//  YJNSceneDelegateManager.m
//  YJNAppEntranceManagerDemo
//
//  Created by yinjn on 2020/1/7.
//  Copyright © 2020 yinjn. All rights reserved.
//

#import "YJNSceneDelegateManager.h"
@interface YJNSceneDelegateManager ()

@property (nonatomic, strong) NSMutableArray *modules;

@end

@implementation YJNSceneDelegateManager
+ (instancetype)sharedInstance{
    static YJNSceneDelegateManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (void)loadRegister:(NSArray<Class> *)classList{
    for (Class class in classList) {
        id<YJNSceneDelegate> module = [[class alloc] init];
        [self addModule:module];
    }
}

- (void)addModule:(id<YJNSceneDelegate>) module{
    if (![self.modules containsObject:module]) {
        [self.modules addObject:module];
    }
}

- (NSMutableArray<id<YJNSceneDelegate>> *)modules{
    if (!_modules) {
        _modules = [[NSMutableArray alloc]init];
    }
    return _modules;
}

#pragma mark - scene 生命周期
-(void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions API_AVAILABLE(ios(13.0)){
    for (id<YJNSceneDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module scene:scene willConnectToSession:session options:connectionOptions];
        }
    }
}

-(void)sceneDidDisconnect:(UIScene *)scene API_AVAILABLE(ios(13.0)){
    for (id<YJNSceneDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module sceneDidDisconnect:scene];
        }
    }
}

-(void)sceneDidBecomeActive:(UIScene *)scene API_AVAILABLE(ios(13.0)){
    for (id<YJNSceneDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module sceneDidBecomeActive:scene];
        }
    }
}

- (void)sceneWillResignActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    for (id<YJNSceneDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module sceneWillResignActive:scene];
        }
    }
}

- (void)sceneWillEnterForeground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    for (id<YJNSceneDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module sceneWillEnterForeground:scene];
        }
    }
}

- (void)sceneDidEnterBackground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    for (id<YJNSceneDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module sceneDidEnterBackground:scene];
        }
    }
}

#pragma mark - schemes跳转
-(void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts API_AVAILABLE(ios(13.0)){
    for (id<YJNSceneDelegate> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module scene:scene openURLContexts:URLContexts];
        }
    }
}
@end
