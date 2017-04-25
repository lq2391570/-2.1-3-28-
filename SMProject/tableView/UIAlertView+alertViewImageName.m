//
//  UIAlertView+alertViewImageName.m
//  SMProject
//
//  Created by shiliuhua on 16/5/25.
//  Copyright © 2016年 石榴花科技. All rights reserved.
//

#import "UIAlertView+alertViewImageName.h"
#import <objc/runtime.h>
@implementation UIAlertView (alertViewImageName)

static void *Mykey=(void *)@"MyImageKey";
- (void)setBigImageName:(NSString *)bigImageName
{
    objc_setAssociatedObject(self, Mykey, bigImageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)bigImageName
{
    return objc_getAssociatedObject(self, Mykey);
}
static void *Mykey2=(void *)@"MyImageKey2";
- (void)setGsNumber:(NSString *)gsNumber
{
    objc_setAssociatedObject(self, Mykey2, gsNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)gsNumber
{
    return objc_getAssociatedObject(self, Mykey2);
}

@end
