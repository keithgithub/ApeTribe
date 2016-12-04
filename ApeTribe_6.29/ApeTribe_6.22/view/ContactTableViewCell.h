//
//  ContactTableViewCell.h
//  WeChatContacts-demo
//
//  Created by shen_gh on 16/3/12.
//  Copyright © 2016年 com.joinup(Beijing). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactModel.h"
@class ContactModel;
typedef void (^cellBlock)(ContactModel *model);
@interface ContactTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *headImageView;//头像
@property (nonatomic,strong) UILabel *nameLabel;//姓名
@property (nonatomic,strong) UIView *lineLabel;//分割线
/**选择按钮*/
@property(nonatomic,strong)UIButton*selectBtn;
/**判断是否打钩属性*/
@property(nonatomic,assign)BOOL isSelect;
/**代码块属性*/
@property(nonatomic,strong)cellBlock cellBlock;
/**字典模型*/
@property(nonatomic,strong)ContactModel*model;
-(void)setCell:(ContactModel *)model;
@end
