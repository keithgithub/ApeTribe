//
//  InteractivityTransitionDelegate.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/13.
//  Copyright © 2016年 One. All rights reserved.
//

#import "InteractivityTransitionDelegate.h"
#import "InteractivityTransitionAnimator.h"
#import "TransitionInteractionController.h"

@implementation InteractivityTransitionDelegate
#pragma mark - Getter
- (ViewControllerTransition *) mineAnimator
{
    if (!_mineAnimator)
    {
        _mineAnimator = [[ViewControllerTransition alloc] init];
    }
    return _mineAnimator;
}

- (TransitionAnimator *)navigationAnimator
{
    if (!_navigationAnimator)
    {
        _navigationAnimator = [[TransitionAnimator alloc] init];
    }
    return _navigationAnimator;
}

- (instancetype) initWithType:(InteractivityTransitionAnimatorType)type
{
    if (self = [super init])
    {
        self.type = type;
        self.targetEdge = UIRectEdgeNone;
        
    }
    return self;
}
- (id<UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    
    switch (self.type) {
        case TransitionAnimatorTypeMine:
        {
            
            self.mineAnimator.animationType = MyAnimationTypePresent;
            self.mineAnimator.leftView = [SlideNavigationController sharedInstance].leftMenu.view;
            self.customAnimator = self.mineAnimator;
        }
            break;
        case TransitionAnimatorTypeNavigation:
        {
            self.navigationAnimator.animationType = TransitionAnimatorTypePresent;
            self.customAnimator = self.navigationAnimator;
            self.gestureRecognizer = nil;
        }
            break;
        default:
            break;
    }
    
    return self.customAnimator;

}

- (id<UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed
{
    switch (self.type)
    {
        case TransitionAnimatorTypeMine:// 右侧菜单转场
        {
            self.mineAnimator.animationType = MyAnimationTypeDismiss;
            self.mineAnimator.leftView = [SlideNavigationController sharedInstance].leftMenu.view;
            self.customAnimator = self.mineAnimator;
        }
            break;
        case TransitionAnimatorTypeNavigation:// 正常转场
        {
            self.navigationAnimator.animationType = TransitionAnimatorTypeDismiss;
            self.customAnimator = self.navigationAnimator;
        }
            break;
        default:
            break;
    }
    
    return self.customAnimator;

}
/// 前两个函数和淡入淡出demo中的实现一致
/// 后两个函数用于实现交互式动画
- (id<UIViewControllerInteractiveTransitioning>) interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
//    UIScreenEdgePanGestureRecognizer *gestureRecognizer = self.gestureRecognizer;

    switch (self.type)
    {
        case TransitionAnimatorTypeNavigation:
        {
            if (self.gestureRecognizer != nil) {
                return [[TransitionInteractionController alloc]initWithGestureRecognizer:self.gestureRecognizer andEdgeForDragging:self.targetEdge];
            }

        }
            break;
        case TransitionAnimatorTypeMine:
            
            break;
        default:
            break;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>) interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
//    UIScreenEdgePanGestureRecognizer *gestureRecognizer = self.gestureRecognizer;
    
    if (self.gestureRecognizer != nil) {
        TransitionInteractionController *transitionInteractionController =  [[TransitionInteractionController alloc]initWithGestureRecognizer:self.gestureRecognizer andEdgeForDragging:self.targetEdge];
        return transitionInteractionController;
        
    }
    return nil;
}














@end
