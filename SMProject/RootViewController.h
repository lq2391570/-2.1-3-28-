//
//  RootViewController.h
//  Sheng123
//
//  Created by 石榴花科技 on 14-4-3.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCPathButton.h"
#import "MWPhotoBrowser.h"
#import "MWPhoto.h"
#import "MBProgressHUD.h"
#import "LogInViewController.h"
#import "Reachability.h"
#import "SDWebImageManager.h"
#import "ASIHTTPRequest.h"
#import "SDWebImageDownloader.h"
#import "MapViewController.h"
#import "CustomerController.h"
#import "MemberController.h"
@interface CustomerInfo : NSObject
@property (nonatomic, strong) NSString * cid;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * usid;
@property (nonatomic, strong) NSString * cardstate;

- (CustomerInfo *)init;

@end

@interface RootViewController : UIViewController<DCPathButtonDelegate,MWPhotoBrowserDelegate,UITextFieldDelegate,MBProgressHUDDelegate,SDWebImageManagerDelegate,myTextDelegate,myTextDelegate2>
{
	MBProgressHUD *HUD;
    NSMutableDictionary *keyDictRe;
    UIButton *_swichBtn;
    UIView *_searchView2;
    UITextField *_cardTextField;
    UITextField *_nameTextField;
    UIButton *_searchBtn;
    UIImageView *_kuangImageView;
    UIButton *_putongBtn;
    UIButton *_jingqueBtn;
    UILabel *_lineLabel;
    UILabel *_hotLineLabel;
    NSInteger selectState;
    
}
@property (nonatomic, strong) UILabel*lhuilable;
@property(nonatomic,assign)NSInteger currentSize;
- (void)allDownLoad:(UIProgressView *)progress uilable:(UILabel*)lable;
- (void)stopDownLoad;
- (BOOL) isConnectionAvailable;
-(BOOL)findeNoDonwloadFile:(NSString*)url;
-(BOOL)judgeArrays:(NSArray*)urls;



@property (nonatomic, strong) UIProgressView *LhprogressView;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;
@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic,strong)UIProgressView *progress;

@property (nonatomic,strong)NSString *ipadName;
@property (nonatomic,strong)NSString *storeName;
@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)NSString *ipadVersionName;

@property (nonatomic,strong)NSString *myVersion;
@property (nonatomic,strong)NSString *ipaVersion;
@property (nonatomic,strong)NSString *data_updata;
@property (nonatomic,strong)NSString *ipadUDID;

@property (nonatomic,strong)NSString *alreadyBianLi;

@end
