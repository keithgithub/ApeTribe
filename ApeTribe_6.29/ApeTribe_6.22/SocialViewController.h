//
//  SocialViewController.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/5.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDViewController.h"
@class SocialViewController;
@protocol SocialViewControllerDelegate <NSObject>

-(void)SocialViewController:(SocialViewController*)SController andInteger:(NSInteger)page;

@end
@interface SocialViewController : UITableViewController
@property(nonatomic,strong)NSMutableArray*mArrData;
@property(nonatomic,assign)long pagesize;
@property(nonatomic,assign)NSInteger currentPage;
@property(nonatomic,weak)id<SocialViewControllerDelegate> adelegate;


@end
