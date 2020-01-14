//
//  FirstWaySceneDelegate.m
//  YJNAppEntranceManagerDemo
//
//  Created by yinjn on 2020/1/14.
//  Copyright © 2020 yinjn. All rights reserved.
//

#import "FirstWaySceneDelegate.h"

@implementation FirstWaySceneDelegate

+(void)load{
    [super load];
}

+(void)loadSubRegister{
    [[YJNSceneDelegateManager sharedInstance]loadRegister:@[
        [FirstWaySceneDelegate class]
    ]];
}

-(void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions API_AVAILABLE(ios(13.0)){
    NSLog(@"我是FirstWaySceneDelegate，我走了");
}

@end
