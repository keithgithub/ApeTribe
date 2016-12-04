//
//  AppDelegate+ApeTribe.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import "AppDelegate+ApeTribe.h"
#import "LoginViewController.h"

@implementation AppDelegate (ApeTribe)

- (void) apeTribeApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];
    // 判断是否已经登录
    if ([[Tool readLoginState:LOGIN_STATE]isEqualToString:@"1"] && ACCESS_TOKEN)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
        
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
        
    }
    NSLog(@"ACCESS_TOKEN == %@",ACCESS_TOKEN);
    // 设置弹框的持续时间
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    if (![Tool isExistenceNetwork])
    {
        [SVProgressHUD showImage:Image(@"icon_net_empty") status:@"无网络"];
    }
}
#pragma mark - login changed

- (void)loginStateChange:(NSNotification *)notification
{
    BOOL loginSuccess = [notification.object boolValue];
    if (loginSuccess)
    {
        // 登陆状态
        [[NetWorkHelp shareHelper]asyncUserInfoFromServer];

    }
    else
    {
        
    }
    
    
}



@end
