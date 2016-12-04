//
//  SearchViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/5.
//  Copyright © 2016年 One. All rights reserved.
//

#import "SearchViewController.h"
#import "SocialViewController.h"
#import "HomeLabel.h"
#import "LoadModel.h"
#import "URL.h"
#import "Ono.h"
#import "SearchXMLModel.h"
#import "MJRefresh.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
@interface SearchViewController ()<UISearchBarDelegate,UIScrollViewDelegate,SocialViewControllerDelegate>
@property(nonatomic,strong)UISearchBar*searchBar;
@property(nonatomic,strong)UIScrollView*contentScrollView;
@property(nonatomic,strong)UIView *buttomV;
@property(nonatomic,strong)NSMutableArray*allTableData;//全部表格数据
@property(nonatomic,assign)NSInteger currentTitle;//当前显示的页码
@property(nonatomic,strong)NSArray *arr;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr = @[@"project",@"post",@"blog",@"news"];

    self.view.backgroundColor = [UIColor whiteColor];
    // 导航栏左侧返回按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"topbar_back_pressed"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"topbar_back_normal"] forState:UIControlStateSelected];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    //初始化搜索栏
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(10, 5, self.view.frame.size.width-20, 44)];
    //显示
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.placeholder = @"搜索";
    self.searchBar.delegate =self;

//     添加子控制器
    [self setupChildVc];
    // 添加标题
    [self setupTitle];
    //创建滚动视图
    self.contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 99, SCREEN_SIZE.width, SCREEN_SIZE.height-99)];
    self.contentScrollView.delegate = self;
   self.contentScrollView.contentSize = CGSizeMake(4*SCREEN_SIZE.width, 0);
    self.contentScrollView.pagingEnabled = YES;
    [self.view addSubview:self.contentScrollView];
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    //设置偏移量
    self.contentScrollView.contentInset = UIEdgeInsetsMake(-64, 0, -49, 0);
    // 创建表格为空时显示的视图
    UIView *blankView0,*blankView1,*blankView2,*blankView3,*blankView4;
    
    blankView0 = [self blankViewWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, self.contentScrollView.frame.size.height)];
    blankView1 = [self blankViewWithFrame:CGRectMake(SCREEN_SIZE.width, 0, SCREEN_SIZE.width, self.contentScrollView.frame.size.height)];
    blankView2 = [self blankViewWithFrame:CGRectMake(SCREEN_SIZE.width * 2, 0, SCREEN_SIZE.width, self.contentScrollView.frame.size.height)];
    blankView3 = [self blankViewWithFrame:CGRectMake(SCREEN_SIZE.width * 3, 0, SCREEN_SIZE.width, self.contentScrollView.frame.size.height)];
    blankView4 = [self blankViewWithFrame:CGRectMake(SCREEN_SIZE.width * 4, 0, SCREEN_SIZE.width, self.contentScrollView.frame.size.height)];
    // 添加视图
    [self.contentScrollView addSubview:blankView0];
    [self.contentScrollView addSubview:blankView1];
    [self.contentScrollView addSubview:blankView2];
    [self.contentScrollView addSubview:blankView3];
    [self.contentScrollView addSubview:blankView4];
    // 默认显示第0个子控制器
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setupChildVc
{
    SocialViewController *softwaraVC = [[SocialViewController alloc]init];
    softwaraVC.adelegate = self;
    softwaraVC.title = @"软件";
    [self addChildViewController:softwaraVC];
    SocialViewController *answersVC = [[SocialViewController alloc]init];
    answersVC.adelegate = self;
    answersVC.title = @"问答";
    [self addChildViewController:answersVC];
    SocialViewController *bogVC = [[SocialViewController alloc]init];
    bogVC.adelegate = self;
    bogVC.title = @"博客";
    [self addChildViewController:bogVC];
    SocialViewController *messageVC = [[SocialViewController alloc]init];
    messageVC.adelegate =self;
    messageVC.title = @"资讯";
    [self addChildViewController:messageVC];
}
/**
 * 添加标题
 */
