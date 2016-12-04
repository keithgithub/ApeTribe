//
//  DetailViewController.m
//  6.23.OSChina
//
//  Created by ibokan on 16/6/26.
//  Copyright © 2016年 Ldm. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailTableViewCell.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@interface DetailViewController ()

//协议
<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

//数据
@property(nonatomic,strong)NSMutableArray * arrData;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //表格
    [self createTableView];
    //文本框及表情符号按钮
    [self createTxtFieldAndEmojiBtn];
}


//创建表格
-(void)createTableView
{
    //获取列表
    NSString * path = [[NSBundle mainBundle]pathForResource:@"DetailTableViewCell" ofType:@"plist"];
    self.arrData = [[NSMutableArray alloc]initWithContentsOfFile:path];
    //创建表格
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-40) style:UITableViewStylePlain];
    //代理
    tableView.dataSource = self;
    tableView.delegate = self;
    //取消表格的线
    tableView.separatorStyle = NO;
    //背景颜色
    tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //隐藏滚动条
    tableView.showsVerticalScrollIndicator = NO;
    //显示
    [self.view addSubview:tableView];
    
    //创建表格头视图
    UIView * tableViewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 120)];
    //显示
    tableView.tableHeaderView = tableViewHeader;
    tableViewHeader.backgroundColor = [UIColor whiteColor];
    
    //头像
    self.imgVHead = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 35, 35)];
    
    
    //昵称
    self.lblName = [[UILabel alloc]initWithFrame:CGRectMake(10+10+self.imgVHead.frame.size.width, self.imgVHead.frame.origin.y, SCREEN_SIZE.width-30-self.imgVHead.frame.size.width, 15)];
    //字体
    self.lblName.font = [UIFont systemFontOfSize:14];
    
    
    //发布时间
    self.btnPushTime = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnPushTime.frame = CGRectMake(self.lblName.frame.origin.x, 10+5+self.lblName.frame.size.height, 75, 15);
    //字体大小
    self.btnPushTime.titleLabel.font = [UIFont systemFontOfSize:12];
    //字体颜色
    [self.btnPushTime setTintColor:[UIColor grayColor]];
    //图片边距
    [self.btnPushTime setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    //标题边距
    [self.btnPushTime setTitleEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
    
    
    //设备
    self.btnDevices = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnDevices.frame = CGRectMake(self.btnPushTime.frame.origin.x+self.btnPushTime.frame.size.width, self.btnPushTime.frame.origin.y, 75, 15);
    //字体大小
    self.btnDevices.titleLabel.font = [UIFont systemFontOfSize:12];
    //字体颜色
    [self.btnDevices setTintColor:[UIColor grayColor]];
    //图片边距
    [self.btnDevices setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    //标题边距
    [self.btnDevices setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    
    
    //内容
    self.lblContent = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+10+self.imgVHead.frame.size.height, SCREEN_SIZE.width-20, 15)];
    self.lblContent.numberOfLines = 0;
    //字体
    self.lblContent.font = [UIFont systemFontOfSize:15];
    
    
    //赞
    self.lblZan = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+self.lblContent.frame.origin.y+self.lblContent.frame.size.height, SCREEN_SIZE.width-20, 15)];
    //字体大小
    self.lblZan.font = [UIFont systemFontOfSize:12];
    //颜色
    self.lblZan.textColor = [UIColor grayColor];
    
    
    
    //点赞按钮
    self.btnZan = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnZan.frame = CGRectMake(SCREEN_SIZE.width-30, self.btnPushTime.frame.origin.y, 15, 15);
    [self.btnZan setTintColor:COLOR_FONT_L_GRAY];
    
    //点击响应
    [self.btnZan addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //显示
    [tableViewHeader addSubview:self.imgVHead];
    [tableViewHeader addSubview:self.lblName];
    [tableViewHeader addSubview:self.lblContent];
    [tableViewHeader addSubview:self.btnDevices];
    [tableViewHeader addSubview:self.btnPushTime];
    [tableViewHeader addSubview:self.lblZan];
    [tableViewHeader addSubview:self.btnZan];
    
    
    [self setData:self.arrData];
}

