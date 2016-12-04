//
//  SearchResultTableView.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindXMLModel.h"
@interface SearchResultTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

/**
 *  选中单元格时，跳转到相应用户的个人中心页面
 *
 *  @param name 选中用户的信息
 */
typedef void(^SelectBlock)(FindXMLModel *findModel);
//声明代码块属性，接收初始化时传进来的代码块对象
@property(nonatomic,strong)SelectBlock selectHandel;

@property(nonatomic,strong)NSMutableArray *arrData;//搜索的数据数组
/**
 *  表格初始化
 *
 *  @param frame     大小
 *  @param style     风格
 *  @param selHandel 选中单元格回调
 *
 *  @return 表格对象
 */
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style andSelectBlock:(SelectBlock)selHandel;



@end
