//
//  PostDetailViewController.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/28.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDViewController.h"
@interface PostDetailViewController : YDViewController
@property (nonatomic,assign) long Id;
@property (nonatomic,assign) long type;//0资讯，1问答
@property (nonatomic,assign) long favoriteType;//1 软件2 话题3 博客4 新闻5 代码
@property (nonatomic,assign) long catalog;
@end
