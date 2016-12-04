//
//  BloggerHeaderView.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/29.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BloggerDetailXmlModel;
@interface BloggerHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *pubDate;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *where;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UIButton *btnFavorite;

@property (nonatomic,assign) BOOL btnSelected;
- (IBAction)btnAction:(UIButton *)sender;

-(void)setBlogerDetailContentView:(BloggerDetailXmlModel*)bloggerDetail;

@end
