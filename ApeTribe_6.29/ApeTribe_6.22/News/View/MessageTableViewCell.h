//
//  MessageTableViewCell.h
//  OpenSourceChina
//
//  Created by ibokan on 16/6/24.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageXmlModel;
@interface MessageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *body;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *pubDate;

//设置单元格内容
-(void)setContentCell:(MessageXmlModel*)message;
@end
