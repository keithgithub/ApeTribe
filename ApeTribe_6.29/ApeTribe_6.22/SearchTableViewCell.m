//
//  SearchTableViewCell.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/5.
//  Copyright © 2016年 One. All rights reserved.
//

#import "SearchTableViewCell.h"
#import "HelpClass.h"
@implementation SearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCell:(SearchXMLModel *)model
{
//    if ([model.type isEqualToString:@"project"])
//    {
//         self.author.text = @"匿名";
//    }else
//    {
//        self.author.text = model.author;
//      
//    }
      self.title.text = model.title;
    
//    self.time.text = str;
//    
//    
   
    
    //  使用富文本
    NSMutableAttributedString *str1;
    if ([model.type isEqualToString:@"project"])
    {
        str1 = [[NSMutableAttributedString alloc]initWithString:@"匿名   "];
    }else
    {
        NSString *string = [model.author stringByAppendingString:@"   "];
       str1 = [[NSMutableAttributedString alloc]initWithString:string];
        
    }

    //创建文本附件包含图片
    NSTextAttachment *attachMent = [[NSTextAttachment alloc]init];
    CGFloat height =self.detail.font.lineHeight-4;
    attachMent.image =[UIImage imageNamed:@"time"];
    attachMent.bounds = CGRectMake(0, -2, height, height);
    NSAttributedString *attrString = [NSAttributedString attributedStringWithAttachment:attachMent];
    [str1 appendAttributedString:attrString];
    NSString *str = [HelpClass compareCurrentTime:model.pubDate];
    NSMutableAttributedString *strtime = [[NSMutableAttributedString alloc]initWithString:str];
    [str1 appendAttributedString:strtime];
  
    //创建文本附件包含图片
    NSTextAttachment *attachMent1 = [[NSTextAttachment alloc]init];
    CGFloat height1 =self.detail.font.lineHeight-2;
    attachMent1.image =[UIImage imageNamed:@"fankui"];
    attachMent1.bounds = CGRectMake(0, -2, height1, height1);
    NSAttributedString *attrString1 = [NSAttributedString attributedStringWithAttachment:attachMent1];
    [str1 appendAttributedString:attrString1];
    
    self.detail.attributedText = str1;




    
    
    
}
@end
