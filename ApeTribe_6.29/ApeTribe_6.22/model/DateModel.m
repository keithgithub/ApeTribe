//
//  DateModel.m
//  4.26标签栏
//
//  Created by ibokan on 16/4/26.
//  Copyright © 2016年 huangfu. All rights reserved.
//

#import "DateModel.h"
#import <UIKit/UIKit.h>

@implementation DateModel

+(NSArray *)getImgName
{
NSArray *arrImg=@[@"font.png",@"crame.png",@"findme.png",@"audio.png",@"saoyisao.png",@"yaoyiyao.png"];

    return arrImg;
}



+(NSArray *)getTitle
{
NSArray *arrTitle=@[@"心 情",@"照片/拍照",@"找 人",@"吼一声",@"扫一扫",@"抖一抖"];

    return arrTitle;
}

@end
