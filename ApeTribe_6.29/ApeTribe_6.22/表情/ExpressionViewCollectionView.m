//
//  ExpressionViewCollectionView.m
//  YuanSheng
//
//  Created by ibokan on 16/7/12.
//  Copyright © 2016年 zhengshengxi. All rights reserved.
//

#import "ExpressionViewCollectionView.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
@implementation ExpressionViewCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    //判断
    if (self=[super initWithFrame:frame collectionViewLayout:layout])
    {
//        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"emoji" ofType:@"plist"];
//        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//        NSLog(@"%@",data[@"[撇嘴]"]);
//        NSMutableArray *arr = [NSMutableArray new];
//        for (NSString *key in data.allKeys)
//        {
//            if ([key hasPrefix:@"["])
//            {
//                NSMutableDictionary *mDic = [NSMutableDictionary new];
//                [mDic setObject:data[key] forKey:key];
//                [arr addObject:mDic];
//            }
//        }
//        self.arrData = arr;
        //注册cell
        UINib *nib = [UINib nibWithNibName:@"ExpressionViewCollectionViewCell" bundle:nil];
        [self registerNib:nib forCellWithReuseIdentifier:@"cell"];
        
        //九宫格视图代理设置
        self.dataSource = self;
        self.delegate = self;
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.arrData.count;
}


//设置单元格样式
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //队列获取cell
    ExpressionViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    [cell setCell:self.arrDatas[indexPath.item]];
    NSDictionary  *dic= [NSDictionary new];
    dic = self.arrData[indexPath.row];
    NSArray *arr = dic.allKeys;
    cell.imgV.image = [UIImage imageNamed:arr[0]];
    return cell;
}

//设置cell大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_SIZE.width)/7-0.01, (SCREEN_SIZE.width)/7-0.01);
}

//cell的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary  *dic= [NSDictionary new];
    dic = self.arrData[indexPath.row];
    NSArray *arr = dic.allValues;
    
    self.calltextBlock(arr[0]);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
