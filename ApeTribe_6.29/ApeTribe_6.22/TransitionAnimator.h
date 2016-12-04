//
//  TransitionAnimator.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/14.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    TransitionAnimatorTypePresent,
    TransitionAnimatorTypeDismiss,
} TransitionAnimatorType;

@interface TransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) TransitionAnimatorType animationType;
@property (nonatomic, weak) UIViewController *fadeViewController;
@property (nonatomic, strong) UIView *fadeAnimationView;

@end
