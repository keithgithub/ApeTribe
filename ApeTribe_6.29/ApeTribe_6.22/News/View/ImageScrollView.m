//
//  ImageScrollView.m
//  GGIcome
//
//  Created by gg on 16/5/21.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import "ImageScrollView.h"
#import "UIImageView+WebCache.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
@implementation ImageScrollView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //初始化数组
        self.mArrImages = [NSMutableArray new];
        
        //创建scrollView
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];

        //创建pagecontroller
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(frame.size.width-100, frame.size.height-30, 100, 30)];
        
        
        //显示
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        
    }
    return self;
}


-(void)setContentScrollView:(NSArray*)mArrImages andTitle:(NSArray*)arrTitle
{
    self.mArrImages = mArrImages;
    
    self.pageControl.numberOfPages = mArrImages.count;
    self.pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    //图片宽度
    CGFloat imageWidth = self.scrollView.frame.size.width;
    //图片高度
    CGFloat imageHeight = self.scrollView.frame.size.height;
    //图片的y
    CGFloat imageY = 0;
    //图片的张数
    NSInteger totalCount = mArrImages.count;
    //1添加5张图片
    for (int i = 0; i<totalCount; i++)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.scrollView.frame.size.height-30, self.frame.size.width, 30)];
        label.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.083];
        label.font = [UIFont systemFontOfSize:15];
        label.text = arrTitle[i];
        
        //图片的x
        CGFloat imageX = i*imageWidth;
        //创建一个图片控件
        UIImageView *imageView = [[UIImageView alloc]init];
        
        //做标记
        imageView.tag = i;
        
        imageView.userInteractionEnabled = YES;
        
        //创建手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        tap.numberOfTapsRequired = 1;
        [tap setNumberOfTouchesRequired:1];
        
        [imageView addGestureRecognizer:tap];

        imageView.frame = CGRectMake(imageX, imageY, imageWidth, imageHeight);
        
        imageView.image = [UIImage imageNamed:mArrImages[i]];
//        [imageView sd_setImageWithURL:[NSURL URLWithString:PICTURE_URL(mArrImages[i][@"CoverPic"])] placeholderImage:[UIImage imageNamed:@"1"]];
        //添加到scrollView中
        [imageView addSubview:label];
        [self.scrollView addSubview:imageView];
    }
    //2设置scrollView的滚动范围
    CGFloat contentWidth = totalCount*imageWidth;
    self.scrollView.contentSize = CGSizeMake(contentWidth, 130);
    
    //隐藏水平指示条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    //3设置分页
    self.scrollView.pagingEnabled = YES;
    //4监听scrollView的滚动
    self.scrollView.delegate = self;
    
    
    static  dispatch_once_t  token;
    
    dispatch_once(&token, ^{
        //定时滚动
        self.timer=[NSTimer  scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
        /**
         *  在timer与collectionView同时执行情况，当拖动collectionView时，runloop进入UITrackingRunLoopModes模式下，不会处理定时事件，此时timer不能处理，所以此时将timer加入到NSRunLoopCommonModes模式(addTimer forMode)
         */
        //添加到runloop
        [[NSRunLoop  currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    });
}

-(void)tapAction:(UITapGestureRecognizer*)sender
{
    
    NSInteger tag = sender.view.tag;
    NSLog(@"%ld",tag);
    [self.gDelegate sendMessageWithUrlString:self.mArrImages[tag][@"BannerUrl"]];
}


-(void) nextImage
{
    //获取现在的页码
    int  currentPage=self.scrollView.contentOffset.x/SCREEN_SIZE.width;
    //计算下一页的页码
    if (self.pageControl.numberOfPages == 0)
    {
        return;
    }
    int  nextPage=(currentPage+1)%self.pageControl.numberOfPages;
    //设置滚动视图的滚动位置
    self.scrollView.contentOffset = CGPointMake(SCREEN_SIZE.width*nextPage, 0);
    //页码器的页码
    self.pageControl.currentPage = nextPage;
}


/**
*  滚动的时候调用
*/
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //计算页码
    //页码=（contentoffset.x+scrollView一半宽度）/scrollView的宽度
    CGFloat scrollViewWidth = scrollView.frame.size.width;
    CGFloat contentOffsizeX = scrollView.contentOffset.x;
    int page = (contentOffsizeX+scrollViewWidth/2)/scrollViewWidth;
    self.pageControl.currentPage  =  page;
}
/**
 *  开始拖拽的时候调用
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}
/**
 *  结束拖拽的时候调用
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}
/**
 *  开启定时器
 */
-(void)addTimer
{

    //定时滚动
    self.timer=[NSTimer  scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    /**
     *  在timer与collectionView同时执行情况，当拖动collectionView时，runloop进入UITrackingRunLoopModes模式下，不会处理定时事件，此时timer不能处理，所以此时将timer加入到NSRunLoopCommonModes模式(addTimer forMode)
     */
    //添加到runloop
    [[NSRunLoop  currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];


}
/**
 *  关闭定时器
 */
-(void) removeTimer
{
    [self.timer invalidate];
}
/**
 *  pageControl.currentPage值改变，改变contenOffsize的大小
 */
- (void)pageControlChaned:(id)sender
{
    CGFloat scrollViewOffsizeX = self.pageControl.currentPage*self.scrollView.frame.size.width;
    CGPoint point = self.scrollView.contentOffset;
    point.x = scrollViewOffsizeX;
    self.scrollView.contentOffset = point;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
