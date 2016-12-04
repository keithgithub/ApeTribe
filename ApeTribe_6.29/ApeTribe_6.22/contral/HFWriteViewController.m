//
//  HFWriteViewController.m
//  6.23新项目
//
//  Created by ibokan on 16/6/23.
//  Copyright © 2016年 huangfu. All rights reserved.
//

#import "HFWriteViewController.h"

#import "HFFriendViewController.h"
#import "HFToolbar.h"
#import "SVProgressHUD.h"
#import "AFHTTPRequestOperationManager+Util.h"
#import "LoginViewController.h"
#import "TZImagePickerController.h"
//#import "HCEmojiKeyboard.h"
#import "HFTextView.h"
#import "FeelingViewController.h"
#import "ExpressionView.h"

//static NSString *emoji = @"Resources.bundle/emoji";
//static NSString *keyboard = @"Resources.bundle/keyboard";
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
@interface HFWriteViewController ()<UITextViewDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>//相机代理
/**工具条*/
@property (strong, nonatomic) HFToolbar *toolbar,*textToolbar;
/**文本框*/
@property(nonatomic,strong)HFTextView *textfield;
@property(nonatomic,strong)UILabel *lblPlace,*lblIup;
/**选择的图片*/
@property(nonatomic,strong)UIImageView *selectImage;
/**导航栏右侧按钮*/
@property(nonatomic,strong)UIButton*btn;
@property(nonatomic,strong)UIImage * image;
@property(nonatomic,strong)NSMutableArray*selectedPhotos;
//@property (strong, nonatomic) HCEmojiKeyboard *emojiKeyboard;
@property (strong, nonatomic) UILabel *showLab;
@property(nonatomic,assign)BOOL isFace;
@property(nonatomic,strong)ExpressionView*expressV;
@end

@implementation HFWriteViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发心情";
    self.view.backgroundColor = [UIColor whiteColor];
    //取消iOS7以后的边缘延伸效果（例如导航栏，状态栏等等）
    //    self.modalPresentationCapturesStatusBarAppearance = NO;
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    self.extendedLayoutIncludesOpaqueBars = NO;
    
    //=======================创建textview===========================
    HFTextView *textfield = [[HFTextView alloc]initWithFrame:CGRectMake(5, 0, SCREEN_W-10, 200)];
    textfield.returnKeyType = UIReturnKeyDone;
    self.textfield = textfield;
    self.textfield.delegate = self;
    [self.view addSubview:textfield];
    //===================================toolbar====================
    
    //声明代码块变量
    __block HFWriteViewController *writeVC = self;
    //底部固定的toorbar
    self.toolbar = [[HFToolbar alloc]initWithFrame:CGRectMake(0, SCREEN_H-44, SCREEN_W, 44) andToolbarBlock:^(UIBarButtonItem* sender) {
        //调用
        [writeVC selectToorbar:sender];
    }];
    //键盘上的toolbar
    self.textToolbar = [[HFToolbar alloc]initWithFrame:CGRectMake(0, SCREEN_H-44, SCREEN_W, 44) andToolbarBlock:^(UIBarButtonItem* sender) {
        //调用
        [writeVC selectToorbar:sender];
    }];
    
    textfield.inputAccessoryView = self.textToolbar;
    [self.view addSubview:self.toolbar];
    
    //===================================导航栏按钮====================
    //创建左侧按钮
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftbtn)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    //创建导航栏右侧按钮
    [self configNav];
    
    [_textfield becomeFirstResponder];
    
    [self creatQQkeyBoard];
    
    
//    [self createEmojiView];
    
}

-(void)creatQQkeyBoard
{
    self.expressV = (ExpressionView *)[[NSBundle mainBundle]loadNibNamed:@"ExpressionView" owner:nil options:nil][0];
    self.expressV.frame = CGRectMake(0, 0, SCREEN_SIZE.width, 120);
    __weak typeof(self) weakSelf = self;
    self.expressV.textCallBlock = ^(NSString *text)
    {
        
        weakSelf.btn.enabled = YES;
        weakSelf.btn.backgroundColor = [UIColor colorWithRed:0.263 green:0.442 blue:0.282 alpha:1.000];
        weakSelf.textfield.placeholder.hidden = YES;
        weakSelf.textfield.text = [NSString stringWithFormat:@"%@%@",weakSelf.textfield.text,text];
        //        weakSelf.btnSend.userInteractionEnabled = YES;
        //        [weakSelf.btnSend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //        [weakSelf text00];
        
        
    };
    //删除按钮
    [self.expressV.btnDelete addTarget:self action:@selector(btnseleteAction:) forControlEvents:UIControlEventTouchUpInside];

    
    
}

