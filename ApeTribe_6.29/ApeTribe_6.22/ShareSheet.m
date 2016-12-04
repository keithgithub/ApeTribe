//
//  ShareSheet.m
//  QueenComing_5.19
//
//  Created by ibokan on 16/5/31.
//  Copyright © 2016年 One. All rights reserved.
//

#import "ShareSheet.h"
#import "SheetTableViewCell.h"
#import "Tool.h"
@implementation ShareSheet

#pragma mark - getter

- (CGFloat)backgroundOpacity {
    if (!_backgroundOpacity) {
        _backgroundOpacity = LC_DEFAULT_BACKGROUND_OPACITY;
    }
    
    return _backgroundOpacity;
}
- (CGFloat) rowHeight
{
    if (!_rowHeight) {
        _rowHeight = ROW_H;
    }
    return _rowHeight;
}

- (CGFloat)animationDuration {
    if (!_animationDuration) {
        _animationDuration = LC_DEFAULT_ANIMATION_DURATION;
    }
    
    return _animationDuration;
}
// 创建背景窗口
- (UIWindow *)backWindow {
    
    if (_backWindow == nil) {
        
        _backWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backWindow.windowLevel       = UIWindowLevelStatusBar;
        _backWindow.backgroundColor   = [UIColor clearColor];
        _backWindow.hidden = NO;
    }
    
    return _backWindow;
}
#pragma end mark

/**
 *  便利构造器
 *
 *  @return 返回视图对象
 */
+ (instancetype) shareSheetWithStyle:(ShareSheetStyle)style andArrData:(NSArray *)arrDatas andHandle:(ConfirmBlock)handle
{
    
    
    return [[self alloc]initWithStyle:style andArrData:arrDatas andHandle:handle];
}
+ (instancetype) shareSheetWithStyle:(ShareSheetStyle)style andArrData:(NSArray *)arrDatas andHandle:(ConfirmBlock)handle andTitle:(NSString *)title
{
    return [[self alloc]initWithStyle:style andArrData:arrDatas andHandle:handle andTitle:title];
}
/**
 *  便利初始化方法
 *
 *  @param style     sheet的风格
 *  @param arrImgs   按钮图片
 *  @param arrTitles 按钮标题
 *
 *  @return 返回视图对象
 */
- (instancetype) initWithStyle:(ShareSheetStyle)style andArrData:(NSArray *)arrDatas andHandle:(ConfirmBlock)handle
{
    return [self initWithStyle:style andArrData:arrDatas andHandle:handle andTitle:nil];
}
- (instancetype) initWithStyle:(ShareSheetStyle)style andArrData:(NSArray *)arrDatas andHandle:(ConfirmBlock)handle andTitle:(NSString *)title
{
    if (self = [super init])
    {
        // 数组赋值
        self.arrData = arrDatas;
        self.style = style;
        self.confirmHandle = handle;
        self.title = title;
        switch (style) {
            case ShareSheetTableImageStyle:
            {
                self.tableView = [[UITableView alloc]init];
                self.tableView.dataSource = self;
                self.tableView.delegate = self;
                self.tableView.scrollEnabled = NO;
                self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                UINib *nib = [UINib nibWithNibName:@"SheetTableViewCell" bundle:[NSBundle mainBundle]];
                [self.tableView registerNib:nib forCellReuseIdentifier:@"sheetCell"];
                
            }
                break;
            case ShareSheetCollectionStyle:
            {
                
            }
                break;
            case ShareSheetGlassStyle:
            {
                
            }
                break;
            case ShareSheetTableStyle:
            {
                self.tableView = [[UITableView alloc]init];
                self.tableView.dataSource = self;
                self.tableView.delegate = self;
                self.tableView.scrollEnabled = NO;
                self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                if (title) {
                    self.tableView.tableHeaderView = [self getTableHeaderView:title];
                }
            }
                break;
            case ShareSheetCancelStyle:
            {
                self.tableView = [[UITableView alloc]init];
                self.tableView.dataSource = self;
                self.tableView.delegate = self;
                self.tableView.scrollEnabled = NO;
                self.tableView.tableHeaderView = [self getTableHeaderView:arrDatas[0]];
                self.tableView.backgroundColor = [UIColor clearColor];
                self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cancelCell"];
            }
                break;
            default:
                break;
        }
    }
    return self;

}

- (void) initTableView
{
    
}

- (void) setMainView
{
    // 暗黑色的view
    UIView *darkView = [[UIView alloc] init];
    [darkView setAlpha:0];
    [darkView setUserInteractionEnabled:NO];
    [darkView setFrame:(CGRect){0, 0, SCREEN_SIZE}];// 设置背景视图位置大小
    [darkView setBackgroundColor:LCColor(46, 49, 50)];// 设置背景颜色
    [self addSubview:darkView];
    _darkView = darkView;
    // 创建点击手势识别器
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    [darkView addGestureRecognizer:tap];// 添加点击的手势识别器
    if (self.style == ShareSheetTableImageStyle) {
        // 初始化表格
        self.tableView.frame = CGRectMake(0, SCREEN_SIZE.height, SCREEN_SIZE.width, self.rowHeight * self.arrData.count);
    }else if (self.style == ShareSheetTableStyle)
    {
        // 初始化表格
        self.rowHeight = 48;
        if (self.title == nil) {
            // 初始化表格
            self.tableView.frame = CGRectMake(0, SCREEN_SIZE.height, SCREEN_SIZE.width, self.rowHeight * (self.arrData.count + 1) + 10);
        }
        else
        {
            
            self.tableView.frame = CGRectMake(0, SCREEN_SIZE.height, SCREEN_SIZE.width, self.rowHeight * (self.arrData.count + 1) + 10 + 64);
        }
        
    }
    else
    {
        self.tableView.frame = CGRectMake(0, SCREEN_SIZE.height, SCREEN_SIZE.width, 182);
    }
    [self.tableView setBackgroundColor:LCColor(233, 233, 238)];
    // 添加表格
    [self addSubview:self.tableView];
    
    // 设置视图位置大小
    [self setFrame:(CGRect){0, 0, SCREEN_SIZE}];
    // 添加视图
    [self.backWindow addSubview:self];
}
// 显示Sheet
- (void) show
{
    [self setMainView];// 设置主视图
    // 弹出视图
    [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        // 设置背景透明度
        [_darkView setAlpha:self.backgroundOpacity];
        // 打开背景的用户交互
        [_darkView setUserInteractionEnabled:YES];
        // 移动表格
        CGRect frame = _tableView.frame;
        frame.origin.y -= frame.size.height;
        [_tableView setFrame:frame];
        
        
    } completion:nil];
    
}

