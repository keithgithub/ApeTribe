//
//  TabBarViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/22.
//  Copyright © 2016年 One. All rights reserved.
//

#import "TabBarViewController.h"
#import "MyTabBar.h"
#import "Function.h"
#import "HFWriteViewController.h"
#import "HFFindViewController.h"
#import "ViewControllerTransition.h"
#import "MineViewController.h"
#import "SynthesizeViewController.h"
#import "AnswerViewController.h"
#import "HFSharkOffViewController.h"
#import "HFAudioViewController.h"
#import "FavoriteViewController.h"
#import "LoginViewController.h"
#import "Scan_VC.h"
#import "SearchViewController.h"
#import "FocusAndFansViewController.h"
#import "ViewController.h"
#import "InteractivityTransitionDelegate.h"
#import "ViewControllerTransition.h"

#define KeyWindow [UIApplication sharedApplication].keyWindow
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@interface TabBarViewController ()<UITabBarControllerDelegate,MyTabBarDelegate,UIViewControllerTransitioningDelegate>
//@property (nonatomic,strong) ViewControllerTransition *customAnimator;
@property (nonatomic, strong) UIViewController *leftViewController;
@property (nonatomic, strong) InteractivityTransitionDelegate *customTransitionDelegate;

//@property (nonatomic,strong) ViewControllerTransition *customAnimator;
@end

@implementation TabBarViewController
singleton_implementation(TabBarViewController)
#pragma mark - getter


- (InteractivityTransitionDelegate *)customTransitionDelegate
{
    if (!_customTransitionDelegate)
    {
        _customTransitionDelegate = [[InteractivityTransitionDelegate alloc]initWithType:TransitionAnimatorTypeMine];
        
    }
    return _customTransitionDelegate;
}
- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 给代理属性赋值
    self.delegate = self;
    
    [self initViewControllers];
    [self addNavigationBarItem];
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshContent)
                                                 name:FINISH_LOAD_DATA
                                               object:nil];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 设置导航栏样式
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont  systemFontOfSize:18],NSFontAttributeName,COLOR_FONT_D_GRAY,NSForegroundColorAttributeName,nil]];
    [[UINavigationBar appearance] setTintColor:COLOR_FONT_D_GRAY];
    
    
    

}
- (void)loginStateChange:(NSNotification *)notification
{
    BOOL loginSuccess = [notification.object boolValue];
    if (loginSuccess)
    {
        // 登陆状态
        [self refreshContent];
        
    }
    else
    {
        // 未登录状态
        [self.button setBackgroundImage:Image(@"headIcon_placeholder") forState:UIControlStateNormal];
    }
    
    
}
// 刷新显示内容
- (void) refreshContent
{
    [self.button sd_setBackgroundImageWithURL:URL(USER_MODEL.portrait) forState:UIControlStateNormal placeholderImage:Image(@"headIcon_placeholder")];
}

- (void) initViewControllers
{
    
    // =====创建自定义标签栏======
    // 创建标签栏
    MyTabBar *tab = [[MyTabBar alloc]init];
    // 设置代理
    tab.tDelegate = self;
    // 替换标签栏控制器的标签栏
    [self setValue:tab forKey:@"tabBar"];
    
    // 设置标签栏的前景颜色
//    self.tabBar.tintColor = [UIColor colorWithRed:0.357 green:0.729 blue:0.000 alpha:1.000];
    self.tabBar.tintColor = [UIColor colorWithRed:0.346 green:0.759 blue:0.598 alpha:1.000];
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    // ==========创建子视图控制器========
    UIStoryboard *storyBoard = STORYBOARD(@"Synthesize");
    SynthesizeViewController *newsVC = [storyBoard instantiateViewControllerWithIdentifier:@"SynthesizeVC"];// 资讯
    FeelingViewController *feelingVC = [[FeelingViewController alloc]init];// 动态
    DiscoveryViewController *discoveryVC = [[DiscoveryViewController alloc]init];// 发现
    UIStoryboard *storyBoardAnswer = STORYBOARD(@"AnswerStoryBoard");
    AnswerViewController *answerVC = [storyBoardAnswer instantiateViewControllerWithIdentifier:@"AnswerVC"];// 问题
    
    
    // 存到数组
    NSArray *childViewControllers = @[newsVC, feelingVC, discoveryVC, answerVC];
    // 标签栏的子控制器赋值
    self.viewControllers = childViewControllers;
    // 获取标签栏按钮的标题
    NSArray *arrayTitles = @[@"首页", @"漫谈", @"发现", @"帖子"];
    // 获取按钮正常显示图片
    NSArray *arrayNormalImages = @[Image(@"icon_tabbar_normal_1"),Image(@"icon_tabbar_normal_2"),Image(@"icon_tabbar_normal_3"),Image(@"icon_tabbar_normal_4")];
    // 获取标签栏按钮点击时显示的图片
    NSArray *arraySelectedImages = @[Image(@"icon_tabbar_selected_1"),Image(@"icon_tabbar_selected_2"),Image(@"icon_tabbar_selected_3"),Image(@"icon_tabbar_selected_4")];
    
    // 循环添加标签栏的子视图控制器并设置标签栏按钮显示图片
    for (int i = 0; i < childViewControllers.count; i++)
    {
        [self addChildViewController:childViewControllers[i] andTitle:arrayTitles[i] andNormalImage:arrayNormalImages[i] andSelectedImage:arraySelectedImages[i]];
    }
    
    // 设置当前显示的子视图
    self.selectedIndex = 0;
    self.title = arrayTitles[0];
    
}

