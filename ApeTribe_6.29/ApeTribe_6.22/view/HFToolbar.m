//
//  HFToolbar.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/25.
//  Copyright © 2016年 One. All rights reserved.
//

#import "HFToolbar.h"
#import "Tool.h"
@implementation HFToolbar

-(instancetype)initWithFrame:(CGRect)frame andToolbarBlock:(toobarBlock)tBlock
{
    if (self = [super initWithFrame:frame])
    {
        self.tBlock = tBlock;
        //创建按钮
        UIBarButtonItem *img1 = [[UIBarButtonItem alloc]initWithImage:[Tool getRendingImageWithName:@"toolbar-image@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(btnAction:)];
        img1.tag = 1;
        // 弹簧 系统类型
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *img2 = [[UIBarButtonItem alloc]initWithImage:[Tool getRendingImageWithName:@"toolbar-mention@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(btnAction:)];
        img2.tag = 2;
        // 弹簧 系统类型
        UIBarButtonItem *flexSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *img3 = [[UIBarButtonItem alloc]initWithImage:[Tool getRendingImageWithName:@"toolbar-reference@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(btnAction:)];
        img3.tag = 3;
        // 弹簧 系统类型
        UIBarButtonItem *flexSpace2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *img4 = [[UIBarButtonItem alloc]initWithImage:[Tool getRendingImageWithName:@"toolbar-emoji@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(btnAction:)];
        img4.tag = 4;
        self.items = @[img1,flexSpace,img2,flexSpace1,img3,flexSpace2,img4];
        
    }
    return self;
}


-(void)btnAction:(UIBarButtonItem *)sender
{
    self.tBlock(sender);
    
}


@end
