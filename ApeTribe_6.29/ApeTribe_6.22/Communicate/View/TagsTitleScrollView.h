//
//  TagsTitleScrollView.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/28.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TagsTitleViewDelegate <NSObject>


@optional
//给代理传递标记然后，根据标记下载数据
-(void)sendMessageWithTag:(NSString*)tag;

@end
@interface TagsTitleScrollView : UIScrollView
@property (nonatomic,assign) id<TagsTitleViewDelegate>gDelegate;

@property (nonatomic,strong) NSArray *arrTitle;//标题

@property (nonatomic,assign) CGFloat contentSizeWidth;//滚动视图的滚动范围
//初始化



-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSArray*)tags;
@end
