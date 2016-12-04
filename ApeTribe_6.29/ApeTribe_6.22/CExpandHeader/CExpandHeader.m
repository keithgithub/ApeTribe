//
//  CExpandHeader.m
//  CExpandHeaderViewExample
//
//  Created by cml on 14-8-27.
//  Copyright (c) 2014年 Mei_L. All rights reserved.
//

#define CExpandContentOffset @"contentOffset"

#import "CExpandHeader.h"

@implementation CExpandHeader{
    __weak UIScrollView *_scrollView; //scrollView或者其子类
    __weak UITableView *_tableView; // 表格
    __weak UIView *_expandView; //背景可以伸展的View
    __weak UIImageView *_bgImgV; // 背景图片
    CGFloat _expandHeight;
    CGFloat originYImgV;
    CGFloat heightImgV;
    CGFloat expandOffset;
    CGFloat _topEdgeInsets;
    CGFloat _topOriginYImgV;
    CGFloat _ImgVOriginY;
}

- (void)dealloc{
    if (_scrollView) {
        [_scrollView removeObserver:self forKeyPath:CExpandContentOffset];
        _scrollView = nil;
    }
    _expandView = nil;
}

+ (id)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView{
    CExpandHeader *expandHeader = [CExpandHeader new];
    [expandHeader expandWithScrollView:scrollView expandView:expandView];
    return expandHeader;
}

/**
 *  给表格设置表头视图
 *
 *  @param tableView  表格
 *  @param expandView 表头视图
 *  @param imgV       背景图片
 */
- (void)expandWithTableView:(UITableView *)tableView expandView:(UIView *)expandView andBackgroundImgV:(UIImageView *)imgV andTopEdgeInsets:(CGFloat)topEdgeInsets
{
    _ImgVOriginY = -20;
    _tableView = tableView;
    _tableView.tableHeaderView = expandView;
    _expandHeight = expandView.frame.size.height;
    _scrollView = tableView;
    [_scrollView addObserver:self forKeyPath:CExpandContentOffset options:NSKeyValueObservingOptionNew context:nil];
    _scrollView.contentInset = UIEdgeInsetsMake(topEdgeInsets, 0, 0, 0);
    _topEdgeInsets = topEdgeInsets;
    
    _bgImgV = imgV;
    originYImgV = imgV.frame.origin.y;
    heightImgV = imgV.frame.size.height;
    
    
    //使View可以伸展效果  重要属性
    _bgImgV.contentMode= UIViewContentModeScaleAspectFill;
    _bgImgV.clipsToBounds = YES;
    
}
- (void)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView{
    
    
    _expandHeight = CGRectGetHeight(expandView.frame);
    
    _scrollView = scrollView;
    _scrollView.contentInset = UIEdgeInsetsMake(_expandHeight, 0, 0, 0);
    [_scrollView insertSubview:expandView atIndex:0];
    // 注册，指定被观察者的属性
    [_scrollView addObserver:self forKeyPath:CExpandContentOffset options:NSKeyValueObservingOptionNew context:nil];
    [_scrollView setContentOffset:CGPointMake(0, -180)];

    _expandView = expandView;
    
    //使View可以伸展效果  重要属性
    _expandView.contentMode= UIViewContentModeScaleAspectFill;
    _expandView.clipsToBounds = YES;
    
    [self reSizeView];

}
// 实现回调方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (![keyPath isEqualToString:CExpandContentOffset]) {
        return;
    }
    [self scrollViewDidScroll:_scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY < _expandHeight * -1)
    {
        CGRect currentFrame = _expandView.frame;
        currentFrame.origin.y = offsetY;
        currentFrame.size.height = -1*offsetY;
        _expandView.frame = currentFrame;
        CGFloat currentHeight = _expandView.frame.size.height;
        for (UIView *v in _expandView.subviews)
        {
            if (v.tag == 400 || v.tag == 401)
            {
                CGRect sFrame = v.frame;
                sFrame.origin.y = currentHeight - _expandHeight;
                v.frame = sFrame;
                
            }
            

        }
    }
    // 设置动画
    if (_bgImgV.frame.origin.y > -heightImgV || offsetY < _expandHeight - _topEdgeInsets) {
        CGRect frameImgV = _bgImgV.frame;
        if (frameImgV.origin.y < _ImgVOriginY) {
            frameImgV.origin.y = originYImgV - (offsetY + _topEdgeInsets) / 2.0;
            expandOffset = offsetY;
            
        }
        else
        {
            if (offsetY >= expandOffset)
            {
                
                frameImgV.origin.y = originYImgV - (offsetY + _topEdgeInsets) / 2.0;
                
            }
            else
            {
                frameImgV.origin.y = _ImgVOriginY;
                frameImgV.size.height = heightImgV - (offsetY - expandOffset);
                for (UIView *v in _bgImgV.subviews)
                {
                    if ([v isKindOfClass:[UIVisualEffectView class]])
                    {
                        v.frame = frameImgV;
                        
                    }
                }
            }

        }
        if (_bgImgV.frame.origin.y > _ImgVOriginY)
        {
            frameImgV.origin.y = _ImgVOriginY;
        }
        
        _bgImgV.frame = frameImgV;
        
    }
    
}

- (void)reSizeView{

    //重置_expandView位置
    [_expandView setFrame:CGRectMake(0, -1*_expandHeight, CGRectGetWidth(_expandView.frame), _expandHeight)];
    
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
