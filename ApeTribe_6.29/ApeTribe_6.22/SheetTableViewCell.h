//
//  SheetTableViewCell.h
//  QueenComing_5.19
//
//  Created by ibokan on 16/5/31.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SheetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;// 图片
@property (weak, nonatomic) IBOutlet UILabel *title;// 标题
// 设置cell
- (void) setCell:(NSDictionary *)dic;
@end
