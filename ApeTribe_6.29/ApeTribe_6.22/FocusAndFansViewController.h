//
//  FocusAndFansViewController.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/1.
//  Copyright © 2016年 One. All rights reserved.
//

#import "TableViewController.h"
#import "FriendXMLModel.h"
@interface FocusAndFansViewController : TableViewController
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, assign) long userId;// 需要获取的用户id
/**
 *  初始化函数方法
 *
 *  @param style 表格的风格
 *  @param uid   需要获取的用户id
 *  @param index 0：关注列表 1：粉丝列表
 *
 *  @return 返回控制器对象
 */
- (instancetype) initWithStyle:(UITableViewStyle)style andUserId:(long)uid andIndex:(int)index andOperationType:(TableViewControllerOperationType)type;
@end
