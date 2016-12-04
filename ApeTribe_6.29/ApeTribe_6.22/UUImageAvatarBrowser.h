//
//  UUAVAudioPlayer.h
//  BloodSugarForDoc
//
//  Created by shake on 14-9-1.
//  Copyright (c) 2014年 shake. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OnClickCallBack)();

@interface UUImageAvatarBrowser : NSObject
//@property (nonatomic, strong) OnClickCallBack clickHandle;

//show imageView on the keyWindow
+(void)showImage:(UIImageView*)avatarImageView;
/**
 *  显示图片
 *
 *  @param avatarImage 图片对象
 */
+(void)showAvatarImage:(UIImage *)avatarImage;
+(void)showAndChangeImage:(UIImageView*)avatarImageView andClickHandle:(OnClickCallBack)clickHandle;
@end
