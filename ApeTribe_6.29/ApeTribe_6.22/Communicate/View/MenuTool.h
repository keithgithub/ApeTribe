//
//  MenuTool.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuToolDelegate <NSObject>

-(void)doSomethingWithTag:(NSInteger)tag;//根据按钮的标记做相应的事情

@end

@interface MenuTool : UIView
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (nonatomic,assign) id<MenuToolDelegate> gDelegate;
@property (weak, nonatomic) IBOutlet UIButton *btnKeyboard;
@property (weak, nonatomic) IBOutlet UIButton *btnCommentList;
@property (weak, nonatomic) IBOutlet UIButton *btnComment;
@property (weak, nonatomic) IBOutlet UIButton *btnFavorite;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UIButton *btnAlert;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;


- (IBAction)btnAction:(UIButton *)sender;

//设置评论的个数
-(void)setCommentNumber:(long)commentCount;
@end
