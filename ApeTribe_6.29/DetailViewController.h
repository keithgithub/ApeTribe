//
//  DetailViewController.h
//  6.23.OSChina
//
//  Created by ibokan on 16/6/26.
//  Copyright © 2016年 Ldm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController


//头像
@property(nonatomic,strong)UIImageView * imgVHead;
//昵称、内容、赞
@property(nonatomic,strong)UILabel * lblName,* lblContent,* lblZan;
//发布时间、设备、点赞按钮、表情符号
@property(nonatomic,strong)UIButton * btnPushTime,* btnDevices,* btnZan,* btnEmoji;
//底部视图
@property(nonatomic,strong)UIView * bgV;
//文本框
@property(nonatomic,strong)UITextField * txtField;


@end
