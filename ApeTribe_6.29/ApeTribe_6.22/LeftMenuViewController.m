//
//  LeftMenuViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/22.
//  Copyright © 2016年 One. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "MineViewController.h"
#import "ViewControllerTransition.h"
#import "PDTransitionAnimator.h"
#import "LeftTableViewCell.h"
#import "UIImageView+WebCache.h"


@interface LeftMenuViewController ()<UINavigationControllerDelegate>
{
    CExpandHeader *_header;
    UIImageView *imageView;
}
@property (nonatomic,strong) ViewControllerTransition *customAnimator;
// 交互控制器 (Interaction Controllers) 通过遵从 UIViewControllerInteractiveTransitioning 协议来控制可交互式的转场。
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition* interactionController;
@property (nonatomic,strong) PDTransitionAnimator *minToMaxAnimator;
@property (strong, nonatomic) MineViewController *nextVC;

@end

@implementation LeftMenuViewController


// 创建背景窗口
- (UIWindow *)backWindow {
    
    if (_backWindow == nil) {
        
        _backWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backWindow.windowLevel       = UIWindowLevelStatusBar;
        _backWindow.backgroundColor   = [UIColor clearColor];
        _backWindow.hidden = NO;
    }
    
    return _backWindow;
}

- (MineTopView *)topEffectview
{
    if (!_topEffectview)
    {
        _topEffectview = [[MineTopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 200)];
    }
    return _topEffectview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.delegate = self;
    // 设置转场动画
    self.customAnimator = [[ViewControllerTransition alloc] init];
    self.minToMaxAnimator = [PDTransitionAnimator new];
    
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeTopViewContent)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];
    //数据下载完成的监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshTopViewContent)
                                                 name:FINISH_LOAD_DATA
                                               object:nil];
    [self initial];
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshTopViewContent];
}
- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
#pragma mark - init
- (void) initial
{
    // 实现交互操作的手势
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didClickPanGestureRecognizer:)];
    [self.navigationController.view addGestureRecognizer:panRecognizer];
    
    // 添加背景图片
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -60, SCREEN_W, SCREEN_W)];
    [imageView setImage:[UIImage imageNamed:@"head.jpg"]];
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithFrame:imageView.bounds];
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    [effectView setEffect:blur];
    [imageView addSubview:effectView];
    
    // ========表格=========
    
    
    __weak typeof(self) weakself = self;
    // 代码块赋值
    self.topEffectview.clickHandle = ^(long index)
    {
        if ([[Tool readLoginState:LOGIN_STATE]isEqualToString:@"1"])
        {
            switch (index) {
                case 0:// 头像
                {
                    [weakself.delegate presentViewController:MineViewControllerType andIndex:0];
                    
                }
                    
                    break;
                case 410:// 二维码
                    [weakself showQRcodeImage];
                    break;
                case 411:// 动态
                    [weakself.delegate presentViewController:MineViewControllerType andIndex:0];
                    break;
                case 412:// 消息
                    [weakself.delegate presentViewController:MineViewControllerType andIndex:1];
                    break;
                case 413:// 编辑
                    
                    break;
                default:
                    break;
            }

        }
        else
        {
            [weakself.delegate presentViewController:LoginViewControllerType andIndex:0];
        }
    };
    
    _header = [CExpandHeader new];
    [_header expandWithTableView:self.tableView expandView:self.topEffectview andBackgroundImgV:imageView andTopEdgeInsets:0];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"LeftMenuTableData" ofType:@"plist"];
    self.arrData = [NSMutableArray arrayWithContentsOfFile:path];
    // 注册cell
    [self.tableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:@"leftTableViewCell"];
    
    
    
    
    
}

#pragma mark - UINavigationControllerDelegate iOS7新增的2个方法
// 动画特效
- (id<UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    /**
     *  typedef NS_ENUM(NSInteger, UINavigationControllerOperation) {
     *     UINavigationControllerOperationNone,
     *     UINavigationControllerOperationPush,
     *     UINavigationControllerOperationPop,
     *  };
     */
    if (operation == UINavigationControllerOperationPush) {
        return self.customAnimator;
    }else{
        return nil;
    }
}

