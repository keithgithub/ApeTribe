//
//  MineViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/22.
//  Copyright © 2016年 One. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "BlogMineTableViewCell.h"
#import "MJRefresh.h"
#import "ShareSheet.h"
#import "TZImagePickerController.h"
#define HEADER_H 30

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource, BaseTableViewCellDelegate,UIImagePickerControllerDelegate, TZImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>
{
    CExpandHeader *_header;
    UIImageView *imageView;
    UIButton *activeButton, *blogButton;
    UIImageView *scrollLine;
    UIButton *btnLeftFocus, *btnRightMsg;
    NSArray *arrCellIdentities;// 单元格的标志数组
    UIImageView *navBarHairlineImageView;
    UIBarButtonItem *backItem;
    
}
@property (nonatomic, strong) UIView *bgView;// 导航栏背景视图
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *interactiveTransitionRecognizer;
@property (nonatomic, strong) InteractivityTransitionDelegate *myTransitionDelegate;
@end

@implementation MineViewController
#pragma mark - getter
- (InteractivityTransitionDelegate *) myTransitionDelegate
{
    if (!_myTransitionDelegate)
    {
        _myTransitionDelegate = [[InteractivityTransitionDelegate alloc]initWithType:TransitionAnimatorTypeNavigation];
    }
    return _myTransitionDelegate;
}
- (UIScreenEdgePanGestureRecognizer *) interactiveTransitionRecognizer
{
    if (!_interactiveTransitionRecognizer)
    {
        _interactiveTransitionRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(interactiveTransitionRecognizerAction:)];
        
    }
    return _interactiveTransitionRecognizer;
}
- (instancetype) initWithState:(BOOL)isMe andUserId:(long)userId andOperationType:(NavigationControllerOperationType)type
{
    if (self = [super init])
    {
        self.type = type;
        self.userId = userId;
        self.isMe = isMe;
        if (userId == USER_MODEL.userId) {
            self.isMe = YES;
        }
        self.firstPageIndex = 0;
        self.secondPageIndex = 0;
        self.page = 0;
    }
    return self;
}
- (instancetype) initWithState:(BOOL)isMe andUserId:(long)userId andPage:(int)page andOperationType:(NavigationControllerOperationType)type
{
    if (self = [super init])
    {
        self.type = type;
        self.userId = userId;
        self.isMe = isMe;
        if (userId == USER_MODEL.userId) {
            self.isMe = YES;
        }
        self.firstPageIndex = 0;
        self.secondPageIndex = 0;
        self.page = page;
    }
    return self;
}

#pragma mark - getter

- (MineTableViewHeader *) headerView
{
    if (!_headerView)
    {
        if (self.isMe)
        {
            _headerView = [[MineTableViewHeader alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 181) andState:self.isMe];
        }
        else
        {
            _headerView = [[MineTableViewHeader alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 181) andState:self.isMe];
        }
    }
    return _headerView;
}

