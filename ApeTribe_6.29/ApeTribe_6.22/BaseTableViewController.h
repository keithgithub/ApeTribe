//
//  BaseTableViewController.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/1.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UIViewController
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *topView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) SegmentView *segmentView;

@end
