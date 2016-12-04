//
//  TransitionInteractionController.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/13.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransitionInteractionController : UIPercentDrivenInteractiveTransition
@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *gestureRecognizer;// 手势识别器
@property (nonatomic, assign) UIRectEdge edge;

- (instancetype) initWithGestureRecognizer:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer andEdgeForDragging:(UIRectEdge)edge;

@end
