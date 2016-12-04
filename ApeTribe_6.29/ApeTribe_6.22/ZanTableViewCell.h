//
//  ZanTableViewCell.h
//  6.23.OSChina
//
//  Created by ibokan on 16/6/27.
//  Copyright © 2016年 Ldm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetLikeListXmlModel.h"


@interface ZanTableViewCell : UITableViewCell

//头像
@property(nonatomic,strong)UIImageView * imgVHead;
//昵称
@property(nonatomic,strong)UILabel * lblName,* lblCutLines;


//设置内容
-(void)setCell:(TweetLikeListXmlModel *)tweetLikeList;


@end
