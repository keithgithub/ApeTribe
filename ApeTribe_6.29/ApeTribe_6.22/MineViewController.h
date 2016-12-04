//
//  MineViewController.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/22.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CExpandHeader.h"
#import "MineTableViewHeader.h"
#import "FocusAndFansViewController.h"
#import "BlogsXMLModelMine.h"
#import "BlogXMLModelMine.h"
#import "ActiveXMLModel.h"
#import "OtherUserXMLModel.h"
#import "ErrorMessageXMLModel.h"
#import "DetailViewController.h"
#import "PostDetailViewController.h"
#import "NSString+LabelHight.h"
#import "InteractivityTransitionDelegate.h"

typedef NS_ENUM(NSInteger, NavigationControllerOperationType) {
    NavigationControllerOperationTypeDismiss,
    NavigationControllerOperationTypePop,
    
};

@interface MineViewController : UIViewController

@property (strong, nonatomic) MineTableViewHeader *headerView;
@property (nonatomic, strong) NSMutableArray *dataArray, *arrData;
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) UIView *sectionView, *blankView;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) BOOL isMe;// 判断是用户本人还是其他用户
@property (nonatomic, assign) long userId;// 用户id
@property (nonatomic, assign) int firstPageIndex, secondPageIndex;// 记录第一个表格的和第二个表格的当前页码
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, assign) NavigationControllerOperationType type;
@property (nonatomic, strong) OtherUserXMLModel *userModel;
@property (nonatomic, strong) InteractivityTransitionDelegate *customTransitionDelegate;

/**
 *  个人主页视图控制器初始化方法
 *
 *  @param isMe   是否是登录用户本人，YES：是 NO：不是
 *  @param userId 显示主页的用户id
 *
 *  @return 返回视图对象
 */
- (instancetype) initWithState:(BOOL)isMe andUserId:(long)userId andOperationType:(NavigationControllerOperationType)type;
/**
 *  个人主页视图控制器初始化方法
 *
 *  @param isMe   是否是登录用户本人，YES：是 NO：不是
 *  @param userId 显示主页的用户id
 *  @param page   0：动态 1：博客
 *
 *  @return 返回视图对象
 */
- (instancetype) initWithState:(BOOL)isMe andUserId:(long)userId andPage:(int)page andOperationType:(NavigationControllerOperationType)type;
@end
