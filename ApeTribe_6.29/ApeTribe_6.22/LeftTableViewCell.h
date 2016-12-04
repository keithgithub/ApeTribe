//
//  LeftTableViewCell.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/26.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgV;
@property (nonatomic, strong) UILabel *titleLb, *lineLb;

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void) setCell:(NSDictionary *)dic;
@end
