//
//  TransitionAnimator.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/14.
//  Copyright © 2016年 One. All rights reserved.
//

#import "TransitionAnimator.h"

@implementation TransitionAnimator
- (UIView *)fadeAnimationView
{
    if (!_fadeAnimationView) {
        _fadeAnimationView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _fadeAnimationView.backgroundColor = [UIColor whiteColor];
    }
   
    return _fadeAnimationView;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}
- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (self.animationType) {
        case TransitionAnimatorTypePresent:
            [self animateTransitionPresent:transitionContext];
            break;
        case TransitionAnimatorTypeDismiss:
            [self animateTransitionDismiss:transitionContext];
            break;
        default:
            break;
    }
    
}

- (void) animateTransitionPresent:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // 可以看做为destination ViewController
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 可以看做为source ViewController
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    // 添加toView到容器上
    
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = fromViewController.view;
    UIView *toView = toViewController.view;
    if ([toViewController respondsToSelector:@selector(viewForKey:)])
    {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }
    
    
    
    
    toView.transform = CGAffineTransformMakeTranslation(IPHONE_W, 0);
    fromView.transform = CGAffineTransformMakeTranslation(0, 0);

    // 如果是XCode5 就是用这段
    [containerView addSubview:self.fadeAnimationView];
    [containerView addSubview:fromView];
    [containerView addSubview:toView];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.alpha = 0.0;
        // 动画效果有很多,这里就展示个左偏移
        toView.transform = CGAffineTransformMakeTranslation(0, 0);
        fromView.transform = CGAffineTransformMakeTranslation(-IPHONE_W / 3.0, 0);
        
        
    } completion:^(BOOL finished) {
        [self.fadeAnimationView removeFromSuperview];
        fromViewController.view.transform = CGAffineTransformIdentity;
        // 声明过渡结束-->记住，一定别忘了在过渡结束时调用 completeTransition: 这个方法
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];

}

- (void) animateTransitionDismiss:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // 可以看做为destination ViewController
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 可以看做为source ViewController
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    

    
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = fromViewController.view;
    UIView *toView = toViewController.view;
    if ([toViewController respondsToSelector:@selector(viewForKey:)])
    {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }
    toView.alpha = 0.01;
    // 添加toView到容器上
    [containerView addSubview:self.fadeAnimationView];
    [containerView addSubview:toView];
    [containerView addSubview:fromView];
    
    fromView.transform = CGAffineTransformMakeTranslation(0, 0);
    toView.transform = CGAffineTransformMakeTranslation(-IPHONE_W/ 3.0, 0);
    
    

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.alpha = 1.0;
        // 动画效果有很多,这里就展示个左偏移
        fromView.transform = CGAffineTransformMakeTranslation(IPHONE_W, 0);
        toView.transform = CGAffineTransformMakeTranslation(0, 0);
        
 
    } completion:^(BOOL finished) {
        toView.transform = CGAffineTransformIdentity;
        fromView.transform = CGAffineTransformIdentity;
        
        // 声明过渡结束-->记住，一定别忘了在过渡结束时调用 completeTransition: 这个方法
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
//    if (isPresenting)
//    {
//        fromView.frame = fromFrame;
//        toView.frame = CGRectOffset(toFrame, toFrame.size.width * offset.dx * -1,toFrame.size.height * offset.dy * -1);
//        [containerView addSubview:toView];
//    }
//    else
//    {
//        fromView.frame = fromFrame;
//        toView.frame = toFrame;
//        [containerView insertSubview:toView belowSubview:fromView];
//    }
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        if (isPresenting)
//        {
//            toView.frame  =toFrame;
//        }
//        else
//        {
//            toView.frame = CGRectOffset(fromFrame, fromFrame.size.width * offset.dx,fromFrame.size.height * offset.dy);
//        }
//    } completion:^(BOOL finished)
//     {
//         BOOL wasCanceled = [transitionContext transitionWasCancelled];
//         if (wasCanceled)
//         {
//             [toView removeFromSuperview];
//             [transitionContext completeTransition:!wasCanceled];
//         }
//     }];


}
@end
