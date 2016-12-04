//
//  LeftMenuViewController.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/22.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "ViewControllerTransition.h"
#import "CExpandHeader.h"
#import "MineTopView.h"



typedef enum : NSUInteger {
    MineViewControllerType,// 个人主页
    FavoriteViewControllerType,// 收藏
    SettingViewControllerType,// 设置
    MessageViewControllerType,// 消息
    LoginViewControllerType,// 登录
    FocusAndFansViewControllerType,// 粉丝关注
    BlankViewControllerType,// 空的视图控制器
    FeedBackViewControllerType,// 反馈视图控制器
} MyViewControllerType;

@protocol LeftMenuViewControllerDelegate <NSObject>

- (void) presentViewController:(MyViewControllerType)type andIndex:(int)index;

@end

@interface LeftMenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIViewControllerTransitioningDelegate>
@property (nonatomic, assign) id <LeftMenuViewControllerDelegate> delegate;
@property (nonatomic, strong) MineTopView *topEffectview;// 表格顶部视图
@property (nonatomic, assign) MyViewControllerType type;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrData;// 表格数据数组
@property (nonatomic, strong) UIWindow *backWindow;
@property (nonatomic, strong) UIVisualEffectView *darkView;
@property (nonatomic, strong) UIImageView *qrImagView;
@end
