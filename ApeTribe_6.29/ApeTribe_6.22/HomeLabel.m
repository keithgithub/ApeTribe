//
//  HomeLabel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/5.
//  Copyright © 2016年 One. All rights reserved.
//

#import "HomeLabel.h"

static const CGFloat XMGRed = 0.339;
static const CGFloat XMGGreen = 0.349;
static const CGFloat XMGBlue = 0.357;
@implementation HomeLabel
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15];
        self.textColor = [UIColor colorWithRed:XMGRed green:XMGGreen blue:XMGBlue alpha:1.0];
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}


- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    //      R G B
    // 默认：0.4 0.6 0.7
    // 红色：1   0   0
//    [UIColor colorWithRed:0.325 green:0.761 blue:0.402 alpha:1.000];
    CGFloat red = XMGRed + (0.325 - XMGRed) * scale;
    CGFloat green = XMGGreen + (0.761 - XMGGreen) * scale;
    CGFloat blue = XMGBlue + (0.402 - XMGBlue) * scale;
    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    // 大小缩放比例
    CGFloat transformScale = 1 + scale * 0.3; // [1, 1.3]
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
}



@end
