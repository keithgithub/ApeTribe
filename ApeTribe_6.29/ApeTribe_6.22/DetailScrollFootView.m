//
//  DetailScrollFootView.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import "DetailScrollFootView.h"

@implementation DetailScrollFootView

-(void)awakeFromNib
{
    self.btn.layer.borderWidth = 1;
    self.btn.layer.borderColor = [UIColor colorWithWhite:0.800 alpha:1.000].CGColor;
    self.btnHome.layer.cornerRadius = 3;
    self.btnHome.layer.masksToBounds = YES;
    self.btnHome.backgroundColor = [UIColor colorWithRed:0.381 green:0.526 blue:1.000 alpha:1.000];
    self.btnDucoment.layer.cornerRadius = 3;
    self.btnDucoment.layer.masksToBounds = YES;
    self.btnDucoment.backgroundColor = [UIColor colorWithRed:0.381 green:0.526 blue:1.000 alpha:1.000];
    self.btnDownLoad.layer.cornerRadius = 3;
    self.btnDownLoad.layer.masksToBounds = YES;
    self.btnDownLoad.backgroundColor = [UIColor colorWithRed:0.381 green:0.526 blue:1.000 alpha:1.000];
    
    
}





- (IBAction)btnLink:(UIButton *)sender {
    
    self.footBlock(sender.tag);
    
    
}


@end
