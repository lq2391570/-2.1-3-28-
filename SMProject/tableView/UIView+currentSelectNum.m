//
//  UIView+currentSelectNum.m
//  SMProject
//
//  Created by shiliuhua on 16/6/8.
//  Copyright © 2016年 石榴花科技. All rights reserved.
//

#import "UIView+currentSelectNum.h"
#import <objc/runtime.h>
@implementation UIView (currentSelectNum)
static void *MyKey=(void *)@"MyKey";

- (void)setCurrentNumStr:(NSString *)currentNumStr
{
    objc_setAssociatedObject(self, MyKey, currentNumStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)currentNumStr
{
    return objc_getAssociatedObject(self, MyKey);
}
@end
