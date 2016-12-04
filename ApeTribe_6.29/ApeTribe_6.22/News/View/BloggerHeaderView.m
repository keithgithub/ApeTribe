//
//  BloggerHeaderView.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/29.
//  Copyright © 2016年 One. All rights reserved.
//

#import "BloggerHeaderView.h"
#import "BloggerDetailXmlModel.h"
#import "UIImageView+WebCache.h"
@implementation BloggerHeaderView
- (IBAction)btnAction:(UIButton *)sender
{
    self.btnSelected = !self.btnSelected;
    if (self.btnSelected == YES)
    {
        [self.btnFavorite setTitle:@"已关注" forState:UIControlStateNormal];
    }
    else
    {
        [self.btnFavorite setTitle:@"未关注" forState:UIControlStateNormal];
    }
}

-(void)setBlogerDetailContentView:(BloggerDetailXmlModel*)bloggerDetail
{
    self.author.text = bloggerDetail.author;
    self.pubDate.text = [NSString stringWithFormat:@"%@",bloggerDetail.pubDate];
    if (bloggerDetail.favorite == 1)
    {
        [self.btnFavorite setTitle:@"已关注" forState:UIControlStateNormal];
    }
    else
    {
        [self.btnFavorite setTitle:@"未关注" forState:UIControlStateNormal];
    }
    
    switch (bloggerDetail.documentType)
    {
        case 1:
            
            break;
            
        default:
            break;
    }
    
    self.title.text = bloggerDetail.title;
    self.where.text = bloggerDetail.where;
    
    self.commentCount.text = [NSString stringWithFormat:@"%ld",bloggerDetail.commentCount];
    
    self.btnFavorite.layer.cornerRadius = 3;
    self.btnFavorite.layer.masksToBounds = YES;
}

@end