- (UIView *) sectionView
{
    if (!_sectionView)
    {
        //================
        _sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, HEADER_H)];
        _sectionView.backgroundColor = [UIColor colorWithWhite:0.982 alpha:1.000];
        
        // 我的博客按钮
        activeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        activeButton.frame = CGRectMake(0, 0, 80, _sectionView.frame.size.height);
        activeButton.center = CGPointMake(SCREEN_W / 3.0 - 10, activeButton.center.y);
        activeButton.tag = 500;
        // 设置按钮的标题
        [activeButton setTitle:@"动态(0)" forState:UIControlStateNormal];
        // 按钮字体的大小
        activeButton.titleLabel.font = FONT(12.5);
        // 设置按钮字体的颜色
        [activeButton setTitleColor:COLOR_FONT_D_GREEN forState:UIControlStateNormal];
        
        
        [_sectionView addSubview:activeButton];
        [activeButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        // 收藏的博客按钮
        blogButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        blogButton.frame = CGRectMake(0, 0, 80, _sectionView.frame.size.height);
        blogButton.center = CGPointMake(SCREEN_W * 2 / 3 + 10, blogButton.center.y);
        blogButton.tag = 501;
        [blogButton setTitle:@"博客(0)" forState:UIControlStateNormal];
        if (self.page == 0) {
            [activeButton setTitleColor:COLOR_FONT_D_GREEN forState:UIControlStateNormal];
            [blogButton setTitleColor:COLOR_FONT_L_GRAY forState:UIControlStateNormal];
            CGFloat width = [activeButton.titleLabel.text sizeWithFont:activeButton.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
            scrollLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, _sectionView.frame.size.height - 1.5, width, 1.5)];
            scrollLine.center = CGPointMake(activeButton.center.x, scrollLine.center.y);
        }
        else
        {
            [activeButton setTitleColor:COLOR_FONT_L_GRAY forState:UIControlStateNormal];
            [blogButton setTitleColor:COLOR_FONT_D_GREEN forState:UIControlStateNormal];
            CGFloat width = [blogButton.titleLabel.text sizeWithFont:blogButton.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
            scrollLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, _sectionView.frame.size.height - 1.5, width, 1.5)];
            scrollLine.center = CGPointMake(blogButton.center.x, scrollLine.center.y);
        }
        
        blogButton.titleLabel.font = FONT(12.5);
        [_sectionView addSubview:blogButton];
        
        [blogButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 2.5, 100, 15)];
        titleLb.font = FONT(11);
        titleLb.textColor = [UIColor whiteColor];
        [_sectionView addSubview:titleLb];
        
        UILabel *lineLb = [[UILabel alloc]initWithFrame:CGRectMake(0, _sectionView.frame.size.height - 0.5, IPHONE_W, 0.5)];
        lineLb.backgroundColor = COLOR_BG_D_GRAY;
        
        [_sectionView addSubview:lineLb];
        
        scrollLine.backgroundColor = COLOR_FONT_D_GREEN;
        [_sectionView addSubview:scrollLine];
        
    }
    return _sectionView;
}

- (UIView *) bottomView
{
    if (!_bottomView)
    {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H - 40, SCREEN_W, 40)];
        btnLeftFocus = [UIButton buttonWithType:UIButtonTypeCustom];
        btnLeftFocus.frame = CGRectMake(0, 0, _bottomView.frame.size.width / 2.0, _bottomView.frame.size.height);
        btnLeftFocus.tag = 502;
        [btnLeftFocus setTitle:@"关注" forState:UIControlStateNormal];
        [btnLeftFocus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnLeftFocus.backgroundColor = COLOR_BG_D_GREEN;
        [btnLeftFocus addTarget:self action:@selector(bottomButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        btnRightMsg = [UIButton buttonWithType:UIButtonTypeCustom];
        btnRightMsg.frame = CGRectMake(_bottomView.frame.size.width / 2.0, 0, _bottomView.frame.size.width / 2.0, _bottomView.frame.size.height);
        btnRightMsg.tag = 503;
        [btnRightMsg setTitle:@"私信" forState:UIControlStateNormal];
        [btnRightMsg setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnRightMsg.backgroundColor = COLOR_FONT_D_GREEN;
        [btnRightMsg addTarget:self action:@selector(bottomButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_bottomView addSubview:btnLeftFocus];
        [_bottomView addSubview:btnRightMsg];
    }
    return _bottomView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
    if (self.isMe) {
        //注册登录状态监听
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(refreshTopViewContent:)
                                                     name:FINISH_LOAD_DATA
                                                   object:nil];
    }
    // 添加滑动交互手势
    self.interactiveTransitionRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:self.interactiveTransitionRecognizer];
    
    [self initialViewContent];
    // 创建改变导航栏背景颜色的视图
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    
    // 插入导航栏底部
    [self.view addSubview:self.bgView];
    
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
   
    // 设置导航栏背景透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // 设置导航栏阴影透明
    navBarHairlineImageView.hidden = YES;
   
}
//通过一个方法来找到这个黑线(findHairlineImageViewUnder):
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews)
    {
        UIImageView *imageView1 = [self findHairlineImageViewUnder:subview];
        if (imageView1)
        {
            return imageView1;
        }
    }
    return nil;
}

