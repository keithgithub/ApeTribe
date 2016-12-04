//
//  HFTextView.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/7.
//  Copyright © 2016年 One. All rights reserved.
//

#import "HFTextView.h"

@implementation HFTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.placeholder = [[UILabel alloc]initWithFrame:CGRectMake(5, 3, frame.size.width, 21)];
        self.placeholder.text = @"赶紧来吐槽一下吧？";
        self.placeholder.textColor = [UIColor colorWithWhite:0.400 alpha:1.000];
        self.placeholder.font = [UIFont systemFontOfSize:12];
        [ self addSubview:self.placeholder];

        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithWhite:0.800 alpha:1.000].CGColor;
      
    }
    return self;
}



@end
