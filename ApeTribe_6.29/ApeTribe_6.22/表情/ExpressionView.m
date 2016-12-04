//
//  ExpressionView.m
//  YuanSheng
//
//  Created by ibokan on 16/7/12.
//  Copyright © 2016年 zhengshengxi. All rights reserved.
//

#import "ExpressionView.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
@implementation ExpressionView


-(void)awakeFromNib
{
    self.hengV_H.constant = 0.5;
    self.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(0, 0, SCREEN_SIZE.width, self.frame.size.height);
    self.page.currentPageIndicatorTintColor = [UIColor cyanColor];
    
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"emoji" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    //获取所有表情数据
    self.mDic = [NSMutableDictionary new];
    for (NSString *key in data.allKeys)
    {
        if ([key hasPrefix:@"["])
        {
            [self.mDic setObject:key forKey:data[key]];
        }
    }
    
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 32, self.frame.size.width, self.frame.size.height-64)];
    scrollView.contentSize = CGSizeMake(SCREEN_SIZE.width*5, self.frame.size.height-64);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    [self addSubview:scrollView];
    
    //创建布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    for (int i = 0; i<5; i++)
    {
        self.collectionView = [[ExpressionViewCollectionView alloc]initWithFrame:CGRectMake(SCREEN_SIZE.width*i, 0, SCREEN_SIZE.width, self.frame.size.height-64) collectionViewLayout:layout];
        self.collectionView.arrData = [self getData:i];
        [self.collectionView reloadData];
        __block typeof(self) blockSelf = self;
        self.collectionView.calltextBlock =^(NSString *text)
        {
            NSLog(@"%@",text);
            blockSelf.textCallBlock(text);
        };
        [scrollView addSubview:self.collectionView];
    }
    
    
}


-(NSMutableArray *)getData:(NSInteger)j
{
    NSMutableArray *mArr = [NSMutableArray new];
    for (long i = 0+21*j; i<21+21*j; i++)
    {
        NSMutableDictionary *mdic = [NSMutableDictionary new];
        NSString *key1;
        if (i<9)
        {
            key1 = [NSString stringWithFormat:@"00%ld",i+1];
        }
        else if (i>=99)
        {
            key1 = [NSString stringWithFormat:@"%ld",i+1];
        }
        else
        {
            key1 = [NSString stringWithFormat:@"0%ld",i+1];
        }
        NSString *va = self.mDic[key1];
        [mdic setObject:va forKey:key1];
        [mArr addObject:mdic];
    }
    return mArr;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x/SCREEN_SIZE.width;
    [UIView animateWithDuration:0.2 animations:^{
        
        self.page.currentPage = page;
    }];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