// 交互
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController*)navigationController                           interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController
{
    /**
     *  在非交互式动画效果中，该方法返回 nil
     *  交互式转场,自我理解意思是,用户能通过自己的动作来(常见:手势)控制,不同于系统缺省给定的push或者pop(非交互式)
     */
    return _interactionController;
}

#pragma mark - Transitioning Delegate (Modal)
// 前2个用于动画
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.customAnimator.animationType = MyAnimationTypePresent;
    return self.customAnimator;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.customAnimator.animationType = MyAnimationTypeDismiss;
    return self.customAnimator;
}

// 后2个用于交互
- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return _interactionController;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return nil;
}
#pragma mark - 手势交互的主要实现--->UIPercentDrivenInteractiveTransition
- (void)didClickPanGestureRecognizer:(UIPanGestureRecognizer*)recognizer
{
    UIView* view = self.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // 获取手势的触摸点坐标
        CGPoint location = [recognizer locationInView:view];
        // 判断,用户从右半边滑动的时候,推出下一个VC(根据实际需要是推进还是推出)
        if (location.x > CGRectGetMidX(view.bounds) && self.navigationController.viewControllers.count == 1){
            self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
            //
            [self presentViewController:_nextVC animated:YES completion:nil];
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        // 获取手势在视图上偏移的坐标
        CGPoint translation = [recognizer translationInView:view];
        // 根据手指拖动的距离计算一个百分比，切换的动画效果也随着这个百分比来走
        CGFloat distance = fabs(translation.x / CGRectGetWidth(view.bounds));
        // 交互控制器控制动画的进度
        [self.interactionController updateInteractiveTransition:distance];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint translation = [recognizer translationInView:view];
        // 根据手指拖动的距离计算一个百分比，切换的动画效果也随着这个百分比来走
        CGFloat distance = fabs(translation.x / CGRectGetWidth(view.bounds));
        // 移动超过一半就强制完成
        if (distance > 0.5) {
            [self.interactionController finishInteractiveTransition];
        } else {
            [self.interactionController cancelInteractiveTransition];
        }
        // 结束后一定要置为nil
        self.interactionController = nil;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // 注销监听
    [[NSNotificationCenter defaultCenter]removeObserver:self name:KNOTIFICATION_LOGINCHANGE object:nil];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.arrData.count - 1) {
        return 10;
    }
    return 0.01;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 10)];
    v.backgroundColor = COLOR_BG_D_GRAY;
    return v;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 10)];
    v.backgroundColor = COLOR_BG_D_GRAY;
    return v;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrData.count;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.arrData[section];
    return arr.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftTableViewCell"];
    if (cell == nil) {
        cell = [[LeftTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftTableViewCell"];
    }
    // 设置cell内容
    [cell setCell:self.arrData[indexPath.section][indexPath.row]];
    NSArray *arr = self.arrData[indexPath.section];
    if (indexPath.row == arr.count - 1) {
        cell.lineLb.hidden = YES;
    }
    else
    {
        cell.lineLb.hidden = NO;
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消表格的单击状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([[Tool readLoginState:LOGIN_STATE]isEqualToString:@"1"])
    {
        switch (indexPath.section) {
            case 0:// 消息
                [self.delegate presentViewController:MessageViewControllerType andIndex:0];
                break;
            case 1:
            {
                switch (indexPath.row) {
                    case 0:// 收藏
                        [self.delegate presentViewController:FavoriteViewControllerType andIndex:0];
//                        [SVProgressHUD showInfoWithStatus:@"敬请期待"];
                        break;
                    case 1:// 团队
                        [self.delegate presentViewController:BlankViewControllerType andIndex:0];
//                        [SVProgressHUD showInfoWithStatus:@"敬请期待"];
                        break;
                    case 2:// 活动
                        [self.delegate presentViewController:BlankViewControllerType andIndex:1];
                        break;
                    default:
                        break;
                }
            }
                break;
            case 2:
            {
                switch (indexPath.row) {
                    case 0:// 设置
                        [self.delegate presentViewController:SettingViewControllerType andIndex:0];
                        break;
                    case 1:// 反馈
                        [self.delegate presentViewController:FeedBackViewControllerType andIndex:0];
                        
                        break;
                    default:
                        break;
                }
            }
                
                break;
            default:
                break;
        }

    }
    else
    {
        if (indexPath.section == 2 && indexPath.row == 0)
        {
            [self.delegate presentViewController:SettingViewControllerType andIndex:0];
        }
        [self.delegate presentViewController:LoginViewControllerType andIndex:0];
    }
    
}
#pragma mark - login changed

- (void)loginStateChange:(NSNotification *)notification
{
//    BOOL loginSuccess = [notification.object boolValue];
    
    [self refreshTopViewContent];
}


#pragma mark - private
// 设置显示信息
- (void) changeTopViewContent
{
    BOOL loginState = [[Tool readLoginState:LOGIN_STATE] isEqualToString:@"1"];
    [self.topEffectview setContentOfView:loginState];
    if (loginState)
    {
        
        [imageView sd_setImageWithURL:URL(USER_MODEL.portrait) placeholderImage:Image(@"head.jpg")];
    }
    else
    {
        
        [imageView setImage:Image(@"head.jpg")];
        
    }
    
    
}
- (void) refreshTopViewContent
{
    BOOL loginState = [[Tool readLoginState:LOGIN_STATE] isEqualToString:@"1"];
    
    if (loginState)
    {
        // 已登录
        if (USER_MODEL.portrait != nil) {
            [imageView sd_setImageWithURL:URL(USER_MODEL.portrait) placeholderImage:Image(@"head.jpg")];
        }
        
    }
    else
    {
        // 未登录
        
        [imageView setImage:Image(@"head.jpg")];
        
    }
    [self.topEffectview setContentOfView:loginState];
    
}

- (void) showQRcodeImage
{
    self.darkView = [[UIVisualEffectView alloc]initWithFrame:self.backWindow.bounds];
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    [self.backWindow addSubview:self.darkView];
    [self.darkView setAlpha:0];
    // 创建点击手势识别器
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    [self.darkView addGestureRecognizer:tap];// 添加点击的手势识别器
    self.qrImagView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W - 60, SCREEN_W - 60)];
    self.qrImagView.center = self.view.center;
    self.qrImagView.backgroundColor = [UIColor whiteColor];
    [self.qrImagView setImage:[Tool createQRWithString:USER_MODEL.url andSize:CGRectGetHeight(self.qrImagView.frame)]];
    
    UILabel *messgeLb = [[UILabel alloc]initWithFrame:CGRectMake(0, self.qrImagView.frame.origin.y + self.qrImagView.frame.size.height + 15, SCREEN_W - 60, 21)];
    messgeLb.center = CGPointMake(SCREEN_W / 2.0, messgeLb.center.y);
    messgeLb.text = @"扫一扫二维码，关注我的部落";
    messgeLb.textAlignment = NSTextAlignmentCenter;
    messgeLb.textColor = [UIColor whiteColor];
    messgeLb.font = FONT(18);
    
    
    // 弹出视图
    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        // 设置背景透明度
        [_darkView setAlpha:0.95];
        [self.darkView setEffect:blur];
        // 打开背景的用户交互
        [_darkView setUserInteractionEnabled:YES];
        [_darkView addSubview:_qrImagView];
        [self.darkView addSubview:messgeLb];
    } completion:nil];

    
}

- (void) dismiss:(UITapGestureRecognizer *)sender
{
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        // 设置背景透明
        [_darkView setAlpha:0];
        [_darkView setUserInteractionEnabled:NO];
        // 移动表格
        
        
    } completion:^(BOOL finished) {
        
        [_darkView removeFromSuperview];
        
        self.backWindow = nil;
    }];
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
