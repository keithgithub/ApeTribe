//
//  AtMeTableViewCell.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/1.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "ActiveXMLModel.h"
#import "YYText.h"

@interface AtMeTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *portraitButton;

@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *replyLb;// 动态的内容
@property (weak, nonatomic) IBOutlet UILabel *activeCatagLb;// 动态类型

@property (weak, nonatomic) IBOutlet UIImageView *deviceImgV;
@property (weak, nonatomic) IBOutlet UILabel *deviceLb;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (nonatomic, strong) ActiveXMLModel *model;

- (IBAction)btnAction:(UIButton *)sender;


@end
