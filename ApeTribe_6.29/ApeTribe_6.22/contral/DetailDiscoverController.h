//
//  DetailDiscoverController.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/29.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "softXMLModel.h"
#import "DetailXMLModel.h"
#import "YDViewController.h"
typedef enum NSInteger1
{
    Favortie,
    Comment
    
}typeStyle;
@interface DetailDiscoverController : YDViewController
/**软件详数据*/
@property(nonatomic,strong)SoftXMLModel *softXMLModel;
/**软件详情数据*/
@property(nonatomic,strong)DetailXMLModel *detailXMLModel;
/**url*/
@property(nonatomic,strong)NSString*url;
@end
