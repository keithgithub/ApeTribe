//
//  HFSharkOffViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/26.
//  Copyright © 2016年 One. All rights reserved.
//

#import "HFSharkOffViewController.h"
#import "SharkXMLModel.h"
#import "SharkView.h"
#import "UIImageView+WebCache.h"
#import "DetailDiscoverController.h"
#import "HelpClass.h"
#import "PostDetailViewController.h"
#import "YDViewController.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
@interface HFSharkOffViewController ()
/**导航栏右侧按钮*/
@property(nonatomic,strong)UIButton*btn;
/**摇一摇视图*/
@property(nonatomic,strong) UIImageView *imgV;
/**摇一摇数据模型*/
@property(nonatomic,strong)SharkXMLModel*sharkXMLModel;
@end

@implementation HFSharkOffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"抖一抖";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建视图===============
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_SIZE.width/2-100, SCREEN_SIZE.height/2-100, 200, 200)];
    self.imgV = imgV;
    UIImage *img = [UIImage imageNamed:@"shaking"];
    imgV.image = img;
    [self.view addSubview:imgV];
    //创建左侧按钮
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftbtn)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    // 设置允许摇一摇功能=====================================
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    // 并让自己成为第一响应者
    [self becomeFirstResponder];
    
}

//导航栏取消按钮
-(void)leftbtn
{
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - 摇一摇相关方法
// 摇一摇开始摇动
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"开始摇动");
    [SVProgressHUD showWithStatus:@"正在加载"];
    [self rotate:self.imgV];
    return;
}
#pragma mark - 动画效果
- (void)rotate:(UIView *)view
{
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotate.fromValue = [NSNumber numberWithFloat:0];
    rotate.toValue = [NSNumber numberWithFloat:M_PI / 3.0];
    rotate.duration = 0.18;
    rotate.repeatCount = 2;
    rotate.autoreverses = YES;
    
    [CATransaction begin];
    [self setAnchorPoint:CGPointMake(-0.2, 0.9) forView:view];
    [CATransaction setCompletionBlock:^{
     
        
    }];
    [view.layer addAnimation:rotate forKey:nil];
    [CATransaction commit];
}
-(void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x,
                                   view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x,
                                   view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}
//下载数据
-(void)getRandomMessage
{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_ROCK_ROCK];
    AFHTTPSessionManager *manage = [AFHTTPSessionManager shareRequestManager];
    [manage GET:strUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //类型转换
        ONOXMLDocument * obj = responseObject;
        ONOXMLElement *result = obj.rootElement;
        self.sharkXMLModel = [[SharkXMLModel alloc]initWithXML:result];
        
        
        double delayInSeconds = 1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [SVProgressHUD dismiss];
            //加载xib
            SharkView *sharkView = [[NSBundle mainBundle]loadNibNamed:@"SharkView" owner:nil options:nil][0];
            sharkView.frame = CGRectMake(0, SCREEN_SIZE.height-101, SCREEN_SIZE.width, 101);
            [self.view addSubview:sharkView];
            [sharkView.logoImgV sd_setImageWithURL:[NSURL URLWithString:self.sharkXMLModel.image]];
            sharkView.title.text = self.sharkXMLModel.title;
            sharkView.subtitle.text = self.sharkXMLModel.detail;
            sharkView.author.text = self.sharkXMLModel.author;
            //转换为几小时前
            NSString *strTime=[HelpClass compareCurrentTime:self.sharkXMLModel.time];
            sharkView.time.text = strTime;
            sharkView.communtCount.text = [NSString stringWithFormat:@"%ld",self.sharkXMLModel.commentCount];
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTouch:)];
            [sharkView addGestureRecognizer:gesture];
        });

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

// 摇一摇摇动结束
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) { // 判断是否是摇动结束
        NSLog(@"摇动结束");
      
        //下载数据
        [self getRandomMessage];
        
    }
    return;
}

-(void)viewTouch:(UITapGestureRecognizer*)tap
{
    YDViewController *vc;
   //跳转到详情页
    switch (self.sharkXMLModel.randomtype) {
        case 1:
        case 2:
        {
            UIStoryboard *std = [UIStoryboard storyboardWithName:@"AnswerStoryBoard" bundle:[NSBundle mainBundle]];
            PostDetailViewController *postVC = [std instantiateViewControllerWithIdentifier:@"PostDetailVC"];
            if (self.sharkXMLModel.randomtype == 1)//资讯
            {
                postVC.type = 0;
                postVC.Id = [self.sharkXMLModel.strID longLongValue];
            }
            else//博客
            {
                postVC.type = 1;
                postVC.Id = [self.sharkXMLModel.strID longLongValue];
            }
            vc = postVC;
        }
            
            break;
            
        default://软件
        {
            DetailDiscoverController *detailVC = [[DetailDiscoverController alloc]init];
            detailVC.url = self.sharkXMLModel.url;
            
            vc = detailVC;
        }
            break;
    }
    vc.customTransitionDelegate = [Tool getInteractivityTransitionDelegateWithType:InteractivityTransitionDelegateTypeNormal];
    [self presentViewController:[Tool getNavigationController:vc andtransitioningDelegate:vc.customTransitionDelegate andNavigationViewControllerType:NavigationControllerNormalType] animated:YES completion:nil];
}




@end
