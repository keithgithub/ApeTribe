//
//  ViewControllerTransition.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/23.
//  Copyright © 2016年 One. All rights reserved.
//

#import "ViewControllerTransition.h"
#import "MineViewController.h"
#import "LeftMenuViewController.h"
@implementation ViewControllerTransition
//
- (void)setEnableShadow:(BOOL)enable
{
    _enableShadow = enable;
    
    if (enable)
    {
        self.view.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        self.view.layer.shadowRadius = MENU_SHADOW_RADIUS;
        self.view.layer.shadowOpacity = MENU_SHADOW_OPACITY;
        self.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
        self.view.layer.shouldRasterize = YES;
        self.view.layer.rasterizationScale = [UIScreen mainScreen].scale;
    }
    else
    {
        self.view.layer.shadowOpacity = 0;
        self.view.layer.shadowRadius = 0;
    }
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35f;
}
- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // 可以看做为destination ViewController
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 可以看做为source ViewController
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    // 如果是XCode5 就是用这段
    UIView * snap = [_leftView snapshotViewAfterScreenUpdates:YES];
    
    
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = fromViewController.view;
    UIView *toView = toViewController.view;
    
//    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
//    CGRect toFrame = [transitionContext initialFrameForViewController:toViewController];
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)])
    {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }
    // 添加toView到容器上
    if (self.animationType == MyAnimationTypePresent)
    {
        toView.transform = CGAffineTransformMakeTranslation(IPHONE_W, 0);
        fromView.transform = CGAffineTransformMakeTranslation(0, 0);
        snap.transform = CGAffineTransformMakeTranslation(0, 0);
        self.view = toView;
        self.enableShadow = YES;
//        CGRect frame = toView.frame;
//        frame.origin.x = IPHONE_W;
//        toView.frame = frame;
//        
//        fromView.frame = fromFrame;
//        
//        frame = snap.frame;
//        frame.origin.x = 0;
//        snap.frame = frame;
        
        // 如果是XCode5 就是用这段
        [containerView addSubview:snap];
        [containerView addSubview:fromView];
        [containerView addSubview:toView];
        
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            // 动画效果有很多,这里就展示个左偏移
            toView.transform = CGAffineTransformMakeTranslation(0, 0);
            fromView.transform = CGAffineTransformMakeTranslation(-IPHONE_W / 3.0, 0);
            snap.transform = CGAffineTransformMakeTranslation(-IPHONE_W / 3.0, 0);
//            CGRect frame = toView.frame;
//            frame.origin.x = 0;
//            toView.frame = frame;
//            
//            frame = fromFrame;
//            frame.origin.x = fromFrame.origin.x - IPHONE_W / 4.0;
//            fromView.frame = frame;
//            
//            frame = snap.frame;
//            frame.origin.x = - IPHONE_W / 4.0;
//            snap.frame = frame;
            
        } completion:^(BOOL finished) {
            fromView.transform = CGAffineTransformIdentity;
//            [fromView removeFromSuperview];
            // 声明过渡结束-->记住，一定别忘了在过渡结束时调用 completeTransition: 这个方法
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];

    }
    else
    {

        
        
//        CGRect frame = snap.frame;
//        frame.origin.x = -IPHONE_W/ 4.0;
//        snap.frame = frame;
//        
//
//        toView.frame = toFrame;
//        
//
//        fromView.frame = fromFrame;
        
        self.view = fromView;
        self.enableShadow = YES;
        fromView.transform = CGAffineTransformMakeTranslation(0, 0);
        toView.transform = CGAffineTransformMakeTranslation(-IPHONE_W/ 3.0, 0);
        snap.transform = CGAffineTransformMakeTranslation(-IPHONE_W / 3.0, 0);
        
        [containerView addSubview:snap];
        [containerView addSubview:toView];
        [containerView addSubview:fromView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
//            CGRect frame = toFrame;
//            frame.origin.x = frame.origin.x + IPHONE_W / 4.0;
//            toView.frame = frame;
//            
//            frame = fromView.frame;
//            frame.origin.x = IPHONE_W;
//            fromView.frame = frame;
//            
//            frame = snap.frame;
//            frame.origin.x = 0;
//            snap.frame = frame;

            // 动画效果有很多,这里就展示个左偏移
            fromView.transform = CGAffineTransformMakeTranslation(IPHONE_W, 0);
            toView.transform = CGAffineTransformMakeTranslation(0, 0);
            snap.transform = CGAffineTransformMakeTranslation(0, 0);
            
            
        } completion:^(BOOL finished) {
            toView.transform = CGAffineTransformIdentity;
            // 声明过渡结束-->记住，一定别忘了在过渡结束时调用 completeTransition: 这个方法
//            [toView removeFromSuperview];
            BOOL wasCanceled = [transitionContext transitionWasCancelled];
            if (wasCanceled)
            {
                [toView removeFromSuperview];
            }
            [transitionContext completeTransition:!wasCanceled];
//            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];

    }
   
}
@end
