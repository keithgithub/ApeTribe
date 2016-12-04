//
//  DiscoveryViewController.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/22.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>


//下载数据类型
typedef enum NSUInteger
{
    software_listStyle,//第一级
    softwarecatalog_listStyle,//第二级
    softwaredetail_listStyle
}softwareStyle;
@interface DiscoveryViewController : UIViewController
@property (nonatomic, assign) NSInteger index;// 显示的页面（0：分类 1：推荐 2：最新 3：热门 4：国产）
@property (nonatomic, assign) NSInteger showtag,showJava ;//判断是不是视图出现
/**下载样式*/
@property(nonatomic,assign)softwareStyle softStyle;


@end
