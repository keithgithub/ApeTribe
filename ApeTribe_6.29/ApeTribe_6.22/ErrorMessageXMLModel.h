//
//  ErrorMessageXMLModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/28.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrorMessageXMLModel : NSObject
@property (nonatomic, assign) long errorCode;// 错误码
@property (nonatomic, copy) NSString *errorMessage;// 错误信息

- (instancetype) initWithXML:(ONOXMLElement *)xml;
@end