-(void)btnseleteAction:(UIButton *)sender
{
   

    if (self.textfield.text.length>0)
    {
        self.textfield.text = [self.textfield.text substringToIndex:self.textfield.text.length-1];
        //        self.tipLabel.text = [NSString stringWithFormat:@"%ld/%ld字",self.textView.text.length+1, (long)MAXVALUE];
        
    }else{
        
        if (self.textfield.text.length==0) {
            self.btn.enabled=NO;
             self.btn.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
            self.textfield.placeholder.hidden=NO;
            
         
        }
        
    }
    
}

//创建导航栏右侧按钮
- (void)configNav{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btn = btn;
    [btn setFrame:CGRectMake(0.0, 0.0, 60.0, 21.0)];
    self.btn.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    //    [btn setBackgroundImage:[UIImage imageNamed:@"contacts_add_friend"] forState:UIControlStateNormal];
    //设置颜色
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:btn]];
}

//导航栏右侧按钮点击事件
-(void)btnClick
{
    
    //上传数据，判断是否登录
    if (![[Tool readLoginState:LOGIN_STATE] isEqualToString:@"1"])
    {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController presentViewController:[Tool getNavigationController:loginVC andtransitioningDelegate:nil andNavigationViewControllerType:NavigationControllerMineType] animated:YES completion:nil];
        
    }else
    {
        
        [SVProgressHUD showInfoWithStatus:@"心情发送中"];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager shareRequestManager];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_OPENPREFIX,URL_TWEET_PUB];
        [manager POST:strUrl parameters:@{@"access_token":ACCESS_TOKEN,@"msg": self.textfield.text,@"dataType":@"xml"} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            if (self.selectImage.image) {
                
                [formData appendPartWithFileData:[self compressImage:self.selectImage.image]
                                            name:@"img"
                                        fileName:@"img.jpg"
                                        mimeType:@"image/jpeg"];
                
            }

        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //类型转换
            ONOXMLDocument *obj = responseObject;
            ONOXMLElement *result = obj.rootElement;//根元素
            ONOXMLElement *softwares = [result firstChildWithTag:@"result"];
            int errorCode = [[[softwares firstChildWithTag:@"errorCode"] numberValue] intValue];
            NSString *errorMessage = [[result firstChildWithTag:@"errorMessage"] stringValue];
            if (errorCode == 200) {
                
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
                [SVProgressHUD setMinimumDismissTimeInterval:1];
                [SVProgressHUD showInfoWithStatus:@"恭喜您心情发送成功"];
            } else {
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
                [SVProgressHUD setMinimumDismissTimeInterval:1];
                [SVProgressHUD showInfoWithStatus:errorMessage];
            }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showInfoWithStatus:@"网络异常，心情发送失败"];
        }];
        
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
        //跳转到我的动弹界面
        FeelingViewController *fellVC = [[FeelingViewController alloc]init];
        [self.navigationController pushViewController:fellVC animated:YES];
        
    }
}

