//
//  BaseTableViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/1.
//  Copyright © 2016年 One. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    [self initial];
    // Do any additional setup after loading the view from its nib.
}
- (void) initial
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"topbar_back_pressed"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"topbar_back_normal"] forState:UIControlStateSelected];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 64 + 30 + 40)];
    UILabel *lineLb = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 0.5, SCREEN_W, 0.5)];
    lineLb.backgroundColor = COLOR_BG_LINE_GRAY;
    [self.topView addSubview:lineLb];

}

#pragma mark - action
- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
