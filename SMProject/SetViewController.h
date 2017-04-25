//
//  SetViewController.h
//  SMProject
//
//  Created by 石榴花科技 on 14-4-20.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "SVProgressHUD.h"
#import "DownloadModel.h"
#import "EBookManage.h"
#import "URLViewController.h"
#import "LogInViewController.h"

@interface SetViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,LogInViewControllerDelegate>
{
    UIProgressView *_progressView;
    SVProgressHUD *svHUD;
    UIWindow *_window;
    LogInViewController *_vc;
    RootViewController *_rootVC;
}
@property (nonatomic, strong) UILabel*lhuilable;
@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong) UIButton *allDownBtn;
@property (nonatomic,strong)UIButton *stopBtn;
@property (nonatomic,strong)RootViewController *rootControl;
@end
