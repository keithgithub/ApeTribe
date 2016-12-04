//
//  ContactTableViewCell.m
//  WeChatContacts-demo
//
//  Created by shen_gh on 16/3/12.
//  Copyright © 2016年 com.joinup(Beijing). All rights reserved.
//

#import "ContactTableViewCell.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation ContactTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //布局View
        [self setUpView];
    }
    return self;
}

#pragma mark - setUpView
- (void)setUpView{
    //头像
    [self.contentView addSubview:self.headImageView];
    //姓名
    [self.contentView addSubview:self.nameLabel];
    //分割线
    [self.contentView addSubview:self.lineLabel];
    //选择按钮
    [self.contentView addSubview:self.selectBtn];
}
- (UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5.0, 5.0, 40.0, 40.0)];
        [_headImageView setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _headImageView;
}
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(50.0, 5.0, kScreenWidth-60.0, 40.0)];
        [_nameLabel setFont:[UIFont systemFontOfSize:16.0]];
    }
    return _nameLabel;
}
-(UIView *)lineLabel
{
    if (!_lineLabel)
    {
        _lineLabel = [[UIView alloc]initWithFrame:CGRectMake(0, 49, kScreenWidth, 1)];
        _lineLabel.backgroundColor = [UIColor colorWithWhite:0.918 alpha:1.000];
    }
    return _lineLabel;
}
-(UIButton *)selectBtn
{
    if (!_selectBtn)
    {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.frame = CGRectMake(kScreenWidth-40, 15, 20, 20);
        [_selectBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
    }
    return _selectBtn;
}
//点击按钮方法
-(void)btnClick
{
    _isSelect = !_isSelect;
    
    //判断是否打钩
    if (_isSelect)
    {
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"finishselect"] forState:UIControlStateNormal];
        [self.model setValue:@(YES) forKey:@"isSelect"];
        
        self.cellBlock(self.model);
        
    }else
    {
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
        [self.model setValue:@(NO) forKey:@"isSelect"];
        self.cellBlock(self.model);
    }
    
}

-(void)setCell:(ContactModel *)model
{
    self.model = model;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@"comment_profile_default@2x"]];
    [self.nameLabel setText:model.name];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
