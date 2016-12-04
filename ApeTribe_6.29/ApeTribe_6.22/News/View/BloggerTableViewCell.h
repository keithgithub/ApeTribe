//
//  BloggerTableViewCell.h
//  OpenSourceChina
//
//  Created by bokan on 16/6/24.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BloggerXmlModel;
@interface BloggerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *body;
@property (weak, nonatomic) IBOutlet UILabel *authorname;
@property (weak, nonatomic) IBOutlet UILabel *pubDate;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;

//设置单元格内容
-(void)setContentCell:(BloggerXmlModel*)blogger andStyle:(int)style;

@end
