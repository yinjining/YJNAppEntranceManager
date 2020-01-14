//
//  YJNAppDelegateExtesion.m
//  YJNAppEntranceManagerDemo
//
//  Created by yinjn on 2019/6/17.
//

#import "YJNAppDelegateExtesion.h"

@implementation YJNAppDelegateExtesion
+(void)load{
    [[NSNotificationCenter defaultCenter] addObserverForName:@"KCYJNAppDelegateExtesion" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [[self class] loadSubRegister];
    }];
}

+ (void)loadSubRegister{
    
}
@end