- (void) addNavigationBarItem
{

    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:Image(@"topbar_screening_pressed") style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.button.layer.masksToBounds = YES;
    self.button.layer.cornerRadius = self.button.frame.size.height/2.0;
    [self.button addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.button sd_setBackgroundImageWithURL:URL(USER_MODEL.portrait) forState:UIControlStateNormal placeholderImage:Image(@"headIcon_placeholder")];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.button];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}
#pragma mark - action
- (void) rightItemAction
{
    
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
    
    
}



// 添加标签栏的子视图控制器并设置标签栏按钮显示图片
- (void) addChildViewController:(UIViewController *)childController andTitle:(NSString *)title andNormalImage:(UIImage *)normalImage andSelectedImage:(UIImage *)selectedImage
{
    childController.title = title;
    childController.tabBarItem.title = title;
    childController.tabBarItem.image = normalImage;
    childController.tabBarItem.selectedImage = selectedImage;
    [self addChildViewController:childController];

}
#pragma mark - LeftMenuViewControllerDelegate

- (void) presentViewController:(MyViewControllerType)type andIndex:(int)index
{
    UIViewController *vc;
    id<UIViewControllerTransitioningDelegate> delegate = nil;
    NavigationControllerType navigationControllerType;
    UIStoryboard *st = STORYBOARD(@"Main");
    switch (type) {
        case MineViewControllerType:
        {
            navigationControllerType = NavigationControllerMineType;
            delegate = self.customTransitionDelegate;
            MineViewController *mineVC = [[MineViewController alloc]initWithState:YES andUserId:USER_MODEL.userId andPage:index andOperationType:NavigationControllerOperationTypeDismiss];
            
            mineVC.customTransitionDelegate = self.customTransitionDelegate;
            vc = mineVC;
        }
            
            break;
        case MessageViewControllerType:
        {
            delegate = self.customTransitionDelegate;
            navigationControllerType = NavigationControllerNormalType;
            MineMessageViewController *messageVC = [[MineMessageViewController alloc]initWithStyle:UITableViewStylePlain andPage:0 andOperationType:TableViewControllerOperationTypeDismiss];
            messageVC.customTransitionDelegate = self.customTransitionDelegate;
            vc = messageVC;
            
            
        }
            
            break;
        case SettingViewControllerType:// 设置
        {
            delegate = self.customTransitionDelegate;
            navigationControllerType = NavigationControllerNormalType;
            
            vc = [st instantiateViewControllerWithIdentifier:@"settingVC"];
            vc.transitioningDelegate = self.customTransitionDelegate;
        }
            break;
        case FavoriteViewControllerType:// 收藏
            
        {
            delegate = self.customTransitionDelegate;
            navigationControllerType = NavigationControllerNormalType;
            
            FavoriteViewController *favoriteVC = [[FavoriteViewController alloc]initWithStyle:UITableViewStylePlain andOperationType:TableViewControllerOperationTypeDismiss];
            favoriteVC.customTransitionDelegate = self.customTransitionDelegate;
            vc = favoriteVC;
        }
            break;
        case LoginViewControllerType:
        {
            delegate = self;
            navigationControllerType = NavigationControllerMineType;
            vc = [[LoginViewController alloc]init];
        }
            break;
        case FocusAndFansViewControllerType:
        {
            delegate = self.customTransitionDelegate;
            navigationControllerType = NavigationControllerNormalType;
            FocusAndFansViewController *focusVC = [[FocusAndFansViewController alloc]init];
            focusVC.customTransitionDelegate = self.customTransitionDelegate;
            vc = focusVC;
        }
            break;
        case BlankViewControllerType:// 空的视图控制器
        {
            delegate = self.customTransitionDelegate;
            navigationControllerType = NavigationControllerNormalType;
            ViewController *blankVC = [[ViewController alloc]initWithStyle:UITableViewStylePlain andTopView:NO andOperationType:TableViewControllerOperationTypeDismiss];
            blankVC.customTransitionDelegate = self.customTransitionDelegate;
            vc = blankVC;
            if (index == 0) {
                vc.title = @"我的团队";
            }
            else
            {
                vc.title = @"我的活动";
            }
        }
            break;
        case FeedBackViewControllerType:
        {
            delegate = self.customTransitionDelegate;
            navigationControllerType = NavigationControllerNormalType;
            vc = [st instantiateViewControllerWithIdentifier:@"feedBackVC"];
            vc.transitioningDelegate = self.customTransitionDelegate;
        }
        default:
            break;
    }
 
    [self presentViewController:[Tool getNavigationController:vc andtransitioningDelegate:delegate andNavigationViewControllerType:navigationControllerType] animated:YES completion:nil];

}
#pragma mark - UITabBarControllerDelegate
/**
 *  点击tabBarItem时会执行的代理方法
 *
 *  @param tabBarController 当前工具视图控制器
 *  @param viewController   选中的子视图控制器
 */
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    // 设置导航栏标题为选中子视图的标题
    self.title = viewController.title;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // 移除监听
    [[NSNotificationCenter defaultCenter]removeObserver:self name:FINISH_LOAD_DATA object:nil];
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

