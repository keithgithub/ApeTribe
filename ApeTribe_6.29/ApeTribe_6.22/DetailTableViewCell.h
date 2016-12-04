//
//  DetailTableViewCell.h
//  6.23.OSChina
//
//  Created by ibokan on 16/6/26.
//  Copyright © 2016年 Ldm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetCommentXmlModel.h"
#import "BaseTableViewCell.h"

@interface DetailTableViewCell : BaseTableViewCell

//头像
@property (weak, nonatomic) IBOutlet UIImageView *imgVHead;
//昵称
@property (weak, nonatomic) IBOutlet UILabel *lblName;
//发布时间图标
@property (weak, nonatomic) IBOutlet UIImageView *imgVPushTime;
//发布时间
@property (weak, nonatomic) IBOutlet UILabel *lblPushTime;
//设备图标
@property (weak, nonatomic) IBOutlet UIImageView *imgVDevice;
//设备
@property (weak, nonatomic) IBOutlet UILabel *lblDevice;
//评论
@property (weak, nonatomic) IBOutlet UILabel *lblComment;
//分割线
@property (weak, nonatomic) IBOutlet UILabel *lblCutLines;

@property (nonatomic,strong) TweetCommentXmlModel *model;
//评论区高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentHLayout;
//评论高度
@property(nonatomic,assign)CGFloat commentH;
//计算评论区高度
-(CGFloat)getCommentH;


//设置内容
-(void)setCell:(TweetCommentXmlModel *)tweetCommentModel;


@end
