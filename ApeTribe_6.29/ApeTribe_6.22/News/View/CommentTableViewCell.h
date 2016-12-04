//
//  CommentTableViewCell.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/1.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>



@class CommentXmlModel;
@interface CommentTableViewCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *referHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *replies;
@property (weak, nonatomic) IBOutlet UILabel *pubDate;

@property (weak, nonatomic) IBOutlet UIView *referView;

-(void)setCell:(CommentXmlModel*)commentModel;

@end
