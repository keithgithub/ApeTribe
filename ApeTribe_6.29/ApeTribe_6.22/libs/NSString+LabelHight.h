//
//  NSString+LabelHight.h
//  Ui6-2
//
//  Created by ibokan on 15/6/1.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (LabelHight)
/**
 *  计算文本高度方法
 *
 *  @param text     要计算的文本内容
 *  @param w        要显示的控件的宽度
 *  @param fontsize 控件显示文本的字体大小
 *
 *  @return 返回计算的文本占用位置的大小（含宽，高）
 */
+(CGSize)calStrSize:(NSString *)text andWidth:(CGFloat)w andFontSize:(CGFloat)fontsize;
/**
 *返回值是该字符串所占的大小(width, height)
 *font : 该字符串所用的字体(字体大小不一样,显示出来的面积也不同)
 *maxSize : 为限制改字体的最大宽和高(如果显示一行,则宽高都设置为MAXFLOAT, 如果显示为多行,只需将宽设置一个有限定长值,高设置为MAXFLOAT)
 */
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end
