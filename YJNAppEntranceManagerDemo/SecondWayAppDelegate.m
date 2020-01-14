//
//  SecondWayAppDelegate.m
//  YJNAppEntranceManagerDemo
//
//  Created by yinjn on 2020/1/14.
//  Copyright © 2020 yinjn. All rights reserved.
//

#import "SecondWayAppDelegate.h"

@implementation SecondWayAppDelegate

+(void)load{
    [super load];
}

+(void)loadSubRegister{
    [[YJNAppDelegateManager sharedInstance]loadRegister:@[
        [SecondWayAppDelegate class]
    ]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    NSLog(@"我是SecondWayAppDelegate，我走了");
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"我是SecondWayAppDelegate中的applicationDidBecomeActive，我走了");
}
@end