// 实现协议方法
-(void)sendMsg
{
    Function *fView =[[Function alloc]initWithFrame:CGRectMake(0, KeyWindow.frame.size.height, KeyWindow.frame.size.width, KeyWindow.frame.size.height)];
  
    __weak typeof(fView)weakfV = fView;
    __weak typeof(self)weakSelf = self;
    //点击按钮执行的方法
    fView.btnBlock = ^(NSInteger tagv)
    {
        switch (tagv) {
            case 100://心情按钮
            {
                [weakfV removeFromSuperview];
                [weakSelf creatWriteContralTag:10];
            }
                break;
            case 101://照片/拍照
            {
                [weakfV removeFromSuperview];
                [weakSelf creatWriteContralTag:20];
            }
                break;
            case 102://找人
            {
                [weakfV removeFromSuperview];
                [weakSelf creatFindContral];
                
            }
                break;
            case 103://吼一声
            {
                [weakfV removeFromSuperview];
                [weakSelf createAudio];
            }
                break;
            case 104://扫一扫
            {
                
                [weakfV removeFromSuperview];
                [weakSelf createSao];
            }
                break;
            case 105://抖一抖
            {
                [weakfV removeFromSuperview];
                [weakSelf creatShark];
                
            }
                break;
                
            default:
                break;
        }
        
    };
    //按钮的动画效果
    for (int i=0; i<6; i++)
    {
        
        UIButton *btn = [fView viewWithTag:105-i];
        
        UILabel *lbl = [fView viewWithTag:15-i];
        
        [UIView animateWithDuration:0.05 delay:0.03*i options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            btn.center = CGPointMake(btn.center.x, btn.center.y-40);
            lbl.center = CGPointMake(lbl.center.x, lbl.center.y-40);
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 animations:^{
                btn.center = CGPointMake(btn.center.x, btn.center.y+40);
                lbl.center = CGPointMake(lbl.center.x, lbl.center.y+40);
                if (i== 0)
                {
                    fView.btnClose.transform = CGAffineTransformMakeRotation(M_PI_2);
                }
                
            }];
            
        }];
        
    }
    
    fView.center=KeyWindow.center;
    //添加到window上
    [KeyWindow addSubview:fView];
    
}
#pragma mark
#pragma mark 创建发心情控制器
-(void)creatWriteContralTag:(NSInteger)Tag
{
    
    HFWriteViewController *writeVC = [[NSBundle mainBundle]loadNibNamed:@"HFWriteViewController" owner:nil options:nil][0];
    writeVC.cameraTag = Tag;
    UINavigationController *naC = [[UINavigationController alloc]initWithRootViewController:writeVC];
    [self presentViewController:naC animated:YES completion:nil];
    
    //    [self.navigationController pushViewController:writeVC animated:YES];
    
}
#pragma mark
#pragma mark 创建找人控制器
-(void)creatFindContral
{
    HFFindViewController *fingVC = [[HFFindViewController alloc]init];
    //    [self.navigationController pushViewController:fingVC animated:YES];
    UINavigationController *naC = [[UINavigationController alloc]initWithRootViewController:fingVC];
    [self presentViewController:naC animated:YES completion:nil];
    
}
#pragma mark
#pragma mark 创建抖一抖控制器
-(void)creatShark
{
    HFSharkOffViewController *sharkVC = [[HFSharkOffViewController alloc]init];
    UINavigationController *naC = [[UINavigationController alloc]initWithRootViewController:sharkVC];
    [self presentViewController:naC animated:YES completion:nil];
}
#pragma mark
#pragma mark 创建语言控制器
-(void)createAudio
{
    HFAudioViewController *audioVC = [[HFAudioViewController alloc]init];
    UINavigationController *naC = [[UINavigationController alloc]initWithRootViewController:audioVC];
    [self presentViewController:naC animated:YES completion:nil];
    
}
//创建扫一扫控制器
-(void)createSao
{
    Scan_VC*vc=[[Scan_VC alloc]init];
    UINavigationController *naC = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:naC animated:YES completion:nil];
    //    [self.navigationController pushViewController:vc animated:YES];
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
