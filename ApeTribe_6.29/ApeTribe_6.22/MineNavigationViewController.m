//
//  MineNavigationViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/28.
//  Copyright © 2016年 One. All rights reserved.
//

#import "MineNavigationViewController.h"

@interface MineNavigationViewController ()

@end

@implementation MineNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏样式
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont  systemFontOfSize:18],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    


}
- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
