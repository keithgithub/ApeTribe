//
//  EventHeaderView.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EventDetailXmlModel;
typedef void(^CallBlock)(EventDetailXmlModel *eventDetailModel);
@protocol EventHeaderViewDelegate <NSObject>

-(void)gotoSignUpVC:(EventDetailXmlModel*)eventDetailModel;

@end

@interface EventHeaderView : UIView
@property (nonatomic,assign) id<EventHeaderViewDelegate> gDelegate;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *spot;
@property (weak, nonatomic) IBOutlet UIButton *btnLink;

@property (nonatomic,strong) CallBlock gotoVcHandel;

@property (nonatomic,strong) EventDetailXmlModel *eventDetailModel;
- (IBAction)btnLinkAction:(UIButton*)sender;


-(void)setEventDetailHeaderView:(EventDetailXmlModel*)eventDetailModel andGotoVC:(CallBlock) gotoVcBlock;
@end
