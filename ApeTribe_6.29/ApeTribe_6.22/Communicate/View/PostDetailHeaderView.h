//
//  PostDetailHeaderView.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/28.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PostDetailXmlModel;
@class MessageDetailModel;
@interface PostDetailHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *pubDate;
@property (weak, nonatomic) IBOutlet UILabel *lbl;
@property (weak, nonatomic) IBOutlet UILabel *tagPost;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;



-(void)setPostDetailContentView:(PostDetailXmlModel*)postDetail;
-(void)setMessageDetailContentView:(MessageDetailModel*)messageDetail;

@end
