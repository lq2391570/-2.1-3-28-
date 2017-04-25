//
//  SubCateViewController.h
//  top100
//
//  Created by Dai Cloud on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CateViewController.h"
#import "ImageModelBaseClass.h"
#import "UIView+currentSelectNum.h"
#import "CompareModel.h"

#import "JCAlertView.h"
@interface SubCateViewController : UIViewController
{
    NSUserDefaults *_user;
    
}

@property (strong, nonatomic) NSArray *subCates;
@property (strong, nonatomic) CateViewController *cateVC;

@property (assign,nonatomic)NSInteger beforeNum;
@property (nonatomic,assign)NSInteger afterNum;
@property (nonatomic,strong)UIImageView *beforeSelectImage;
@property (nonatomic,strong)UIImageView *beforeSelectImage2;
@property (nonatomic,strong)UIImageView *afterSelectImage;
@property (nonatomic,strong)UIImageView *afterSelectImage2;

@property (nonatomic,strong)ImageModelBaseClass *beforeBassClass;
@property (nonatomic,strong)ImageModelBaseClass *afterBassClass;
@property (nonatomic,strong)ImageModelBaseClass *receiptBassClass;
//服务号
@property (nonatomic,strong)NSString *serNumber;


//选中数组
@property (nonatomic,strong)NSMutableArray *selectArray;

//对比数组
@property (nonatomic,strong)NSMutableArray *compareArray;
//项目id
@property (nonatomic,strong)NSString *iid;
//顾客id
@property (nonatomic,strong)NSString *cid;

//项目服务前弹出的6张图片
@property (nonatomic,strong)NSMutableArray *popImageListArray;

@property (nonatomic,strong)JCAlertView *customAlert;


@end
