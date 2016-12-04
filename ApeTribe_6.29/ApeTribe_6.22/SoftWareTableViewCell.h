//
//  SoftWareTableViewCell.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/2.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoftWareXMLModel.h"
@interface SoftWareTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UIButton *time;
@property (weak, nonatomic) IBOutlet UIButton *type;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property(nonatomic,strong)SoftWareXMLModel *model;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHigh;

-(void)setCellModel:(SoftWareXMLModel *)softModel;
//获取内容文本高度
-(CGFloat)getContentH;

@end
