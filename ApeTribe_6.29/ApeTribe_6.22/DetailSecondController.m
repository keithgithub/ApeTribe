//
//  DetailSecondController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import "DetailSecondController.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
@interface DetailSecondController ()
/**uiview*/
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation DetailSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =self.detailTitlt;
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建webview
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height-44)];
    self.webView.scrollView.backgroundColor = [UIColor whiteColor];
      NSURL *url = [NSURL URLWithString:self.url];
      NSURLRequest *request = [NSURLRequest requestWithURL:url];
      [self.webView loadRequest:request];

    [self.view addSubview:self.webView];
}



@end
