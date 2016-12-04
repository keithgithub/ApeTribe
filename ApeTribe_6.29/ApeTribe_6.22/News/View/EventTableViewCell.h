//
//  EventTableViewCell.h
//  OpenSourceChina
//
//  Created by bokan on 16/6/25.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EventXmlModel;
@interface EventTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UILabel *startTime;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *actor_count;


//设置单元格内容
-(void)setContentCell:(EventXmlModel*)event;
@end
