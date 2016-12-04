//
//  SignUpViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import "SignUpViewController.h"
#import "LoadModel.h"
#import "HelpClass.h"
#import "URL.h"
#import "EventDetailXmlModel.h"
@interface SignUpViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gender;
@property (weak, nonatomic) IBOutlet UITextField *mobile;
@property (weak, nonatomic) IBOutlet UITextField *company;
@property (weak, nonatomic) IBOutlet UITextField *job;
@property (nonatomic,copy) NSString *sex;
@end

@implementation SignUpViewController

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)genderAction:(UISegmentedControl *)sender
{
    self.sex = [sender titleForSegmentAtIndex:sender.selected];
}
- (IBAction)comfirmAction:(UIButton *)sender
{
    if ([self.name.text isEqualToString:@""])
    {
        [HelpClass warning:@"请输入姓名" andView:self.view andHideTime:1];
        return;
    }
    
    //判断电话号码是不是正确的电话号码
    if (![HelpClass checkTelNumber:self.mobile.text])
    {
        [HelpClass warning:@"请输入正确的电话号码" andView:self.view andHideTime:1];
        return;
    }
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_EVENT_APPLY];
    
    [LoadModel postRequestWithUrl:strUrl andParams:PARAM_EVENT_APPLY(self.eventDetailModel.eventId, USER_MODEL.userId, self.name.text, self.sex, self.mobile.text, self.company.text, self.job.text) andSucBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        //类型转换
        ONOXMLDocument *obj = responseObject;
        
        ONOXMLElement *result = obj.rootElement;//根元素
        ONOXMLElement *result1 = [result firstChildWithTag:@"result"];
        //错误编号
        NSInteger errorCode = [[[result1 firstChildWithTag:@"errorCode"] numberValue] integerValue];
        //错误信息
        NSString *errorMessage = [[result1 firstChildWithTag:@"errormessage"] stringValue];
        
        if (errorCode == 1)
        {
            [HelpClass warning:errorMessage andView:self.view andHideTime:1];
        }
        else
        {
            [HelpClass warning:errorMessage andView:self.view andHideTime:1];
        }

    } andFailBlock:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sex = @"男";
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
