//
//  HttpEngine.h
//  SMProject
//
//  Created by shiliuhua on 17/3/16.
//  Copyright © 2017年 石榴花科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectList.h"
@interface HttpEngine : NSObject
//得到项目列表
+ (void)getProjectList:(NSString *)cid complete:(void (^) (NSMutableArray *tempArray))complete;
//根据会员号上传首次服务小票
+ (void)uploadSmlTicketOfFirstSer:(NSString *)serNum upImageState:(int)upImageState complete:(void (^) (NSString *str))complete;
//得到首次服务小票list
+ (void)getFirstSerTicketList:(NSString *)serNum complete:(void (^) (NSMutableArray *tempArray))complete;
//得到服务记录list（新）
+ (void)getSerRecordListNew:(NSString *)serNum complete:(void (^) (NSMutableArray *tempArray))complete;
//得到项目列表新
+ (void)getProjectListNew:(NSString *)serNum complete:(void (^) (NSMutableArray *tempArray))complete;
//上传项目服务前的图片
+ (void)uploadProductSerPhoto:(NSString *)serNum proId:(NSString *)proId proName:(NSString *)proName proStyleName:(NSString *)proStyleName proBuyArea:(NSString *)proBuyArea proTime:(NSString *)proTime setDelegateVC:(UIViewController *)DelegateVC complete:(void (^) (NSString *errorCode,NSString *msg))complete;
//获取项目服务前的图片列表
+ (void)getProSerBeforePhotoList:(NSString *)serNum proId:(NSString *)proId complete:(void (^) (NSMutableArray *tempArray))complete;
@end
