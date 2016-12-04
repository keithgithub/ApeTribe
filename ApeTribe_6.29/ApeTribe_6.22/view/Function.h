//
//  Function.h
//  4.26标签栏
//
//  Created by ibokan on 16/4/26.
//  Copyright © 2016年 huangfu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^btnBlock)(NSInteger tagv);
@interface Function : UIView
/**打叉按钮*/
@property(nonatomic,strong) UIButton *btnClose;
/**代码块属性*/
@property(nonatomic,strong)btnBlock btnBlock ;
@end
