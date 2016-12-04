//
//  PDTransitionAnimator.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/23.
//  Copyright © 2016年 One. All rights reserved.
//

#import "PDTransitionAnimator.h"

@implementation PDTransitionAnimator
#define Switch_Time 1.2
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return Switch_Time;
}

#define Button_Width 50.f
#define Button_Space 10.f
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView * toView = toViewController.view;
    UIView * fromView = fromViewController.view;
    
    if (self.animationType == AnimationTypeDismiss) {
        // 这个方法能够高效的将当前显示的view截取成一个新的view.你可以用这个截取的view用来显示.例如,也许你只想用一张截图来做动画,毕竟用原始的view做动画代价太高.因为是截取了已经存在的内容,这个方法只能反应出这个被截取的view当前的状态信息,而不能反应这个被截取的view以后要显示的信息.然而,不管怎么样,调用这个方法都会比将view做成截图来加载效率更高.
        UIView * snap = [toView snapshotViewAfterScreenUpdates:YES];
        [transitionContext.containerView addSubview:snap];
        [snap setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - Button_Width - Button_Space, [UIScreen mainScreen].bounds.size.height - Button_Width - Button_Space, Button_Width, Button_Width)];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            [snap setFrame:[UIScreen mainScreen].bounds];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                [[transitionContext containerView] addSubview:toView];
                snap.alpha = 0;
            } completion:^(BOOL finished) {
                [snap removeFromSuperview];
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
        }];
    } else {
        UIView * snap2 = [toView snapshotViewAfterScreenUpdates:YES];
        [transitionContext.containerView addSubview:snap2];
        UIView * snap = [fromView snapshotViewAfterScreenUpdates:YES];
        [transitionContext.containerView addSubview:snap];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            [snap setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - Button_Width - Button_Space+ (Button_Width/2), [UIScreen mainScreen].bounds.size.height - Button_Width - Button_Space + (Button_Width/2), 0, 0)];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                //snap.alpha = 0;
            } completion:^(BOOL finished) {
                [snap removeFromSuperview];
                [snap2 removeFromSuperview];
                [[transitionContext containerView] addSubview:toView];
                // 切记不要忘记了噢
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
        }];
        
    }
}
@end
