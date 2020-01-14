//
//  YJNSceneDelegateExtension.m
//  YJNAppEntranceManagerDemo
//
//  Created by yinjn on 2020/1/13.
//  Copyright © 2020 yinjn. All rights reserved.
//

#import "YJNSceneDelegateExtension.h"

@implementation YJNSceneDelegateExtension
+(void)load{
    [[NSNotificationCenter defaultCenter] addObserverForName:@"KCYJNSceneDelegateExtesion" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [[self class] loadSubRegister];
    }];
}

+ (void)loadSubRegister{
}
@end
