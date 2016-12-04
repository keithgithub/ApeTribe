//
//  TransitionInteractionController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/13.
//  Copyright © 2016年 One. All rights reserved.
//

#import "TransitionInteractionController.h"

@implementation TransitionInteractionController
- (instancetype) initWithGestureRecognizer:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer andEdgeForDragging:(UIRectEdge)edge
{
    if (self = [super init])
    {
        self.gestureRecognizer = gestureRecognizer;
        self.edge = edge;
        [self.gestureRecognizer addTarget:self action:@selector(gestureRecognizeDidUpdate:)];
    }
    return self;
}

- (void) startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    [super startInteractiveTransition:transitionContext];
    
}

/**
 用于根据计算动画完成的百分比
 
 :param: gesture 当前的滑动手势，通过这个手势获取滑动的位移
 
 :returns: 返回动画完成的百分比
 */

- (CGFloat) percentForGesture:(UIScreenEdgePanGestureRecognizer *)gesture
{
    UIView *transitionContainerView = self.transitionContext.containerView;
    CGPoint locationInSourceView = [gesture locationInView:transitionContainerView];
    CGFloat width = transitionContainerView.bounds.size.width;
    CGFloat height = transitionContainerView.bounds.size.height;
    CGFloat percent = 0;
    switch (self.edge)
    {
        case UIRectEdgeRight:
            percent = (width - locationInSourceView.x) / width;
            break;
        case UIRectEdgeLeft:
            percent = locationInSourceView.x / width;
            break;
        case UIRectEdgeBottom:
            percent = (height - locationInSourceView.y) / height;
            break;
        case UIRectEdgeTop:
            percent = locationInSourceView.y / height;
            break;
        default:
            break;
    }
    return percent;
}

// 当手势有滑动时触发这个函数
- (void) gestureRecognizeDidUpdate:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer
{
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged://手势滑动，更新百分比
            [self updateInteractiveTransition:[self percentForGesture:gestureRecognizer]];
            break;
        case UIGestureRecognizerStateEnded:// 滑动结束，判断是否超过一半，如果是则完成剩下的动画，否则取消动画
            if ([self percentForGesture:gestureRecognizer] >= 0.5)
            {
                [self finishInteractiveTransition];
            }
            else
            {
                [self cancelInteractiveTransition];
            }
            break;
        default:
            break;
    }
}





















@end