- (void) initialViewContent
{
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head.jpg"]];
    imageView.frame = CGRectMake(-10, -60, SCREEN_W + 20, SCREEN_W + 20);
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithFrame:imageView.bounds];
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    [effectView setEffect:blur];
    [imageView addSubview:effectView];
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    backItem = [[UIBarButtonItem alloc]initWithImage:[Tool getRendingImageWithName:@"barbuttonicon_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.blankView = [[UIView alloc]initWithFrame:CGRectMake(0, self.headerView.frame.size.height, SCREEN_W, self.tableView.frame.size.height)];
    self.blankView.backgroundColor = [UIColor colorWithWhite:0.954 alpha:1.000];
    [self.tableView addSubview:self.blankView];
    [self.tableView sendSubviewToBack:self.blankView];
    UINib *nib = [UINib nibWithNibName:@"BlogMineTableViewCell" bundle:nil];
    // 注册cell
    [self.tableView registerNib:nib forCellReuseIdentifier:@"blogCell"];
    // 注册cell
    UINib *nib0 = [UINib nibWithNibName:@"AtMeTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib0 forCellReuseIdentifier:@"atMeCell"];
//    UINib *nib1 = [UINib nibWithNibName:@"FansTableViewCell" bundle:nil];
//    [self.tableView registerNib:nib1 forCellReuseIdentifier:@"fansCell"];
    arrCellIdentities = @[@"atMeCell",@"blogCell"];

    
    [self.view addSubview:self.tableView];
    
    //    _header = [CExpandHeader expandWithScrollView:_tableView expandView:self.headerView];
    _header = [CExpandHeader new];
    
    [_header expandWithTableView:self.tableView expandView:self.headerView andBackgroundImgV:imageView andTopEdgeInsets:64];
    __weak typeof(self) weakself = self;
    self.headerView.tapHandle = ^(int index)// 点击头像
    {
        switch (index) {
            case 0:// 相册
            {
//                UIImagePickerController *imagePickerController = [UIImagePickerController new];
//                imagePickerController.delegate = weakself;
//                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//                imagePickerController.allowsEditing = YES;
//                imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
//                
//                [weakself presentViewController:imagePickerController animated:YES completion:nil];
                // 创建图片选择视图控制器
                TZImagePickerController *tzImagePC = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:weakself];
                // 推出控制器
                [weakself presentViewController:tzImagePC animated:YES completion:nil];

            }
                break;
            case 1:// 相机
            {
                
                
                if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                {
                    [Tool showAlertControllerWithTitle:@"Error" andMessage:@"Device has no camera" andPresentUIViewController:weakself];
                } else {
                    UIImagePickerController *imagePickerController = [UIImagePickerController new];
                    imagePickerController.delegate = weakself;
                    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                    imagePickerController.allowsEditing = YES;
                    imagePickerController.showsCameraControls = YES;
                    imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                    imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
                    
                    [weakself presentViewController:imagePickerController animated:YES completion:nil];
                }
            }
                break;
            default:
                break;
        }

    };
    self.headerView.clickhandle = ^(long index)
    {
        switch (index) {
                case 1:// 点击更多
            {
                
            }
                break;
            case 2:// 点击关注
            {
                FocusAndFansViewController *focusVC = [[FocusAndFansViewController alloc]initWithStyle:UITableViewStylePlain andUserId:weakself.userId andIndex:0 andOperationType:TableViewControllerOperationTypePop];
                focusVC.customTransitionDelegate = weakself.myTransitionDelegate;
                [weakself presentViewController:[Tool getNavigationController:focusVC andtransitioningDelegate:weakself.myTransitionDelegate andNavigationViewControllerType:NavigationControllerNormalType] animated:YES completion:nil];
            }
                break;
            case 3:// 点击粉丝
            {
                FocusAndFansViewController *fansVC = [[FocusAndFansViewController alloc]initWithStyle:UITableViewStylePlain andUserId:weakself.userId andIndex:1 andOperationType:TableViewControllerOperationTypePop];
                fansVC.customTransitionDelegate = weakself.myTransitionDelegate;
                [weakself presentViewController:[Tool getNavigationController:fansVC andtransitioningDelegate:weakself.myTransitionDelegate andNavigationViewControllerType:NavigationControllerNormalType] animated:YES completion:nil];
                
            }
                break;
            default:
                break;
        }
    };
    
    self.dataArray = [NSMutableArray new];
    NSMutableArray *arr0 = [NSMutableArray new];
    NSMutableArray *arr1 = [NSMutableArray new];
    self.arrData = [NSMutableArray new];
    [self.arrData addObject:arr0];
    [self.arrData addObject:arr1];
    
    
    // 判断是否是他人的个人详情
    if (self.isMe)
    {
        if ([[Tool readLoginState:LOGIN_STATE]isEqualToString:@"1"]) {
            __weak typeof(self) weakself = self;
            // 添加上提加载
            [self.tableView addLegendFooterWithRefreshingBlock:^{
                [weakself tableViewDidTriggerFooterRefresh];
            }];
            // 下载数据
            [self refreshTableViewWithPageIndex:0];
            
        }
        [self refreshTopViewContent:nil];
        
    }
    else
    {
        __weak typeof(self) weakself = self;
        // 添加上提加载
        [self.tableView addLegendFooterWithRefreshingBlock:^{
            [weakself tableViewDidTriggerFooterRefresh];
        }];
        // 添加底部视图
        [self.view addSubview:self.bottomView];
        [self refreshViewContent];
        // 下载数据
        [self refreshTableViewWithPageIndex:0];
    }
    
    
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark - action
- (void)backAction:(UIBarButtonItem *)sender
{
    [self buttonDidClicked:sender];
}
- (void) btnAction:(UIButton *)sender
{
    if (self.isMe && ![[Tool readLoginState:LOGIN_STATE]isEqualToString:@"1"])
    {
        return;
    }
    switch (sender.tag)
    {
        case 500:// 第一个页面
        {
            if (self.page != 0) {
                self.page = 0;
                self.dataArray = self.arrData[self.page];
                if (self.dataArray.count == 0)
                {
                    [self refreshTableViewWithPageIndex:0];
                    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
                    self.bgView.backgroundColor = [UIColor clearColor];
                    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont  systemFontOfSize:18],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
                }
                else
                {
                    [self.tableView reloadData];
                    [self.tableView layoutIfNeeded];
                }
                [activeButton setTitleColor:COLOR_FONT_D_GREEN forState:UIControlStateNormal];
                [blogButton setTitleColor:COLOR_FONT_L_GRAY forState:UIControlStateNormal];
                CGFloat width = [activeButton.titleLabel.text sizeWithFont:activeButton.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
                [UIView animateWithDuration:0.3 animations:^{
                    CGRect frame = scrollLine.frame;
                    frame.size.width = width;
                    scrollLine.frame = frame;
                    scrollLine.center = CGPointMake(activeButton.center.x, scrollLine.center.y);
                }];
            }
            

        }
            break;
        case 501:// 第二个页面
        {
            if (self.page != 1) {
                self.page = 1;
                self.dataArray = self.arrData[self.page];
                if (self.dataArray.count == 0)
                {
                    [self refreshTableViewWithPageIndex:0];
                    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
                    self.bgView.backgroundColor = [UIColor clearColor];
                    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont  systemFontOfSize:18],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
                }
                else
                {
                    [self.tableView reloadData];
                    [self.tableView layoutIfNeeded];
                }
                [activeButton setTitleColor:COLOR_FONT_L_GRAY forState:UIControlStateNormal];
                [blogButton setTitleColor:COLOR_FONT_D_GREEN forState:UIControlStateNormal];
            }
            CGFloat width = [blogButton.titleLabel.text sizeWithFont:blogButton.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = scrollLine.frame;
                frame.size.width = width;
                scrollLine.frame = frame;
                scrollLine.center = CGPointMake(blogButton.center.x, scrollLine.center.y);
            }];
            
        }
            break;
        default:
            break;
    }
//        NSMutableArray *arr = self.arrData[0];
//    
//    NSLog(@"self.page = %d",self.page);
//    NSLog(@"arr ======= %@",arr);
}
- (void) bottomButtonAction:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 502:// 关注
        {
            int relation = 0;
            if (self.userModel.relation == 3)// 未关注
            {
                relation = 1;
            }
            __weak typeof(self) weakself = self;
            [[NetWorkHelp shareHelper]asyncDataFromServerWithURLString:URL_STR(SERVER, URL_UPDATE_RELATION_LIST) andParamDictionary:PARAM_UPDATE_RELATION_LIST(self.userModel.userId, relation, ACCESS_TOKEN, @"xml") andModelType:UpdateRelationModel andSuccessHandle:^(id obj) {
                ErrorMessageXMLModel *errorModel = obj;
                if (errorModel.errorCode == 200)
                {
                    [SVProgressHUD showInfoWithStatus:errorModel.errorMessage];
                    [weakself refreshViewContent];
                }
                else
                {
                    [SVProgressHUD showInfoWithStatus:errorModel.errorMessage];
                }
            } andFailhandle:^(NSString *error) {
                
            }];
        }
            break;
        case 503:// 私信
            
            break;
        default:
            break;
    }
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
#pragma mark - UITableViewDelegate,UITableViewDataSource

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.sectionView;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
}
// 组高
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return HEADER_H;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier;
    switch (self.page) {
        case 0:
            cellIdentifier = arrCellIdentities[0];
            break;
        case 1:
            cellIdentifier = arrCellIdentities[1];
            break;
        default:
            break;
    }
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    // 设置cell内容
    [cell setCell:self.dataArray[indexPath.row]];
    return cell;
}
// 行高
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.page == 0) {
        return 95;
    }
    return 53;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.page == 0)
    {
        ActiveXMLModel *model = self.dataArray[indexPath.row];
        DetailViewController *detailVC = [[DetailViewController alloc]initWithListID:model.activeId];
        detailVC.customTransitionDelegate = self.myTransitionDelegate;
        [self presentViewController:[Tool getNavigationController:detailVC andtransitioningDelegate:self.myTransitionDelegate andNavigationViewControllerType:NavigationControllerNormalType] animated:YES completion:nil];
        
    }
    else
    {
        BlogXMLModelMine *model = self.dataArray[indexPath.row];
        UIStoryboard *std = [UIStoryboard storyboardWithName:@"AnswerStoryBoard" bundle:[NSBundle mainBundle]];
        PostDetailViewController *postVC = [std instantiateViewControllerWithIdentifier:@"PostDetailVC"];
        postVC.type = 1;
        postVC.Id = model.blogId;
        postVC.customTransitionDelegate = self.myTransitionDelegate;
        [self presentViewController:[Tool getNavigationController:postVC andtransitioningDelegate:self.myTransitionDelegate andNavigationViewControllerType:NavigationControllerNormalType] animated:YES completion:nil];
    }
}
#pragma mark - UIScrollViewDelegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 当tableView返回顶部是清空导航栏背景颜色
    if (self.tableView.contentOffset.y > -64)
    {
        self.bgView.backgroundColor = [UIColor clearColor];
        
    }
    // 根据tableView的移动位置改变导航栏的背景颜色
    if (self.tableView.contentOffset.y / 100 < 1)
    {
        [self.navigationController.navigationBar setBackgroundImage:[Tool imageWithBGColor:[UIColor colorWithRed:0.186 green:0.715 blue:0.581  alpha:self.tableView.contentOffset.y / 100]] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
//        [backItem setImage:[Tool getRendingImageWithName:@"barbuttonicon_back"]];
        navBarHairlineImageView.hidden = YES;
    }
    else
    {
        
    }
    if (self.tableView.contentOffset.y > 100)
    {
        
        self.bgView.backgroundColor = [UIColor colorWithRed:0.186 green:0.715 blue:0.581 alpha:1.000];
        // 设置导航栏视图的颜色
        
    }

}

