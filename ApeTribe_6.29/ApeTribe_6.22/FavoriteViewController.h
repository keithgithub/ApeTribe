//
//  FavoriteViewController.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/1.
//  Copyright © 2016年 One. All rights reserved.
//

#import "TableViewController.h"
#import "FavoriteXMLModel.h"
@interface FavoriteViewController : TableViewController
@property (nonatomic, strong) NSMutableArray *arrData, *arrPageIndexs;

/**
 *  初始化函数方法
 *
 *  @param style 表格样式(默认第0页)
 *
 *  @return 返回视图控制器
 */
- (instancetype) initWithStyle:(UITableViewStyle)style andOperationType:(TableViewControllerOperationType)type;
/**
 *  初始化函数方法
 *
 *  @param style 表格样式
 *  @param index 控制器显示的第几个页面
 *
 *  @return 返回视图控制器
 */
- (instancetype) initWithStyle:(UITableViewStyle)style andPage:(int)page andOperationType:(TableViewControllerOperationType)type;

@end
