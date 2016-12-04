//
//  ViewControllerTransition.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/23.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MENU_SHADOW_RADIUS 10
#define MENU_SHADOW_OPACITY 1

typedef enum : NSUInteger {
    MyAnimationTypePresent,
    MyAnimationTypeDismiss,
} MyAnimationType;

@interface ViewControllerTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) MyAnimationType animationType;
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, weak) UIView *leftView, *view;
@property (nonatomic, assign) BOOL enableShadow;// 是否显示阴影
@end
