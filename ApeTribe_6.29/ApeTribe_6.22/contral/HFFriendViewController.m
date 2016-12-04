//
//  HFFriendViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/24.
//  Copyright © 2016年 One. All rights reserved.
//

#import "HFFriendViewController.h"
#import "ContactModel.h"
#import "ContactTableViewCell.h"
#import "ContactDataHelper.h"//根据拼音A~Z~#进行排序的tool
#import "SVProgressHUD.h"
#import "FindXMLModel.h"
#import "LoadModel.h"
#import "Ono.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
@interface HFFriendViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate>
{
    NSArray *_rowArr;//row arr
    NSArray *_sectionArr;//section arr
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *serverDataArr;//数据源
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) UISearchBar *searchBar;//搜索框
@property (nonatomic,strong) UISearchDisplayController *searchDisplayController;//搜索VC
/**导航栏右侧按钮*/
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,assign)NSInteger count;

/**存放选中的数据数组*/
@property(nonatomic,strong)NSMutableArray*selectArr;
@end

@implementation HFFriendViewController
{
    NSMutableArray *_searchResultArr;//搜索结果Arr
    
}
#pragma mark - dataArr(模拟从服务器获取到的数据)
//- (NSArray *)serverDataArr{
//    if (!_serverDataArr) {
//        _serverDataArr=@[@{@"portrait":@"1",@"name":@"1",@"isSelect":@(NO)},@{@"portrait":@"2",@"name":@"花无缺",@"isSelect":@(NO)},@{@"portrait":@"3",@"name":@"东方不败",@"isSelect":@(NO)},@{@"portrait":@"4",@"name":@"任我行",@"isSelect":@(NO)},@{@"portrait":@"5",@"name":@"逍遥王",@"isSelect":@(NO)},@{@"portrait":@"6",@"name":@"阿离",@"isSelect":@(NO)},@{@"portrait":@"13",@"name":@"百草堂",@"isSelect":@(NO)},@{@"portrait":@"8",@"name":@"三味书屋",@"isSelect":@(NO)},@{@"portrait":@"9",@"name":@"彩彩",@"isSelect":@(NO)},@{@"portrait":@"10",@"name":@"陈晨",@"isSelect":@(NO)},@{@"portrait":@"11",@"name":@"多多",@"isSelect":@(NO)},@{@"portrait":@"12",@"name":@"峨嵋山",@"isSelect":@(NO)},@{@"portrait":@"7",@"name":@"哥哥",@"isSelect":@(NO)},@{@"portrait":@"14",@"name":@"林俊杰",@"isSelect":@(NO)},@{@"portrait":@"15",@"name":@"足球",@"isSelect":@(NO)},@{@"portrait":@"16",@"name":@"58赶集",@"isSelect":@(NO)},@{@"portrait":@"17",@"name":@"搜房网",@"isSelect":@(NO)},@{@"portrait":@"18",@"name":@"欧弟",@"isSelect":@(NO)}];
//    }
//    return _serverDataArr;
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"选择@好友";
    
    //下载好友列表
    NSDictionary *dic =@{@"uid":@(USER_MODEL.userId),@"relation":@(1),@"pageIndex":@(0),@"pageSize":@(20),@"all":@(1)};
    [self LOadMyFriendData:dic];
    
    //configNav
    [self configNav];
    //布局View
    //    [self setUpView];
    
    _searchDisplayController=[[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
    
    [_searchDisplayController setDelegate:self];
    [_searchDisplayController setSearchResultsDataSource:self];
    [_searchDisplayController setSearchResultsDelegate:self];
    
    [self.view addSubview:self.tableView];
    
    
    
}

-(void)LOadMyFriendData:(NSDictionary *)param
{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_FRIENDS_LIST];
    
    [LoadModel postRequestWithUrl:strUrl andParams:param andSucBlock:^(id responseObject) {
        
        ONOXMLDocument *obj = responseObject;
        ONOXMLElement *result = obj.rootElement;
        ONOXMLElement *objXML = [result firstChildWithTag:@"friends"];
        NSArray *arr = [objXML childrenWithTag:@"friend"];
        self.serverDataArr=[NSMutableArray array];
        for (ONOXMLElement * objectXML in arr)
        {
            FindXMLModel *obj = [[FindXMLModel alloc]initWithXML:objectXML andBool:NO];
            NSDictionary *dict = @{@"portrait":obj.portrait,@"name":obj.name,@"isSelect":@(obj.isSelect)};
            [self.serverDataArr addObject:dict];
            
        }
        
        self.dataArr=[NSMutableArray array];
        for (NSDictionary *subDic in self.serverDataArr) {
            //字典转模型
            ContactModel *model=[[ContactModel alloc]initWithDic:subDic];
            //添加数据
            [self.dataArr addObject:model];
        }
        //按字母排序后返回的数组，数组里放的是数组（里面放着相同字母的字典）
        _rowArr=[ContactDataHelper getFriendListDataBy:self.dataArr];
        
        //共有多少组
        _sectionArr=[ContactDataHelper getFriendListSectionBy:[_rowArr mutableCopy]];
        [self.tableView reloadData];
        
    } andFailBlock:^(NSError *error) {
        
    }];
    
    
}

