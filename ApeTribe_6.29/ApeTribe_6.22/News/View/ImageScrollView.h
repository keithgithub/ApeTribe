//
//  ImageScrollView.h
//  GGIcome
//
//  Created by gg on 16/5/21.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageScrollViewDelegate <NSObject>

-(void)sendMessageWithUrlString:(NSString*)urlStr;

@end

@interface ImageScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic,assign) id<ImageScrollViewDelegate>gDelegate;

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSArray *mArrImages;
@property (nonatomic,strong) NSTimer *timer;


-(void)setContentScrollView:(NSArray*)mArrImages andTitle:(NSArray*)arrTitle;
@end
