//
//  FocusAndFansViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/1.
//  Copyright © 2016年 One. All rights reserved.
//

#import "FocusAndFansViewController.h"
#import "FocusTableViewCell.h"
#import "MineViewController.h"
#import "MJRefresh.h"
#define ROW_H 58

@interface FocusAndFansViewController ()<UITableViewDelegate, UITableViewDataSource, BaseTableViewCellDelegate>
{
    int fansCurrentPage;
    int focusCurrentPage;

}
@end

@implementation FocusAndFansViewController
- (instancetype) initWithStyle:(UITableViewStyle)style andUserId:(long)uid andIndex:(int)index andOperationType:(TableViewControllerOperationType)type
{
    if (self = [super initWithStyle:style andTopView:NO andOperationType:type])
    {
        
        self.page = index;
        self.userId = uid;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initial];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void) initial
{
    UILabel *lineLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 65 - 0.5, SCREEN_W, 0.5)];
    lineLb.backgroundColor = COLOR_BG_LINE_GRAY;
    [self.topView addSubview:lineLb];
    
    self.segmentView = [[SegmentView alloc]initWithFrame:CGRectMake(0, 32, 150, 28) andIndex:self.page andBackgroundColor:COLOR_FONT_D_GREEN andTitles:@[@"关注",@"粉丝"]];
    self.segmentView.center = CGPointMake(self.view.frame.size.width/2.0, self.segmentView.frame.size.height);

    // 将按钮添加到导航栏视图
    self.navigationItem.titleView = self.segmentView;
    __weak typeof(self) weakself = self;
    self.segmentView.clickHandle = ^(int index)
    {
        weakself.page = index;
        NSArray *arr = weakself.arrData[index];
        // 判断是否已经有数据
        if (arr.count == 0) {
            [weakself.tableView.header beginRefreshing];
            [weakself tableViewDidTriggerHeaderRefresh];
            
        }
        else
        {
            weakself.dataArray = arr.mutableCopy;
            [weakself.tableView reloadData];
        }
        
    };
    weakself.arrData = [NSMutableArray new];
    NSMutableArray *arr = [NSMutableArray new];
    [weakself.arrData addObject:arr];
    [weakself.arrData addObject:arr];
    UINib *nib = [UINib nibWithNibName:@"FocusTableViewCell" bundle:[NSBundle mainBundle]];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"focusCell"];
    self.showRefreshHeader = YES;
    self.showRefreshFooter = YES;
    focusCurrentPage = 0;
    fansCurrentPage = 0;
    [self tableViewDidTriggerHeaderRefresh];
    [self.tableView.header beginRefreshing];
}


- (UIStatusBarStyle)preferredStatusBarStyle
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FocusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"focusCell" forIndexPath:indexPath];
    cell.delegate = self;
    switch (self.page)
    {
        case 0:
            
            break;
        
        case 1:
            
            break;
        default:
            break;
    }
    
    // Configure the cell...
    
    [cell setCell:(FriendXMLModel *)self.dataArray[indexPath.row]];
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ROW_H;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FriendXMLModel *model = self.dataArray[indexPath.row];
    [self clickButtonAction:model.userId];
    
    
}
#pragma mark - BaseTableViewCellDelegate
- (void) clickButtonAction:(long)userId
{
    MineViewController *mineVC = [[MineViewController alloc]initWithState:NO andUserId:userId andOperationType:NavigationControllerOperationTypePop];
    mineVC.customTransitionDelegate = self.myTransitionDelegate;
    [self presentViewController:[Tool getNavigationController:mineVC andtransitioningDelegate:self.myTransitionDelegate andNavigationViewControllerType:NavigationControllerMineType] animated:YES completion:nil];
}

#pragma mark - private



- (void) tableViewDidTriggerHeaderRefresh
{
    [self refreshTableViewWithPageIndex:0];
}

- (void) tableViewDidTriggerFooterRefresh
{
    if (self.page == 0) {
        [self refreshTableViewWithPageIndex:++focusCurrentPage];
    }
    else
    {
        [self refreshTableViewWithPageIndex:++fansCurrentPage];
    }
    
}


- (void) refreshTableViewWithPageIndex:(int)pageIndex
{
    __weak typeof(self) weakself = self;
    NSLog(@"self.page = %d",self.page);
    // relation：0:粉丝 1：关注的
    // all：0：分页 1：不分页
    [[NetWorkHelp shareHelper]asyncDataFromServerWithURLString:URL_STR(URL_HTTP_PREFIX, URL_FRIENDS_LIST) andParamDictionary:PARAM_FRIENDS_LIST(self.userId, pageIndex, 20, abs(self.page - 1), 0) andModelType:FriendModel andSuccessHandle:^(id obj) {
        NSMutableArray *arr = weakself.arrData[self.page];
        NSMutableArray *mArr = (NSMutableArray *)obj;
        // 判断下拉还是上提
        if (pageIndex == 0)
        {
            // 下拉刷新
            arr = obj;
            weakself.dataArray = arr;
            [weakself.arrData replaceObjectAtIndex:weakself.page withObject:arr];
            [self.tableView reloadData];
            // 结束刷新
            if (mArr.count == 0)
            {
                [weakself tableViewDidFinishTriggerHeader:YES reload:NO];
            }
            else
            {
                [weakself tableViewDidFinishTriggerHeader:YES reload:YES];
            }
        }
        else
        {
            // 上提刷新
            
            // 结束刷新
            if (mArr.count < 20)
            {
                
                // 当前页回退
                if (weakself.page == 0)
                {
                    focusCurrentPage--;
                }
                else
                {
                    fansCurrentPage--;
                }
                [arr addObjectsFromArray:obj];
                [weakself.arrData replaceObjectAtIndex:weakself.page withObject:arr];
                weakself.dataArray = arr;
                [self.tableView reloadData];
                [weakself tableViewDidFinishTriggerHeader:NO reload:NO];
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