- (void)setupTitle
{
    UIView *buttomV = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_SIZE.width, 30)];
    self.buttomV = buttomV;
    CGFloat labelW = SCREEN_SIZE.width/4;
    CGFloat labelY = 0;
    CGFloat labelH =30;
    //添加label
    for (NSInteger i = 0; i<4; i++)
    {
        HomeLabel *label = [[HomeLabel alloc]init];
        label.text = [self.childViewControllers[i] title];
        CGFloat labelX= i*labelW;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        label.tag = i;
        [buttomV addSubview:label];
        if (i==0) {
            label.scale = 1.0;
        }

    }
  
    [self.view addSubview:buttomV];

}
//lable监听
-(void)labelClick:(UITapGestureRecognizer *)tap
{
  
    NSInteger index = tap.view.tag;
    self.currentTitle = index;
    [self.contentScrollView setContentOffset:CGPointMake(index*SCREEN_SIZE.width, 0) animated:NO];
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];

    //上传数据，判断是否登录
    if (![[Tool readLoginState:LOGIN_STATE] isEqualToString:@"1"])
    {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController presentViewController:[Tool getNavigationController:loginVC andtransitioningDelegate:nil andNavigationViewControllerType:NavigationControllerMineType] animated:YES completion:nil];
    }else
    {
        if (_searchBar.text.length !=0)
        {
            
            NSDictionary *dic = @{@"access_token":ACCESS_TOKEN,@"catalog":_arr[index],@"q":_searchBar.text,@"pageSize":@(20),@"page":@(1),@"dataType":@"xml"};
            
            [self loadMyData:dic andIndex:self.currentTitle andpage:1];
        }
        
    }



}
#pragma mark - <UIScrollViewDelegate>
/**
 * scrollView结束了滚动动画以后就会调用这个方法（比如- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;方法执行的动画完毕后）
 */
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 一些临时变量
    CGFloat width = self.contentScrollView.frame.size.width;
    CGFloat height = self.contentScrollView.frame.size.height;
    CGFloat offsetX = self.contentScrollView.contentOffset.x;
    //当前位置需要显示的控制器的索引
    NSInteger index = offsetX / width;
    self.currentTitle = index;
    
    if (![[Tool readLoginState:LOGIN_STATE] isEqualToString:@"1"])
    {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController presentViewController:[Tool getNavigationController:loginVC andtransitioningDelegate:nil andNavigationViewControllerType:NavigationControllerMineType] animated:YES completion:nil];
    }else
    {
        if (_searchBar.text.length !=0)
        {
            NSDictionary *dic = @{@"access_token":ACCESS_TOKEN,@"catalog":_arr[index],@"q":_searchBar.text,@"pageSize":@(20),@"page":@(1),@"dataType":@"xml"};
            
            [self loadMyData:dic andIndex:self.currentTitle andpage:1];
        }
        
    }
   
    // 取出对应的标题
    HomeLabel *label = self.buttomV.subviews[index];
    label.scale = 1.0;
    // 让其他label回到最初的状态
    for (HomeLabel *otherLabel in self.buttomV.subviews) {
        if (otherLabel != label) otherLabel.scale = 0.0;
    }
    // 取出需要显示的控制器
    UIViewController *willShowVc = self.childViewControllers[index];

    // 如果当前位置的位置已经显示过了，就直接返回
    if ([willShowVc isViewLoaded]) return;
    
    // 添加控制器的view到contentScrollView中;
    willShowVc.view.frame = CGRectMake(offsetX, 0, width, height);
    [scrollView addSubview:willShowVc.view];
}
/**
 * 手指松开scrollView后，scrollView停止减速完毕就会调用这个
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}
/**
 * 只要scrollView在滚动，就会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scale = self.contentScrollView.contentOffset.x / self.contentScrollView.frame.size.width;
    if (scale < 0 || scale > self.buttomV.subviews.count - 1) return;
    
    // 获得需要操作的左边label
    NSInteger leftIndex = scale;
    HomeLabel *leftLabel = self.buttomV.subviews[leftIndex];
    
    // 获得需要操作的右边label
    NSInteger rightIndex = leftIndex + 1;
    HomeLabel *rightLabel = (rightIndex == self.buttomV.subviews.count) ? nil : self.buttomV.subviews[rightIndex];
    
    // 右边比例
    CGFloat rightScale = scale - leftIndex;
    // 左边比例
    CGFloat leftScale = 1 - rightScale;
    // 设置label的比例
    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;
}

// 创建表格为空时显示的视图
- (UIView *) blankViewWithFrame:(CGRect)frame
{
    UIView *blankView = [[UIView alloc]initWithFrame:frame];
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, 60, 60)];
    imgV.center = CGPointMake(SCREEN_SIZE.width / 2, 150);
    imgV.backgroundColor = [UIColor whiteColor];
    imgV.image = [UIImage imageNamed:@"page_icon_empty@2x"];
    UILabel *messageLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 21)];
    messageLb.text = @"暂无内容";
    messageLb.center = CGPointMake(SCREEN_SIZE.width / 2, imgV.frame.origin.y + 60 + 30);
    messageLb.textAlignment = NSTextAlignmentCenter;
    messageLb.font = [UIFont systemFontOfSize:15 weight:1];
    //    blankView.backgroundColor = [UIColor redColor];
    [blankView addSubview:imgV];
    [blankView addSubview:messageLb];
    return blankView;
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (![[Tool readLoginState:LOGIN_STATE] isEqualToString:@"1"])
    {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController presentViewController:[Tool getNavigationController:loginVC andtransitioningDelegate:nil andNavigationViewControllerType:NavigationControllerMineType] animated:YES completion:nil];
    }else
    {
    [self downData:1];
    }
    [searchBar resignFirstResponder];
  
    
}

#pragma mark
#pragma mark 代理方法
-(void)SocialViewController:(SocialViewController *)SController andInteger:(NSInteger)page
{
    [self downData:page];
    
}
-(void)downData:(long)page
{
    if (self.currentTitle == 0)
    {
        NSDictionary *dic = @{@"access_token":ACCESS_TOKEN,@"catalog":@"project",@"q":_searchBar.text,@"pageSize":@(20),@"page":@(page),@"dataType":@"xml"};
        
        [self loadMyData:dic andIndex:self.currentTitle  andpage:page];
        
    }else if (self.currentTitle == 1)
    {
        NSDictionary *dic = @{@"access_token":ACCESS_TOKEN,@"catalog":@"post",@"q":_searchBar.text,@"pageSize":@(20),@"page":@(page),@"dataType":@"xml"};
        
        [self loadMyData:dic andIndex:self.currentTitle andpage:page];
    }else if (self.currentTitle == 2)
    {
        NSDictionary *dic = @{@"access_token":ACCESS_TOKEN,@"catalog":@"blog",@"q":_searchBar.text,@"pageSize":@(20),@"page":@(page),@"dataType":@"xml"};
        
        [self loadMyData:dic andIndex:self.currentTitle andpage:page ];
    }else
    {
        NSDictionary *dic = @{@"access_token":ACCESS_TOKEN,@"catalog":@"news",@"q":_searchBar.text,@"pageSize":@(20),@"page":@(page),@"dataType":@"xml"};
        
        [self loadMyData:dic andIndex:self.currentTitle andpage:page ];
    }

}

-(void)loadMyData:(NSDictionary *)param andIndex:(NSInteger)index andpage:(long)page
{
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_OPENPREFIX,URL_SEARCH_LIST];
    
    [LoadModel postRequestWithUrl:strUrl andParams:param andSucBlock:^(id responseObject) {
//         NSLog(@"========%@",responseObject);
        ONOXMLDocument *obj = responseObject;
        ONOXMLElement *result = obj.rootElement;
        ONOXMLElement *object = [result firstChildWithTag:@"results"];
        NSArray *arr = [object childrenWithTag:@"result"];
        //下载的个数
        long pageSize = [[[result firstChildWithTag:@"pageSize"] numberValue]longValue];
        NSMutableArray *mArr = [NSMutableArray new];
        for (ONOXMLElement *objectXML in arr)
        {
            SearchXMLModel *searchModel =[[SearchXMLModel alloc]initWithXML:objectXML];
            [mArr addObject:searchModel];

        }
        //取出相应的控制器
        SocialViewController *socialVC = self.childViewControllers[index];
         socialVC.pagesize = pageSize;
        if (page>=2)//加载下一页
        {
            //累加商品
            [ socialVC.mArrData addObjectsFromArray:mArr];
        }else
        {
            if (mArr.count == 0)
            {
                socialVC.tableView.hidden = YES;
            }else
            {
              socialVC.mArrData = mArr;
                socialVC.tableView.hidden = NO;
            }
            
        }
    
        [socialVC.tableView reloadData];
        //结束下拉刷新
        [socialVC.tableView.header endRefreshing];
        //结束上提刷新
        [socialVC.tableView.footer endRefreshing];
       
    } andFailBlock:^(NSError *error) {
        
    }];
}
@end
