//
//  FansTableViewCell.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/2.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"


@interface FansTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *portraitButton;

@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *detailLb;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayoutConstraint;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *msgCount;
@property (nonatomic, assign) id obj;
- (IBAction)btnAction:(UIButton *)sender;
@end
