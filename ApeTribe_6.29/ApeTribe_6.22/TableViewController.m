//
//  TableViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/1.
//  Copyright © 2016年 One. All rights reserved.
//

#import "TableViewController.h"
#import "MJRefresh/MJRefresh.h"
#import "InteractivityTransitionDelegate.h"

@interface TableViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    CGFloat originY;
    UIImageView *navBarHairlineImageView;
}
@property (nonatomic, readonly) UITableViewStyle style;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *interactiveTransitionRecognizer;
@end

@implementation TableViewController
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
- (instancetype)initWithStyle:(UITableViewStyle)style andTopView:(BOOL)showTopView andOperationType:(TableViewControllerOperationType)type
{
    self = [super init];
    if (self) {
        _style = style;
        _type = type;
        _showTopView = showTopView;
        
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 添加滑动交互手势
    self.interactiveTransitionRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:self.interactiveTransitionRecognizer];
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    [self initialView];
}
- (void) viewWillAppear:(BOOL)animated
{
    // 设置导航栏样式
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont  systemFontOfSize:18],NSFontAttributeName,COLOR_FONT_D_GRAY,NSForegroundColorAttributeName,nil]];
    [[UINavigationBar appearance] setTintColor:COLOR_FONT_D_GRAY];
    
    [self.navigationController.navigationBar setBackgroundImage:[Tool imageWithBGColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setShadowImage:[Tool imageWithBGColor:[UIColor colorWithWhite:0.647 alpha:1.000]]];
    
    // 隐藏导航栏返回按钮的文字
//    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(-100, -60) forBarMetrics:UIBarMetricsDefault];
    navBarHairlineImageView.hidden = NO;
    
}

- (void) initialView
{
    // 设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    // 导航栏左侧按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"topbar_back_pressed"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"topbar_back_normal"] forState:UIControlStateSelected];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
    _showRefreshHeader = NO;
    _showRefreshFooter = NO;
    _showTableBlankView = NO;

    // 横坐标
    if (_showTopView) {
        self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W,  30 + 40)];
        [self.view addSubview:self.topView];
        
        originY = 30 + 40;
        originY = self.topView.frame.origin.y + self.topView.frame.size.height;
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY) style:self.style];
        
    }
    else
    {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:self.style];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    
    
    
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

#pragma mark - setter

- (void)setShowRefreshHeader:(BOOL)showRefreshHeader
{
    if (_showRefreshHeader != showRefreshHeader) {
        _showRefreshHeader = showRefreshHeader;
        if (_showRefreshHeader) {
//            __weak typeof(self)weakSelf = self;
            [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(tableViewDidTriggerHeaderRefresh) dateKey:nil];
//            self.tableView.header = [MJRefreshHeader headerWithRefreshingBlock:^{
//                [weakSelf tableViewDidTriggerHeaderRefresh];
//                [weakSelf.tableView.header beginRefreshing];
//            }];
            //            header.updatedTimeHidden = YES;
        }
        else{
            //            [self.tableView removeHeader];
        }
    }
}

- (void)setShowRefreshFooter:(BOOL)showRefreshFooter
{
    if (_showRefreshFooter != showRefreshFooter) {
        _showRefreshFooter = showRefreshFooter;
        if (_showRefreshFooter) {
//            __weak typeof(self)weakSelf = self;
            // 添加下拉刷新
            [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(tableViewDidTriggerFooterRefresh)];
//            self.tableView.footer = [MJRefreshFooter footerWithRefreshingBlock:^{
//                [weakSelf tableViewDidTriggerFooterRefresh];
//                [weakSelf.tableView.mj_footer beginRefreshing];
//            }];
        }
        else{
            //            [self.tableView removeFooter];
        }
    }
}

- (void)setShowTableBlankView:(BOOL)showTableBlankView
{
    if (_showTableBlankView != showTableBlankView) {
        _showTableBlankView = showTableBlankView;
    }
}

#pragma mark - getter

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (NSMutableDictionary *)dataDictionary
{
    if (_dataDictionary == nil) {
        _dataDictionary = [NSMutableDictionary dictionary];
    }
    
    return _dataDictionary;
}

- (UIView *)defaultFooterView
{
    if (_defaultFooterView == nil) {
        _defaultFooterView = [[UIView alloc] init];
    }
    
    return _defaultFooterView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KCELLDEFAULTHEIGHT;
}

#pragma mark - public refresh
// 自动刷新表格
- (void)autoTriggerHeaderRefresh
{
    if (self.showRefreshHeader) {
        [self tableViewDidTriggerHeaderRefresh];
    }
}

/**
 *  下拉刷新事件
 */
- (void)tableViewDidTriggerHeaderRefresh
{
    
}

/**
 *  上拉加载事件
 */
- (void)tableViewDidTriggerFooterRefresh
{
    
}

// 结束刷新
- (void)tableViewDidFinishTriggerHeader:(BOOL)isHeader reload:(BOOL)reload
{
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (isHeader)
        {
            [weakSelf.tableView.header endRefreshing];
            
        }
        else{
            if (reload) {
                [weakSelf.tableView.footer resetNoMoreData];
            }
            else
            {
                [weakSelf.tableView.footer noticeNoMoreData];
            }
            
        }
    });
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
