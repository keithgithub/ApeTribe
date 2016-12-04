//
//  FeedbackViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/11.
//  Copyright © 2016年 One. All rights reserved.
//

#import "FeedbackViewController.h"
#import "TZImagePickerController.h"
#import "InteractivityTransitionDelegate.h"
@interface FeedbackViewController ()<UITextViewDelegate, TZImagePickerControllerDelegate>
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;
@property (nonatomic, strong) InteractivityTransitionDelegate *customTransitionDelegate;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *interactiveTransitionRecognizer;
@end

@implementation FeedbackViewController
#pragma mark - getter
- (UIScreenEdgePanGestureRecognizer *) interactiveTransitionRecognizer
{
    if (!_interactiveTransitionRecognizer)
    {
        _interactiveTransitionRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(interactiveTransitionRecognizerAction:)];
        
    }
    return _interactiveTransitionRecognizer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.checkSelected = 1;
    [self initial];
    // 添加滑动交互手势
    self.interactiveTransitionRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:self.interactiveTransitionRecognizer];
}

- (void) initial
{
    self.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
    self.rightBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"topbar_back_pressed"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"topbar_back_normal"] forState:UIControlStateSelected];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    //取消iOS7以后的边缘延伸效果（例如导航栏，状态栏等等）
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = 5;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
// 发送反馈
- (void)rightItemAction
{
    if (self.textView.text.length > 100)
    {
        [SVProgressHUD showErrorWithStatus:@"字数不能超过100"];
    }
    else
    {
        [[NetWorkHelp shareHelper]sendDataWithImage:self.image andMessage:self.textView.text andType:self.checkSelected andSuccessHandle:^(id obj) {
            [SVProgressHUD showSuccessWithStatus:@"发送成功，感谢您的反馈"];
        } andFailhandle:^(NSString *error) {
            
        }];
        
    }
}
#pragma mark - action
- (void)backAction:(UIBarButtonItem *)sender
{
    [self buttonDidClicked:sender];
}

- (void) interactiveTransitionRecognizerAction:(UIScreenEdgePanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        [self buttonDidClicked:sender];
    }
}

- (void) buttonDidClicked:(id)sender
{
    
    if (self.transitioningDelegate != nil)
    {
        self.customTransitionDelegate = (InteractivityTransitionDelegate *)self.transitioningDelegate;
        if ([sender isKindOfClass:[UIGestureRecognizer class]])
        {
            self.customTransitionDelegate.gestureRecognizer = self.interactiveTransitionRecognizer;
        }
        else
        {
            self.customTransitionDelegate.gestureRecognizer = nil;
        }
        self.customTransitionDelegate.targetEdge = UIRectEdgeLeft;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (IBAction)btnAction:(id)sender
{
    
    if ([sender isKindOfClass:[UIButton class]])
    {
        UIButton *btn;
        btn = (UIButton *)sender;
        switch (btn.tag) {
            case 100:// 程序错误
            {
                self.checkSelected = 1;
                [self.debugCheckButton setImage:Image(@"icon_radio_selectel") forState:UIControlStateNormal];
                [self.suggestCheckButton setImage:Image(@"icon_radio_normal") forState:UIControlStateNormal];
            }
                break;
            case 101:// 意见反馈
            {
                self.checkSelected = 2;
                [self.suggestCheckButton setImage:Image(@"icon_radio_selectel") forState:UIControlStateNormal];
                [self.debugCheckButton setImage:Image(@"icon_radio_normal") forState:UIControlStateNormal];
            }
                break;
            case 102:// 添加截图
            {
                // 创建图片选择视图控制器
                TZImagePickerController *tzImagePC = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
                // 推出控制器
                [self presentViewController:tzImagePC animated:YES completion:nil];
            }
                break;
            default:
                break;
        }
    }
    
}

#pragma mark - TZImagePickerControllerDelegate
// 取消选择回调的方法
- (void) imagePickerControllerDidCancel:(TZImagePickerController *)picker
{
    
}

// 选择好图片点击确定回调的方法（不带图片信息）
- (void) imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    if (photos.count > 0)
    {
        self.image = photos[0];
        [self.addPictureButton setBackgroundImage:photos[0] forState:UIControlStateNormal];
    }
    
}

// 选择好图片点击确定回调的方法（带图片信息）
- (void) imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos
{
    
}

#pragma mark - UITextViewDelegate
- (void) textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""])
    {
        self.rightBarButtonItem.enabled = NO;
    }
    else
    {
        self.rightBarButtonItem.enabled = YES;
    }

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
