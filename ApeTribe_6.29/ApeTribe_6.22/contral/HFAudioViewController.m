//
//  HFAudioViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/26.
//  Copyright © 2016年 One. All rights reserved.
//

#import "HFAudioViewController.h"
#import <AVFoundation/AVFoundation.h>

#import "AFHTTPRequestOperationManager+Util.h"
#import "LoginViewController.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
@interface HFAudioViewController ()<UITextViewDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate>

/**导航栏右侧按钮*/
@property(nonatomic,strong)UIButton*btn;
/**textView*/
@property(nonatomic,strong)UITextView*textView;
@property (nonatomic, strong) UIImageView *voiceImageView;
@property(nonatomic,strong)UILabel *lblPlace;
@property (nonatomic, strong) UILabel *voiceTimes;//显示文本
@property (nonatomic, strong) UILabel *timesLabel;//计算文本
@property (nonatomic, strong) UIButton *recordingButton;//长按按钮
@property (nonatomic, strong) UIButton *playButton;//播放按钮
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) AVAudioRecorder *audioRecorder;//录音
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;//播放
@property (nonatomic, strong) AVAudioSession *audioSession;//音频会话对象

@property (nonatomic, strong) NSURL *recordingUrl;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) int recordTime;//录音时间
@property (nonatomic, assign) int minute;
@property (nonatomic, assign) int second;
@property (nonatomic, assign) BOOL isPlay;//是否播放
@property (nonatomic, assign) BOOL hasVoice;//发表状态
@property (nonatomic, assign) int recordNumber;//记录录音次数

@property (nonatomic, assign) int playDuration;
@property (nonatomic, assign) int playTimes;
@end

@implementation HFAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发心情";
    //取消iOS7以后的边缘延伸效果（例如导航栏，状态栏等等）
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    //创建左侧按钮
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftbtn)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    //创建导航栏右侧按钮
    [self configNav];
    self.navigationItem.rightBarButtonItem.enabled = _hasVoice;
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(15, 24, SCREEN_SIZE.width-30,100)];
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [UIColor colorWithWhite:0.800 alpha:1.000].CGColor;
    self.lblPlace = [[UILabel alloc]initWithFrame:CGRectMake(5, 3, SCREEN_W, 21)];
    self.lblPlace.text = @"为你的声音附一段描述...";
    self.lblPlace.textColor = [UIColor colorWithWhite:0.400 alpha:1.000];
    self.lblPlace.font = [UIFont systemFontOfSize:12];
    [ self.textView addSubview:self.lblPlace];
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    
    //创建播放录音的视图=====================
    _voiceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 134, 100, 31)];
    _voiceImageView.image = [UIImage imageNamed:@"voice_0"];
    [self.view addSubview:_voiceImageView];
    
    //添加图片
    NSMutableArray *PicArray = [NSMutableArray new];
    for (int nums = 1; nums < 4; nums++) {//四张图片
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"voice_%d.png", nums]];
        
        [PicArray addObject:image];
    }
    _voiceImageView.animationImages = PicArray;
    _voiceImageView.animationDuration = 1;//一次完整动画的时长
    _voiceImageView.hidden = YES;
    _voiceImageView.userInteractionEnabled = YES;
    
    //添加录音图片点击事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PlayVoice)];
    [_voiceImageView addGestureRecognizer:tapGesture];
    
    //创建播放时间lable=======
    _voiceTimes = [[UILabel alloc]initWithFrame:CGRectMake(120, 134, 50, 31)];
    //    _voiceTimes.text = @"05";
    [_voiceTimes setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:_voiceTimes];
    //创建录音按钮==========
    _recordingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _recordingButton.frame = CGRectMake(SCREEN_SIZE.width/2-65, SCREEN_SIZE.height-260, 130, 130);
    
    [_recordingButton setImage:[UIImage imageNamed:@"voice_record.png"] forState:UIControlStateNormal];
    [self.view addSubview:_recordingButton];
    //添加监听
    [_recordingButton addTarget:self action:@selector(StartRecordingVoice) forControlEvents:UIControlEventTouchDown];
    [_recordingButton addTarget:self action:@selector(StopRecordingVoice) forControlEvents:UIControlEventTouchUpInside];
    [_recordingButton addTarget:self action:@selector(StopRecordingVoice) forControlEvents:UIControlEventTouchUpOutside];
    
    //创建显示时间============
    _timesLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_SIZE.width/2-50, SCREEN_SIZE.height-290, 100, 21)];
    //    _timesLabel.text = @"00:45";
    _timesLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_timesLabel];
    //创建播放按钮======
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _playButton.frame =CGRectMake(15, SCREEN_SIZE.height-205, 40, 40);
    [_playButton setImage:[UIImage imageNamed:@"voice_play.png"] forState:UIControlStateNormal];
    [_playButton addTarget:self action:@selector(PlayVoice) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playButton];
    //创建删除按钮======
    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteButton.frame =CGRectMake(SCREEN_SIZE.width/2+75+25, SCREEN_SIZE.height-205, 40, 40);
    [_deleteButton setImage:[UIImage imageNamed:@"voice_delete.png"] forState:UIControlStateNormal];
    [_deleteButton addTarget:self action:@selector(DeleteVoice) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_deleteButton];
    //长按 录音==============================
    _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_SIZE.width/2-50, SCREEN_SIZE.height-100, 100, 21)];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.text = @"长按  录音";
    _textLabel.textColor = [UIColor colorWithWhite:0.298 alpha:1.000];
    [self.view addSubview:_textLabel];
    
    [self prepareForAudio];
    _recordNumber = 1;
    
    
    //创建分割线
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_SIZE.height-316, SCREEN_SIZE.width, 1)];
    line.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    [self.view addSubview:line];
    
    
}
//隐藏键盘
-(void)keyboardHide
{
    [_textView resignFirstResponder];
}

