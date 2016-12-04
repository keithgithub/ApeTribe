//
//  DetailViewController.h
//  6.23.OSChina
//
//  Created by ibokan on 16/6/26.
//  Copyright © 2016年 Ldm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailTableViewCell.h"
#import "TweetListXmlModel.h"
#import "TweetCommentXmlModel.h"
#import "TweetDetailXmlModel.h"
#import "YDViewController.h"

@interface DetailViewController : YDViewController

//表情符号
@property(nonatomic,strong)UIButton * btnEmoji;
//底部视图
@property(nonatomic,strong)UIView * bgV;
//文本框
@property(nonatomic,strong)UITextField * txtField;

//评论单元格数据
@property(nonatomic,strong)NSMutableArray * arrCommentData;

//表格
@property(nonatomic,strong)UITableView * tableView;

//评论单元格
@property(nonatomic,strong)DetailTableViewCell * cell;




//重写方法
-(instancetype)initWithListID:(long)ID;


///**
// *  个人主页视图控制器初始化方法
// *
// *  @param isMe   是否是登录用户本人，YES：是 NO：不是
// *  @param userId 显示主页的用户id
// *
// *  @return 返回视图对象
// */
//- (instancetype) initWithState:(BOOL)isMe andUserId:(long)userId andOperationType:(NavigationControllerOperationType)type;



@end