//按钮响应
-(void)tapAction:(UIButton *)sender
{
    
}

#pragma mark 表格代理


//单元格数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrData.count;
}


//单元格样式
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[DetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //设置内容
    [cell setCell:self.arrData[indexPath.row]];
    
    return cell;
}


//单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}


//组头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * v = [[UIView alloc]initWithFrame:self.view.bounds];
    if (section == 0)
    {
        UILabel * lblText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 30)];
        lblText.text = @"4条评论";
        lblText.textAlignment = NSTextAlignmentCenter;
        lblText.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [v addSubview:lblText];
    }
    return v;
}

#pragma end mark


//数据接口
-(void)setData:(NSMutableArray *)arr
{
    //头像
    self.imgVHead.image = [UIImage imageNamed:@"1.jpg"];
    //昵称
    self.lblName.text = @"地瓜";
    
    //发布时间
    [self.btnPushTime setTitle:@"40分钟前" forState:UIControlStateNormal];
    [self.btnPushTime setImage:[UIImage imageNamed:@"time.png"] forState:UIControlStateNormal];
    
    //设备
    [self.btnDevices setTitle:@"iPhone 5" forState:UIControlStateNormal];
    [self.btnDevices setImage:[UIImage imageNamed:@"iphone"] forState:UIControlStateNormal];
    
    //点赞按钮
    [self.btnZan setImage:[UIImage imageNamed:@"ic_thumbup_normal"] forState:UIControlStateNormal];
    
    //内容
    self.lblContent.text = @"地瓜地瓜地瓜地瓜地瓜地瓜番薯番薯番薯番薯番薯！";
    //赞
    self.lblZan.text = @"某某某觉得很赞！";
}


//创建底部文本框及表情符号按钮
-(void)createTxtFieldAndEmojiBtn
{
    //创建底部视图
    self.bgV = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H-40, SCREEN_W, 40)];
    //背景颜色
    self.bgV.backgroundColor = [UIColor colorWithWhite:0.869 alpha:1.000];
    
    //创建文本框
    self.txtField = [[UITextField alloc]initWithFrame:CGRectMake(5, 5, SCREEN_W-45, 30)];
    self.txtField.borderStyle = UITextBorderStyleRoundedRect;
    //提示
    self.txtField.placeholder = @"说点啥吧";
    //字体大小
    self.txtField.font = [UIFont systemFontOfSize:16];
    //代理
    self.txtField.delegate = self;
    self.txtField.userInteractionEnabled = YES;
    
    //创建表情符号按钮
    self.btnEmoji = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnEmoji.frame = CGRectMake(10+self.txtField.frame.size.width, self.txtField.frame.origin.y, 30, 30);
    //设置图片
    [self.btnEmoji setImage:[UIImage imageNamed:@"chat_bottom_smile_nor"] forState:UIControlStateNormal];
    //按钮响应
    [self.btnEmoji addTarget:self action:@selector(EmojiBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //显示
    [self.view addSubview:self.bgV];
    [self.bgV addSubview:self.txtField];
    [self.bgV addSubview:self.btnEmoji];

}

//按钮响应
-(void)EmojiBtnAction:(UIButton *)sender
{
    
}

//文本框开始编辑时
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //键盘默认高度216
    CGFloat offset = 0;
    if (textField == self.txtField)
    {
        //返回按钮设置为发送
        self.txtField.returnKeyType = UIReturnKeySend;
        offset = self.view.frame.size.height - (self.bgV.frame.origin.y+textField.frame.origin.y+textField.frame.size.height+216+47);
    }
    if (offset <= 0)
    {
        //改变视图位置
        [UIView animateWithDuration:0.47 animations:
         ^{
             //获取视图的frame
             CGRect vframe = self.view.frame;
             //改变视图的frame的y轴
             vframe.origin.y = offset;
             //重新设置视图的frame
             self.view.frame = vframe;
        }];
    }
    return YES;
}

//回收键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView animateWithDuration:0.2 animations:
     ^{
         CGRect vframe = self.view.frame;
         vframe.origin.y = 0.0;
         self.view.frame = vframe;
    }];
    //回收键盘
    [textField resignFirstResponder];
    return YES;
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
