//
//  SoftXMLModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/27.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"
@interface SoftXMLModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *Adescription;
@property(nonatomic,copy)NSString *url;
- (instancetype)initWithXML:(ONOXMLElement *)xml;
@end
