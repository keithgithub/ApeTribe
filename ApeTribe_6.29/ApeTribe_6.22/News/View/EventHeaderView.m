//
//  EventHeaderView.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import "EventHeaderView.h"
#import "EventDetailXmlModel.h"
@implementation EventHeaderView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(void)setEventDetailHeaderView:(EventDetailXmlModel*)eventDetailModel andGotoVC:(CallBlock) gotoVcBlock
{
    self.eventDetailModel = eventDetailModel;
    self.title.text = eventDetailModel.title;
    self.startTime.text = [NSString stringWithFormat:@"开始时间:%@",eventDetailModel.startTime];
    self.endTime.text = [NSString stringWithFormat:@"结束时间:%@",eventDetailModel.endTime];
    self.spot.text = [NSString stringWithFormat:@"活动地点:%@",eventDetailModel.spot];
    
    self.btnLink.layer.cornerRadius = 5;
    self.btnLink.layer.masksToBounds = YES;
}

- (IBAction)btnLinkAction:(id)sender
{
    //    self.gotoVcHandel(_eventDetailModel);
    [self.gDelegate gotoSignUpVC:self.eventDetailModel];
}
@end
