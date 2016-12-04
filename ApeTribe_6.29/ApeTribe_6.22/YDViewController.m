//
//  YDViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/26.
//  Copyright © 2016年 One. All rights reserved.
//

#import "YDViewController.h"

@interface YDViewController ()
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *interactiveTransitionRecognizer;
@end

@implementation YDViewController
#pragma mark - getter

- (UIScreenEdgePanGestureRecognizer *) interactiveTransitionRecognizer
{
    if (!_interactiveTransitionRecognizer)
    {
        _interactiveTransitionRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(interactiveTransitionRecognizerAction:)];
        
    }
    return _interactiveTransitionRecognizer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 导航栏左侧按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"topbar_back_pressed"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"topbar_back_normal"] forState:UIControlStateSelected];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
    // 添加滑动交互手势
    self.interactiveTransitionRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:self.interactiveTransitionRecognizer];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark - action
- (void)backAction:(UIBarButtonItem *)sender
{
    [self buttonDidClicked:sender];
}

- (void) interactiveTransitionRecognizerAction:(UIScreenEdgePanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        [self buttonDidClicked:sender];
    }
}

- (void) buttonDidClicked:(id)sender
{
    
    if (self.customTransitionDelegate != nil)
    {
        if ([sender isKindOfClass:[UIGestureRecognizer class]])
        {
            self.customTransitionDelegate.gestureRecognizer = self.interactiveTransitionRecognizer;
        }
        else
        {
            self.customTransitionDelegate.gestureRecognizer = nil;
        }
        self.customTransitionDelegate.targetEdge = UIRectEdgeLeft;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