//toorbar按钮选择
-(void)selectToorbar:(UIBarButtonItem*) sender
{
    
    switch (sender.tag) {
        case 1://相册
        {
            //调用选择相机的方法
            TZImagePickerController *pickvC= [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
            
            [self presentViewController:pickvC animated:YES completion:nil];
        }
            break;
        case 2://@
        {
            HFFriendViewController *friendV = [[HFFriendViewController alloc]init];
            
            friendV.friendBlock = ^(NSString *strName)
            {
                self.textfield.placeholder.hidden = YES;
                self.textfield.text = [ self.textfield.text stringByAppendingString:strName];
                
            };
            [self.navigationController pushViewController:friendV animated:YES];
            
        }
            break;
        case 3://#
        {
            self.lblPlace.hidden = YES;
            [self insertString:@"#请输入软件名或话题#" andSelect:YES];
            
        }
            break;
        case 4://笑脸
        {
            [self clickedFaceBtn:(UIButton*)sender];
            
            
            
            
        }
            break;
        default:
            break;
    }
}

//- (void)createEmojiView {
//    
//    _emojiKeyboard = [HCEmojiKeyboard sharedKeyboard];
//    _emojiKeyboard.showAddBtn = YES;
//    [_emojiKeyboard addBtnClicked:^{
//        NSLog(@"clicked add btn");
//    }];
//    [_emojiKeyboard sendEmojis:^{
//        //赋值
//        //   _showLab.text = _textWindow.text;
//        
//    }];
//}

//改变键盘状态
- (void)clickedFaceBtn:(UIButton *)button{
    self.isFace = !self.isFace;
//    if (self.isFace){
//        [_emojiKeyboard setTextInput:self.textfield];
//        
//    }else{
//        
//        self.textfield.inputView = nil;
//    }
//    [self.textfield reloadInputViews];
//    
//    [_textfield becomeFirstResponder];
    if (self.isFace) {
        self.textfield.inputView = self.expressV;
        
    }else
    {
       self.textfield.inputView = nil;
    }
    
    [self.textfield reloadInputViews];
    
     
    
}


-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    self.selectedPhotos = [NSMutableArray arrayWithArray:photos];
    //    self.selectedAssets = [NSMutableArray arrayWithArray:assets];
    //    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    
    if (self.selectImage.image==nil)
    {
        self.selectImage  =[[UIImageView alloc]initWithFrame:CGRectMake(10, SCREEN_SIZE.width/2+30, 100, 100)];
    }
    
    [self.view addSubview:self.selectImage];
    
    UIButton *closebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closebtn.frame = CGRectMake(80, 0, 20, 20);
    [closebtn setBackgroundImage:[UIImage imageNamed:@"alphaClose@2x"] forState:UIControlStateNormal];
    [closebtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.selectImage addSubview:closebtn];
    
    self.selectImage.userInteractionEnabled=YES;
    self.selectImage.image=nil;
    self.selectImage.image=self.selectedPhotos[0];
    self.image =self.selectedPhotos[0];
    
}

-(void)closeAction:(UIButton *)sender
{
    [self.selectedPhotos removeAllObjects];
    
    
    [self.selectImage removeFromSuperview];
    self.selectImage.image = nil;
    
}

- (void)insertString:(NSString *)string andSelect:(BOOL)shouldSelect
{
    [_textfield becomeFirstResponder];
    _textfield.placeholder.hidden = YES;
    NSUInteger cursorLocation = _textfield.selectedRange.location;
    [_textfield replaceRange:_textfield.selectedTextRange withText:string];
    
    if (shouldSelect) {
        UITextPosition *selectedStartPos = [_textfield positionFromPosition:_textfield.beginningOfDocument offset:cursorLocation + 1];
        UITextPosition *selectedEndPos   = [_textfield positionFromPosition:_textfield.beginningOfDocument offset:cursorLocation + string.length - 1];

        UITextRange *newRange = [_textfield textRangeFromPosition:selectedStartPos toPosition:selectedEndPos];
        
        [_textfield setSelectedTextRange:newRange];
    }
}

//压缩图片
-(NSData *)compressImage:(UIImage *)image
{
    CGSize size = [self scaleSize:image.size];
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSUInteger maxFileSize = 500 * 1024;
    CGFloat compressionRatio = 0.7f;
    CGFloat maxCompressionRatio = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(scaledImage, compressionRatio);
    while (imageData.length > maxFileSize && compressionRatio > maxCompressionRatio)
    {
        compressionRatio -= 0.1f;
        imageData = UIImageJPEGRepresentation(image, compressionRatio);
    }
    return imageData;
    
}
-(CGSize)scaleSize:(CGSize)sourceSize
{
    float width = sourceSize.width;
    float height = sourceSize.height;
    if (width >= height)
    {
        return CGSizeMake(800, 800 * height / width);
    }
    else
    {
        return CGSizeMake(800 * width / height, 800);
    }
}

//导航栏取消按钮
-(void)leftbtn
{
    [self.textfield resignFirstResponder];
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}
//textview文字改变的调用方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""])
    {
        self.textfield.placeholder.hidden = YES;
        self.btn.enabled = YES;
        self.btn.backgroundColor = [UIColor colorWithRed:0.263 green:0.442 blue:0.282 alpha:1.000];
        
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        
        self.textfield.placeholder.hidden = NO;
        self.btn.enabled = NO;
        self.btn.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    }
    
    if ([text isEqualToString:@"\n"]) {
        
        if (_textfield.text.length == 0)
        {
            self.textfield.placeholder.hidden = NO;
            self.btn.enabled = NO;
            self.btn.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
        }
        
        
        [self.textfield  resignFirstResponder];
        
        return NO;
    }
    
    return YES;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.cameraTag == 20)
    {
        //调用选择相机的方法
        TZImagePickerController *pickvC= [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
        
        [self presentViewController:pickvC animated:YES completion:nil];
    }
    self.cameraTag = 21;
}


@end
