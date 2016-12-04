//
//  InteractivityTransitionAnimator.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/13.
//  Copyright © 2016年 One. All rights reserved.
//

#import "InteractivityTransitionAnimator.h"

@implementation InteractivityTransitionAnimator
-(instancetype) initWithTargetEdge:(UIRectEdge)targetEdge
{
    if (self = [super init])
    {
        self.targetEdge = targetEdge;
    }
    return self;
}

- (CGFloat) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35;
}

- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = fromViewController.view;
    UIView *toView = toViewController.view;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)])
    {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }
    /// isPresenting用于判断当前是present还是dismiss
    
    BOOL isPresenting = (toViewController.presentingViewController == fromViewController);
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect toFrame = [transitionContext initialFrameForViewController:toViewController];
    
    /// offset结构体将用于计算toView的位置
    CGVector offset = CGVectorMake(0, 0);
    switch (self.targetEdge) {
        case UIRectEdgeTop:
            offset = CGVectorMake(0, 1);
            break;
        case UIRectEdgeBottom:
            offset = CGVectorMake(0, -1);
            break;
        case UIRectEdgeLeft:
            offset = CGVectorMake(1, 0);
            break;
        case UIRectEdgeRight:
            offset = CGVectorMake(-1, 0);
            break;
        default:
            NSLog(@"targetEdge must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.");
            break;
    }
    /// 根据当前是dismiss还是present，横屏还是竖屏，计算好toView的初始位置以及结束位置
    if (isPresenting)
    {
        fromView.frame = fromFrame;
        toView.frame = CGRectOffset(toFrame, toFrame.size.width * offset.dx * -1,toFrame.size.height * offset.dy * -1);
        [containerView addSubview:toView];
    }
    else
    {
        fromView.frame = fromFrame;
        toView.frame = toFrame;
        [containerView insertSubview:toView belowSubview:fromView];
    }
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        if (isPresenting)
        {
            toView.frame  =toFrame;
        }
        else
        {
            toView.frame = CGRectOffset(fromFrame, fromFrame.size.width * offset.dx,fromFrame.size.height * offset.dy);
        }
    } completion:^(BOOL finished)
    {
        BOOL wasCanceled = [transitionContext transitionWasCancelled];
        if (wasCanceled)
        {
            [toView removeFromSuperview];
            [transitionContext completeTransition:!wasCanceled];
        }
    }];
}

















@end
