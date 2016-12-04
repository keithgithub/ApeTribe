//
//  BlogMineTableViewCell.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/5.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "BlogXMLModelMine.h"
@interface BlogMineTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *typeImgV;// 博客类型
@property (weak, nonatomic) IBOutlet UILabel *titleLb;// 标题
@property (weak, nonatomic) IBOutlet UILabel *timeLb;// 发表时间
@property (weak, nonatomic) IBOutlet UILabel *commentCountLb;// 评论数


@end
