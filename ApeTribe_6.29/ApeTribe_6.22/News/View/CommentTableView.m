//
//  CommentTableView.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/1.
//  Copyright © 2016年 One. All rights reserved.
//

#import "CommentTableView.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "CommentTableViewCell.h"
#import "CommentXmlModel.h"

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@implementation CommentTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        //初始化数组
        self.arrCommentDatas = [NSMutableArray new];
        //设置代理
        self.dataSource = self;
        self.delegate = self;
        
        //注册xib
        UINib *nib = [UINib nibWithNibName:@"CommentTableViewCell" bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:@"CommentCell"];
        
        
        //添加下拉刷新
        __block CommentTableView *gTableView  = self;
        [self addLegendHeaderWithRefreshingBlock:^{
            [gTableView.gDelegate loadCommentDataWithCurrentPage:0];
        }];
        
        [self addLegendFooterWithRefreshingBlock:^{
            //上提时候要执行的代码
            //判断是否有下一页
            if (gTableView.arrCommentDatas.count>=20)
            {
                gTableView.currentPage++;
                //有下一页
                [gTableView.gDelegate loadCommentDataWithCurrentPage:gTableView.currentPage];
            }
            else
            {
                [gTableView.footer setState:MJRefreshFooterStateNoMoreData];

                
            }
        }];
        
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrCommentDatas.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    [cell setCell:self.arrCommentDatas[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentXmlModel *model = self.arrCommentDatas[indexPath.row];
    
    CGFloat sizeReferHeight;
    CGFloat sizeReplyHeight;
    CGFloat sizeContentHeight;
//    if (model.refers.count <=0)
//    {
//        sizeReferHeight = 0;
//    }
//    else
//    {
//        sizeRefer = [model.refers boundingRectWithSize:CGSizeMake(SCREEN_SIZE.width-64, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
//    }
//    
    
    if (model.replies.count <= 0)
    {
        sizeReplyHeight = 0;
    }
    else
    {
        NSMutableString *string = [NSMutableString stringWithFormat:@"--共有%ld条评论--\n",model.replies.count];
        for (int i= 0; i<model.replies.count; i++)
        {
            NSDictionary *dict = model.replies[i];
            [string appendString:[NSString stringWithFormat:@"%@:%@",dict[@"rauthor"],dict[@"rcontent"]]];
        }

        NSString *reply = [string substringToIndex:string.length-2];
        sizeReplyHeight = [reply boundingRectWithSize:CGSizeMake(SCREEN_SIZE.width-64, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    }
    
    sizeContentHeight = [model.content boundingRectWithSize:CGSizeMake(SCREEN_SIZE.width-64, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    
    
    CGFloat height = 75+sizeReplyHeight+sizeContentHeight;
    
    return height;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CommentXmlModel *model = self.arrCommentDatas[indexPath.row];
    [self.gDelegate comeBackWithString:model.author];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */



@end
