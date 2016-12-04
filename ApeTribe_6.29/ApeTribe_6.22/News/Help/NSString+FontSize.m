//
//  NSString+FontSize.m
//  DrawLine
//
//  Created by ibokan on 16/4/26.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import "NSString+FontSize.h"
@implementation NSString (FontSize)
-(CGSize)calTextAizeWithFontSize:(CGFloat)fSize andTextWidth:(CGFloat)width;
{
    // self字符串本身
    //第一个参数   一行文本的宽和高CGSizeMake(width, MAXFLOAT)
    // NSStringDrawingUsesLineFragmentOrigin响应的操作方式
    // 样式描述 字体大小 字体号@{NSFontAttributeName:[UIFont systemFontOfSize:fSize]}
    //  上下文  nil
    //  拿到的是宽和高  size
    CGSize size=[self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fSize]} context:nil].size;
    return size;
}
@end
