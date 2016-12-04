//
//  text.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/12.
//  Copyright © 2016年 One. All rights reserved.
//

#import "text.h"

@implementation text
//2.对得到的数组进行分析

+(NSMutableAttributedString *)test:(NSString *)str
{
    NSMutableArray *contentArray = [NSMutableArray array];
    NSMutableArray *atArray1 = [NSMutableArray new];
    NSMutableArray *atArray2 = [NSMutableArray new];
    
    [self getMessageRange:str :contentArray];
    
    if ([str containsString:@"@"]) {
        [self getATRange:str :atArray1 :atArray2];
    }
    
    
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] init];
    
    
    for (NSString *object in contentArray) {
        
        
        if ([object hasSuffix:@"]"]&&[object hasPrefix:@"["])
        {
            
            //如果是表情用iOS中附件代替string在label上显示
            
            NSTextAttachment *imageStr = [[NSTextAttachment alloc]init];
            
            
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"emoji" ofType:@"plist"];
            NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
            NSMutableDictionary *mDic = [NSMutableDictionary new];
            for (NSString *key in data.allKeys)
            {
                if ([key hasPrefix:@"["])
                {
                    
                    [mDic setObject:data[key] forKey:key];
                }
            }
            NSString *str = mDic[object];
            imageStr.image = [UIImage imageNamed:str];
            
            //这里对图片的大小进行设置一般来说等于文字的高度
            
            //            CGFloat height = self.label.font.lineHeight;
            
            imageStr.bounds = CGRectMake(0, -3, 21, 21);
            
            NSAttributedString *attrString = [NSAttributedString attributedStringWithAttachment:imageStr];
            
            [strM appendAttributedString:attrString];
            
        }else{
            
            //如果不是表情直接进行拼接
            
            
            [strM appendAttributedString:[[NSAttributedString alloc] initWithString:object]];
            
        }
        
    }
    if (atArray1.count>0) {
        for (int i=0; i<atArray1.count; i++) {
            [strM addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange([atArray1[i]integerValue],[atArray2[i]integerValue])];
        }
        
    }
    
    
    
    [strM addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, strM.length)];//字体大小
    return strM;
    //self.label.attributedText = strM;
}

+(void)getMessageRange:(NSString*)message :(NSMutableArray*)array {
    
    NSRange range=[message rangeOfString: @"["];
    
    NSRange range1=[message rangeOfString: @"]"];
    
    //判断当前字符串是否还有表情的标志。
    
    if (range.length>0 && range1.length>0) {
        
        if (range.location<range1.location) {
            
       
        
        if (range.location > 0) {
            
            [array addObject:[message substringToIndex:range.location]];
            
            [array addObject:[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)]];
            
            NSString *str=[message substringFromIndex:range1.location+1];
            
            [self getMessageRange:str :array];
            
        }else {
            
            NSString *nextstr=[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)];
            
            //排除文字是“”的
            
            if (![nextstr isEqualToString:@""]) {
                
                [array addObject:nextstr];
                
                NSString *str=[message substringFromIndex:range1.location+1];
                
                [self getMessageRange:str :array];
                
            }else {
                
                return;
                
            }
            
        }
            
        
        }
        
    } else if (message != nil) {
        
        [array addObject:message];
        
    }
    
}
//获取@的人
+(void)getATRange:(NSString*)message :(NSMutableArray*)array1 :(NSMutableArray*)array2 {
    
    int mark =-1;
    BOOL isFirst = NO ;
    for (int i=0; i<message.length; i++)
    {
        NSString *m = [message substringWithRange:NSMakeRange(i, 1)];
        if (([m isEqualToString:@"#"] || [m isEqualToString:@"@"]) && isFirst == NO)  {
            mark = i;
            isFirst = YES;
            continue;
        }
        if (isFirst && ([m isEqualToString:@"#"] || [m isEqualToString:@" "])){
            [array1 addObject:@(mark)];
            if ([m isEqualToString:@"#"]) {
                [array2 addObject:@(i-mark+1)];
            }else{
                [array2 addObject:@(i-mark)];
            }
            
            isFirst =NO;
        }
    }
    if (isFirst) {
        [array1 addObject:@(mark)];
        [array2 addObject:@(message.length-mark)];
    }
    
    
}


@end
