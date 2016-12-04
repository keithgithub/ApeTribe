//
//  TableViewController.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/1.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InteractivityTransitionDelegate.h"
#define KCELLDEFAULTHEIGHT 50 // 表格的行高
typedef NS_ENUM(NSInteger, TableViewControllerOperationType) {
    TableViewControllerOperationTypeDismiss,
    TableViewControllerOperationTypePop,
    
};
@interface TableViewController : UIViewController

@property (strong, nonatomic) UIView *topView;// 控制器的顶部视图
@property (nonatomic, strong) SegmentView *segmentView;// 按钮视图
@property (strong, nonatomic) NSArray *rightItems;// 导航栏右侧按钮数组
@property (strong, nonatomic) UIView *defaultFooterView;// 默认表尾视图
@property (strong, nonatomic) UITableView *tableView;// 表格
@property (strong, nonatomic) UIView *blankView;// 数据为空时显示的视图
@property (strong, nonatomic) NSMutableArray *dataArray;// 表格数据
@property (strong, nonatomic) NSMutableDictionary *dataDictionary;// 数据字典
@property (nonatomic) int page;
@property (nonatomic, assign) TableViewControllerOperationType type;
@property (nonatomic) BOOL showRefreshHeader;//是否支持下拉刷新
@property (nonatomic) BOOL showRefreshFooter;//是否支持上拉加载
@property (nonatomic) BOOL showTopView;//是否支持顶部视图
@property (nonatomic) BOOL showTableBlankView;//是否显示无数据时默认背景
@property (nonatomic, strong) InteractivityTransitionDelegate *customTransitionDelegate, *myTransitionDelegate;

- (instancetype)initWithStyle:(UITableViewStyle)style andTopView:(BOOL)showTopView andOperationType:(TableViewControllerOperationType)type;

- (void)tableViewDidTriggerHeaderRefresh;//下拉刷新事件
- (void)tableViewDidTriggerFooterRefresh;//上拉加载事件

- (void)tableViewDidFinishTriggerHeader:(BOOL)isHeader reload:(BOOL)reload;
@end
