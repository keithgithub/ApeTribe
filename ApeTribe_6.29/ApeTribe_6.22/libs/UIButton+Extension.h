//
//  UIButton+Extension.h
//  QueenComing_5.19
//
//  Created by ibokan on 16/5/21.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    MyButtonColorBackgroundStyle,// 背景有颜色，字体为白色的实心的样式
    MyButtonBlankBackgroundStyle,// 背景白色，有颜色和字体颜色一样的边框的样式
    MyButtonNoneStyle,// 背景白色，无边框，有颜色的字体的样式
} MyButtonStyle;
@interface UIButton (Extension)
/**
 *  便利构造器
 *
 *  @param buttonType      按钮风格
 *  @param frame           位置大小
 *  @param btnActionHandle 按钮点击执行的代码块
 *
 *  @return 返回按钮对象
 */
- (void) setWithFrame:(CGRect)frame
                     andTitle:(NSString *)title
                     andColor:(UIColor *)color
                      andFont:(UIFont *)font;
/**
 *  便利构造器
 *
 *  @param buttonType      按钮风格
 *  @param frame           位置大小
 *  @param btnActionHandle 按钮点击执行的代码块
 *
 *  @return 返回按钮对象
 */
- (void) setWithFrame:(CGRect)frame
                     andTitle:(NSString *)title
                     andColor:(UIColor *)color
                      andFont:(UIFont *)font
                     andStyle:(MyButtonStyle)style;




@end
