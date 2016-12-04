//
//  UIButton+Extension.m
//  QueenComing_5.19
//
//  Created by ibokan on 16/5/21.
//  Copyright © 2016年 One. All rights reserved.
//

#import "UIButton+Extension.h"

#define BTN_R 18

@implementation UIButton (Extension)

- (void) setWithFrame:(CGRect)frame andTitle:(NSString *)title andColor:(UIColor *)color andFont:(UIFont *)font
{
    
    self.frame = frame;
    [self setTitle:title forState:UIControlStateNormal];
    self.titleLabel.font = font;
    self.backgroundColor = [UIColor whiteColor];
    self.tintColor = [UIColor blackColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 0.5;
}

- (void) setWithFrame:(CGRect)frame andTitle:(NSString *)title andColor:(UIColor *)color andFont:(UIFont *)font andStyle:(MyButtonStyle)style
{
    self.frame = frame;
    [self setTitle:title forState:UIControlStateNormal];
    self.titleLabel.font = font;
    switch (style) {
        case MyButtonBlankBackgroundStyle:
            self.backgroundColor = [UIColor whiteColor];
            self.tintColor = color;
            self.layer.borderColor = color.CGColor;
            self.layer.borderWidth = 1;
            self.layer.masksToBounds = YES;
            self.layer.cornerRadius = BTN_R;
            break;
        case MyButtonColorBackgroundStyle:
            self.backgroundColor = color;
            self.tintColor = [UIColor whiteColor];
            self.layer.masksToBounds = YES;
            self.layer.cornerRadius = BTN_R;
            break;
        case MyButtonNoneStyle:
            self.backgroundColor = [UIColor whiteColor];
            self.tintColor = color;
            break;
        default:
            break;
    }
}






@end
