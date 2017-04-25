//
//  UIButton+btnImageName.m
//  SMProject
//
//  Created by shiliuhua on 16/5/23.
//  Copyright © 2016年 石榴花科技. All rights reserved.
//

#import "UIButton+btnImageName.h"
#import <objc/runtime.h>
@implementation UIButton (btnImageName)
static void *MyKey=(void *)@"MyBtnImageKey";

- (void)setImageName:(NSString *)imageName
{
    objc_setAssociatedObject(self, MyKey, imageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)imageName
{
    return objc_getAssociatedObject(self, MyKey);
}

static void *MyKey2=(void *)@"MyBtnImageKey2";
- (void)setBigImageName:(NSString *)bigImageName
{
    objc_setAssociatedObject(self, MyKey2, bigImageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)bigImageName
{
    return objc_getAssociatedObject(self, MyKey2);
}

static void *myKey3=(void *)@"MyBtnImageKey3";
- (void)setGsNumber:(NSString *)gsNumber
{
    objc_setAssociatedObject(self, myKey3, gsNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)gsNumber
{
    return objc_getAssociatedObject(self, myKey3);
}

static void *myKey4=(void *)@"MyBtnImageKey4";
- (void)setRelativitybigImageName:(NSString *)relativitybigImageName
{
    objc_setAssociatedObject(self, myKey4, relativitybigImageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)relativitybigImageName
{
    return objc_getAssociatedObject(self, myKey4);
}




@end
