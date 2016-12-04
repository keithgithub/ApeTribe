//
//  DetailScrollFootView.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^FootBlock)(NSInteger tagV);

@interface DetailScrollFootView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *deal;
@property (weak, nonatomic) IBOutlet UILabel *language;
@property (weak, nonatomic) IBOutlet UILabel *system;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *btnHome;
@property (weak, nonatomic) IBOutlet UIButton *btnDucoment;
@property (weak, nonatomic) IBOutlet UIButton *btnDownLoad;
/**44*/
@property(nonatomic,strong)FootBlock footBlock;

@end
