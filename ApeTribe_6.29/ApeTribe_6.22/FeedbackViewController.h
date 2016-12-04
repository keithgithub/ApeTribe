//
//  FeedbackViewController.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/11.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *suggestCheckButton;
@property (weak, nonatomic) IBOutlet UIButton *debugCheckButton;
@property (weak, nonatomic) IBOutlet UIButton *addPictureButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, assign) int checkSelected;// 1:表示程序错误; 2：表示意见反馈
- (IBAction)btnAction:(id)sender;

@end
