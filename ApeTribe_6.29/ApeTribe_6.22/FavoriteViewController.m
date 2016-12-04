//
//  FavoriteViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/1.
//  Copyright © 2016年 One. All rights reserved.
//

#import "FavoriteViewController.h"
#import "FavoriteXMLModel.h"
#import "MJRefresh.h"
#import "PostDetailViewController.h"
#import "DetailDiscoverController.h"
#define F_ROW_H 40
@interface FavoriteViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *arrTitles;
}

@end

@implementation FavoriteViewController

- (instancetype) initWithStyle:(UITableViewStyle)style andOperationType:(TableViewControllerOperationType)type
{
    return [self initWithStyle:style andPage:0 andOperationType:type];
}

- (instancetype) initWithStyle:(UITableViewStyle)style andPage:(int)page andOperationType:(TableViewControllerOperationType)type
{
    if (self = [super initWithStyle:UITableViewStylePlain andTopView:YES andOperationType:type])
    {
        self.page = page;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏";
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *lineLb = [[UILabel alloc]initWithFrame:CGRectMake(0, self.topView.frame.size.height - 0.5, SCREEN_W, 0.3)];
    lineLb.backgroundColor = [UIColor colorWithWhite:0.903 alpha:1.000];
    [self.topView addSubview:lineLb];
    
    
    arrTitles = @[@"软件",@"帖子",@"博客",@"资讯"];
    self.segmentView = [[SegmentView alloc]initWithFrame:CGRectMake(20, self.topView.frame.size.height - 50, SCREEN_W - 40, 30) andIndex:self.page andBackgroundColor:COLOR_FONT_D_GREEN andTitles:arrTitles];
    [self.topView addSubview:self.segmentView];
    __weak typeof(self) weakself = self;
    self.segmentView.clickHandle = ^(int index)
    {
        weakself.page = index;
        NSArray *arr = weakself.arrData[index];
        // 判断是否已经有数据
        if (arr.count == 0)
        {
            [weakself.tableView.header beginRefreshing];
            [weakself tableViewDidTriggerHeaderRefresh];
            
        }
        else
        {
            weakself.dataArray = arr.mutableCopy;
            [weakself.tableView reloadData];
        }
    };

    self.tableView.backgroundColor = [UIColor colorWithWhite:0.938 alpha:1.000];
    self.showRefreshHeader = YES;
    self.showRefreshFooter = YES;
    // 初始化数组
    NSMutableArray *mArr = [NSMutableArray new];
    self.arrData = [NSMutableArray new];// 表格的页码
    self.arrPageIndexs = [NSMutableArray new];// 表格数据
    for (int i = 0; i < 4; i++)
    {
        [self.arrPageIndexs addObject:@"1"];
        [self.arrData addObject:mArr];
        
    }
    [self.tableView.header beginRefreshing];
    [self refreshTableViewWithPageIndex:1];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate, UITableViewDataSource


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *cellIdentifier;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    FavoriteXMLModel *model = (FavoriteXMLModel *)self.dataArray[indexPath.section];
    cell.textLabel.text = model.title;
    cell.textLabel.font = FONT(13);
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return F_ROW_H;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FavoriteXMLModel *model = self.dataArray[indexPath.section];
    
    switch (self.page)
    {
        case 0:// 软件
        {
            DetailDiscoverController *detailVC = [[DetailDiscoverController alloc]init];
            detailVC.url = model.url;
            detailVC.customTransitionDelegate = self.myTransitionDelegate;
            [self presentViewController:[Tool getNavigationController:detailVC andtransitioningDelegate:self.myTransitionDelegate andNavigationViewControllerType:NavigationControllerNormalType] animated:YES completion:nil];
        }
            break;
        case 1:// 帖子
        {
            UIStoryboard *std = [UIStoryboard storyboardWithName:@"AnswerStoryBoard" bundle:[NSBundle mainBundle]];
            PostDetailViewController *postVC = [std instantiateViewControllerWithIdentifier:@"PostDetailVC"];
            postVC.type = 3;
            postVC.Id = model.objid;
            postVC.customTransitionDelegate = self.myTransitionDelegate;
            [self presentViewController:[Tool getNavigationController:postVC andtransitioningDelegate:self.myTransitionDelegate andNavigationViewControllerType:NavigationControllerNormalType] animated:YES completion:nil];
            
        }
            break;
        case 2:// 博客
        {
            UIStoryboard *std = [UIStoryboard storyboardWithName:@"AnswerStoryBoard" bundle:[NSBundle mainBundle]];
            PostDetailViewController *postVC = [std instantiateViewControllerWithIdentifier:@"PostDetailVC"];
            postVC.type = 1;
            postVC.Id = model.objid;
            postVC.customTransitionDelegate = self.myTransitionDelegate;
            [self presentViewController:[Tool getNavigationController:postVC andtransitioningDelegate:self.myTransitionDelegate andNavigationViewControllerType:NavigationControllerNormalType] animated:YES completion:nil];
        }
            break;
        case 3:// 资讯
        {
            UIStoryboard *std = [UIStoryboard storyboardWithName:@"AnswerStoryBoard" bundle:[NSBundle mainBundle]];
            PostDetailViewController *postVC = [std instantiateViewControllerWithIdentifier:@"PostDetailVC"];
            postVC.type = 0;
            postVC.Id = model.objid;
            postVC.customTransitionDelegate = self.myTransitionDelegate;
            [self presentViewController:[Tool getNavigationController:postVC andtransitioningDelegate:self.myTransitionDelegate andNavigationViewControllerType:NavigationControllerNormalType] animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.5;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.dataArray.count - 1)
    {
        return 1;
    }
    return 0.5;
}




#pragma mark - private



- (void) tableViewDidTriggerHeaderRefresh
{
    [self refreshTableViewWithPageIndex:1];
}

- (void) tableViewDidTriggerFooterRefresh
{
    int pagIndex = [self.arrPageIndexs[self.page]intValue];
    [self refreshTableViewWithPageIndex:++pagIndex];
    [self.arrPageIndexs replaceObjectAtIndex:self.page withObject:[NSString stringWithFormat:@"%d",pagIndex]];
}

- (void) refreshTableViewWithPageIndex:(int)pageIndex
{
    int type = 0;// type：0-全部|1-软件|2-话题|3-博客|4-新闻|5代码|7-翻译
    switch (self.page) {
        case 0:// 软件
            type = 1;
            break;
        case 1:// 帖子
            type = 2;
            break;
        case 2:// 博客
            type = 3;
            break;
        case 3:// 资讯
            type = 4;
            break;
        default:
            break;
    }
    __weak typeof(self) weakself = self;
    __block int pageIndexBlock = pageIndex;
    // 下载数据
    [[NetWorkHelp shareHelper]asyncDataFromServerWithParamDictionary:PARAM_FAVORITE_LIST(type, 1, 20, ACCESS_TOKEN, @"xml") andModelType:FavoriteModel andSuccessHandle:^(id obj) {
        NSMutableArray *arr = weakself.arrData[self.page];
        NSMutableArray *mArr = (NSMutableArray *)obj;
        // 判断下拉还是上提
        if (pageIndex == 1)
        {
            // 下拉刷新
            arr = obj;
            weakself.dataArray = arr;
            [weakself.arrData replaceObjectAtIndex:weakself.page withObject:arr];
            [self.tableView reloadData];
            // 结束刷新
            if (mArr.count < 20)
            {
                [weakself tableViewDidFinishTriggerHeader:YES reload:NO];
            }
            else
            {
                [weakself tableViewDidFinishTriggerHeader:YES reload:YES];
            }
        }
        else// 上提刷新
        {
            
            // 结束刷新
            if (mArr.count < 20)
            {
                weakself.dataArray = arr;
                [self.tableView reloadData];
                [weakself tableViewDidFinishTriggerHeader:NO reload:NO];
                // 当前页回退
                [weakself.arrPageIndexs replaceObjectAtIndex:weakself.page withObject:[NSString stringWithFormat:@"%d",--pageIndexBlock]];
                
            }
            else
            {
                [arr addObjectsFromArray:obj];
                [weakself.arrData replaceObjectAtIndex:weakself.page withObject:arr];
                weakself.dataArray = arr;
                [self.tableView reloadData];

                [weakself tableViewDidFinishTriggerHeader:NO reload:YES];
            }
        }

    } andFailhandle:^(NSString *error) {
        
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
