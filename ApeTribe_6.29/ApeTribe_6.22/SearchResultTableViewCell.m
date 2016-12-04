//
//  SearchResultTableViewCell.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import "SearchResultTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation SearchResultTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void)setCell:(FindXMLModel *)model
{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@"comment_profile_default@2x"]];
    //  使用富文本
    //创建文本附件包含图片
    NSTextAttachment *attachMent = [[NSTextAttachment alloc]init];
    CGFloat height =self.name.font.lineHeight;
    if ([model.gender isEqualToString:@"男"]) {
        attachMent.image =[UIImage imageNamed:@"userinfo_icon_male"];
    }else
    {
        attachMent.image = [UIImage imageNamed:@"userinfo_icon_female"];
    }
    attachMent.bounds = CGRectMake(0, -5, height, height);
    NSAttributedString *attrString = [NSAttributedString attributedStringWithAttachment:attachMent];
    NSMutableAttributedString *strM =[[NSMutableAttributedString alloc]initWithString:model.name];
    [strM appendAttributedString:attrString];
    self.name.attributedText = strM;
    self.area.text = model.from;
    
    
    
}
@end
