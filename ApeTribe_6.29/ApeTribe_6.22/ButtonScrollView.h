//
//  ButtonScrollView.h
//  6.23.OSChina
//
//  Created by ibokan on 16/6/23.
//  Copyright © 2016年 Ldm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallBackBlock)(int index);

@interface ButtonScrollView : UIScrollView


//滑动按钮标题
@property(nonatomic,strong)NSArray * arrTitles;

//滑动条
@property(nonatomic,strong)UIView * moveView;
//按钮
@property(nonatomic,strong)UIButton * btn;

//存储临时代码块
@property(nonatomic,strong)CallBackBlock  callBackBlock;


-(instancetype)initWithFrame:(CGRect)frame andCallBackBlock:(CallBackBlock) handleBlock;


-(void)changeButtonState:(NSInteger)currentPage;


@end
