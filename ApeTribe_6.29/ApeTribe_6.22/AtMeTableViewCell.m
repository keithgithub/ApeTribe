//
//  AtMeTableViewCell.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/1.
//  Copyright © 2016年 One. All rights reserved.
//

#import "AtMeTableViewCell.h"
#import "HelpClass.h"


#define COLOR_LB_BG [UIColor colorWithWhite:0.902 alpha:0.500]
@implementation AtMeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.portraitButton.layer.masksToBounds = YES;
    self.portraitButton.layer.cornerRadius = self.portraitButton.frame.size.height / 2.0;
    
    
    
}

- (void) setCell:(id)obj
{
    ActiveXMLModel *model = obj;
    self.model = model;
    self.nameLb.text = model.author;
    self.nameLb.font = [UIFont systemFontOfSize:13 weight:1];
    [self.portraitButton sd_setBackgroundImageWithURL:URL(model.portrait) forState:UIControlStateNormal placeholderImage:Image(@"headIcon_placeholder")];
    
    // 判断动态的类型，设置动态的状态
    switch (model.objecttype)
    {
        case 100:// 发动态
            self.replyLb.text = model.message;
            self.replyLb.backgroundColor = [UIColor whiteColor];
            self.activeCatagLb.text = @"更新了动态";
            self.time.text = [HelpClass compareCurrentTime:model.pubDate];
            break;
        case 101:// 回复动态
        {
            self.replyLb.text = model.message;
            self.time.text = [HelpClass compareCurrentTime:model.pubDate];
            
            // 创建主富文本对象
            NSMutableAttributedString *text = [NSMutableAttributedString new];
            
            {
                
                // 创建富文本对象
                NSMutableAttributedString *state = [[NSMutableAttributedString new]initWithString:@"回复了动态："];
                // 使用YYText设置字体属性
                state.yy_color = COLOR_FONT_L_GRAY;
                state.yy_font = FONT(12.5);
                [text appendAttributedString:state];
                
                
                if (model.message != nil)
                {
                    
                    NSMutableAttributedString *message = [self setColorWithString:model.message andTargetString:USER_MODEL.name];
//                    message.yy_font = [UIFont systemFontOfSize:12.5 weight:2];
//                    message.yy_color = [UIColor colorWithWhite:0.098 alpha:1.000];
                    // 拼接富文本
                    [text appendAttributedString:message];
                }
                
                
            }
            
            // 设置label的文本
            self.activeCatagLb.attributedText = text;
            
            self.replyLb.text = [NSString stringWithFormat:@"%@：%@",model.objectname,model.objectbody];
            self.replyLb.backgroundColor = COLOR_LB_BG;
        }
            break;
        default:
            
            break;
    }
    
    UILabel *lineLb = [[UILabel alloc]initWithFrame:CGRectMake(56, self.frame.size.height - 0.5, IPHONE_W - 56, 0.5)];
    lineLb.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    [self.contentView addSubview:lineLb];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSMutableAttributedString *) setColorWithString:(NSString *)mainStrng andTargetString:(NSString *) targetString
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:mainStrng];
    text.yy_font = [UIFont systemFontOfSize:12.5 weight:2];
    text.yy_color = [UIColor colorWithWhite:0.098 alpha:1.000];
    // 判断是否存在@我
    if ([mainStrng containsString:[NSString stringWithFormat:@"@%@",targetString]])
    {
        NSRange range = [mainStrng rangeOfString:[NSString stringWithFormat:@"@%@",targetString]];
        NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:12.5 weight:1.5],NSForegroundColorAttributeName:self.nameLb.textColor};
        [text addAttributes:attribute range:range];
    }
    
    
    return text;
}

- (IBAction)btnAction:(UIButton *)sender {
    
    [self.delegate clickButtonAction:self.model.authorid];
}
@end
