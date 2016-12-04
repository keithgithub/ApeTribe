//
//  CommentView.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CommentViewDelegate <NSObject>

-(void)commentWithTag:(NSInteger)tag;//根据按钮的标记做相应的事情

@end
@interface CommentView : UIView<UITextViewDelegate>
@property (nonatomic,assign) id<CommentViewDelegate> gDelegate;
@property (weak, nonatomic) IBOutlet UIButton *btnBackToMenu;
@property (weak, nonatomic) IBOutlet UITextField *textFieldComment;

@property (weak, nonatomic) IBOutlet UIButton *btnFace;
@property (weak, nonatomic) IBOutlet UIButton *btnFavotite;

- (IBAction)btnAction:(UIButton *)sender;

@end
