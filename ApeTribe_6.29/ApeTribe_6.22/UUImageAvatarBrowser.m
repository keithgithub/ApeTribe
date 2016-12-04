//
//  UUAVAudioPlayer.m
//  BloodSugarForDoc
//
//  Created by shake on 14-9-1.
//  Copyright (c) 2014年 shake. All rights reserved.
//

#import "UUImageAvatarBrowser.h"
//#import "BGAlertClass.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
static UIImageView *orginImageView;
@implementation UUImageAvatarBrowser

+(void)showImage:(UIImageView *)avatarImageView
{
    UIImage *image=avatarImageView.image;
    orginImageView = avatarImageView;
    orginImageView.alpha = 0;
    //创建窗口
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    //创建背景视图
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_SIZE.width , SCREEN_SIZE.height)];
    CGRect oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    //背景视图颜色
    backgroundView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:1.0];
    backgroundView.alpha=1;
    //图片视图
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    //设置图片
    imageView.image=image;
    //图片标记
    imageView.tag=1;
    //图片填充模式
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    //添加到背景视图显示
    [backgroundView addSubview:imageView];
    //添加到窗口显示
    [window addSubview:backgroundView];
    
    //单击手势
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    //添加到背景视图
    [backgroundView addGestureRecognizer: tap];
    
    //动画
    [UIView animateWithDuration:0.3 animations:^{
        //视图大小
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];

    
    
}

+(void)showAvatarImage:(UIImage *)avatarImage
{
    UIImage *image=avatarImage;
//    orginImageView = avatarImageView;
    orginImageView.alpha = 0;
    //创建窗口
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    //创建背景视图
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_SIZE.width , SCREEN_SIZE.height)];
//    CGRect oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    //背景视图颜色
    backgroundView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:1.0];
    backgroundView.alpha=0;
    //图片视图
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:window.bounds];
    //设置图片
    imageView.image=image;
    //图片标记
    imageView.tag=1;
    //图片填充模式
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    //添加到背景视图显示
    [backgroundView addSubview:imageView];
    //添加到窗口显示
    [window addSubview:backgroundView];
    
    //单击手势
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction)];
    [imageView addGestureRecognizer:longPress];
    //添加到背景视图
    [backgroundView addGestureRecognizer: tap];
    
    //动画
    [UIView animateWithDuration:0.3 animations:^{
        //视图大小
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];

}
+(void)showAndChangeImage:(UIImageView *)avatarImageView andClickHandle:(OnClickCallBack)clickHandle
{
    UIImage *image=avatarImageView.image;
    orginImageView = avatarImageView;
    orginImageView.alpha = 0;
    //创建窗口
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    //创建背景视图
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_SIZE.width , SCREEN_SIZE.height)];
    CGRect oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    //背景视图颜色
    backgroundView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:1.0];
    backgroundView.alpha=1;
    //图片视图
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    //设置图片
    imageView.image=image;
    //图片标记
    imageView.tag=1;
    //图片填充模式
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    //添加到背景视图显示
    [backgroundView addSubview:imageView];
    //添加到窗口显示
    [window addSubview:backgroundView];
    
    //单击手势
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    //添加到背景视图
    [backgroundView addGestureRecognizer: tap];
    
    //动画
    [UIView animateWithDuration:0.3 animations:^{
        //视图大小
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

//+(void)saveImage:(UILongPressGestureRecognizer*)Long
//{
////    if (self.saveBlock) {
////        UIImageView *imageView=(UIImageView*)[Long.view viewWithTag:1];
////        self.saveBlock(imageView);
////    }
//    
//    
//    [[BGAlertClass new] alertFromBottomWithOneTitle:@"保存到相册" andHander1:^{
//        
//    } andDelegate:self];
//    NSLog(@"11111");
//}


+(void)hideImage:(UITapGestureRecognizer*)tap
{
    //
    UIView *backgroundView=tap.view;
    //图片视图
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    //动画
    [UIView animateWithDuration:0.3 animations:^{
        //视图大小
        imageView.frame=[orginImageView convertRect:orginImageView.bounds toView:[UIApplication sharedApplication].keyWindow];
    } completion:^(BOOL finished) {
        //移除
        [backgroundView removeFromSuperview];
        orginImageView.alpha = 1;
        backgroundView.alpha=0;
    }];
}
@end
