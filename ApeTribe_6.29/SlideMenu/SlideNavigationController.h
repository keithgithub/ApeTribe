//
//  SlideNavigationController.h
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//
// https://github.com/aryaxt/iOS-Slide-Menu
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@protocol SlideNavigationControllerDelegate <NSObject>
@optional
- (BOOL)slideNavigationControllerShouldDisplayRightMenu;
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu;
@end

typedef  enum{
	MenuLeft = 1,
	MenuRight = 2
}Menu;

@protocol SlideNavigationContorllerAnimator;
@interface SlideNavigationController : NavigationViewController <UINavigationControllerDelegate>

extern NSString * const SlideNavigationControllerDidOpen;
extern NSString  *const SlideNavigationControllerDidClose;
extern NSString  *const SlideNavigationControllerDidReveal;

@property (nonatomic, assign) BOOL avoidSwitchingToSameClassViewController;// 是否当在菜单栏选择同一个视图控制器是直接回收菜单
@property (nonatomic, assign) BOOL enableSwipeGesture;// 是否可以侧滑打开菜单
@property (nonatomic, assign) BOOL enableShadow;// 是否显示阴影
@property (nonatomic, strong) UIViewController *rightMenu;// 右侧菜单
@property (nonatomic, strong) UIViewController *leftMenu;// 左侧菜单
@property (nonatomic, strong) UIBarButtonItem *leftBarButtonItem;//
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;
@property (nonatomic, assign) CGFloat portraitSlideOffset;// 纵向侧滑时显示的主视图的宽度
@property (nonatomic, assign) CGFloat landscapeSlideOffset;// 横向侧滑时显示的主视图的宽度
@property (nonatomic, assign) CGFloat panGestureSideOffset;// 侧滑手势响应的距屏幕边缘的宽度
@property (nonatomic, assign) CGFloat menuRevealAnimationDuration;// 菜单消失动画的时间
@property (nonatomic, assign) UIViewAnimationOptions menuRevealAnimationOption;// 菜单消失
@property (nonatomic, strong) id <SlideNavigationContorllerAnimator> menuRevealAnimator;

+ (SlideNavigationController *)sharedInstance;
- (void)switchToViewController:(UIViewController *)viewController withCompletion:(void (^)())completion __deprecated;// 该方法被弃用
// 弹出根视图控制器可以带动画
- (void)popToRootAndSwitchToViewController:(UIViewController *)viewController withSlideOutAnimation:(BOOL)slideOutAnimation andCompletion:(void (^)())completion;
//
- (void)popToRootAndSwitchToViewController:(UIViewController *)viewController withCompletion:(void (^)())completion;

- (void)popAllAndSwitchToViewController:(UIViewController *)viewController withSlideOutAnimation:(BOOL)slideOutAnimation andCompletion:(void (^)())completion;
- (void)popAllAndSwitchToViewController:(UIViewController *)viewController withCompletion:(void (^)())completion;
- (void)bounceMenu:(Menu)menu withCompletion:(void (^)())completion;// 使
- (void)openMenu:(Menu)menu withCompletion:(void (^)())completion;// 打开菜单
- (void)closeMenuWithCompletion:(void (^)())completion;// 关闭菜单
- (void)toggleLeftMenu;// 弹出左侧菜单
- (void)toggleRightMenu;// 弹出右侧菜单
- (BOOL)isMenuOpen;// 判断菜单是否打开

@end