//创建导航栏右侧按钮
- (void)configNav{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btn = btn;
    [btn setFrame:CGRectMake(0.0, 0.0, 60.0, 21.0)];
    self.btn.backgroundColor = [UIColor colorWithWhite:0.600 alpha:1.000];
    
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
    //获取用户ID 如果为0跳转到登录界面
    //上传数据，判断是否登录
    if (![[Tool readLoginState:LOGIN_STATE] isEqualToString:@"1"])
    {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        //        [self.navigationController pushViewController:loginVC animated:YES];
        [self.navigationController presentViewController:[Tool getNavigationController:loginVC andtransitioningDelegate:nil andNavigationViewControllerType:NavigationControllerMineType] animated:YES completion:nil];
        
    }else
    {
        
        
        NSString *message;
        //如果有内容
        if (self.textView.text.length!=0)
        {
            message = self.textView.text;
        }else
        {
            message = @"#语音心情#";
        }
        [SVProgressHUD showInfoWithStatus:@"语音心情发送中"];
        //        NSLog(@"========%ld",USER_MODEL.userId);
        //定义参数
        //        NSDictionary *dic = @{@"access_token":ACCESS_TOKEN,@"msg":message};
        //定义参数
        NSDictionary *dic = @{@"uid":@(USER_MODEL.userId),@"msg":message};
        //上传
        [self UpMyDataDic:dic];
    }
}
-(void)UpMyDataDic:(NSDictionary *)param
{
    
    //    NSString *strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_OPENPREFIX,URL_TWEET_PUB];
    NSString *strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_TWEET_PUB];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager shareRequestManager];
    [manager POST:strUrl parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (_recordingUrl.absoluteString.length) {
            
            NSError *error = nil;
            NSString *voicePath = [NSString stringWithFormat:@"%@selfRecord.wav", NSTemporaryDirectory()];
            
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:voicePath isDirectory:NO]
                                       name:@"amr"
                                   fileName:@"selfRecord.wav"
                                   mimeType:@"audio/mpeg"
                                      error:&error];
            
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //类型转换
        ONOXMLDocument *obj = responseObject;
        ONOXMLElement *result = obj.rootElement;//根元素
        ONOXMLElement *softwares = [result firstChildWithTag:@"result"];
        int errorCode = [[[softwares firstChildWithTag:@"errorCode"] numberValue] intValue];
        NSString *errorMessage = [[result firstChildWithTag:@"errorMessage"] stringValue];
        if (errorCode == 1) {
            
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
        
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//导航栏取消按钮
-(void)leftbtn
{
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

//textview文字改变的调用方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""])
        
    {
        self.lblPlace.hidden = YES;
        //        _hasVoice = !_hasVoice;
        //        self.navigationItem.rightBarButtonItem.enabled = _hasVoice;
        //        self.btn.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:0.251 alpha:1.000];
        
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        
        self.lblPlace.hidden = NO;
        //        _hasVoice = !_hasVoice;
        //        self.navigationItem.rightBarButtonItem.enabled = _hasVoice;
        //         self.btn.backgroundColor = [UIColor colorWithWhite:0.600 alpha:1.000];
        
    }
    
    if ([text isEqualToString:@"\n"]) {
        if (_textView.text.length == 0)
        {
            self.lblPlace.hidden = NO;
            
        }
        
        
        [self.textView  resignFirstResponder];
        
        return NO;
    }
    
    return YES;
    
}
//准备
- (void)prepareForAudio
{
    //创建会话对象
    _audioSession = [AVAudioSession sharedInstance];
    NSError *error = nil;
    //音频类别，播放和录音
    [_audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    
    if (error) {
        NSLog(@"audioSession:%@ %d %@", [error domain], (int)[error code], [[error userInfo] description]);
        return;
    }
    //设置会话活动
    [_audioSession setActive:YES error:&error];
    error = nil;
    if (error) {
        NSLog(@"audioSession:%@ %d %@", [error domain], (int)[error code], [[error userInfo] description]);
        return;
    }
    
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   [NSNumber numberWithFloat: 44100.0],AVSampleRateKey,
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                   [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,
                                   [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey, nil];
    //获取文件目录
    _recordingUrl = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:@"selfRecord.wav"]];
    
    error = nil;
    //录音
    _audioRecorder = [[AVAudioRecorder alloc] initWithURL:_recordingUrl settings:recordSetting error:&error];
    _audioRecorder.meteringEnabled = YES;
    _audioRecorder.delegate = self;
}

#pragma mark- 长按 开始录音
- (void)StartRecordingVoice
{
    //判断是否是第一次录制
    if (_recordNumber > 1) {
        [self recordAgain];
    }
    
    _audioSession = [AVAudioSession sharedInstance];
    
    if (!_audioRecorder.recording) {
        
        _recordNumber++;
        
        _hasVoice = YES;
        self.navigationItem.rightBarButtonItem.enabled = _hasVoice;
        self.btn.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:0.251 alpha:1.000];
        _timesLabel.hidden = NO;
        _textLabel.text = @"放开  停止";
        
        [_audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        [_audioSession setActive:YES error:nil];
        
        [_audioRecorder prepareToRecord];
        [_audioRecorder peakPowerForChannel:0.0];
        [_audioRecorder record];
        //初始化
        _recordTime = 0;
        
        [self recordTimeStart];
    }
}

#pragma mark - 录音时间
- (void)recordTimeStart
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(recordTimesTick) userInfo:nil repeats:YES];
}

