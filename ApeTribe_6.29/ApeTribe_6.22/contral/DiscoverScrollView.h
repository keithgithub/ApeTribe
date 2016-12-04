//
//  DiscoverScrollView.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/25.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverTableView.h"
#import "SoftXMLModel.h"
typedef void(^SetTitleBlock)(NSInteger index);
typedef void(^DisSelectTabCellBlock)(SoftXMLModel *softXMLModel);
@interface DiscoverScrollView : UIScrollView<UIScrollViewDelegate,DiscoverTableViewDelegate>
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray *arrTableDatas;
@property (nonatomic, strong) NSArray *arrTableViews;
@property (nonatomic, strong) SetTitleBlock setTitleHandle;

@property(nonatomic,strong)NSDictionary*dict;
/**存储数据的数组*/
@property(nonatomic,strong)NSMutableArray*mData,*mArr;
/**获取网络参数的数组*/
@property(nonatomic,strong)NSMutableArray*paramArray;
/**获取从控制器获取的数据*/
@property(nonatomic,strong)NSMutableArray*oneArray;
/**表格*/
@property(nonatomic,strong)DiscoverTableView *classifyTV;
/**表格*/
@property(nonatomic,strong)DiscoverTableView *recommendTV;
/**表格*/
@property(nonatomic,strong)DiscoverTableView *newsTV;
/**表格*/
@property(nonatomic,strong)DiscoverTableView *hotTV;
/**表格*/
@property(nonatomic,strong)DiscoverTableView*chinaTV;
/**选中单元格代码块属性*/
@property(nonatomic,strong)DisSelectTabCellBlock selectTabCellBlock;
/**
 *  初始化函数方法
 *
 *  @param frame 位置大小
 *  @param index 显示页面的页码
 *
 *  @return 返回视图对象
 */


- (instancetype) initWithFrame:(CGRect)frame andIndex:(NSInteger)index andTitleBlock:(SetTitleBlock)titleBlock andDisSelectTabCellBlock:(DisSelectTabCellBlock)selectTabCellBlock;

/**
 *  设置显示的表格
 *
 *  @param index 表格的页码
 */
- (void) setScrollContentOffset:(NSInteger)index;

@end
