//
//  MineMessageViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/25.
//  Copyright © 2016年 One. All rights reserved.
//

#import "MineMessageViewController.h"
#import "MineViewController.h"
#import "AtMeTableViewCell.h"
#import "FansTableViewCell.h"
#import "MJRefresh.h"
@interface MineMessageViewController ()<UITableViewDelegate,UITableViewDataSource, BaseTableViewCellDelegate>
{
    NSArray *arrTitles;// 按钮标题字符串数组
    NSArray *arrCellIdentities;// 单元格的标志数组
   
}
@end

@implementation MineMessageViewController

- (instancetype) initWithStyle:(UITableViewStyle)style andPage:(int)page andOperationType:(TableViewControllerOperationType)type
{
    if (self = [super initWithStyle:style andTopView:YES andOperationType:type])
    {
        self.page = page;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    
    [self initialContent];
    
}
- (void) initialContent
{
    UILabel *lineLb = [[UILabel alloc]initWithFrame:CGRectMake(0, self.topView.frame.size.height - 0.5, SCREEN_W, 0.3)];
    lineLb.backgroundColor = COLOR_BG_LINE_GRAY;
    [self.topView addSubview:lineLb];
    
    arrTitles = @[@"@我",@"私信",@"评论",@"通知"];
    self.segmentView = [[SegmentView alloc]initWithFrame:CGRectMake(20, self.topView.frame.size.height - 50, SCREEN_W - 40, 30) andIndex:self.page andBackgroundColor:COLOR_FONT_D_GREEN andTitles:arrTitles];
    [self.topView addSubview:self.segmentView];
    __weak typeof(self) weakself = self;
    self.segmentView.clickHandle = ^(int index)
    {
        weakself.page = index;
        NSArray *arr = weakself.arrData[index];
        // 判断是否已经有数据
        if (arr.count == 0) {
            if (weakself.page != 0) {
                [weakself.tableView.header beginRefreshing];
                [weakself tableViewDidTriggerHeaderRefresh];
            }
            else
            {
                
                weakself.dataArray = arr.mutableCopy;
                [weakself.tableView reloadData];
            }
            
            
        }
        else
        {
            weakself.dataArray = arr.mutableCopy;
            [weakself.tableView reloadData];
        }

    };
    
    // 注册cell
    UINib *nib0 = [UINib nibWithNibName:@"AtMeTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib0 forCellReuseIdentifier:@"atMeCell"];
    UINib *nib1 = [UINib nibWithNibName:@"FansTableViewCell" bundle:nil];
    [self.tableView registerNib:nib1 forCellReuseIdentifier:@"fansCell"];
    arrCellIdentities = @[@"atMeCell",@"fansCell"];
    
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
    
    
    //
    [weakself.tableView.header beginRefreshing];
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


#pragma mark - action



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
    NSString *cellIdentifier;
//    MineTableViewCellStyle style = MineAtMeTableViewCellStyle;
    switch (self.page) {
        case 0:
        case 2:
            cellIdentifier = arrCellIdentities[0];
            break;
        case 1:
        case 3:
            cellIdentifier = arrCellIdentities[1];
            break;
        default:
            break;
    }
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    // 设置单元格内容
    [cell setCell:self.dataArray[indexPath.row]];
    
    return cell;
}
#pragma mark - AtMeTableViewCellDelegate
- (void) clickButtonAction:(long)userId
{
    MineViewController *mineVC = [[MineViewController alloc]initWithState:NO andUserId:userId andOperationType:NavigationControllerOperationTypePop];
    mineVC.customTransitionDelegate = self.myTransitionDelegate;
    [self presentViewController:[Tool getNavigationController:mineVC andtransitioningDelegate:self.myTransitionDelegate andNavigationViewControllerType:NavigationControllerMineType] animated:YES completion:nil];
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.page == 1 || self.page == 3)
    {
        return 58;
    }
    return 93;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
// 下拉刷新
- (void) tableViewDidTriggerHeaderRefresh
{
    [self refreshTableViewWithPageIndex:1];
}
// 上提加载
- (void) tableViewDidTriggerFooterRefresh
{
    int pagIndex = [self.arrPageIndexs[self.page]intValue];
    [self refreshTableViewWithPageIndex:++pagIndex];
    [self.arrPageIndexs replaceObjectAtIndex:self.page withObject:[NSString stringWithFormat:@"%d",pagIndex]];
}


- (void) refreshTableViewWithPageIndex:(int)pageIndex
{
    
    NSDictionary *paramDic = PARAM_ACTIVE_LIST(USER_MODEL.userId, 2, pageIndex, 20, ACCESS_TOKEN, @"xml");// 默认@我参数
    NSString *urlString = URL_STR(SERVER, URL_ACTIVE_LIST);// 默认动态网址
    switch (self.page) {
        case 0:// @我
            paramDic = PARAM_ACTIVE_LIST(USER_MODEL.userId, 2, pageIndex, 20, ACCESS_TOKEN, @"xml");
            break;
        case 1:// 私信
            
            paramDic = PARAM_MSG_LIST(pageIndex, 20, ACCESS_TOKEN, @"xml");
            break;
        case 2:// 评论
            paramDic = PARAM_ACTIVE_LIST(USER_MODEL.userId, 3, pageIndex, 20, ACCESS_TOKEN, @"xml");
            break;
        case 3:// 新增粉丝，赞我
            paramDic = PARAM_ACTIVE_LIST(USER_MODEL.userId, 4, pageIndex, 20, ACCESS_TOKEN, @"xml");
            break;
        default:
            break;
    }
    XMLModelType modelType = ActiveModel;
    // 判断是私信
    if (self.page == 1)
    {
        urlString = URL_STR(SERVER, URL_MSG_LIST);
        modelType = MessageModel;
    }
    
    __weak typeof(self) weakself = self;
    __block int pageIndexBlock = pageIndex;
    // 下载数据
    [[NetWorkHelp shareHelper]asyncDataFromServerWithURLString:urlString andParamDictionary:paramDic andModelType:modelType andSuccessHandle:^(id obj) {
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
