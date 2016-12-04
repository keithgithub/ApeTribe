//
//  ShareSheet.h
//  QueenComing_5.19
//
//  Created by ibokan on 16/5/31.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LC_DEFAULT_ANIMATION_DURATION 0.3f// 视图消失的时间
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size// 屏幕大小

#define ROW_H 50.0f// 默认行高
#define BG_COLOR [UIColor colorWithWhite:0.000 alpha:0.154]// 背景颜色
// 颜色
#define LCColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define LC_DEFAULT_BACKGROUND_OPACITY 0.3f// 背景透明度
// 点击确认执行的代码块
typedef void(^ConfirmBlock)(long index);

typedef enum : NSUInteger {
    ShareSheetTableImageStyle,// 表格带图片
    ShareSheetTableStyle,// 表格不带图片
    ShareSheetCollectionStyle,// 九宫格
    ShareSheetGlassStyle,// 毛玻璃背景
    ShareSheetCancelStyle,// 带取消按钮的弹框
} ShareSheetStyle;

@protocol ShareSheetDelegate <NSObject>
// 选中选项执行的方法
- (void) selectAction:(long)index;

@end

@interface ShareSheet : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign) id<ShareSheetDelegate> delegate;// 代理属性
@property (nonatomic, strong) UITableView *tableView;// 表格
@property (nonatomic, strong) UICollectionView *collectionView;// 九宫格
@property (nonatomic, strong) NSArray *arrData;// 数据数组
@property (nonatomic, strong) UIWindow *backWindow;// 背景窗口
@property (nonatomic, strong) UIView *darkView, *bottomView;// 黑色背景视图
@property (nonatomic, assign) CGFloat animationDuration;// sheet消失时间
@property (nonatomic, strong) NSArray *arrImages, *arrTitles;// 存放数据的数组
@property (nonatomic, assign) CGFloat rowHeight;// 行高
@property (nonatomic, assign) CGFloat backgroundOpacity;// 不透明性
@property (nonatomic, assign) ShareSheetStyle style;// 风格
@property (nonatomic, strong) ConfirmBlock confirmHandle;
@property (nonatomic,copy) NSString *title;
+ (instancetype) shareSheetWithStyle:(ShareSheetStyle)style andArrData:(NSArray *)arrDatas andHandle:(ConfirmBlock)handle;
+ (instancetype) shareSheetWithStyle:(ShareSheetStyle)style andArrData:(NSArray *)arrDatas andHandle:(ConfirmBlock)handle andTitle:(NSString *)title;
- (instancetype) initWithStyle:(ShareSheetStyle)style andArrData:(NSArray *)arrDatas andHandle:(ConfirmBlock)handle;

- (instancetype) initWithStyle:(ShareSheetStyle)style andArrData:(NSArray *)arrDatas andHandle:(ConfirmBlock)handle andTitle:(NSString *)title;

- (void) setMainView;// 设置主视图
- (void) show;// 显示
- (void) dismiss:(UITapGestureRecognizer *)sender;// 关闭
@end
