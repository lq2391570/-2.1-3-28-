//
//  MemberController.h
//  SMProject
//
//  Created by arvin yan on 10/28/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@protocol myTextDelegate2
-(void)changeText2;

@end



@interface MemberController : UIViewController<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate,MBProgressHUDDelegate>
{
	MBProgressHUD *HUD;
}

@property (nonatomic,retain) IBOutlet UILabel * name;
@property (nonatomic,retain) IBOutlet UILabel * jdTime;
@property (nonatomic,retain) IBOutlet UILabel * zjTime;
@property (nonatomic,retain) IBOutlet UILabel * cardNO;
@property (nonatomic,retain) IBOutlet UILabel * daNO;
@property (nonatomic,retain) IBOutlet UILabel * gkNO;
//卡状态
@property (nonatomic,strong)NSString *cardState;


@property (nonatomic, retain) IBOutlet UILabel * ahText;
@property (nonatomic, retain) IBOutlet UILabel * gmsText;
@property (nonatomic, retain) IBOutlet UILabel * remarkText;

@property (nonatomic, retain) NSString * query;

@property (nonatomic,retain) IBOutlet UIButton * imageBtn;
@property (nonatomic, strong) UIPopoverController *popOver;

@property (nonatomic,retain) IBOutlet UIView * ahView;
@property (nonatomic,retain) IBOutlet UIView * gmsView;
@property (nonatomic,retain) IBOutlet UIView * yqView;
@property (nonatomic,assign)id<myTextDelegate2>delegate;

//新添加的View

@property (strong, nonatomic) IBOutlet UIView *smlTicketView;


@property (strong, nonatomic) IBOutlet UIButton *addBtn1;

@property (strong, nonatomic) IBOutlet UIButton *addBtn2;

@property (strong, nonatomic) IBOutlet UIButton *addBtn3;

@property (strong, nonatomic) IBOutlet UIButton *addBtn0;


@property (strong, nonatomic) IBOutlet UILabel *leftLabel;
@property (strong, nonatomic) IBOutlet UILabel *rightLabel;



//小票Array
@property (nonatomic,strong) NSMutableArray *smlTicketArray;


@property (strong, nonatomic) IBOutlet UIButton *projectListBtn;
//打开相机或图片的状态，判断是点击的哪一个
@property (assign,nonatomic) int imageStateNum;






- (void)submitErrand;

@end
