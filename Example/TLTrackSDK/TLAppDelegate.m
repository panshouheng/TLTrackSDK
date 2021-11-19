//
//  TLAppDelegate.m
//  TLTrackSDK
//
//  Created by panshouheng on 11/17/2021.
//  Copyright (c) 2021 panshouheng. All rights reserved.
//

#import "TLAppDelegate.h"
#import <TLTrackSDK.h>
#import <AdSupport/AdSupport.h>
@implementation TLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [TLAnalyticsSDK startWithServerURL:@"https://qas-gl-cn-api.tineco.com/v1/private/CN/ZH_CN/d6fdc8acc4cb1949aa38c7356db535fa/global_e/1.1.29/c_huawei/1/common/track/full?authAppkey=1538105560006&authSign=8a1d43c584bddbd8cd68f942d5fb9970&authTimeZone=Asia/Shanghai&authTimespan=1622531049056&userId=20201112162015_eaa1cfa31d108cec1109b2ed9e16419a&accessToken=35b1720ed5e9028ae0e53ffe16bee8cf"];
    // 在系统默认的 UserAgent 值中添加默认标记（" /sa-sdk-ios "）
    [[TLAnalyticsSDK sharedInstance] addWebViewUserAgent:nil];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
