//
//  PDTransitionAnimator.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/23.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    AnimationTypePresent,
    AnimationTypeDismiss,
} AnimationType;

@interface PDTransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) AnimationType animationType;
@end
