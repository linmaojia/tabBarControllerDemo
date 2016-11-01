//
//  AppDelegate.m
//  Masonry
//
//  Created by LXY on 16/4/27.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "ETAppDelegate.h"
#import "YZGLoginViewController.h"
#import "YZGNewFeatureViewController.h"
#import "YZGUserManager.h"
#import "YZGTabBarControllerConfig.h"
@interface ETAppDelegate ()

@end

@implementation ETAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];//设置主窗口并显示出来
    
    
    [self registThirdPart];//注册第三方库
    
    [self handleOtherLogic];//其他配置
    
    [self baseViewJumpLogic];//基本页面跳转逻辑
    
 
    return YES;
}
- (void)baseViewJumpLogic
{
    if ([YZGUserManager firstLaunch])//首次使用
    {
        YZGNewFeatureViewController *featureVC = [[YZGNewFeatureViewController alloc] init];
        [self.window setRootViewController:featureVC];
    }
    else
    {
        BOOL isLog = YES;
        if(isLog)
        {
            YZGLoginViewController *loginVC = [[YZGLoginViewController alloc] init];
            YZGRootNavigationController *loginNav = [[YZGRootNavigationController alloc] initWithRootViewController:loginVC];
            self.window.rootViewController = loginNav;
        }
        else
        {
            YZGTabBarControllerConfig *tabBarControllerConfig = [[YZGTabBarControllerConfig alloc] init];
            [self.window setRootViewController:tabBarControllerConfig.tabBarController];
            
        }
     
    }
    
   
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)registThirdPart
{
    
}

- (void)handleOtherLogic
{
}



@end
