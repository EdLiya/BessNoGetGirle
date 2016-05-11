//
//  XMGTextField.m
//  百思不得姐
//
//  Created by dev on 16/5/11.
//  Copyright © 2016年 dev. All rights reserved.
//

#import "XMGTextField.h"
#import <objc/runtime.h>


static NSString * const XMGPlacerholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation XMGTextField

+ (void)initialize {
    [self getIvars];
}

+ (void)getIvars {
    unsigned int count = 0;
    // 拷贝出所有的成员变量列表
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    
    for (int i = 0; i < count; i++) {
        // 取出成员变量
//        Ivar ivar = ivars[i];
         Ivar ivar = ivars[i]; // 指针可以像数组一样访问元素
        
        // 打印成员变量名字
        XMGLog(@"%s,%s",ivar_getName(ivar),ivar_getTypeEncoding(ivar)); // ivar_getTypeEncoding 获取类型
    }
    // 释放
    free(ivars);
}

/** 这个可以用于写字典转模型的框架, 获取到属性名称和属性类型 */
+ (void)getProperties
{
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList([UITextField class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出属性
        objc_property_t property = properties[i];
        
        // 打印属性名字
        XMGLog(@"%s   <---->   %s", property_getName(property), property_getAttributes(property)); // property_getAttributes 获取属性类型
    }
    
    free(properties);
}

- (void)awakeFromNib {
    // 设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    
    // 不成为第一响应者
    [self resignFirstResponder];
}

/**
 * 当前文本框聚焦时就会调用
 */
- (BOOL)becomeFirstResponder
{
    // 修改占位文字颜色
    [self setValue:self.textColor forKeyPath:XMGPlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}

/**
 * 当前文本框失去焦点时就会调用
 */
- (BOOL)resignFirstResponder
{
    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:XMGPlacerholderColorKeyPath];
    return [super resignFirstResponder];
}
/**
 运行时(Runtime):
 * 苹果官方一套C语言库
 * 能做很多底层操作(比如访问隐藏的一些成员变量\成员方法....)
 */
@end
