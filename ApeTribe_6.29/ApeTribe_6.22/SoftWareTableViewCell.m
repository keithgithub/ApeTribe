//
//  SoftWareTableViewCell.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/2.
//  Copyright © 2016年 One. All rights reserved.
//

#import "SoftWareTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+LabelHight.h"
#import "HelpClass.h"
#import "text.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
@implementation SoftWareTableViewCell

- (void)awakeFromNib {
    self.imgV.layer.cornerRadius = 25;
    self.imgV.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

-(void)setCellModel:(SoftWareXMLModel *)softModel
{
    self.model = softModel;
//     NSLog(@"========%@",softModel);
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:softModel.portrait] placeholderImage:[UIImage imageNamed:@"comment_profile_default"]];
    
    self.name.text = softModel.author;
//    self.detail.text = softModel.body;
    self.detail.attributedText = [text test:softModel.body];
    NSString *strTime=[HelpClass compareCurrentTime:softModel.pubDate];
    [self.time setTitle:strTime forState:UIControlStateNormal];
    if (softModel.appclient !=1)
    {
        self.type.hidden = YES;
    }
    self.count.text = [NSString stringWithFormat:@"%ld",softModel.commentCount];
   
    CGFloat contentHeigh = [self getContentH];
    
    self.contentHigh.constant = contentHeigh+10;
}

-(CGFloat)getContentH
{
    
    return [NSString calStrSize:self.model.body andWidth:SCREEN_SIZE.width-96 andFontSize:14].height;
}




@end
