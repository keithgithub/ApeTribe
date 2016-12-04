//
//  HFToolbar.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/25.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^toobarBlock)(UIBarButtonItem *barButton);
@interface HFToolbar : UIToolbar
/**代码块属性*/
@property(nonatomic,strong)toobarBlock tBlock;
-(instancetype)initWithFrame:(CGRect)frame andToolbarBlock:(toobarBlock)tBlock;
@end
