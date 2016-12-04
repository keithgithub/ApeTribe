//
//  DiscoveryViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/22.
//  Copyright © 2016年 One. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "DiscoverScrollView.h"
#import "NSString+LabelHight.h"
#import "UILabel+Extension.h"
#import "LoadModel.h"
#import "MJRefresh.h"
#import "Ono.h"

#import "CatalogXMLMoel.h"
#import "SoftXMLModel.h"

#import "DetailDiscoverController.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
@interface DiscoveryViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UIView *titleView;
    // 创建滚动条
    UIImageView *indicateImgV;
}
/**滚动视图*/
@property(nonatomic,strong)DiscoverScrollView *scrollV;
/**菜单背景view*/
@property(nonatomic,strong)UIView *backV,*place;
@property(nonatomic,assign)BOOL isOpen;//判断是否展开
/**右边表格*/
@property(nonatomic,strong)UITableView*rightTableView;
/**左边表格*/
@property(nonatomic,strong)UITableView*leftTableView;
/**存放左边表格的数据*/
@property(nonatomic,strong)NSMutableArray*leftArr;
/**存放右边表格的数据*/
@property(nonatomic,strong)NSMutableArray*rightArr;
/**存放详细表格的数据*/
@property(nonatomic,strong)NSMutableArray*detailArr;

@property(nonatomic,assign)long currentPage;//当前页
//当前下载个数
@property (nonatomic,assign) long pagesize;


@end

@implementation DiscoveryViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发现";
    
    self.index = 0;
    // 创建按钮标题
    [self initTitleButtons];
    __block DiscoveryViewController *discoverVC = self;
    //创建滚动视图
    DiscoverScrollView *scrollV = [[DiscoverScrollView alloc]initWithFrame:CGRectMake(0, 64+35, SCREEN_SIZE.width, SCREEN_SIZE.height-99) andIndex:_index andTitleBlock:^(NSInteger index) {
        
        [discoverVC setBtnTitle:index];
        
    } andDisSelectTabCellBlock:^(SoftXMLModel *softXMLModel) {
        //选中单元格执行代码块
        DetailDiscoverController *detailVC = [[DetailDiscoverController alloc]init];
        detailVC.softXMLModel = softXMLModel;
        detailVC.customTransitionDelegate = [Tool getInteractivityTransitionDelegateWithType:InteractivityTransitionDelegateTypeNormal];
        [self presentViewController:[Tool getNavigationController:detailVC andtransitioningDelegate:detailVC.customTransitionDelegate andNavigationViewControllerType:NavigationControllerNormalType] animated:YES completion:nil];
        
    }];
    self.scrollV = scrollV;
    //添加视图
    [self.view addSubview:scrollV];
    //创建菜单视图
    self.backV = [[UIView alloc]initWithFrame:CGRectMake(0, 99, SCREEN_SIZE.width, self.scrollV.frame.size.height)];
    self.backV.backgroundColor = [UIColor colorWithWhite:0.500 alpha:0.622];
    self.backV.hidden = YES;
    self.isOpen =YES;
    //创建空白视图
    self.place = [[UIView alloc]initWithFrame:CGRectMake(0, 300, SCREEN_SIZE.width, self.backV.frame.size.height-300)];
    [self.backV addSubview:self.place];
    //给视图添加手势
    UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.place addGestureRecognizer:tapGes];
    
    //创建左边视图
    self.leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/2, 300)];
    //创建右边视图
    self.rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_W/2, 0, SCREEN_W/2, 300)];
    
    //添加下拉刷新
    __block UITableView *gRightView = self.rightTableView;
    __block UITableView *gTableView = self.scrollV.classifyTV;
    __block DiscoveryViewController *gTVC = self;
    [gTableView addLegendHeaderWithRefreshingBlock:^{
        
        if (self.showJava == 200)
        {
            //拼接参数
            NSDictionary *dic = @{@"searchTag":@(19),@"pageIndex":@(0),@"pageSize":@(20)};
            [self loadMyDataDict:dic andPage:0 andStyle:softwaredetail_listStyle];

        }else
        {
        
        //取出右边表格选中行
        NSInteger row = gRightView.indexPathForSelectedRow.row;
        CatalogXMLMoel *model = gTVC.rightArr[row];
        //下载数据
        NSDictionary *param = [gTVC rightTablePag:0 andLong:model.cTag];
        //下载第一页
        [gTVC loadMyDataDict:param andPage:0 andStyle:softwaredetail_listStyle];
        }
    }];
    //初始化第一页
    self.currentPage = 0;
    //添加上提刷新
    [self.scrollV.classifyTV addLegendFooterWithRefreshingBlock:^{
        
        //判断是否有下一页
        if ( self.pagesize<20)
        {
            //最后一页
            //弹框背景
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            //设置消失时间
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            //设置信息内容
            [SVProgressHUD showInfoWithStatus:@"已经是最后一页！"];
            //结束刷新
            [gTableView.footer endRefreshing];
            
        }else
        {
            
            gTVC.currentPage++;
            if (self.showJava == 200)
            {
                //拼接参数
                NSDictionary *dic = @{@"searchTag":@(19),@"pageIndex":@(gTVC.currentPage),@"pageSize":@(20)};
                [gTVC loadMyDataDict:dic andPage:gTVC.currentPage andStyle:softwaredetail_listStyle];
                
            }else
            {

            //取出右边表格选中行
            NSInteger row = gRightView.indexPathForSelectedRow.row;
            CatalogXMLMoel *model = gTVC.rightArr[row];
            //下载数据
            NSDictionary *param = [gTVC rightTablePag:gTVC.currentPage andLong:model.cTag];
            [gTVC loadMyDataDict:param andPage:gTVC.currentPage andStyle:softwaredetail_listStyle];
            }
            
        }
        
    }];
    

    //设置表格代理
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.delegate = self;
    
    [self.backV addSubview:self.leftTableView];
    [self.backV addSubview:self.rightTableView];
    [self.view addSubview:self.backV];
    
    //下载数据
    NSDictionary *dic = @{@"tag":@(0)};
    [self loadMyDataDict:dic andPage:0 andStyle:software_listStyle];
    
    self.leftArr = [NSMutableArray new];
    self.rightArr = [NSMutableArray new];
    
}
#pragma mark
#pragma mark 手势实现方法
-(void)tapAction:(UITapGestureRecognizer *)sender
{

    self.backV.hidden = YES;
    self.isOpen = !self.isOpen;
    
}


