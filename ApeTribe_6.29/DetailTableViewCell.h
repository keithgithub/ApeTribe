//
//  DetailTableViewCell.h
//  6.23.OSChina
//
//  Created by ibokan on 16/6/26.
//  Copyright © 2016年 Ldm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewCell : UITableViewCell

//头像
@property(nonatomic,strong)UIImageView * imgVHead;
//昵称、内容、分割线
@property(nonatomic,strong)UILabel * lblName,* lblComment,* lblCutLines;
//发布时间、设备
@property(nonatomic,strong)UIButton * btnPushTime, *btnDevices;

//设置内容
-(void)setCell:(NSDictionary *)dic;

@end
