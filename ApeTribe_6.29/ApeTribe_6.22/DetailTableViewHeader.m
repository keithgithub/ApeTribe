//
//  DetailTableViewHeader.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import "DetailTableViewHeader.h"
#import "NSString+LabelHight.h"
#import "HelpClass.h"
#import "UUImageAvatarBrowser.h"
#import "ZanViewController.h"
#import "MBProgressHUD+NJ.h"
#import "text.h"

@implementation DetailTableViewHeader

-(void)setHeader:(TweetDetailXmlModel *)model
{
    self.detailModel = model;
    //头像
    [self.imgVHead sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@"headIcon_placeholder"]];
    self.imgVHead.layer.cornerRadius = 17.5;
    //昵称
    self.lblName.text = model.author;
    self.lblName.textColor = COLOR_BG_D_GREEN;
    //发布时间
    self.lblPushTime.text = [HelpClass compareCurrentTime:model.pubDate];
    //设备
    //显示图标
    self.imgVDevice.hidden = NO;
    //判断设备类型
    if (model.appclient == 3)
    {
        self.lblDevice.text = @"Android";
        self.imgVDevice.image = [UIImage imageNamed:@"iphone"];
    }
    else if(model.appclient == 4)
    {
        self.lblDevice.text = @"iPhone";
        self.imgVDevice.image = [UIImage imageNamed:@"iphone"];
    }
    else if(model.appclient == 2)
    {
        self.lblDevice.text = @"手机";
        self.imgVDevice.image = [UIImage imageNamed:@"iphone"];
    }
    else if(model.appclient == 5)
    {
        self.lblDevice.text = @"Window Phone";
        self.imgVDevice.image = [UIImage imageNamed:@"iphone"];
    }
    else
    {
        self.lblDevice.text = @"";
        self.imgVDevice.hidden = YES;//不是设备隐藏图标
    }
    
    
    //消除下载数据中的空格及换行
//    //选择要清除的类型  whitespaceAndNewlineCharacterSet：清除空格及换行
//    NSCharacterSet * whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    //或者自定义需要清除的符号
    NSCharacterSet * whiteSpace = [NSCharacterSet characterSetWithCharactersInString:@" \n\t"];
    //新建字符串存放下载的数据
    NSString * body = model.body;
    //清除不想要的空格或换行
    body = [body stringByTrimmingCharactersInSet:whiteSpace];
    //将清除后的数据添加显示
    //内容
//    self.lblContent.text = body;
    self.lblContent.attributedText = [text test:body];
    
    //点赞列表
    NSString * str = @"";
    NSMutableArray *mArr = model.likeList;
    for (int i=0; i<mArr.count; i++)
    {
        NSDictionary *dic = mArr[i];
        str = [NSString stringWithFormat:@"%@@%@、",str,dic[@"name"]];
    }
    if (mArr.count >= 10)
    {
        //设置内容
        self.lblLikeList.text = [NSString stringWithFormat:@"%@等觉得很赞",str];
    }
    else
    {
        //设置内容
        self.lblLikeList.text = [NSString stringWithFormat:@"%@觉得很赞",str];
    }
    
    
    
    //图片
    [self.imgVSmall sd_setImageWithURL:[NSURL URLWithString:model.imgSmall]];
    
    //定义calW与calH存放图片的宽高
    CGFloat calW = self.imgVSmall.image.size.width;
    CGFloat calH = self.imgVSmall.image.size.height;
    
    //计算文本高度与点赞列表高度
    CGFloat h1 = [self getContentH]+10;
    CGFloat h2 = [self getLikeListH]+20;
    
    //判断
    if([model.imgSmall isEqualToString:@""] && model.likeList.count <= 0)//无图无点赞列表
    {
        self.imageHLayout.constant = 0;//图片高
        self.imageWLayout.constant = 0;//图片宽
        self.likeListHLayout.constant = 0;//点赞列表高
        self.contentHLayout.constant = h1;//内容区高
        //无图、无点赞列表，只有内容区高度
        self.tempH = self.contentHLayout.constant;
    }
    else if([model.imgSmall isEqualToString:@""])//无图
    {
        self.imageHLayout.constant = 0;//图片高
        self.imageWLayout.constant = 0;//图片宽
        self.contentHLayout.constant = h1;//内容区高
        self.likeListHLayout.constant = h2;//点赞列表高
        //无图只有内容区与点赞列表高度
        self.tempH = self.contentHLayout.constant + self.likeListHLayout.constant;
    }
    else if(model.likeList.count <= 0)//无点赞列表
    {
        self.imageHLayout.constant = calH;//图片高
        self.imageWLayout.constant = calW;//图片宽
        self.contentHLayout.constant = h1;//内容区高
        self.likeListHLayout.constant = 0;//点赞列表高
        //图片与内容区高
        self.tempH = self.contentHLayout.constant + self.imageHLayout.constant;
    }
    else//全部都有
    {
        self.imageHLayout.constant = calH;//图片高
        self.imageWLayout.constant = calW;//图片宽
        self.contentHLayout.constant = h1;//内容区高
        self.likeListHLayout.constant = h2;//点赞列表高
        //图片与内容区高度及点赞列表高度
        self.tempH = self.contentHLayout.constant + self.likeListHLayout.constant + self.imageHLayout.constant;
    }
    
    //图片点击手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    //添加手势
    [self.imgVSmall addGestureRecognizer:tap];
    //原始图片
    self.imgVBig = [UIImageView new];
    [self.imgVBig sd_setImageWithURL:[NSURL URLWithString:model.imgBig]];
    
    
    //点赞列表手势
    UITapGestureRecognizer * tapLikeList = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLikeListAction:)];
    [self.lblLikeList addGestureRecognizer:tapLikeList];
    
    
    //头像单击手势
    UITapGestureRecognizer * tapPerson = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPersonAction:)];
    [self.imgVHead addGestureRecognizer:tapPerson];
    
    
}


//按钮响应
- (IBAction)btnLike:(id)sender
{
//    NSLog(@"赞赞赞");
    if (USER_MODEL.userId == 0)
    {
        [MBProgressHUD showError:@"请先登录！"];
    }
    else if (self.detailModel.isLike==0)
    {
        self.btnLike = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.btnLike setImage:[UIImage imageNamed:@"ic_thumbup_normal"] forState:UIControlStateNormal];
        self.btnZanHandle(0);
    }
    else if(self.detailModel.isLike ==1)
    {
        self.btnLike  = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.btnLike setImage:[UIImage imageNamed:@"ic_thumbup_actived"] forState:UIControlStateNormal];
        self.btnZanHandle(1);
    }
}

//获取内容区高度
-(CGFloat)getContentH
{
    return [NSString calStrSize:self.lblContent.text andWidth:self.lblContent.frame.size.width andFontSize:14].height;
}

//获取点赞列表高度
-(CGFloat)getLikeListH
{
    return [NSString calStrSize:self.lblLikeList.text andWidth:self.lblLikeList.frame.size.width andFontSize:11].height;
}

//点击响应
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    [UUImageAvatarBrowser showImage:self.imgVBig];
}


//点赞列表手势响应
-(void)tapLikeListAction:(UITapGestureRecognizer *)tapLikeList
{
    [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:@"ZanVC" object:nil]];

}


//头像单击响应
-(void)tapPersonAction:(UITapGestureRecognizer *)tapPerson
{
    if (self.portraitHandle)
    {
        self.portraitHandle(self.detailModel.authorID);
    }
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
