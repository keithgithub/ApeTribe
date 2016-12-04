//
//  DiscoverTableView.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/25.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoftXMLModel.h"
typedef void(^TableViewCellBlock)(SoftXMLModel * softXMLModel);
//声明下拉刷新加载第一页的协议
@protocol DiscoverTableViewDelegate <NSObject>

/**
 *  下拉刷新下载第一页
 *
 *  @param page    页码，填写1（下拉刷新）
 *  @param tableTag    当前表格
 */

-(void)loadGoodsDataWithCurrentPage:(long)page andTableTag:(NSInteger)tableTag;

@end


//表格单元格的样式
typedef enum NSInteger
{
    DiscoverTableViewCellLeftStyle,//分类
    DiscoverTableViewCellSubtitleStyle//其他四个
    
}DiscoverTableViewCellStyle;

@interface DiscoverTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)id<DiscoverTableViewDelegate>loadDelegat;//代理属性
@property (nonatomic, strong) NSMutableArray *arrData;//下载的表格数据
/**表格样式*/
@property(nonatomic,assign)DiscoverTableViewCellStyle cellStyle;

//当前下载页码
@property (nonatomic,assign) long currentPage;

//当前下载个数
@property (nonatomic,assign) long pagesize;
//判读是那个表格
@property (nonatomic,assign) NSInteger tableTag;//(0,1,2,3,4)
/**选中单元格代码块属性*/
@property(nonatomic,strong)TableViewCellBlock tVCellBlock;

//重写初始化方法
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style andcellStyle:(DiscoverTableViewCellStyle)cellStyle andTableViewCellBlock:(TableViewCellBlock)tVCellBlock;

@end
