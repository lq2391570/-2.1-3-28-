//
//  LogInViewController.h
//  SMProject
//
//  Created by 石榴花科技 on 14-4-8.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDataXMLNode.h"
#import "GDataDefines.h"
#import "ASIFormDataRequest.h"
#import "SVProgressHUD.h"


@protocol LogInViewControllerDelegate <NSObject>

- (void)changeRootViewController;

@end

@interface LogInViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
   
}
@property (nonatomic, strong) UITextField *nameTextfield;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UITextField *UserNameTextField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *resgistButton;

//版本号显示label
@property (nonatomic,strong)UILabel *ipadVersionLabel;

@property (nonatomic,strong)NSString *ipadName;
@property (nonatomic,strong)NSString *storeName;
@property (nonatomic,strong)NSString *ipadUDID;
@property (nonatomic, strong) id<LogInViewControllerDelegate> delegate;

@property (nonatomic,strong)NSNumber *ipadStatus;
@property (nonatomic,strong)NSString *shopCode;
@property (nonatomic,strong)NSString *myIpadName;

@property (nonatomic,strong)NSString *data_updata;

@property (nonatomic,assign)BOOL isdimiss;




@end