//创建导航栏右侧按钮
- (void)configNav{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btn = btn;
    [btn setFrame:CGRectMake(0.0, 0.0, 60.0, 21.0)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor colorWithRed:0.263 green:0.442 blue:0.282 alpha:1.000];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    //    [btn setBackgroundImage:[UIImage imageNamed:@"contacts_add_friend"] forState:UIControlStateNormal];
    //设置颜色
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:btn]];
}
//右侧按钮点击事件
-(void)btnClick
{
    if ([self.btn.currentTitle isEqualToString:@"确定"]||[self.btn.currentTitle isEqualToString:@"0/10"]) {
        [SVProgressHUD showInfoWithStatus:@"还没选择好友"];
    }else
    {
    //获取选中的好友
    NSMutableArray *mArr = [NSMutableArray new];
    for (int i = 0; i<self.selectArr.count; i++)
    {
        ContactModel *model = self.selectArr[i];
        NSString *strname=[NSString stringWithFormat:@"%@",model.name];
        [mArr addObject:strname];
    }
    NSString *string = [mArr componentsJoinedByString:@"@"];
    NSString *str = @"@";
    NSString *str1 = [str stringByAppendingString:string];
    NSString *str2 = [str1 stringByAppendingString:@" "];
    self.friendBlock(str2);
    [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - setUpVie
//- (void)setUpView{
//    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0.0,kScreenHeight-49.0, kScreenWidth, 49.0)];
//    [imageView setImage:[UIImage imageNamed:@"footerImage"]];
//    [imageView setContentMode:UIViewContentModeScaleToFill];
//    [self.view addSubview:imageView];
//
//    [self.view insertSubview:self.tableView belowSubview:imageView];
//}
- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        [_searchBar setBackgroundImage:[UIImage imageNamed:@"ic_searchBar_bgImage"]];
        [_searchBar sizeToFit];
        [_searchBar setPlaceholder:@"搜索"];
        [_searchBar.layer setBorderWidth:0.5];
        [_searchBar.layer setBorderColor:[UIColor colorWithRed:229.0/255 green:229.0/255 blue:229.0/255 alpha:1].CGColor];
        [_searchBar setDelegate:self];
        [_searchBar setKeyboardType:UIKeyboardTypeDefault];
    }
    return _searchBar;
}
#pragma mark
#pragma mark 创建表格
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
        [_tableView setSectionIndexColor:[UIColor darkGrayColor]];
        [_tableView setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]];
        //设置表头
        _tableView.tableHeaderView=self.searchBar;
        //cell无数据时，不显示间隔线
        UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView setTableFooterView:v];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //section
    if (tableView==_searchDisplayController.searchResultsTableView) {
        return 1;
    }else{
        return _rowArr.count;
    }
}
//每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //row
    if (tableView==_searchDisplayController.searchResultsTableView) {
        return _searchResultArr.count;
    }else{
        return [_rowArr[section] count];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}
