//
//  YZGTabBarControllerConfig.m
//  yzg
//
//  Created by AVGD—JK on 16/5/31.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGTabBarControllerConfig.h"


//View Controllers
#import "YZGHomeViewController.h"
#import "YZGCategoryViewController.h"
#import "YZGMineViewController.h"
#import "YZGCategoryViewController.h"
#import "YZGShoppingCarVC.h"
@interface YZGTabBarControllerConfig ()


@end

@implementation YZGTabBarControllerConfig

/**
 *  lazy load tabBarController
 *
 *  @return CYLTabBarController
 */
- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        YZGHomeViewController *firstViewController = [[YZGHomeViewController alloc] init];
        UIViewController *firstNavigationController = [[YZGRootNavigationController alloc]
                                                       initWithRootViewController:firstViewController];
        
        YZGCategoryViewController *secondViewController = [[YZGCategoryViewController alloc] init];
        UIViewController *secondNavigationController = [[YZGRootNavigationController alloc]
                                                        initWithRootViewController:secondViewController];
        
        YZGShoppingCarVC *thirdViewController = [[YZGShoppingCarVC alloc] init];
        UIViewController *thirdNavigationController = [[YZGRootNavigationController alloc]
                                                       initWithRootViewController:thirdViewController];
        
        YZGMineViewController *fourthViewController = [[YZGMineViewController alloc] init];
        UIViewController *fourthNavigationController = [[YZGRootNavigationController alloc]
                                                        initWithRootViewController:fourthViewController];
        YZGTabBarController *tabBarController = [[YZGTabBarController alloc] init];
        
        
        [self setUpTabBarItemsAttributesForController:tabBarController];
        
        [tabBarController setViewControllers:@[
                                               firstNavigationController,
                                               secondNavigationController,
                                               thirdNavigationController,
                                               fourthNavigationController
                                               ]];
        // 更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
        [self customizeTabBarAppearance:tabBarController];
         _tabBarController = tabBarController;
    }
    return _tabBarController;
}

/**
 *  在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括 title、Image、selectedImage。
 */
- (void)setUpTabBarItemsAttributesForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"tab_home_pre",
                            CYLTabBarItemSelectedImage : @"tab_home",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"分类",
                            CYLTabBarItemImage : @"tab_classify_pre",
                            CYLTabBarItemSelectedImage : @"tab_classify",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"采购单",
                            CYLTabBarItemImage : @"tab_shopping_pre",
                            CYLTabBarItemSelectedImage : @"tab_shopping",
                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"tab_my_pre",
                            CYLTabBarItemSelectedImage : @"tab_my"
                            };
    NSArray *tabBarItemsAttributes = @[
                                       dict1,
                                       dict2,
                                       dict3,
                                       dict4
                                       ];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
 */
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // 设置背景图片
    UITabBar *tabBarAppearance = [UITabBar appearance];
    [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
    
    // 去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