- (void)recordTimesTick
{
    _recordTime += 1;
    //最长时间
    if (_recordTime == 30) {
        _recordTime = 0;
        [_audioRecorder stop];
        [[AVAudioSession sharedInstance] setActive:NO error:nil];
        
        [_timer invalidate];
        _timesLabel.text = @"00:00";
        
        return;
    }
    [self updateRecordTime];
}
- (void)updateRecordTime
{
    _minute = _recordTime/60.0;
    _second = _recordTime - _minute * 60;
    
    _timesLabel.text = [NSString stringWithFormat:@"%02d:%02d", _minute, _second];
}

#pragma mark- 放开长按 停止录音
- (void)StopRecordingVoice
{
    _audioSession = [AVAudioSession sharedInstance];
    
    if (_audioRecorder.isRecording) {
        int seconds = _minute*60 + _second;
        _voiceTimes.text = [NSString stringWithFormat:@"%d\" ",seconds];
        
        _voiceImageView.hidden = NO;
        _voiceTimes.hidden = NO;
        _textLabel.text = @"长按  录音";
        
        [_audioRecorder stop];
        [_audioSession setActive:NO error:nil];
        [_timer invalidate];
        
        [self updateRecordTime];
    }
}

#pragma mark - 播放录音
- (void)PlayVoice
{
    if (_hasVoice) {
        _audioSession = [AVAudioSession sharedInstance];
        //有音频
        if (_isPlay) {
            [_playButton setImage:[UIImage imageNamed:@"voice_play.png"] forState:UIControlStateNormal];
            _isPlay = NO;
            
            [_voiceImageView stopAnimating];
            
            [_audioPlayer pause];
            [_audioSession setActive:NO error:nil];
        } else {
            _voiceImageView.hidden = NO;
            _voiceTimes.hidden = NO;
            [_voiceImageView startAnimating];
            
            [_playButton setImage:[UIImage imageNamed:@"voice_pause.png"] forState:UIControlStateNormal];
            _isPlay = YES;
            
            [_audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
            [_audioSession setActive:YES error:nil];
            
            NSError *error = nil;
            if (_recordingUrl != nil) {
                _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_recordingUrl error:&error];
            }
            if (error) {
                NSLog(@"error:%@", [error description]);
            }
            
            [_audioPlayer prepareToPlay];
            _audioPlayer.volume = 1;
            [_audioPlayer play];
            
            //播放时间
            _playDuration = (int)_audioPlayer.duration;
            _playTimes = 0;
            [self audioPlayTimesStart];
        }
        
    } else {
        [SVProgressHUD showErrorWithStatus:@"没有语音信息可播放"];
        [SVProgressHUD setMinimumDismissTimeInterval:1];
    }
    
}

