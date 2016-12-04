//
//  InteractivityTransitionAnimator.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/13.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InteractivityTransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) UIRectEdge targetEdge;

-(instancetype) initWithTargetEdge:(UIRectEdge)targetEdge;

@end
