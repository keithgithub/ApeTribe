//
//  SettingViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/27.
//  Copyright © 2016年 One. All rights reserved.
//

#import "SettingViewController.h"
#import "ShareSheet.h"
#import "InteractivityTransitionDelegate.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) InteractivityTransitionDelegate *customTransitionDelegate;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *interactiveTransitionRecognizer;
@end

@implementation SettingViewController
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
    self.title = @"设置";
    
    // 设置导航栏阴影透明
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"topbar_back_pressed"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"topbar_back_normal"] forState:UIControlStateSelected];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshTableView)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];
    // 添加滑动交互手势
    self.interactiveTransitionRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:self.interactiveTransitionRecognizer];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self refreshTableView];
}
- (UIStatusBarStyle) preferredStatusBarStyle
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
    
    if (self.transitioningDelegate != nil)
    {
        self.customTransitionDelegate = (InteractivityTransitionDelegate *)self.transitioningDelegate;
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


#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消表格的单击状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 1:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5://
            
            break;
        case 6:// 关于
            
            break;
        case 8:// 退出登录
        {
            NSArray *arr = @[@"退出后不会删除任何历史数据，下次登录依然可以使用本账号",@"退出登录",@"取消"];
            
            ShareSheet *sheet = [ShareSheet shareSheetWithStyle:ShareSheetCancelStyle andArrData:arr andHandle:^(long index){
                // 未登录状态
                [SVProgressHUD showInfoWithStatus:@"退出登录成功"];
                // 退出登录
                [Tool writeLoginState:@"0" andKey:LOGIN_STATE];
                [Tool writeToUserD:@"" andKey:ACCESS_TOKEN_KEY];
                // 发送登录状态改变的通知
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
                
            }];
            // 显示
            [sheet show];

            
        }
            break;
        default:
            break;
    }
    NSLog(@"indexPath.row === %ld",(long)indexPath.row);
}

- (void) refreshTableView
{
    if ([[Tool readLoginState:LOGIN_STATE]isEqualToString:@"1"])
    {
        self.logoutCell.hidden = NO;
    }
    else
    {
        self.logoutCell.hidden = YES;
    }
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
