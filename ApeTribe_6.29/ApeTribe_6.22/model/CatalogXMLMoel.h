//
//  CatalogXMLMoel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/28.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"
@interface CatalogXMLMoel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)long cTag;

- (instancetype)initWithXML:(ONOXMLElement *)xml;

@end
