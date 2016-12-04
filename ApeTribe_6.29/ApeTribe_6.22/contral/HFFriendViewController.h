//
//  HFFriendViewController.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/24.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^FriendNameBlock)(NSString *str);
@interface HFFriendViewController : UIViewController
/**代码块属性*/
@property(nonatomic,strong)FriendNameBlock friendBlock;
@end