- (void) initTitleButtons
{
    titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 35)];
    titleView.backgroundColor = [UIColor whiteColor];
    CGFloat btnWidth = self.view.frame.size.width / 5.0f;
    NSArray *arrTitles = @[@"分类",@"推荐",@"最新",@"热门",@"国产"];
    UIButton *selectBtn = nil;
    // 创建按钮
    for (int i = 0; i < 5; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.tag = 300 + i;
        btn.frame = CGRectMake(i * btnWidth, 0, btnWidth, titleView.frame.size.height);
        [btn setTitle:arrTitles[i] forState:UIControlStateNormal];
        if (i == 0)
        {
            UIImageView *vv = [[UIImageView alloc]initWithFrame:CGRectMake(55, 17, 10, 10)];
            UIImage *img = [UIImage imageNamed:@"drom@3x"];
            vv.image = img;
            [btn addSubview:vv];
            
        }
        
        if (i == _index)
        {
            btn.tintColor = COLOR_FONT_D_GREEN;
            btn.titleLabel.font = [UIFont systemFontOfSize:15 weight:1];
            selectBtn = btn;
        }
        else
        {
            btn.tintColor = COLOR_FONT_L_GRAY;
            btn.titleLabel.font = [UIFont systemFontOfSize:14 weight:0.5];
        }
        [titleView addSubview:btn];
        [btn addTarget:self action:@selector(btnTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    // 创建分割线
    UILabel *lineLb = [[UILabel alloc]init];
    [lineLb lineWithColor:[UIColor colorWithWhite:0.930 alpha:1.000] andLength:SCREEN_W andOriginX:0 andOriginY:34 andStyle:UILabelhorizontalLineStyle];
    [titleView addSubview:lineLb];
    
    // 创建滚动条
    indicateImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, titleView.frame.size.height - 2, btnWidth, 2)];
    CGRect frame = indicateImgV.frame;
    frame.size.width = [selectBtn.titleLabel.text sizeWithFont:selectBtn.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    indicateImgV.frame = frame;
    indicateImgV.center = CGPointMake(selectBtn.center.x, indicateImgV.center.y);
    indicateImgV.backgroundColor = COLOR_FONT_D_GREEN;
    [titleView addSubview:indicateImgV];
    [self.view addSubview:titleView];
}
// 点击按钮响应的方法
- (void) btnTitleAction:(UIButton *)sender
{
    NSInteger index = sender.tag - 300;
    
    if (index == 0)
    {
        
        
        if (self.isOpen)
        {
            self.backV.hidden = NO;
            
        }else
        {
            self.backV.hidden = YES;
        }
        self.isOpen = !self.isOpen;
        
    }else
    {
        //选到其他按钮
        self.isOpen = NO;
        self.backV.hidden = YES;
        
    }
    
    [self.scrollV setScrollContentOffset:index];
    [self setBtnTitle:index];
}
// 设置标题
- (void) setBtnTitle:(NSInteger)index
{
    UIButton *selectedBtn;
    // 设置按钮字体颜色
    for (UIView *v in [titleView subviews])
    {
        if ([v isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)v;
            btn.tintColor = COLOR_FONT_L_GRAY;
            btn.titleLabel.font = [UIFont systemFontOfSize:14 weight:0.5];
            if (btn.tag == 300 + index)
            {
                selectedBtn = btn;
                btn.tintColor = COLOR_FONT_D_GREEN;
                btn.titleLabel.font = [UIFont systemFontOfSize:15 weight:1];
            }
        }
    }
    if (self.showtag == 100)
    {
        CGRect frame = indicateImgV.frame;
        frame.size.width = [selectedBtn.titleLabel.text sizeWithFont:selectedBtn.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
        indicateImgV.frame = frame;
        indicateImgV.center = CGPointMake(selectedBtn.center.x, indicateImgV.center.y);
        self.showtag = 101;//保证只执行一遍
    }else
    {
        //设置滚动条
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = indicateImgV.frame;
            frame.size.width = [selectedBtn.titleLabel.text sizeWithFont:selectedBtn.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
            indicateImgV.frame = frame;
            indicateImgV.center = CGPointMake(selectedBtn.center.x, indicateImgV.center.y);
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 左边表格
    if (tableView == self.leftTableView) return self.leftArr.count;
    // 右边表格
    return self.rightArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 左边表格
    if (tableView == self.leftTableView) {
        static NSString *ID = @"category";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        }
        //取出模型
        CatalogXMLMoel *camodel = self.leftArr[indexPath.row];
            cell.textLabel.text = camodel.name;
            // 设置label高亮时的文字颜色
        cell.textLabel.highlightedTextColor = COLOR_FONT_D_GREEN;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        
        return cell;
    } else {
        // 右边表格
        static NSString *ID = @"subcategory";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        }
        //取出模型
         CatalogXMLMoel *camodel = self.rightArr[indexPath.row];
         cell.textLabel.text = camodel.name;
            // 设置label高亮时的文字颜色
            cell.textLabel.highlightedTextColor = COLOR_FONT_D_GREEN;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>
//选中的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        //取出模型
        CatalogXMLMoel *camodel = self.leftArr[indexPath.row];
        long ctag = camodel.cTag;
        //下载数据
        NSDictionary *param = @{@"tag":@(ctag)};
        //下载数据
        [self loadMyDataDict:param andPage:0 andStyle:softwarecatalog_listStyle];
    }else
    {
        //获取参数字典
        //取出模型
        CatalogXMLMoel * xmlModel = self.rightArr[indexPath.row];
        long ctag1 = xmlModel.cTag;
        //拼接字典
        NSDictionary *param = [self rightTablePag:0 andLong:ctag1];
        //下载数据
        [self loadMyDataDict:param andPage:0 andStyle:softwaredetail_listStyle];
        //隐藏视图
        self.backV.hidden = YES;
        //改变showjava的值
        self.showJava = 201;
        self.isOpen  = !self.isOpen;
     
    }
}

//右边表格第二级下载参数page下载页数
-(NSDictionary *)rightTablePag:(long)page  andLong:(long)ctag
{
    //拼接参数
    NSDictionary *dic = @{@"searchTag":@(ctag),@"pageIndex":@(page),@"pageSize":@(20)};
 
    return dic;
}



#pragma mark
#pragma mark 下载数据 page下载页数

-(void)loadMyDataDict:(NSDictionary *)param andPage:(long)page andStyle:(softwareStyle)softwareStyle
{
    NSString *strUrl;
    if (softwareStyle == software_listStyle ||softwareStyle == softwarecatalog_listStyle) {
        //下载数据url
       strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_SOFTWARECATALOG_LIST];
    }else
    {
        //下载数据url
        strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_SOFTWARETAG_LIST];
    }
    
    [LoadModel postRequestWithUrl:strUrl andParams:param andSucBlock:^(id responseObject) {
        
        //类型转换
        ONOXMLDocument *obj = responseObject;
        ONOXMLElement *result = obj.rootElement;//根元素
        NSArray *arrData;
        NSMutableArray *newArr = [NSMutableArray new];
        
        if (softwareStyle == software_listStyle ||softwareStyle == softwarecatalog_listStyle)
        {
            ONOXMLElement *softwares = [result firstChildWithTag:@"softwareTypes"];
            arrData = [softwares childrenWithTag:@"softwareType"];
        }else
        {
            ONOXMLElement *softwares = [result firstChildWithTag:@"softwares"];
            arrData = [softwares childrenWithTag:@"software"];
            
        }
        
        if (softwareStyle == software_listStyle ||softwareStyle == softwarecatalog_listStyle)
        {
        
            for (ONOXMLElement *objXML in arrData)
            {
                CatalogXMLMoel *obj =[[CatalogXMLMoel alloc]initWithXML:objXML];
                [newArr addObject:obj];
                
            }
        }else
        {
            for (ONOXMLElement *objXML in arrData)
            {
                SoftXMLModel *obj =[[SoftXMLModel alloc]initWithXML:objXML];
                [newArr addObject:obj];
                
            }
 
        }
        
        if (softwareStyle == software_listStyle)//第一个
        {
             self.leftArr = newArr;
            //刷新表格
            [self.leftTableView reloadData];

        }else if(softwareStyle == softwarecatalog_listStyle)
        {
            self.rightArr = newArr;
            [self.rightTableView reloadData];
       
            
        }else
        {

            //下载的个数
            long pageSize = [[[result firstChildWithTag:@"pageSize"] numberValue]longValue];
            self.pagesize = pageSize;
            if (page>= 1)
            {
                //累加商品
                [self.detailArr addObjectsFromArray:newArr];
            }else
            {
                self.detailArr = newArr;
                
            }
            //赋值
            self.scrollV.classifyTV.arrData =self.detailArr;
            //结束下拉刷新
            [self.scrollV.classifyTV.header endRefreshing];
            //结束上提刷新
            [self.scrollV.classifyTV.footer endRefreshing];
            //刷新表格
            [self.scrollV.classifyTV reloadData];
            
        }
        
        
    } andFailBlock:^(NSError *error) {
         NSLog(@"err:%@",error);
    }];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.scrollV setScrollContentOffset:0];
    self.showtag = 100;
    self.showJava = 200;
    [self setBtnTitle:0];
    
    //加载java数据
    //拼接参数
    NSDictionary *dic = @{@"searchTag":@(19),@"pageIndex":@(0),@"pageSize":@(20)};
    [self loadMyDataDict:dic andPage:0 andStyle:softwaredetail_listStyle];
    
}





@end
