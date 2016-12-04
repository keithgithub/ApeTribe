//
//  FavoriteXMLModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/3.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoriteXMLModel : NSObject
@property (nonatomic, assign)int type;// 收藏的的类型
@property(nonatomic,copy)NSString *title;// 收藏的标题
@property(nonatomic,assign)int   objid;// 对应对象的id
@property(nonatomic,copy)NSString *url;// 对应的url

- (instancetype)initWithXML:(ONOXMLElement *)xml;

@end
