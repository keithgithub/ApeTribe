//
//  InteractivityTransitionDelegate.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/13.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewControllerTransition.h"
#import "TransitionAnimator.h"
typedef enum : NSUInteger {
    TransitionAnimatorTypeMine,
    TransitionAnimatorTypeNavigation,
    TransitionAnimatorTypeNone,
} InteractivityTransitionAnimatorType;

@interface InteractivityTransitionDelegate : NSObject<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *gestureRecognizer;
@property (nonatomic, assign) UIRectEdge targetEdge;
@property (nonatomic, strong) id<UIViewControllerAnimatedTransitioning> customAnimator;
@property (nonatomic, strong) ViewControllerTransition *mineAnimator;
@property (nonatomic, strong) TransitionAnimator *navigationAnimator;
@property (nonatomic, assign) BOOL isGesture;
@property (nonatomic, assign) InteractivityTransitionAnimatorType type;
- (instancetype) initWithType:(InteractivityTransitionAnimatorType)type;
@end
