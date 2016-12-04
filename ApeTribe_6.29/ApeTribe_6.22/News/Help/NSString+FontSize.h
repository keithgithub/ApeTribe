//
//  NSString+FontSize.h
//  DrawLine
//
//  Created by ibokan on 16/4/26.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (FontSize)
/**
 *  计算文本内容占用的尺寸
 *
 *  @param fSize 字体的大小
 *  @param width 一行文本的宽度
 *
 *  @return 返回尺寸大小
 */
-(CGSize)calTextAizeWithFontSize:(CGFloat)fSize andTextWidth:(CGFloat)width;
@end