//组头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //viewforHeader
    id label = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (!label) {
        label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:14.5f]];
        [label setTextColor:[UIColor grayColor]];
        [label setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]];
    }
    //设置内容
    [label setText:[NSString stringWithFormat:@"  %@",_sectionArr[section+1]]];
    return label;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (tableView!=_searchDisplayController.searchResultsTableView) {
        return _sectionArr;
    }else{
        return nil;
    }
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index-1;
}
//组头的高度
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView==_searchDisplayController.searchResultsTableView) {
        return 0;
    }else{
        return 22.0;
    }
}

#pragma mark - UITableView dataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //static NSString *cellIde=@"cellIde";
    /**通过为每个cell指定不同的重用标识符(reuseIdentifier)来解决。
     重用机制是根据相同的标识符来重用cell的，标识符不同的cell不能彼此重用。于是我们将每个cell的标识符都设置为不同，就可以避免不同cell重用的问题了。
     */
    NSString *cellIde = [NSString stringWithFormat:@"Cell%ld%ld", indexPath.section, indexPath.row];
    
    ContactTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIde];
    if (cell==nil) {
        cell=[[ContactTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
        cell.cellBlock = ^(ContactModel *model)
        {
            self.selectArr = [NSMutableArray new];
            [self.selectArr removeAllObjects];
            //替换掉对应的字典
            [_rowArr[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:model];
            //遍历所有的数据
            for (NSArray *arr in _rowArr)
            {
                for (ContactModel *model1 in arr) {
                    
                    if (model1.isSelect)
                    {
                        self.count++;
                        
                        [self.selectArr addObject:model1];
                        
                    }
                }
            }
                [self.btn setTitle:[NSString stringWithFormat:@"%ld/10",self.count ] forState:UIControlStateNormal];
                //初始化数据
                self.count =0;
                
        
            
        };
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (tableView==_searchDisplayController.searchResultsTableView){
        ContactModel *conmodel = _searchResultArr[indexPath.row];
        
        [cell setCell:conmodel];
        //        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[_searchResultArr[indexPath.row] valueForKey:@"portrait"]] placeholderImage:[UIImage imageNamed:@"comment_profile_default@2x"]];
        //        [cell.nameLabel setText:[_searchResultArr[indexPath.row] valueForKey:@"name"]];
    }else{
        ContactModel *model=_rowArr[indexPath.section][indexPath.row];
        
        [cell setCell:model];
        
    }
    
    return cell;
}

#pragma mark searchBar delegate
//searchBar开始编辑时改变取消按钮的文字
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSArray *subViews;
    subViews = [(searchBar.subviews[0]) subviews];
    for (id view in subViews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* cancelbutton = (UIButton* )view;
            [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
            break;
        }
    }
    searchBar.showsCancelButton = YES;
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //取消
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = NO;
}

#pragma mark searchDisplayController delegate
- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView{
    //cell无数据时，不显示间隔线
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [tableView setTableFooterView:v];
    
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString
                               scope:[self.searchBar scopeButtonTitles][self.searchBar.selectedScopeButtonIndex]];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    [self filterContentForSearchText:self.searchBar.text
                               scope:self.searchBar.scopeButtonTitles[searchOption]];
    return YES;
}

#pragma mark - 源字符串内容是否包含或等于要搜索的字符串内容
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    NSMutableArray *tempResults = [NSMutableArray array];
    NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    
    for (int i = 0; i < self.dataArr.count; i++) {
        NSString *storeString = [(ContactModel *)self.dataArr[i] name];
        NSString *storeImageString=[(ContactModel *)self.dataArr[i] portrait]?[(ContactModel *)self.dataArr[i] portrait]:@"";
        
        NSRange storeRange = NSMakeRange(0, storeString.length);
        
        NSRange foundRange = [storeString rangeOfString:searchText options:searchOptions range:storeRange];
        if (foundRange.length) {
            NSDictionary *dic=@{@"name":storeString,@"portrait":storeImageString,@"isSelect":@(NO)};
            
            //字典转模型
            ContactModel *model1=[[ContactModel alloc]initWithDic:dic];
            [tempResults addObject:model1];
        }
        
    }
    
    //    [_searchResultArr removeAllObjects];
    _searchResultArr = [NSMutableArray new];
    [_searchResultArr addObjectsFromArray:tempResults];
    
}




@end