#pragma mark - 播放录音时间

- (void)audioPlayTimesStart
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(playTimeTick) userInfo:nil repeats:YES];
}

- (void)playTimeTick
{
    //当播放时长等于音频时长时，停止跳动。
    if (_playDuration == _playTimes) {
        
        _isPlay = NO;
        [_playButton setImage:[UIImage imageNamed:@"voice_play.png"] forState:UIControlStateNormal];
        [_voiceImageView stopAnimating];
        
        
        _playTimes = 0;
        [_audioPlayer stop];
        //结束活动
        [[AVAudioSession sharedInstance] setActive:NO error:nil];
        //停止计时
        [_timer invalidate];
        return;
    }
    if (!_audioPlayer.isPlaying) {
        return;
    }
    _playTimes += 1;
}
//再次录音
- (void)recordAgain
{
    [_audioPlayer stop];
    [_audioRecorder stop];
    [_audioSession setActive:NO error:nil];
    
    [_timer invalidate];
    _recordTime = 0;
    _playTimes = 0;
}

#pragma mark - 删除录音
- (void)DeleteVoice
{
    if (_hasVoice) {
        _audioSession = [AVAudioSession sharedInstance];
        
        _hasVoice = NO;
        self.navigationItem.rightBarButtonItem.enabled = _hasVoice;
        self.btn.backgroundColor = [UIColor colorWithWhite:0.600 alpha:1.000];
        [_audioPlayer stop];
        _isPlay = NO;
        [_playButton setImage:[UIImage imageNamed:@"voice_play"] forState:UIControlStateNormal];
        [_voiceImageView stopAnimating];
        
        [_audioRecorder stop];
        
        [_audioSession setActive:NO error:nil];
        
        [_timer invalidate];
        [_audioRecorder deleteRecording];
        
        _voiceImageView.hidden = YES;
        _voiceTimes.hidden = YES;
        _timesLabel.text = @"00:00";
    }
    
}



@end
