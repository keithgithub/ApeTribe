//
//  MenuTool.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import "MenuTool.h"

@implementation MenuTool

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)btnAction:(UIButton *)sender
{
    
    [self.gDelegate doSomethingWithTag:sender.tag];
}

-(void)setCommentNumber:(long)commentCount
{
    self.commentCount.layer.cornerRadius = 9;
    self.commentCount.layer.masksToBounds = YES;
    if (commentCount == 0)
    {
        self.commentCount.hidden = YES;
    }
    else if (commentCount <= 99 && commentCount > 0)
    {
        self.commentCount.hidden = NO;
        self.commentCount.text = [NSString stringWithFormat:@"%ld",commentCount];
    }
    else if(commentCount>99)
    {
        self.commentCount.hidden = NO;
        self.widthConstraint.constant = 40.0;
        self.commentCount.text = @"99+";
    }
}

@end
