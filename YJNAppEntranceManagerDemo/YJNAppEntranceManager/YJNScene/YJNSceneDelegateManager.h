//
//  YJNSceneDelegateManager.h
//  YJNAppEntranceManagerDemo
//
//  Created by yinjn on 2020/1/7.
//  Copyright © 2020 yinjn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol YJNSceneDelegate <UIWindowSceneDelegate>

@end

@interface YJNSceneDelegateManager : NSObject <UIWindowSceneDelegate>
@property (nonatomic, strong,readonly) NSMutableArray *modules;

+ (instancetype)sharedInstance;

//注册
- (void)loadRegister:(NSArray<Class> *)classList;

@end

NS_ASSUME_NONNULL_END
