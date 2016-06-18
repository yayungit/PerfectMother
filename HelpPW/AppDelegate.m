//
//  AppDelegate.m
//  HelpPW
//
//  Created by BurNIng on 16/1/26.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AppDelegate.h"
#import "PregnancyBudgetViewController.h"
#import "HomeViewController.h"
#import "RESideMenu.h"
#import "LeftViewController.h"
#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialSnsService.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //    设置友盟key
    [UMSocialData setAppKey:@"56a0d1e1e0f55a1207001219"];
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"2579478634" secret:@"74ed06086722c53adb70eeb1783e3aa2" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];

    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    HomeViewController *homeVC= [[HomeViewController alloc] init];
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    
    RESideMenu *sideVC = [[RESideMenu alloc] initWithContentViewController:homeVC leftMenuViewController:leftVC rightMenuViewController:nil];
    // 设置主视图
    sideVC.mainController = homeVC;
    // 菜单首选状态栏样式
    sideVC.menuPreferredStatusBarStyle = 1;
    
    sideVC.delegate = self;
    // 内容视图阴影颜色
    sideVC.contentViewShadowColor = [UIColor whiteColor];
    // 内容视图影子 偏移量
    sideVC.contentViewShadowOffset = CGSizeMake(0, 0);
    // 内容视图影子透明度
    sideVC.contentViewShadowOpacity = 0.65;
    // 内容视图影子半径
    sideVC.contentViewShadowRadius = 12;
    // 内容视图影子是否启用
    sideVC.contentViewShadowEnabled = YES;
    
    self.window.rootViewController = sideVC;
    [self.window makeKeyAndVisible];
    
    PregnancyBudgetViewController *preVC = [[PregnancyBudgetViewController alloc] init];
    UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:preVC];
    NSUserDefaults *uf = [NSUserDefaults standardUserDefaults];
    BOOL yesOrNo = [uf boolForKey:@"haveDate"];
    if (yesOrNo == YES) {
        self.window.rootViewController = sideVC;
    }else {
        self.window.rootViewController = na;
    }
    
    
    return YES;
}

-(BOOL)application:(UIApplication *)app openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation {
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        
    }
    return result;
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

@end
