//
//  UILabel+Extension.m
//  QueenComing_5.19
//
//  Created by ibokan on 16/5/21.
//  Copyright © 2016年 One. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
/**
 *  将UILabel设置为特定背景颜色矩形
 *
 *  @param frame 位置大小
 *  @param color 背景颜色
 */
- (void) rectWithFrame:(CGRect)frame andColor:(UIColor *)color
{
    self.frame = frame;
    self.backgroundColor = color;
}
/**
 *  将UILabel设置为特定颜色的线条（线条宽度为1个像素）
 *
 *  @param color   线条的颜色
 *  @param length   线条的长度
 *  @param originX 线条的纵坐标
 *  @param originY 线条的横坐标
 
 *  @param style   线条的方向（水平或者垂直）
 */
- (void) lineWithColor:(UIColor *)color andLength:(CGFloat)length andOriginX:(CGFloat)originX andOriginY:(CGFloat)originY andStyle:(UILabelLineStyle)style
{
    switch (style) {
        case UILabelhorizontalLineStyle:// 水平线条
            [self rectWithFrame:CGRectMake(originX, originY, length, 0.5) andColor:color];
            break;
        case UILabelVerticalLineStyle:// 垂直线条
            [self rectWithFrame:CGRectMake(originX, originY, 0.5, length) andColor:color];
            break;
        default:
            break;
    }
    
}
/**
 *  将UILabel设置为特定颜色和宽度的矩形框
 *
 *  @param frame       位置大小
 *  @param color       边框颜色
 *  @param borderWidth 边框宽度
 */
- (void) borderWithFrame:(CGRect)frame andColor:(UIColor *)color andBorderWidth:(CGFloat)borderWidth
{
    [self rectWithFrame:frame andColor:[UIColor whiteColor]];
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = borderWidth;
}
/**
 *  将UILabel设置为特定颜色、宽度和特定圆角半径的圆角矩形框
 *
 *  @param frame       位置大小
 *  @param color       边框颜色
 *  @param borderWidth 边框宽度
 *  @param radius      圆角半径
 */
- (void) borderWithFrame:(CGRect)frame andColor:(UIColor *)color andBorderWidth:(CGFloat)borderWidth andCornerRadius:(CGFloat)radius
{
    [self borderWithFrame:frame andColor:color andBorderWidth:borderWidth];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}


@end
