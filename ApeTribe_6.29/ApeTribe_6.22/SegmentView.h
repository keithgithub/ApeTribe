//
//  SegmentView.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/25.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Extension.h"
typedef void(^ClickButtonCallBackBlock)(int index);

@interface SegmentView : UIView
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) NSArray *arrTitles;
@property (nonatomic, assign) int index;// 当前选中的按钮下标
@property (nonatomic, strong) ClickButtonCallBackBlock clickHandle;
/**
 *  初始化函数方法（默认选中第0个按钮）
 *
 *  @param frame           视图的位置大小
 *  @param backgroundColor 选中按钮和视图边框的颜色
 *  @param arrTitles       按钮标题的字符串数组
 *
 *  @return 返回视图对象
 */

- (instancetype) initWithFrame:(CGRect)frame andBackgroundColor:(UIColor *) backgroundColor andTitles:(NSArray *)arrTitles;
/**
 *  初始化函数方法
 *
 *  @param frame           视图的位置大小
 *  @param index           选中的按钮下标（从0开始）
 *  @param backgroundColor 选中按钮和视图边框的颜色
 *  @param arrTitles       按钮标题的字符串数组
 *
 *  @return 返回视图对象
 */
- (instancetype) initWithFrame:(CGRect)frame andIndex:(int)index andBackgroundColor:(UIColor *) backgroundColor andTitles:(NSArray *)arrTitles;


@end
