//
//  ExpressionView.h
//  YuanSheng
//
//  Created by ibokan on 16/7/12.
//  Copyright © 2016年 zhengshengxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpressionViewCollectionView.h"
#import "ExpressionViewCollectionViewCell.h"

typedef void(^TextCallBlock)(NSString *text);

@interface ExpressionView : UIView<UIScrollViewDelegate>
@property(nonatomic,strong)ExpressionViewCollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;

@property(nonatomic,strong)TextCallBlock textCallBlock;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hengV_H;

@property(nonatomic,strong)NSMutableDictionary *mDic;//获取的所有表情数据
@property (weak, nonatomic) IBOutlet UIPageControl *page;

@end
