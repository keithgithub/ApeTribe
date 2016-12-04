//
//  SearchResultTableView.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import "SearchResultTableView.h"
#import "SearchResultTableViewCell.h"

@implementation SearchResultTableView
/**
 *  表格初始化
 *
 *  @param frame     大小
 *  @param style     风格
 *  @param selHandel 选中单元格回调
 *
 *  @return 表格对象
 */
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style andSelectBlock:(SelectBlock)selHandel
{
    
    if (self = [super initWithFrame:frame style:style])
    {
        //初始化
        self.arrData = [NSMutableArray new];
        self.dataSource = self;
        self.delegate = self;
        //给代码块 赋值
        self.selectHandel = selHandel;
        
        UINib *nib = [UINib nibWithNibName:@"SearchResultTableViewCell" bundle:[NSBundle mainBundle]];
        //注册xib
        [self registerNib:nib forCellReuseIdentifier:@"cell"];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
    }
    
    return self;
}
//返回搜索到的个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建获取单元格
    SearchResultTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell setCell:self.arrData[indexPath.row]];
    return cell;
}

//选择，当选中搜索框的表格的时候
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //回调发送用户信息
    self.selectHandel(self.arrData[indexPath.row]);
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 69;
}

@end