#pragma mark - BaseTableViewCellDelegate
- (void) clickButtonAction:(long)userId
{
    MineViewController *mineVC = [[MineViewController alloc]initWithState:NO andUserId:userId andOperationType:NavigationControllerOperationTypePop];
    mineVC.customTransitionDelegate = self.myTransitionDelegate;
    [self presentViewController:[Tool getNavigationController:mineVC andtransitioningDelegate:self.myTransitionDelegate andNavigationViewControllerType:NavigationControllerNormalType] animated:YES completion:nil];
}
#pragma mark - private
// 设置显示信息
- (void) refreshTopViewContent:(OtherUserXMLModel *)model
{
    if (self.isMe)
    {
        if ([[Tool readLoginState:LOGIN_STATE] isEqualToString:@"1"])
        {
            // 已登录
            self.title = USER_MODEL.name;
            [imageView sd_setImageWithURL:URL(USER_MODEL.portrait) placeholderImage:Image(@"head.jpg")];
            
            [self refreshTableViewWithPageIndex:0];
        }
        else
        {
            // 未登录
            self.title = @"点击头像登录";
            [imageView setImage:Image(@"head.jpg")];

            
        }
        [self.headerView setContentOfView:nil];
        
    }
    else
    {
        [self.headerView setContentOfView:model];
        self.title = model.name;
        [imageView sd_setImageWithURL:URL(model.portrait) placeholderImage:Image(@"headIcon_placeholder")];
        // 关注情况：1-已关注（对方未关注我）2-相互关注 3-未关注
        switch (model.relation)
        {
            case 1:
                [btnLeftFocus setTitle:@"已互粉" forState:UIControlStateNormal];
                break;
            case 2:
                [btnLeftFocus setTitle:@"已关注" forState:UIControlStateNormal];
                break;
            case 3:
                [btnLeftFocus setTitle:@"+关注" forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }
    
    
}
#pragma mark - private
// 上提加载
- (void) tableViewDidTriggerFooterRefresh
{
    if (self.page == 0) {
        [self refreshTableViewWithPageIndex:++self.firstPageIndex];
    }
    else
    {
        [self refreshTableViewWithPageIndex:++self.secondPageIndex];
    }
    
}


- (void) refreshTableViewWithPageIndex:(int)pageIndex
{
    XMLModelType type = BlogsModel;
    NSDictionary *dic = PARAM_MINE_BLOG_LIST(self.userId, pageIndex, 20, ACCESS_TOKEN, @"xml");
    NSString *urlString = URL_STR(SERVER, URL_MINE_BLOG_LIST);
    if (self.page == 0) {
        if (self.isMe)
        {
            dic = PARAM_ACTIVE_LIST(USER_MODEL.userId, 3, pageIndex, 20, ACCESS_TOKEN, @"xml");
        }
        else
        {
            dic = PARAM_OTHER_ACTIVE_LIST(self.userId, 3, pageIndex, 20, ACCESS_TOKEN, @"xml");
        }
        urlString = URL_STR(SERVER, URL_ACTIVE_LIST);
        type = ActiveModel;
    }
    [SVProgressHUD show];
    __weak typeof(self) weakself = self;
    [[NetWorkHelp shareHelper]asyncDataFromServerWithURLString:urlString andParamDictionary:dic andModelType:type andSuccessHandle:^(id obj) {
        [SVProgressHUD dismiss];
        NSMutableArray *arr = weakself.arrData[weakself.page];
        NSMutableArray *mArr;
        if (weakself.page == 1)
        {
            BlogsXMLModelMine *model = (BlogsXMLModelMine *)obj;
            mArr = model.blogs;
            [blogButton setTitle:[NSString stringWithFormat:@"博客(%d)",model.blogsCount] forState:UIControlStateNormal];
        }
        else
        {
            mArr = obj;
        }
        if (mArr.count == 0 && pageIndex == 0)
        {
            weakself.dataArray = mArr;
            [weakself.arrData replaceObjectAtIndex:weakself.page withObject:mArr];
            NSLog(@"weakself.page === %d",weakself.page);
            [weakself.tableView reloadData];
            [weakself.tableView.footer noticeNoMoreData];
        }else if (mArr.count < 20)// 结束刷新
        {
                        // 判断是否是第一页
            if (pageIndex != 0)
            {
                // 当前页回退
                if (weakself.page == 0)
                {
                    weakself.firstPageIndex--;
                }
                else
                {
                    weakself.secondPageIndex--;
                }
                [arr addObjectsFromArray:mArr];
                NSLog(@"weakself.page === %d",weakself.page);
                [weakself.arrData replaceObjectAtIndex:weakself.page withObject:arr];
                weakself.dataArray = arr;
                [weakself.tableView reloadData];
                [weakself.tableView layoutIfNeeded];

            }
            else// 第一页
            {
                weakself.dataArray = mArr;
                NSLog(@"weakself.page === %d",weakself.page);
                [weakself.arrData replaceObjectAtIndex:weakself.page withObject:mArr];
                [weakself.tableView reloadData];
                [weakself.tableView layoutIfNeeded];
            }
            
            [weakself.tableView.footer noticeNoMoreData];
        }
        else
        {
            [arr addObjectsFromArray:mArr];
            NSLog(@"weakself.page === %d",weakself.page);
            [weakself.arrData replaceObjectAtIndex:weakself.page withObject:arr];
            weakself.dataArray = arr;
            [weakself.tableView reloadData];
            [weakself.tableView layoutIfNeeded];
            // 没有更多的数据
            [weakself.tableView.footer endRefreshing];
        }
        if (weakself.page == 0)
        {
            [activeButton setTitle:[NSString stringWithFormat:@"动态(%ld)",weakself.dataArray.count] forState:UIControlStateNormal];
        }
        
    } andFailhandle:^(NSString *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}
// 刷新显示的用户数据
- (void) refreshViewContent
{
    
    __weak typeof(self) weakself = self;
    [[NetWorkHelp shareHelper]asyncDataFromServerWithParamDictionary:PARAM_USER_LIST(ACCESS_TOKEN, USER_MODEL.userId, self.userId, @"xml") andModelType:OtherUserModel andSuccessHandle:^(id obj) {
        weakself.userModel = obj;
        [weakself refreshTopViewContent:obj];
    } andFailhandle:^(NSString *error) {
        
    }];
}



#pragma mark - UIImagePickerController

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.image = info[UIImagePickerControllerEditedImage];
    __weak typeof(self) weakself = self;
    [picker dismissViewControllerAnimated:YES completion:^ {

        [[NetWorkHelp shareHelper]sendDataWithImage:weakself.image andMessage:nil andType:0 andSuccessHandle:^(id obj) {
            [weakself refreshViewContent];
        } andFailhandle:^(NSString *error) {
            
        }];
        
    }];
}
#pragma mark - TZImagePickerControllerDelegate
// 取消选择回调的方法
- (void) imagePickerControllerDidCancel:(TZImagePickerController *)picker
{
    
}

// 选择好图片点击确定回调的方法（不带图片信息）
- (void) imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    if (photos.count > 0)
    {
        self.image = photos[0];
        __weak typeof(self) weakself = self;
        [[NetWorkHelp shareHelper]sendDataWithImage:self.image andMessage:nil andType:0 andSuccessHandle:^(id obj) {
            [weakself refreshViewContent];
        } andFailhandle:^(NSString *error) {
            
        }];
    }
    
}

// 选择好图片点击确定回调的方法（带图片信息）
- (void) imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos
{
    
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