// 移除sheet
- (void) dismiss:(UITapGestureRecognizer *)sender
{
    
    [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        // 设置背景透明
        [_darkView setAlpha:0];
        [_darkView setUserInteractionEnabled:NO];
        // 移动表格
        CGRect frame = _tableView.frame;
        frame.origin.y += frame.size.height;
        [_tableView setFrame:frame];
        
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        self.backWindow.hidden = YES;
    }];

}
// 设置表头视图
- (UIView *) getTableHeaderView:(NSString *)title
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 64)];
    UILabel *messageLb = [[UILabel alloc]initWithFrame:CGRectMake(20, 11, SCREEN_SIZE.width - 40, 42)];
    messageLb.numberOfLines = 2;
    messageLb.font = [UIFont systemFontOfSize:12];
    messageLb.text = title;
    messageLb.textAlignment = NSTextAlignmentCenter;
    messageLb.textColor = [UIColor colorWithWhite:0.600 alpha:1.000];
    UILabel *lineLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 63, SCREEN_SIZE.width, 0.5)];
    lineLb.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    [headerView addSubview:messageLb];
    [headerView addSubview:lineLb];
//    messageLb.backgroundColor = [UIColor redColor];
    headerView.backgroundColor = [UIColor whiteColor];
    return headerView;
}

#pragma mark 表格的代理方法
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (self.style == ShareSheetCancelStyle || self.style == ShareSheetTableStyle)
    {
        return 2;
    }
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.style == ShareSheetCancelStyle) {
        return 1;
    }
    if (self.style == ShareSheetTableStyle)
    {
        if (section == 0) {
            return self.arrData.count;
        }
        else
        {
            return 1;
        }
    }
    return self.arrData.count;
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.style == ShareSheetCancelStyle) {
        if (section == 1) {
            return 10.0f;
        }
        else
        {
            return 0.01f;
        }
    }
    if (self.style == ShareSheetTableStyle)
    {
        if (section == 0) {
            return 0.001f;
        }
        return 10.01f;
    }
    return 0.01f;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.style == ShareSheetTableStyle)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        
        UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(20, 11, SCREEN_SIZE.width - 40, 22)];
        titleLb.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:titleLb];
        UILabel *lineLb = [[UILabel alloc]initWithFrame:CGRectMake(0, self.rowHeight - 0.5, SCREEN_SIZE.width, 0.5)];
        lineLb.backgroundColor = [UIColor colorWithWhite:0.936 alpha:1.000];
        [cell.contentView addSubview:lineLb];
        if (indexPath.section == 0)
        {
            titleLb.text = self.arrData[indexPath.row];
        }
        else
        {
            titleLb.text = @"取消";
        }
        return cell;
    }
    if (self.style == ShareSheetCancelStyle) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cancelCell" forIndexPath:indexPath];
        UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(20, 16, SCREEN_SIZE.width - 40, 22)];
        titleLb.text = self.arrData[indexPath.section + 1];
        titleLb.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:titleLb];
        // 设置确定按钮颜色
        if (indexPath.section == 0) {
            titleLb.textColor = [UIColor colorWithRed:1.000 green:0.212 blue:0.083 alpha:1.000];
        }
        return cell;
    }
    else
    {
        SheetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sheetCell" forIndexPath:indexPath];
        // 设置标题
        [cell setCell:self.arrData[indexPath.row]];
        return cell;
    }
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.style == ShareSheetCancelStyle) {
        if (indexPath.section == 0) {
            if (self.confirmHandle != nil) {
                self.confirmHandle(0);
            }
            
            [self dismiss:nil];// 回收sheet
        }
        else
        {
            [self dismiss:nil];// 回收sheet
        }
    }// 判断是否有某个名字命名的方法
    if (self.style == ShareSheetTableStyle)
    {
        if (indexPath.section == 0)
        {
            if (self.confirmHandle != nil)
            {
                self.confirmHandle(indexPath.row);
            }
            
            [self dismiss:nil];// 回收sheet
        }
        else
        {
            [self dismiss:nil];// 回收sheet
        }
    }
    else if ([self.delegate respondsToSelector:@selector(selectAction:)])
    {
        [self.delegate selectAction:indexPath.row];
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.style == ShareSheetCancelStyle) {
        return 54;
    }
    if (self.style == ShareSheetTableStyle) {
        return self.rowHeight;
    }
    return ROW_H;
}
#pragma end mark
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
