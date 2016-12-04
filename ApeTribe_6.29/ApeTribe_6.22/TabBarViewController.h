//
//  TabBarViewController.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/22.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "SingleTon.h"
#import "LeftMenuViewController.h"
#import "MineMessageViewController.h"
#import "NavigationViewController.h"
#import "BaseTableViewController.h"
#import "UIButton+WebCache.h"

@interface TabBarViewController : UITabBarController <SlideNavigationControllerDelegate,LeftMenuViewControllerDelegate>
singleton_interface(TabBarViewController)
@property (nonatomic, strong) UIButton *button;

@end
