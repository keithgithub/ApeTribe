//
//  AppDelegate.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/22.
//  Copyright © 2016年 One. All rights reserved.
//

#import "AppDelegate.h"
#import "SlideNavigationController.h"
#import "TabBarViewController.h"
#import "LeftMenuViewController.h"
#import "AppDelegate+ApeTribe.h"
//友盟
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

    
    [self apeTribeApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    // 创建标签栏控制器
    _tabVC = [[TabBarViewController alloc]init];
    // 创建左侧侧滑菜单
    UIStoryboard *storyBoard = STORYBOARD(@"Main");
    LeftMenuViewController *leftMenuVC = [storyBoard instantiateViewControllerWithIdentifier:@"leftMenuVC"];
    // 创建侧滑菜单控制器
    SlideNavigationController *slideMenu = [[SlideNavigationController alloc]initWithRootViewController:_tabVC];
    leftMenuVC.delegate = _tabVC;
    [SlideNavigationController sharedInstance].leftMenu = leftMenuVC;
    // Creating a custom bar button for right menu
    
    //设置友盟的APPKey
    [UMSocialData setAppKey:@"5774e4aee0f55a0ae6001483"];
    //设置微信 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialWechatHandler setWXAppId:@"wx6f2c2f302768cf07" appSecret:@"309d97f1e1da94fdb3427fad32fc2b5d" url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"1105510094" appKey:@"Y7ySWBJQU4CnKOv0" url:@"http://www.umeng.com/social"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"2906728398"
                                              secret:@"340c14750dbe80ff125acecf95330938"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    
    
    [SlideNavigationController sharedInstance].menuRevealAnimationDuration = 0.3;
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidClose object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Closed %@", menu);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidOpen object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Opened %@", menu);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidReveal object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Revealed %@", menu);
    }];
    
    // 创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = slideMenu;
    [self.window makeKeyAndVisible];
    
    return YES;
}
//在APPdelegate.m中增加下面的系统回调配置，注意如果同时使用微信支付、支付宝等其他需要改写回调代理的SDK，请在if分支下做区分，否则会影响 分享、登录的回调
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    BOOL rst=[UMSocialSnsService handleOpenURL:url];
    if (rst==false)
    {
        
    }
    return rst;
}


//添加系统回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
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

@end
