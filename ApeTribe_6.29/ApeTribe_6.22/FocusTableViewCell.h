//
//  FocusTableViewCell.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/2.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendXMLModel.h"
#import "BaseTableViewCell.h"
@interface FocusTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *portraitButton;

@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *detailLb;
@property (nonatomic, strong) FriendXMLModel *model;
- (IBAction)btnAction:(UIButton *)sender;
// 设置单元格的内容
- (void) setCell:(FriendXMLModel *)model;
@end
