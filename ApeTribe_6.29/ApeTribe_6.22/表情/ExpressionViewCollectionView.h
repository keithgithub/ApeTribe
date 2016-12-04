//
//  ExpressionViewCollectionView.h
//  YuanSheng
//
//  Created by ibokan on 16/7/12.
//  Copyright © 2016年 zhengshengxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpressionViewCollectionViewCell.h"

typedef void(^CalltextBlock)(NSString *text);

@interface ExpressionViewCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>//签协议

@property(nonatomic,strong)NSMutableArray *arrData;

@property(nonatomic,strong)CalltextBlock calltextBlock;

@end
