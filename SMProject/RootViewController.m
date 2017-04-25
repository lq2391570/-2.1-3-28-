//
//  RootViewController.m
//  Sheng123
//
//  Created by 石榴花科技 on 14-4-3.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import "RootViewController.h"
#import "EbookViewController.h"
#import "SBJSON.h"
#import "WebViewController.h"
#import "SDImageCache.h"
#import <MediaPlayer/MediaPlayer.h>

#import "ProjectDescriptionViewController.h"
#import "CelebrationViewController.h"
#import "HighequipmentViewController.h"
#import "SetViewController.h"
#import "SGInfoAlert.h"
#import "InformationViewController.h"
#import "EBookManage.h"
#import "SMSelfServiceController.h"
#import "XMLmanage.h"
#import "MemberController.h"
#import "CustomerController.h"
#import "CateViewController.h"
#import "SMSelfServiceController.h"
#import "DAViewController.h"
#import "SMArchivesController.h"
#import "SVProgressHUD.h"

#import "ProjectManage.h"
#import "CelebrationViewController.h"
#import "QDManage.h"
#import "ASIFormDataRequest.h"
#import "EBookManage.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "SDWebImageManager.h"
#import "SDWebImageDownloader.h"
#import "SDWebImageDownloaderOperation.h"
//#import "UIImage+WebP.h"

#import "UIImage+MultiFormat.h"
#import "UIImage+GIF.h"
#import "SDWebImageCompat.h"
#import "SDWebImageOperation.h"
#import "InformationManage.h"
#import "HighManage.h"
#import "ProjectManage.h"
#import "ASINetworkQueue.h"
#import "DownloadModel.h"
#define imageUrl LocationIp
int queryFlag;
NSString * uName;
FMDatabase *__db = nil;

@interface RootViewController ()

{
    NSMutableArray *namearr;
    NSMutableArray *urlarr;
    UIButton *button;
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    UIImageView *bgimageView;
    //    UIImageView *searchView;
    NSArray *photo1;
    NSMutableArray *_selections;
    
    UIButton *mybutton1;
    UIButton *mybutton2;
    UITextField *searcktextField;
    UIView *searchView;
    MPMoviePlayerViewController *movPl;
    
    NSString *str;
    
    BOOL bt;
    UIButton *_returnBtn;
    
    NSArray *_dataArray;
    NSDictionary *_eBookDict1;
    
    UIProgressView *_progressView;
    ASINetworkQueue *_queue;
   
    UIButton *_allDown;
    
    NSMutableArray *_fileArray;
}

@end

@implementation RootViewController
@synthesize progress=_progress;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //        [self request];
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
        bt = NO;
    }
    return self;
}

-(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    
    if (!isExistenceNetwork) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络不通畅，请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    
    return isExistenceNetwork;
}


- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBarHidden = YES;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    //    [user setObject:@"smbg模糊原图 2" forKey:@"bg"];
    
    str = [user objectForKey:@"bg"];
    if (str == NULL) {
        str = @"smbg模糊原图 2";
    }
    
    NSLog(@"%@",str);
    bgimageView.image = [UIImage imageNamed:str];
  //  searcktextField.text = @"O";
   // [self isConnectionAvailable];
   // [SVProgressHUD dismiss];
    [self getStoreNum:^(NSArray *array) {
        NSDictionary *dic=[array objectAtIndex:0];
        NSDictionary *dic2=[dic objectForKey:@"data"];
        self.data_updata=[dic2 objectForKey:@"data_update"];
        NSLog(@"self.data_updata==%@",self.data_updata);
    }];
NSLog(@"self.data_updata==%@",self.data_updata);
  //  [self performSelector:@selector(popAlertView) withObject:nil afterDelay:3];
    [self popAlertView];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar"] forBarMetrics:UIBarMetricsDefault];
    
    
    bgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    bgimageView.image = [UIImage imageNamed:str];
    NSLog(@"%@",str);
    [self.view addSubview:bgimageView];
    
    UIImageView *logView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 34)];
    logView.image = [UIImage imageNamed:@"logo原色发光"];
    logView.center = CGPointMake(self.view.center.x, self.view.center.y/4 + 90);
    [self.view addSubview:logView];
    
    DCPathButton *dcPathButton = [[DCPathButton alloc]
                                  initDCPathButtonWithSubButtons:6
                                  totalRadius:270
                                  centerRadius:70
                                  subRadius:70
                                  centerImage:@"更多"
                                  centerBackground:nil
                                  subImages:^(DCPathButton *dc){
                                      [dc subButtonImage:@"index_zz" withTag:0];
                                      [dc subButtonImage:@"index_gw" withTag:1];
                                      [dc subButtonImage:@"index_qd.png" withTag:2];
                                      [dc subButtonImage:@"index_dc.png" withTag:3];
                                      [dc subButtonImage:@"index_sz.png" withTag:4];
                                      [dc subButtonImage:@"圣梦地图.png" withTag:5];
                                  }
                                  subImageBackground:@"圣梦app未登录.jpg"
                                  inLocationX:510 locationY:360 toParentView:self.view];
    dcPathButton.delegate = self;
    [self creatButton];
    [self creatSearchView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
//    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame=CGRectMake(480, 440, 60, 60);
// //   [btn setBackgroundColor:[UIColor blueColor]];
//   // [btn setTitle:@"一键下载" forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"一键下载_点击前.png"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(allDownLoadAll) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=CGRectMake(210, 440, 60, 60);
    [btn1 setBackgroundImage:[UIImage imageNamed:@"一键下载_点击前.png"] forState:UIControlStateNormal];
    //  [btn2 setBackgroundColor:[UIColor greenColor]];
    [btn1 setTitle:@"更新" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(allDownLoad:) forControlEvents:UIControlEventTouchUpInside];
  //  [self.view addSubview:btn1];
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(845, 440, 60, 60);
    [btn2 setBackgroundImage:[UIImage imageNamed:@"一键下载_点击前.png"] forState:UIControlStateNormal];
  //  [btn2 setBackgroundColor:[UIColor greenColor]];
    [btn2 setTitle:@"更新" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(allDownLoad2) forControlEvents:UIControlEventTouchUpInside];
  //  [self.view addSubview:btn2];
    
    UIButton *btn3=[UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame=CGRectMake(655, 440, 60, 60);
    [btn3 setBackgroundImage:[UIImage imageNamed:@"一键下载_点击前.png"] forState:UIControlStateNormal];
    [btn3 setTitle:@"更新" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(allDownLoad3) forControlEvents:UIControlEventTouchUpInside];
  //  [self.view addSubview:btn3];
    
//    UIButton *btn4=[UIButton buttonWithType:UIButtonTypeCustom];
//    btn4.frame=CGRectMake(615, 440, 60, 60);
//    [btn4 setTitle:@"更新" forState:UIControlStateNormal];
//    [btn4 addTarget:self action:@selector(allDownLoad4) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn4];
//
    
    UIButton *btnStop=[UIButton buttonWithType:UIButtonTypeCustom];
    btnStop.frame=CGRectMake(805, 440, 40, 40);
    [btnStop setTitle:@"暂停" forState:UIControlStateNormal];
    [btnStop addTarget:self action:@selector(stopDownLoad) forControlEvents:UIControlEventTouchUpInside];
  //  [self.view addSubview:btnStop];

    _progress=[[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progress.frame=CGRectMake(100, 100, 100, 20);
    //进度条
    _progress.backgroundColor = [UIColor redColor];
    _progress.progressTintColor=[UIColor blackColor];
//    _progressView.progress=10;//赋值为0
   // [self.view addSubview:_progressView];
    _fileArray=[[NSMutableArray alloc] initWithCapacity:0];
    
    UILabel *storeLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 750, 200, 17)];
    storeLabel.text=[NSString stringWithFormat:@"连锁机构代码：%@",self.storeName];
    
    storeLabel.textColor=[UIColor darkGrayColor];
  //  storeLabel.text=self.storeName;
    [self.view addSubview:storeLabel];
    UILabel *namelabel=[[UILabel alloc] initWithFrame:CGRectMake(220, 750, 200, 17)];
    namelabel.text=[NSString stringWithFormat:@"管理人员代码：%@",self.userName];
  //  namelabel.text=self.userName;
    namelabel.textColor=[UIColor darkGrayColor];
    
    [self.view addSubview:namelabel];
    UILabel *ipadNamelabel=[[UILabel alloc] initWithFrame:CGRectMake(430, 750, 200, 17)];
    ipadNamelabel.text=[NSString stringWithFormat:@"设备名称：%@",self.ipadName];
  //  ipadNamelabel.text=self.ipadName;
    NSLog(@"========%@",ipadNamelabel.text);
    
    ipadNamelabel.textColor=[UIColor darkGrayColor];
    [self.view addSubview:ipadNamelabel];
    
//    if ([kWSPath isEqualToString:@"http://ipad.sanmoon.net/Sanmoon1.0/"]) {
//        NSUserDefaults *users=[NSUserDefaults standardUserDefaults];
//        NSString *version=[users objectForKey:@"appVersion"];
//        self.ipadVersionName=[NSString stringWithFormat:@"正式版%@v",version];
//    };
    
//    UILabel *ipadVersionlabel=[[UILabel alloc] initWithFrame:CGRectMake(600, 750, 200, 17)];
//    ipadVersionlabel.text=[NSString stringWithFormat:@"版本：%@",self.ipadVersionName];
//    //  ipadNamelabel.text=self.ipadName;
//    NSLog(@"========%@",ipadVersionlabel.text);
//    ipadVersionlabel.textColor=[UIColor darkGrayColor];
//    [self.view addSubview:ipadVersionlabel];
   // [self popAlertView];
    
}
//上传状态
- (void)updateZhuangTai:(void (^) (NSString *string))complete
{
    
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@updateIpadDataUpToIpad",LocationIp]]];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *ipadUDID=[user objectForKey:@"ipadUDID"];
    if (self.ipadUDID==nil) {
        [request addPostValue:ipadUDID forKey:@"ipad.udid"];
    }else{
        [request addPostValue:self.ipadUDID forKey:@"ipad.udid"];
    }
  
    
    [request setTimeOutSeconds:15];
    NSMutableArray *tempArray=[[NSMutableArray alloc] initWithCapacity:0];
    [request setCompletionBlock:^{
        NSLog(@"%@",request.responseString);
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        
        NSString *str=[dic objectForKey:@"status"];
        if ([str integerValue]==1) {
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"数据更新成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
        }else{
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"数据更新失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
        }
        //  [tempArray addObject:dic];
        //        self.cardStatus=[dic objectForKey:@"status"];
        //        NSDictionary *dic2=[dic objectForKey:@"data"];
        //        self.shopCode=[dic2 objectForKey:@"shopCode"];
        
        if (complete) {
            complete(str);
        }
        
    }];
    
    [request startAsynchronous];
    
}
- (void)getStoreNum:(void (^) (NSArray *array))complete
{
    NSDictionary *dic=[[NSBundle mainBundle] infoDictionary];
    NSString *app_version=[dic objectForKey:@"CFBundleVersion"];

    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@checkLoginToIpad",LocationIp]]];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *ipadUDID=[user objectForKey:@"ipadUDID"];
    
    [request addPostValue:ipadUDID forKey:@"ipad.udid"];
     [request addPostValue:app_version forKey:@"ipad.currentVersion"];
    [request setTimeOutSeconds:15];
    NSMutableArray *tempArray=[[NSMutableArray alloc] initWithCapacity:0];
    [request setCompletionBlock:^{
        
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        [tempArray addObject:dic];
        //        self.cardStatus=[dic objectForKey:@"status"];
        //        NSDictionary *dic2=[dic objectForKey:@"data"];
        //        self.shopCode=[dic2 objectForKey:@"shopCode"];
        if (tempArray) {
            complete(tempArray);
        }
        
    }];
    
    [request startAsynchronous];
    
}

//更新数据
- (void)updateShuJu
{
    //    [self getStoreNum:^(NSArray *array) {
    //
    //        NSDictionary *dic=[array objectAtIndex:0];
    //        NSDictionary *dict2=[dic objectForKey:@"data"];
    //        self.data_updata=[dict2 objectForKey:@"data_updata"];
    
    
//    if (self.data_updata==nil) {
//        NSUserDefaults *users=[NSUserDefaults standardUserDefaults];
//        if ([[users objectForKey:@"dataupdata"] isEqual:[NSNull null]]) {
//            
//        }else{
//            self.data_updata=[users objectForKey:@"dataupdata"];
//        }
//        NSLog(@"===%@",self.data_updata);
//        
//    }
    //提示更新数据
    NSUserDefaults *users=[NSUserDefaults standardUserDefaults];
    if (![[users objectForKey:@"upData"] isKindOfClass:[NSString class]]||[self.data_updata integerValue]==1) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"目前不是最新数据，是否更新" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alert.tag=1000;
        [alert show];
    }else{
        
    }

    
//    //提示更新数据
//    NSLog(@"===%@",self.data_updata);
//    if ([self.data_updata integerValue]==1) {
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"目前不是最新数据，是否更新" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//        alert.tag=1000;
//        [alert show];
//        
//    }
    //}];
    
    
}

- (void)upDAteVerison
{
    UIWebView *web=[[UIWebView alloc] initWithFrame:self.view.bounds];
   // NSString *path = @"https://sm.shiliuflower.com/data/SMVersion.html";
      NSString *path=ReLocationPlist;
    NSURL *url = [NSURL URLWithString:path];
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"update version testing" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
    
    [web loadRequest:[NSURLRequest requestWithURL:url]];
     web.delegate=self;
    [self.view addSubview:web];
    [self exitApplication];

}
- (void)exitApplication {
    
    [UIView beginAnimations:@"exitApplication" context:nil];
    
    [UIView setAnimationDuration:0.5];
    
    [UIView setAnimationDelegate:self];
    
    // [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.view.window cache:NO];
    
    [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.view cache:NO];
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    
    //self.view.window.bounds = CGRectMake(0, 0, 0, 0);
    
    self.view.bounds = CGRectMake(0, 0, 0, 0);
    
    [UIView commitAnimations];
    
}



- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if ([animationID compare:@"exitApplication"] == 0) {
        
        exit(0);
        
    }
    
}

- (void)allDownLoadAll
{
   // [self allDownLoad];
    [self allDownLoad2];
    [self allDownLoad3];
}

-(BOOL)findeNoDonwloadFile:(NSString*)url
{
  //  更具传进来的url找到 存放文件目录。判断文件 是不是存在存在返回yes 否则返回no
    [_fileArray addObject:url];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:url]) {
        return YES;
    }else{
        return NO;
    }
        
    
}

-(BOOL)judgeArrays:(NSArray*)urls
{//这里是所有需要下载的文件
    urls=[NSArray arrayWithArray:_fileArray];
    NSLog(@"%d",urls.count);
    for (NSString*url in  urls) {
        if(![self findeNoDonwloadFile:url]){//寻找没有下载完成的文件
            return YES;
        }
    }
    //文件都已经下载
    return NO;
}


- (void)allDownLoad:(UIProgressView *)progress uilable:(UILabel*)lable
{
     [self initDatabase];
    self.lhuilable = lable;
    self.LhprogressView = progress;
    [SVProgressHUD showWithStatus:@"下载中，请稍等" maskType:SVProgressHUDMaskTypeClear];
    if(!keyDictRe){
        keyDictRe = [NSMutableDictionary dictionaryWithCapacity:200];
    }
//    [[DownloadModel sharedDownloadModel]setP:progress];
//
//    
    NSLog(@"点击了一键更新");
    _dataArray=[[NSArray alloc] init];
    [self complete:^(NSArray *array) {
        _dataArray=array;
      //  NSLog(@"%@",array);
        NSLog(@"=-%d",array.count);
        NSMutableArray *booInfoArray=[[NSMutableArray alloc] initWithCapacity:0];
       
        for (int i=0; i<array.count; i++) {
            //EBookInfo
            NSDictionary *dict=[array objectAtIndex:i];

            EBookInfo *bookInfo=[[EBookInfo alloc] init];
            bookInfo.type = [dict objectForKey:@"type"];

            //InformationInfo
            InformationInfo *mationInfo=[[InformationInfo alloc] init];
            mationInfo.type=[dict objectForKey:@"type"];
            HighInfo *highbookInfo=[[HighInfo alloc] init];
            highbookInfo.type = [dict objectForKey:@"type"];
            ProjectInfo *project=[[ProjectInfo alloc] init];
            project.type = [dict objectForKey:@"type"];
#pragma mark 项目手册
            if ([project.type integerValue]==4) {
                project.ID = [dict objectForKey:@"id"];
                project.imagesIDs = [dict objectForKey:@"imagesIds"];
                project.imgUrl = [dict objectForKey:@"imgUrl"];
                project.name = [dict objectForKey:@"name"];
                project.compId = [dict objectForKey:@"compId"];
                NSLog(@"--%@",project.name);
                [self insertProjectDB:project];
                [self createDirectoryPath:@"cover1" withName:project.name];
                //                if ([project.imgUrl rangeOfString:@"resources/img"].location != NSNotFound ) {
                //
                //                    NSArray * array = [project.imgUrl componentsSeparatedByString:@"resources/img/"];
                //                    NSString *fileName = [array objectAtIndex:1];
                //
                //                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //                        [self download:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageUrl,project.imgUrl]] path:[NSString stringWithFormat:@"Library/Caches/cover1/%@/%@",project.name,fileName]];
                //                        NSLog(@"==%@",[NSString stringWithFormat:@"Library/Caches/cover1/%@/%@",project.name,fileName]);
                //                    });
                //
                //                }
                
                [self deleteBookInfoOfProject:project.name];
                NSArray *imageArray=[dict objectForKey:@"images"];
                NSLog(@"%d---",imageArray.count);
                for (NSDictionary *imageDic in imageArray) {
                    PImageInfo *imgInfo=[[PImageInfo alloc] init];
                    //  imgInfo.type=NULL;
                    imgInfo.imgUrl=[imageDic objectForKey:@"imgUrl"];
                    imgInfo.bookVersion=project.name;
                    
                    NSArray *array=[imageDic objectForKey:@"link"];
                    for (NSDictionary *linkDic in array) {
                        
                        imgInfo.linkurl=[linkDic objectForKey:@"link"]  ;
                        imgInfo.startX=[[linkDic objectForKey:@"startX"] stringValue] ;
                        imgInfo.startY=[[linkDic objectForKey:@"startY"] stringValue];
                        imgInfo.endX=[[linkDic objectForKey:@"endX"] stringValue];
                        imgInfo.endY=[[linkDic objectForKey:@"endY"] stringValue];
                        [self insertPImageBookInfo:imgInfo];
                        
                    }
                    
                    [self insertPImageBookInfo:imgInfo];
                    [self createDirectoryPath:@"ephoto" withName:imgInfo.bookVersion];
                    if ([imgInfo.imgUrl rangeOfString:@"resources/images"].location != NSNotFound ) {
                        
                        NSArray * array = [imgInfo.imgUrl componentsSeparatedByString:@"resources/images/"];
                        NSString *fileName = [array objectAtIndex:1];
                        
                        ASIHTTPRequest*rest =  [[DownloadModel sharedDownloadModel]downloadFile:self url:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl] folder:imgInfo.bookVersion tag:1 fileType:1];
                        
                       [self findeNoDonwloadFile:[DownloadModel getPath:imgInfo.bookVersion nsurl:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]]];
                        
                        NSString *strOfFile=[DownloadModel getPath:imgInfo.bookVersion nsurl:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]];
                        [_fileArray addObject:strOfFile];
                        
                        if(rest){
                            [keyDictRe setObject:rest forKey:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]];
                        }
                        
                        //                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        //                            [self download:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]] path:[NSString stringWithFormat:@"Library/Caches/ephoto/%@/%@",imgInfo.bookVersion,fileName]];
                        //                            NSLog(@"==%@",[NSString stringWithFormat:@"Library/Caches/ephoto/%@/%@",imgInfo.name,fileName]);
                        //                        });
                        
                    }
                }
                
                
            }

#pragma mark 高端仪器
                if ([highbookInfo.type integerValue]==2) {
                highbookInfo.ID = [dict objectForKey:@"id"];
                highbookInfo.imagesIDs = [dict objectForKey:@"imagesIds"];
                highbookInfo.imgUrl = [dict objectForKey:@"imgUrl"];
                highbookInfo.name = [dict objectForKey:@"name"];
                highbookInfo.compId = [dict objectForKey:@"compId"];
                NSLog(@"--%@",highbookInfo.name);
                [self insertHighDB:highbookInfo];
                [self createDirectoryPath:@"cover2" withName:highbookInfo.name];
                //                if ([highbookInfo.imgUrl rangeOfString:@"resources/img"].location != NSNotFound ) {
                //
                //                    NSArray * array = [highbookInfo.imgUrl componentsSeparatedByString:@"resources/img/"];
                //                    NSString *fileName = [array objectAtIndex:1];
                //
                //                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //                        [self download:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageUrl,highbookInfo.imgUrl]] path:[NSString stringWithFormat:@"Library/Caches/cover2/%@/%@",highbookInfo.name,fileName]];
                //                        NSLog(@"==%@",[NSString stringWithFormat:@"Library/Caches/cover2/%@/%@",highbookInfo.name,fileName]);
                //                    });
                //                }
                
                
                [self deleteBookInfo:highbookInfo.name];
                NSArray *imageArray=[dict objectForKey:@"images"];
                NSLog(@"%d---",imageArray.count);
                for (NSDictionary *imageDic in imageArray) {
                    HImageInfo *imgInfo=[[HImageInfo alloc] init];
                    //  imgInfo.type=NULL;
                    imgInfo.imgUrl=[imageDic objectForKey:@"imgUrl"];
                    imgInfo.bookVersion=highbookInfo.name;
                    NSArray *array=[imageDic objectForKey:@"link"];
                    for (NSDictionary *linkDic in array) {
                        imgInfo.linkurl=[linkDic objectForKey:@"link"]  ;
                        imgInfo.startX=[[linkDic objectForKey:@"startX"] stringValue] ;
                        imgInfo.startY=[[linkDic objectForKey:@"startY"] stringValue];
                        imgInfo.endX=[[linkDic objectForKey:@"endX"] stringValue];
                        imgInfo.endY=[[linkDic objectForKey:@"endY"] stringValue];
                        [self insertHighBookInfo:imgInfo];
                    }
                    [self insertHighBookInfo:imgInfo];
                    
                    [self createDirectoryPath:@"ephoto" withName:imgInfo.bookVersion];
                    
                    
                    if ([imgInfo.imgUrl rangeOfString:@"resources/images"].location != NSNotFound ) {
                        
                        NSArray * array = [imgInfo.imgUrl componentsSeparatedByString:@"resources/images/"];
                        NSString *fileName = [array objectAtIndex:1];
                        
                        
                        
                        //                     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        //                         ASIHTTPRequest*rest =  [[DownloadModel sharedDownloadModel]downloadFile:self url:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl] folder:imgInfo.bookVersion tag:1 fileType:1];
                        //
                        //                         if(rest){
                        //                             [keyDictRe setObject:rest forKey:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]];
                        //                         }
                        //
                        //                     });
                        
                        ASIHTTPRequest*rest =  [[DownloadModel sharedDownloadModel]downloadFile:self url:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl] folder:imgInfo.bookVersion tag:1 fileType:1];
                        [self findeNoDonwloadFile:[DownloadModel getPath:imgInfo.bookVersion nsurl:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]]];
                        NSString *strOfFile=[DownloadModel getPath:imgInfo.bookVersion nsurl:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]];
                        [_fileArray addObject:strOfFile];
                        
                        if(rest){
                            [keyDictRe setObject:rest forKey:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]];
                        }
                        //                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        //                            [self download:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]] path:[NSString stringWithFormat:@"Library/Caches/ephoto/%@/%@",imgInfo.bookVersion,fileName]];
                        //                            NSLog(@"==%@",[NSString stringWithFormat:@"Library/Caches/ephoto/%@/%@",imgInfo.name,fileName]);
                        //                        });
                        
                        //                        [self download:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]] path:[NSString stringWithFormat:@"Library/Caches/ephoto/%@/%@",imgInfo.bookVersion,fileName]];
                        //                            NSLog(@"==%@",[NSString stringWithFormat:@"Library/Caches/ephoto/%@/%@",imgInfo.name,fileName]);
                        
                    }
                }
                
                
            }

            
#pragma mark 圣梦资讯
            if ([mationInfo.type integerValue]==0) {
                mationInfo.ID=[dict objectForKey:@"id"];
                 mationInfo.imagesIDs=[dict objectForKey:@"imagesIds"];
                 mationInfo.imgUrl=[dict objectForKey:@"imgUrl"];
                mationInfo.name=[dict objectForKey:@"name"];
                mationInfo.compId=[dict objectForKey:@"compId"];
                [self insertCompInDB2:mationInfo];
                [self createDirectoryPath:@"informationCover" withName:mationInfo.name];
//            if ([mationInfo.imgUrl rangeOfString:@"resources/img"].location!=NSNotFound) {
//                NSArray * array = [mationInfo.imgUrl componentsSeparatedByString:@"resources/img/"];
//                NSString *fileName = [array objectAtIndex:1];
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    [self download:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageUrl,mationInfo.imgUrl]] path:[NSString stringWithFormat:@"Library/Caches/informationCover/%@/%@",mationInfo.name,fileName]];
//                    NSLog(@"==%@",[NSString stringWithFormat:@"Library/Caches/informationCover/%@/%@",mationInfo.name,fileName]);
//                });
//            }
            
                [self deleteBookInfoOfInformation:mationInfo.name];
             NSArray *imageArray=[dict objectForKey:@"images"];
            for (NSDictionary *imageDic in imageArray) {
                IImageInfo *imgInfo=[[IImageInfo alloc] init];
                imgInfo.type=NULL;
                imgInfo.imgUrl=[imageDic objectForKey:@"imgUrl"];
                imgInfo.bookVersion=mationInfo.name;
                NSArray *array=[imageDic objectForKey:@"link"];
                for (NSDictionary *linkDic in array) {
                    
                    imgInfo.linkurl=[linkDic objectForKey:@"link"]  ;
                    imgInfo.startX=[[linkDic objectForKey:@"startX"] stringValue] ;
                    imgInfo.startY=[[linkDic objectForKey:@"startY"] stringValue];
                    imgInfo.endX=[[linkDic objectForKey:@"endX"] stringValue];
                    imgInfo.endY=[[linkDic objectForKey:@"endY"] stringValue];
                    [self insertBookInfo2:imgInfo];
                }
                [self insertBookInfo2:imgInfo];
                [self createDirectoryPath:@"ephoto" withName:imgInfo.bookVersion];
                if ([imgInfo.imgUrl rangeOfString:@"resources/images"].location != NSNotFound ) {
                    
                    NSArray * array = [imgInfo.imgUrl componentsSeparatedByString:@"resources/images/"];
                    NSString *fileName = [array objectAtIndex:1];
                   
                    ASIHTTPRequest*rest =  [[DownloadModel sharedDownloadModel]downloadFile:self url:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl] folder:imgInfo.bookVersion tag:1 fileType:1];
                    
                    [self findeNoDonwloadFile:[DownloadModel getPath:imgInfo.bookVersion nsurl:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]]];
                    NSString *strOfFile=[DownloadModel getPath:imgInfo.bookVersion nsurl:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]];
                    [_fileArray addObject:strOfFile];
                    
                    
                    if(rest){
                        [keyDictRe setObject:rest forKey:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]];
                    }
                   
                    
                }
            
            }
        }
#pragma mark 圣梦画册
           // NSLog(@"==%@",bookInfo.type);
            if ([bookInfo.type integerValue]==1) {
                bookInfo.ID = [dict objectForKey:@"id"];
                bookInfo.imagesIDs = [dict objectForKey:@"imagesIds"];
                bookInfo.imgUrl = [dict objectForKey:@"imgUrl"];
                bookInfo.name = [dict objectForKey:@"name"];
                bookInfo.compId = [dict objectForKey:@"compId"];
                NSLog(@"--%@",bookInfo.name);
                [self insertCompInDB:bookInfo];
                [self createDirectoryPath:@"cover" withName:bookInfo.name];
                
//                if ([bookInfo.imgUrl rangeOfString:@"resources/img"].location != NSNotFound ) {
//                    
//                    NSArray * array = [bookInfo.imgUrl componentsSeparatedByString:@"resources/img/"];
//                    NSString *fileName = [array objectAtIndex:1];
//                
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [self download:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageUrl,bookInfo.imgUrl]] path:[NSString stringWithFormat:@"Library/Caches/cover/%@/%@",bookInfo.name,fileName]];
//        NSLog(@"==%@",[NSString stringWithFormat:@"Library/Caches/cover/%@/%@",bookInfo.name,fileName]);
//        });
//         
//                }
                
                
                [self deleteBookInfoOfEBook:bookInfo.name];
              NSArray *imageArray=[dict objectForKey:@"images"];
                NSLog(@"%d---",imageArray.count);
                for (NSDictionary *imageDic in imageArray) {
                    ImageInfo *imgInfo=[[ImageInfo alloc] init];
                    imgInfo.type=NULL;
                    imgInfo.imgUrl=[imageDic objectForKey:@"imgUrl"];
                    imgInfo.bookVersion=bookInfo.name;
                    
                    NSArray *array=[imageDic objectForKey:@"link"];
                    for (NSDictionary *linkDic in array) {
                        
                        imgInfo.linkurl=[linkDic objectForKey:@"link"]  ;
                        imgInfo.startX=[[linkDic objectForKey:@"startX"] stringValue] ;
                        imgInfo.startY=[[linkDic objectForKey:@"startY"] stringValue];
                        imgInfo.endX=[[linkDic objectForKey:@"endX"] stringValue];
                        imgInfo.endY=[[linkDic objectForKey:@"endY"] stringValue];
                        [self insertBookInfo:imgInfo];
                    }
                    [self insertBookInfo:imgInfo];
                    [self createDirectoryPath:@"ephoto" withName:imgInfo.bookVersion];
                    if ([imgInfo.imgUrl rangeOfString:@"resources/images"].location != NSNotFound ) {
                        
                        NSArray * array = [imgInfo.imgUrl componentsSeparatedByString:@"resources/images/"];
                        NSString *fileName = [array objectAtIndex:1];
                        
                                               ASIHTTPRequest*rest =  [[DownloadModel sharedDownloadModel]downloadFile:self url:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl] folder:imgInfo.bookVersion tag:1 fileType:1];
                        [self findeNoDonwloadFile:[DownloadModel getPath:imgInfo.bookVersion nsurl:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]]];
                        NSString *strOfFile=[DownloadModel getPath:imgInfo.bookVersion nsurl:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]];
                        [_fileArray addObject:strOfFile];
                        
                        if(rest){
                            [keyDictRe setObject:rest forKey:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]];
                        }
                      

//                   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                       [self download:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]] path:[NSString stringWithFormat:@"Library/Caches/ephoto/%@/%@",imgInfo.bookVersion,fileName]];
//                       NSLog(@"==%@",[NSString stringWithFormat:@"Library/Caches/ephoto/%@/%@",bookInfo.name,fileName]);
//                   });
                    
                    }
                }
                [booInfoArray addObject:bookInfo];
                
            }
            
        }
        [SVProgressHUD dismiss];
        
        
       self.currentSize = [[DownloadModel sharedDownloadModel] countOfqueue];
        if (self.currentSize < 2) {
          //  [SVProgressHUD dismiss];
          //  [SVProgressHUD showSuccessWithStatus:@"已是最新数据" duration:3];
            [SVProgressHUD showSuccessWithStatus:@"已是最新数据"];
            self.LhprogressView.hidden = YES;
            self.lhuilable.hidden = YES;
            [self updateZhuangTai:^(NSString *string) {
                [SVProgressHUD showSuccessWithStatus:@"已遍历数据"];
                self.alreadyBianLi=@"1";
                [[NSNotificationCenter defaultCenter] postNotificationName:@"btnChange" object:self.alreadyBianLi];
                
            }];

        }
      
       //        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
//        [user setObject:@"0" forKey:@"dataupdata"];
    self.LhprogressView.progress = 0.0;
    }];
    
//    [SVProgressHUD dismiss];

}
- (void)allDownLoad4
{
    
    
    
}
- (void)didImageDownloaded:(NSString*)path url:(NSString*)url{
    [keyDictRe removeObjectForKey:url];
    ASIHTTPRequest*rest = [keyDictRe objectForKey:url];
    [DownloadModel deleteRequest:rest];
    
    float num = self.currentSize;
    float size = [keyDictRe allKeys].count;
    self.LhprogressView.progress =(num-size)/num;
    self.lhuilable.text = [NSString stringWithFormat:@"%0.2f%s",self.LhprogressView.progress*100,"%"];
     [SVProgressHUD showProgress:(num-size)/num status:@"下载中，请稍等" maskType:SVProgressHUDMaskTypeNone];
    
    if (size < 2) {
        [SVProgressHUD dismiss];
         [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];
        [self updateZhuangTai:^(NSString *string) {
            
        }];
    }
   
}
-(void)dismiss{
    self.LhprogressView.hidden = YES;
    self.lhuilable.hidden = YES;
   // [SVProgressHUD showSuccessWithStatus:@"下载完成" duration:3];
    [self updateZhuangTai:^(NSString *string) {
        if ([string intValue]==1) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"数据更新完成" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            self.alreadyBianLi=@"1";
            [[NSNotificationCenter defaultCenter] postNotificationName:@"btnChange" object:self.alreadyBianLi];
        }
    }];

    [SVProgressHUD showSuccessWithStatus:@"下载完成"];
}
- (void)allDownLoad2
{
    
  //  [SVProgressHUD showWithStatus:@"下载中，请稍等"];
    if(!keyDictRe){
        keyDictRe = [NSMutableDictionary dictionaryWithCapacity:200];
    }
     [[DownloadModel sharedDownloadModel]setP:_progressView];
    NSLog(@"点击");
#pragma mark 高端仪器
    [self complete:^(NSArray *array) {
        for (int i=0; i<array.count; i++){
        NSDictionary *dict=[array objectAtIndex:i];
            HighInfo *highbookInfo=[[HighInfo alloc] init];
            highbookInfo.type = [dict objectForKey:@"type"];
            if ([highbookInfo.type integerValue]==2) {
                highbookInfo.ID = [dict objectForKey:@"id"];
                highbookInfo.imagesIDs = [dict objectForKey:@"imagesIds"];
                highbookInfo.imgUrl = [dict objectForKey:@"imgUrl"];
                highbookInfo.name = [dict objectForKey:@"name"];
                highbookInfo.compId = [dict objectForKey:@"compId"];
                NSLog(@"--%@",highbookInfo.name);
                [self insertHighDB:highbookInfo];
                [self createDirectoryPath:@"cover2" withName:highbookInfo.name];
//                if ([highbookInfo.imgUrl rangeOfString:@"resources/img"].location != NSNotFound ) {
//                    
//                    NSArray * array = [highbookInfo.imgUrl componentsSeparatedByString:@"resources/img/"];
//                    NSString *fileName = [array objectAtIndex:1];
//                    
//                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                        [self download:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageUrl,highbookInfo.imgUrl]] path:[NSString stringWithFormat:@"Library/Caches/cover2/%@/%@",highbookInfo.name,fileName]];
//                        NSLog(@"==%@",[NSString stringWithFormat:@"Library/Caches/cover2/%@/%@",highbookInfo.name,fileName]);
//                    });
//                    
//                }
                
                
               [self deleteBookInfo:highbookInfo.name];
                NSArray *imageArray=[dict objectForKey:@"images"];
                NSLog(@"%d---",imageArray.count);
                for (NSDictionary *imageDic in imageArray) {
                    HImageInfo *imgInfo=[[HImageInfo alloc] init];
                  //  imgInfo.type=NULL;
                    imgInfo.imgUrl=[imageDic objectForKey:@"imgUrl"];
                    imgInfo.bookVersion=highbookInfo.name;
                    NSArray *array=[imageDic objectForKey:@"link"];
                    for (NSDictionary *linkDic in array) {
                        
                        imgInfo.linkurl=[linkDic objectForKey:@"link"]  ;
                        imgInfo.startX=[[linkDic objectForKey:@"startX"] stringValue] ;
                        imgInfo.startY=[[linkDic objectForKey:@"startY"] stringValue];
                        imgInfo.endX=[[linkDic objectForKey:@"endX"] stringValue];
                        imgInfo.endY=[[linkDic objectForKey:@"endY"] stringValue];
                        
                    }
                    [self insertHighBookInfo:imgInfo];
                   
                    [self createDirectoryPath:@"ephoto" withName:imgInfo.bookVersion];
                   
                    
                    if ([imgInfo.imgUrl rangeOfString:@"resources/images"].location != NSNotFound ) {
                        
                        NSArray * array = [imgInfo.imgUrl componentsSeparatedByString:@"resources/images/"];
                        NSString *fileName = [array objectAtIndex:1];
                        
                        
                       
//                     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                         ASIHTTPRequest*rest =  [[DownloadModel sharedDownloadModel]downloadFile:self url:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl] folder:imgInfo.bookVersion tag:1 fileType:1];
//                         
//                         if(rest){
//                             [keyDictRe setObject:rest forKey:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]];
//                         }
//
//                     });
                       ASIHTTPRequest*rest =  [[DownloadModel sharedDownloadModel]downloadFile:self url:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl] folder:imgInfo.bookVersion tag:1 fileType:1];
                        
                        if(rest){
                            [keyDictRe setObject:rest forKey:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]];
                        }
//                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                            [self download:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]] path:[NSString stringWithFormat:@"Library/Caches/ephoto/%@/%@",imgInfo.bookVersion,fileName]];
//                            NSLog(@"==%@",[NSString stringWithFormat:@"Library/Caches/ephoto/%@/%@",imgInfo.name,fileName]);
//                        });
                        
//                        [self download:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]] path:[NSString stringWithFormat:@"Library/Caches/ephoto/%@/%@",imgInfo.bookVersion,fileName]];
                        //                            NSLog(@"==%@",[NSString stringWithFormat:@"Library/Caches/ephoto/%@/%@",imgInfo.name,fileName]);

                    }
                }
                
                
            }

        }
    }];
    
    [_progressView removeFromSuperview];
 //    [SVProgressHUD dismiss];
}
- (void)allDownLoad3
{
    
    if(!keyDictRe){
        keyDictRe = [NSMutableDictionary dictionaryWithCapacity:200];
    }
    [[DownloadModel sharedDownloadModel]setP:_progressView];

    [self complete:^(NSArray *array) {
        for (int i=0; i<array.count; i++){
            NSDictionary *dict=[array objectAtIndex:i];
            ProjectInfo *project=[[ProjectInfo alloc] init];
            project.type = [dict objectForKey:@"type"];
            if ([project.type integerValue]==4) {
                project.ID = [dict objectForKey:@"id"];
                project.imagesIDs = [dict objectForKey:@"imagesIds"];
                project.imgUrl = [dict objectForKey:@"imgUrl"];
                project.name = [dict objectForKey:@"name"];
                project.compId = [dict objectForKey:@"compId"];
                NSLog(@"--%@",project.name);
                [self insertProjectDB:project];
                [self createDirectoryPath:@"cover1" withName:project.name];
//                if ([project.imgUrl rangeOfString:@"resources/img"].location != NSNotFound ) {
//                    
//                    NSArray * array = [project.imgUrl componentsSeparatedByString:@"resources/img/"];
//                    NSString *fileName = [array objectAtIndex:1];
//                    
//                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                        [self download:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageUrl,project.imgUrl]] path:[NSString stringWithFormat:@"Library/Caches/cover1/%@/%@",project.name,fileName]];
//                        NSLog(@"==%@",[NSString stringWithFormat:@"Library/Caches/cover1/%@/%@",project.name,fileName]);
//                    });
//                    
//                }
                
                [self deleteBookInfoOfProject:project.name];
                NSArray *imageArray=[dict objectForKey:@"images"];
                NSLog(@"%d---",imageArray.count);
                for (NSDictionary *imageDic in imageArray) {
                    PImageInfo *imgInfo=[[PImageInfo alloc] init];
                    //  imgInfo.type=NULL;
                    imgInfo.imgUrl=[imageDic objectForKey:@"imgUrl"];
                    imgInfo.bookVersion=project.name;
                    
                    NSArray *array=[imageDic objectForKey:@"link"];
                    for (NSDictionary *linkDic in array) {
                        
                        imgInfo.linkurl=[linkDic objectForKey:@"link"]  ;
                        imgInfo.startX=[[linkDic objectForKey:@"startX"] stringValue] ;
                        imgInfo.startY=[[linkDic objectForKey:@"startY"] stringValue];
                        imgInfo.endX=[[linkDic objectForKey:@"endX"] stringValue];
                        imgInfo.endY=[[linkDic objectForKey:@"endY"] stringValue];
                        
                    }   
                   
                    [self insertPImageBookInfo:imgInfo];
                    [self createDirectoryPath:@"ephoto" withName:imgInfo.bookVersion];
                    if ([imgInfo.imgUrl rangeOfString:@"resources/images"].location != NSNotFound ) {
                        
                        NSArray * array = [imgInfo.imgUrl componentsSeparatedByString:@"resources/images/"];
                        NSString *fileName = [array objectAtIndex:1];
                                               ASIHTTPRequest*rest =  [[DownloadModel sharedDownloadModel]downloadFile:self url:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl] folder:imgInfo.bookVersion tag:1 fileType:1];
                        
                        if(rest){
                            [keyDictRe setObject:rest forKey:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]];
                        }
                       
//                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                            [self download:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageUrl,imgInfo.imgUrl]] path:[NSString stringWithFormat:@"Library/Caches/ephoto/%@/%@",imgInfo.bookVersion,fileName]];
//                            NSLog(@"==%@",[NSString stringWithFormat:@"Library/Caches/ephoto/%@/%@",imgInfo.name,fileName]);
//                        });
                        
                    }
                }
                
                
            }
            
        }
    }];

    
    
    
    
    
}
- (void)popAlertView
{
//    NSString *versionStr;
//    [self getVersion];
    [self updateVersion];
    
//    NSLog(@"当前版本为：%@ ipa版本为：%@",self.myVersion,self.ipaVersion);
//    if (![self.myVersion isEqualToString:self.ipaVersion]) {
//        versionStr=@"是";
//    }else{
//        versionStr=@"否";
//    }
//    NSString *versionIsNeed=[NSString stringWithFormat:@"版本是否需要更新：%@",versionStr];
//    if ([versionStr isEqualToString:@"是"]) {
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:versionIsNeed delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//    }
    
    
    
    
}
- (NSString *)getVersion
{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString* version = [infoDict objectForKey:@"CFBundleVersion"];
    self.myVersion=version;
    return version;
}

- (void)updateVersion
{
    if (![self isConnectionAvailable]) {
        return;
    }
    NSDictionary * dict = [[EBookManage shardSingleton] jsonParseWithURL:[NSString stringWithFormat:@"%@updateNewVersionToIpad",LocationIp]];
    NSLog(@"the ipaversion is %@",[dict objectForKey:@"ipaVersion"]);
    float version = [[dict objectForKey:@"ipaVersion"] floatValue];
    NSLog(@"the new version is %@",[self getVersion]);
    
    NSString * versions = [self getVersion];
    self.ipaVersion=[dict objectForKey:@"ipaVersion"];
  
#define mark 重新得到update
    [self getStoreNum:^(NSArray *array) {
        NSDictionary *dic=[array objectAtIndex:0];
        NSDictionary *dic2=[dic objectForKey:@"data"];
        self.data_updata=[dic2 objectForKey:@"data_update"];
        
    }];

    if (!versions) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"发现新版本,是否更新？" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
        [alert setTag:12];
        alert.delegate=self;
        [alert show];
        return;
    }
    float localVersion = [versions floatValue];
    if (version > localVersion) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"发现新版本,是否更新？" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
        [alert setTag:12];
        alert.delegate=self;
        [alert show];
    }else{
         [self updateShuJu];
    }
   // else
//    {
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"当前版本已是最新版本" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//    }
}
//alert点击
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==12) {
        if (buttonIndex==0) {
            [self upDAteVerison];
           // [self updateShuJu];
        }else{
           // [self performSelector:@selector(updateShuJu) withObject:nil afterDelay:2];
            [self updateShuJu];
        }
    }
    if (alertView.tag==1000) {
        if (buttonIndex==0) {
            NSUserDefaults *users=[NSUserDefaults standardUserDefaults];
            [users setObject:@"Y" forKey:@"upData"];
            [SVProgressHUD showWithStatus:@"下载中，请稍等" maskType:SVProgressHUDMaskTypeNone];
            //  MBProgressHUD *hud=[[MBProgressHUD alloc] init];
            //  [hud show:YES];
            [self allDownLoad:_progressView uilable:self.lhuilable];
            //        [self.view bringSubviewToFront:_stopBtn];
            //        [self.view addSubview: _progressView];
            //        self.lhuilable.hidden = NO;
            //        self.lhuilable.text = @"00.00%";
            //   [self performSelector:@selector(netWorkUse) withObject:self afterDelay:10];
            NSLog(@"begin");
        }
        
        
    }

    
}
-(void)complete:(void (^)(NSArray *array))complete
{
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@initAllDataToIpad",LocationIp]]];
    
    
    [request setCompletionBlock:^{
        
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:request.responseData   options:NSJSONReadingMutableContainers error:nil];
     //   NSLog(@"%@",dic);
        
        NSString *message=[dic objectForKey:@"message"] ;
        NSLog(@"%@",message);
        NSArray *dataArray=[dic objectForKey:@"data"] ;
        
            if (dataArray) {
                complete(dataArray);
            }
     
    }];
    [request startAsynchronous];
    

}

- (void)initDatabase
{
    
  NSString *sandBoxPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/EBook"];
    NSFileManager *manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath:sandBoxPath]) {
            NSLog(@"文件存在");
            __db = [[FMDatabase alloc] initWithPath:sandBoxPath];
            [__db setShouldCacheStatements:YES];
            [__db open];
        }else{
            NSLog(@"文件没找到");
        }

}
- (void)insertIntoCover:(EBookInfo *)info
{
    [__db executeUpdate:@"insert into cover (id,name,compId,imageIds,imgUrl) values (?,?,?,?,?);",info.ID,info.name,info.compId,info.imagesIDs,info.imgUrl];
    NSLog(@"%@,%@,%@,%@,%@",info.ID,info.name,info.compId,info.imagesIDs,info.imgUrl);
    NSLog(@"执行插入操作");
}
- (void)insertCompInDB:(EBookInfo *)info
{
    
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    NSString * dbPath = [self getDBPathOfEBook];
    if ([fileManager fileExistsAtPath:dbPath])
    {
        // open database
        sqlite3 * database;
        if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK)
        {
            NSLog(@"Failed to open news.dat database!");
            sqlite3_close(database);
        }
        else
        {
            sqlite3_stmt * stmt;
            
            NSString * execInsert = [NSString stringWithFormat:@"insert into cover  (id,name,imgUrl,compId,imageIds) values (?,?,?,?,?);"];
            NSLog(@"the execInsert is %@",execInsert);
            
            if (sqlite3_prepare(database, [execInsert UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                sqlite3_bind_int(stmt, 1, [info.ID intValue]);
                NSString *str1 = [NSString stringWithFormat:@"%@",info.name];
                sqlite3_bind_text(stmt, 2, [str1 UTF8String], -1, NULL);
                NSString *str2 = [NSString stringWithFormat:@"%@",info.imgUrl];
                sqlite3_bind_text(stmt, 3, [str2 UTF8String], -1, NULL);
                sqlite3_bind_int(stmt, 4, [info.compId intValue]);
                NSString *str = [NSString stringWithFormat:@"%@",info.imagesIDs];
                sqlite3_bind_text(stmt, 5,   [str UTF8String], -1, NULL);
            }
            if (sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"insert to  table Failed");
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
    
}
- (BOOL)insertBookInfo:(ImageInfo *)info
{
    BOOL execResultSuccess = NO;
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    NSString * dbPath = [self getDBPathOfEBook];
    if ([fileManager fileExistsAtPath:dbPath])
    {
        // open database
        sqlite3 * database;
        if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK)
        {
            NSLog(@"Failed to open news.dat database!");
            sqlite3_close(database);
        }
        else
        {
            sqlite3_stmt * stmt;
            int maxIndex = -1;
            NSString * execSelect = [NSString stringWithFormat:@"select max(id) from bookInfo"];
            NSString * execInsert = [NSString stringWithFormat:@"insert into bookInfo  (version,id,imgUrl,linkURL,startX,startY,endX,endY,imgid,type) values (?,?,?,?,?,?,?,?,?,?);"];
            NSLog(@"the execInsert is %@",execInsert);
            if (sqlite3_prepare(database, [execSelect UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                while (sqlite3_step(stmt) == SQLITE_ROW)
                {
                    maxIndex = sqlite3_column_int(stmt, 0);
                }
            }
            //NSLog(@"maxIndex = %d",maxIndex);
            
            if (sqlite3_prepare(database, [execInsert UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                sqlite3_bind_text(stmt, 1, [info.bookVersion UTF8String], -1, NULL);
                sqlite3_bind_int(stmt, 2, maxIndex+1);
                
                sqlite3_bind_text(stmt, 3,   [info.imgUrl  UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 4,   [info.linkurl UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 5,   [info.startX  UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 6,   [info.startY  UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 7,   [info.endX    UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 8,   [info.endY    UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 9,   [info.imagID  UTF8String], -1, NULL);
                //NSLog(@"the type is %@",[info.type    UTF8String]);
                // NSString * tmp = [info.type]
                sqlite3_bind_text(stmt, 10,  [info.type UTF8String], -1, NULL);
            }
            if (sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"insert to  table Failed");
            }
            else
            {
                execResultSuccess = YES;
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
    return execResultSuccess;
}
- (void)insertCompInDB2:(InformationInfo *)info
{
    
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    NSString * dbPath = [self getDBPathOfHigh];
    if ([fileManager fileExistsAtPath:dbPath])
    {
        // open database
        sqlite3 * database;
        if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK)
        {
            NSLog(@"Failed to open news.dat database!");
            sqlite3_close(database);
        }
        else
        {
            sqlite3_stmt * stmt;
            
            NSString * execInsert = [NSString stringWithFormat:@"insert into Information  (id,name,imgUrl,compId,imageIds) values (?,?,?,?,?);"];
            NSLog(@"the execInsert is %@",execInsert);
            
            if (sqlite3_prepare(database, [execInsert UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                sqlite3_bind_int(stmt, 1, [info.ID intValue]);
                NSString *str1 = [NSString stringWithFormat:@"%@",info.name];
                sqlite3_bind_text(stmt, 2, [str1 UTF8String], -1, NULL);
                NSString *str2 = [NSString stringWithFormat:@"%@",info.imgUrl];
                sqlite3_bind_text(stmt, 3, [str2 UTF8String], -1, NULL);
                sqlite3_bind_int(stmt, 4, [info.compId intValue]);
                NSString *str = [NSString stringWithFormat:@"%@",info.imagesIDs];
                sqlite3_bind_text(stmt, 5,   [str UTF8String], -1, NULL);
            }
            if (sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"insert to  table Failed");
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
    
}
- (BOOL)insertBookInfo2:(IImageInfo *)info
{
    BOOL execResultSuccess = NO;
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    NSString * dbPath = [self getDBPathOfHigh];
    if ([fileManager fileExistsAtPath:dbPath])
    {
        // open database
        sqlite3 * database;
        if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK)
        {
            NSLog(@"Failed to open news.dat database!");
            sqlite3_close(database);
        }
        else
        {
            sqlite3_stmt * stmt;
            int maxIndex = -1;
            NSString * execSelect = [NSString stringWithFormat:@"select max(id) from newsinfo"];
            NSString * execInsert = [NSString stringWithFormat:@"insert into newsinfo  (version,id,imgUrl,linkURL,startX,startY,endX,endY,type) values (?,?,?,?,?,?,?,?,?);"];
            NSLog(@"the execInsert is %@",execInsert);
            if (sqlite3_prepare(database, [execSelect UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                while (sqlite3_step(stmt) == SQLITE_ROW)
                {
                    maxIndex = sqlite3_column_int(stmt, 0);
                }
            }
            //NSLog(@"maxIndex = %d",maxIndex);
            
            if (sqlite3_prepare(database, [execInsert UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                sqlite3_bind_text(stmt, 1, [info.bookVersion UTF8String], -1, NULL);
                sqlite3_bind_int(stmt, 2, maxIndex+1);
                
                sqlite3_bind_text(stmt, 3, [info.imgUrl UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 4,   [info.linkurl UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 5,   [info.startX UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 6,   [info.startY UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 7,   [info.endX UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 8,   [info.endY UTF8String], -1, NULL);
                NSLog(@"%@",info.type);
                sqlite3_bind_int(stmt, 9, [info.type intValue]);
            }
            if (sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"insert to  table Failed");
            }
            else
            {
                execResultSuccess = YES;
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
    return execResultSuccess;
}
- (void)insertHighDB:(HighInfo *)info
{
    
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    NSString * dbPath = [self getDBPathOfHigh];
    if ([fileManager fileExistsAtPath:dbPath])
    {
        // open database
        sqlite3 * database;
        if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK)
        {
            NSLog(@"Failed to open news.dat database!");
            sqlite3_close(database);
        }
        else
        {
            sqlite3_stmt * stmt;
            
            NSString * execInsert = [NSString stringWithFormat:@"insert into cover  (id,name,imgUrl,compId,imageIds) values (?,?,?,?,?);"];
            NSLog(@"the execInsert is %@",execInsert);
            
            if (sqlite3_prepare(database, [execInsert UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                sqlite3_bind_int(stmt, 1, [info.ID intValue]);
                NSString *str1 = [NSString stringWithFormat:@"%@",info.name];
                sqlite3_bind_text(stmt, 2, [str1 UTF8String], -1, NULL);
                NSString *str2 = [NSString stringWithFormat:@"%@",info.imgUrl];
                sqlite3_bind_text(stmt, 3, [str2 UTF8String], -1, NULL);
                sqlite3_bind_int(stmt, 4, [info.compId intValue]);
                NSString *str = [NSString stringWithFormat:@"%@",info.imagesIDs];
                sqlite3_bind_text(stmt, 5,   [str UTF8String], -1, NULL);
            }
            if (sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"insert to  table Failed");
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
    
}
- (BOOL)insertHighBookInfo:(HImageInfo *)info
{
    BOOL execResultSuccess = NO;
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    NSString * dbPath = [self getDBPathOfHigh];
    if ([fileManager fileExistsAtPath:dbPath])
    {
        // open database
        sqlite3 * database;
        if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK)
        {
            NSLog(@"Failed to open news.dat database!");
            sqlite3_close(database);
        }
        else
        {
            sqlite3_stmt * stmt;
            int maxIndex = -1;
            NSString * execSelect = [NSString stringWithFormat:@"select max(id) from bookInfo"];
            NSString * execInsert = [NSString stringWithFormat:@"insert into bookInfo  (version,id,imgUrl,linkURL,startX,startY,endX,endY) values (?,?,?,?,?,?,?,?);"];
            NSLog(@"the execInsert is %@",execInsert);
            if (sqlite3_prepare(database, [execSelect UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                while (sqlite3_step(stmt) == SQLITE_ROW)
                {
                    maxIndex = sqlite3_column_int(stmt, 0);
                }
            }
            //NSLog(@"maxIndex = %d",maxIndex);
            
            if (sqlite3_prepare(database, [execInsert UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                sqlite3_bind_text(stmt, 1, [info.bookVersion UTF8String], -1, NULL);
                sqlite3_bind_int(stmt, 2, maxIndex+1);
                
                sqlite3_bind_text(stmt, 3, [info.imgUrl UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 4,   [info.linkurl UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 5,   [info.startX UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 6,   [info.startY UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 7,   [info.endX UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 8,   [info.endY UTF8String], -1, NULL);
            }
            if (sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"insert to  table Failed");
            }
            else
            {
                execResultSuccess = YES;
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
    return execResultSuccess;
}
- (void)insertProjectDB:(ProjectInfo *)info
{
    
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    NSString * dbPath = [self getDBPathOfProject];
    if ([fileManager fileExistsAtPath:dbPath])
    {
        // open database
        sqlite3 * database;
        if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK)
        {
            NSLog(@"Failed to open news.dat database!");
            sqlite3_close(database);
        }
        else
        {
            sqlite3_stmt * stmt;
            //            int maxIndex = -1;
            //            NSString * execSelect = [NSString stringWithFormat:@"select max(id) from P"];
            NSString * execInsert = [NSString stringWithFormat:@"insert into cover  (id,name,imgUrl,compId,imageIds) values (?,?,?,?,?);"];
            NSLog(@"the execInsert is %@",execInsert);
            //            if (sqlite3_prepare(database, [execSelect UTF8String], -1, &stmt, 0) == SQLITE_OK)
            //            {
            //                while (sqlite3_step(stmt) == SQLITE_ROW)
            //                {
            //                    maxIndex = sqlite3_column_int(stmt, 0);
            //                }
            //            }
            //NSLog(@"maxIndex = %d",maxIndex);
            
            if (sqlite3_prepare(database, [execInsert UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                sqlite3_bind_int(stmt, 1, [info.ID intValue]);
                NSString *str1 = [NSString stringWithFormat:@"%@",info.name];
                sqlite3_bind_text(stmt, 2, [str1 UTF8String], -1, NULL);
                NSString *str2 = [NSString stringWithFormat:@"%@",info.imgUrl];
                sqlite3_bind_text(stmt, 3, [str2 UTF8String], -1, NULL);
                sqlite3_bind_int(stmt, 4, [info.compId intValue]);
                NSString *str = [NSString stringWithFormat:@"%@",info.imagesIDs];
                sqlite3_bind_text(stmt, 5,   [str UTF8String], -1, NULL);
            }
            if (sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"insert to  table Failed");
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
    
}
- (BOOL)insertOrderInfo:(OrderInfo *)info
{
    BOOL execResultSuccess = NO;
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    NSString * dbPath = [self getDBPathOfProject];
    if ([fileManager fileExistsAtPath:dbPath])
    {
        // open database
        sqlite3 * database;
        if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK)
        {
            NSLog(@"Failed to open news.dat database!");
            sqlite3_close(database);
        }
        else
        {
            sqlite3_stmt * stmt;
            int maxIndex = -1;
            // NSString * execSelect = [NSString stringWithFormat:@"select max(id) from bookInfo"];
            NSString * execInsert = [NSString stringWithFormat:@"insert into OrderSale  (produce,type,counts,ID,name,price,rate,money,batch,skpmount) values (?,?,?,?,?,?,?,?,?,?);"];
            NSLog(@"the execInsert is %@",execInsert);
            //            if (sqlite3_prepare(database, [execSelect UTF8String], -1, &stmt, 0) == SQLITE_OK)
            //            {
            //                while (sqlite3_step(stmt) == SQLITE_ROW)
            //                {
            //                    maxIndex = sqlite3_column_int(stmt, 0);
            //                }
            //            }
            //NSLog(@"maxIndex = %d",maxIndex);
            
            if (sqlite3_prepare(database, [execInsert UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                sqlite3_bind_text(stmt, 1, [info.produce UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 2, [info.type UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 3, [info.counts UTF8String], -1, NULL);
                NSLog(@"the coutns is %@",info.counts);
                sqlite3_bind_text(stmt, 4, [info.ID UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 5, [info.name UTF8String], -1, NULL);
                
                sqlite3_bind_text(stmt, 6, [info.price UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 7, [info.rate UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 8, [info.money UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 9, [info.batch UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 10, [info.skpmount UTF8String], -1, NULL);
                
            }
            if (sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"insert to  table Failed");
            }
            else
            {
                execResultSuccess = YES;
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
    return execResultSuccess;
}
- (BOOL)insertPImageBookInfo:(PImageInfo *)info
{
    BOOL execResultSuccess = NO;
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    NSString * dbPath = [self getDBPathOfProject];
    if ([fileManager fileExistsAtPath:dbPath])
    {
        // open database
        sqlite3 * database;
        if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK)
        {
            NSLog(@"Failed to open news.dat database!");
            sqlite3_close(database);
        }
        else
        {
            sqlite3_stmt * stmt;
            int maxIndex = -1;
            NSString * execSelect = [NSString stringWithFormat:@"select max(id) from bookInfo"];
            NSString * execInsert = [NSString stringWithFormat:@"insert into bookInfo  (version,id,imgUrl,linkURL,startX,startY,endX,endY) values (?,?,?,?,?,?,?,?);"];
            NSLog(@"the execInsert is %@",execInsert);
            if (sqlite3_prepare(database, [execSelect UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                while (sqlite3_step(stmt) == SQLITE_ROW)
                {
                    maxIndex = sqlite3_column_int(stmt, 0);
                }
            }
            //NSLog(@"maxIndex = %d",maxIndex);
            
            if (sqlite3_prepare(database, [execInsert UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                sqlite3_bind_text(stmt, 1, [info.bookVersion UTF8String], -1, NULL);
                sqlite3_bind_int(stmt, 2, maxIndex+1);
                
                sqlite3_bind_text(stmt, 3, [info.imgUrl UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 4, [info.linkurl UTF8String], -1, NULL);
//                sqlite3_bind_text(stmt, 5, [info.startX UTF8String], -1, NULL);
//                sqlite3_bind_text(stmt, 6, [info.startY UTF8String], -1, NULL);
//                sqlite3_bind_text(stmt, 7, [info.endX UTF8String], -1, NULL);
//                sqlite3_bind_text(stmt, 8,   [info.endY UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 5, [info.startX UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 6, [info.startY UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 7, [info.endX UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 8,   [info.endY UTF8String], -1, NULL);

            }
            if (sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"insert to  table Failed");
            }
            else
            {
                execResultSuccess = YES;
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
    return execResultSuccess;
}

//获取数据库文件(Bbook)
- (NSString *)getDBPathOfEBook
{
    NSString * docsDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * dbPath = [docsDir stringByAppendingPathComponent:@"EBook"];
    NSLog(@"the path is %@",dbPath);
    // NSString * dbPath = [modulesInUseDir stringByAppendingPathComponent:@"news.dat"];
    return dbPath;
}
//获取数据库文件(High)
- (NSString *)getDBPathOfHigh
{
    NSString * docsDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * dbPath = [docsDir stringByAppendingPathComponent:@"High"];
    NSLog(@"the path is %@",dbPath);
    // NSString * dbPath = [modulesInUseDir stringByAppendingPathComponent:@"news.dat"];
    return dbPath;
}
//获取数据库文件(Project)
- (NSString *)getDBPathOfProject
{
    NSString * docsDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * dbPath = [docsDir stringByAppendingPathComponent:@"Project"];
    NSLog(@"the path is %@",dbPath);
    // NSString * dbPath = [modulesInUseDir stringByAppendingPathComponent:@"news.dat"];
    return dbPath;
}

- (void)creatrPath:(NSString *)url withCoverName:(NSString *)name
{
    NSString * path;
    NSArray * dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString * documentDirectory = [dir objectAtIndex:0];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString * fileName;
    
    if ([url rangeOfString:@"resources/img"].location != NSNotFound ) {
        
        NSString * dirPath = [documentDirectory stringByAppendingPathComponent:@"cover"];
        path = [dirPath stringByAppendingPathComponent:name];
        
        NSArray * array = [url componentsSeparatedByString:@"resources/img/"];
        fileName = [array objectAtIndex:1];
    }
    else if ([url rangeOfString:@"resources/images"].location != NSNotFound )
    {
        NSString * dirPath = [documentDirectory stringByAppendingPathComponent:@"ephoto"];
        path = [dirPath stringByAppendingPathComponent:name];
        
        NSArray * array = [url componentsSeparatedByString:@"resources/images/"];
        
        fileName = [array objectAtIndex:1];
    }
    else
    {
        return;
    }
    
    if (![fileManager fileExistsAtPath:path])
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    }
    NSString * filePath = [path stringByAppendingPathComponent:fileName];
    if ([fileManager fileExistsAtPath:filePath])
    {
        NSLog(@"the file path is %@ exists",filePath);
        return;
    }
 //   [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
}
- (void)download:(NSURL *)url path:(NSString *)pathStr
{
   
//    _queue = [[ASINetworkQueue alloc] init];
//    //设置支持较高精度的进度追踪
//    [_queue setShowAccurateProgress:YES];
//    //启动
//    //启动后，添加到队列的请求会自动执行
//    [_queue go];
    
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
  //  request.timeOutSeconds = 30;
    NSArray * dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString * documentDirectory = [dir objectAtIndex:0];
    NSString * dirPath = [documentDirectory stringByAppendingPathComponent:@"down"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dirPath])
    {
        [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }

    // 设置文件下载的临时路径
  //  NSString *tempPath = [NSHomeDirectory() stringByAppendingPathComponent:dirPath];
    
    request.temporaryFileDownloadPath = dirPath;
    
    
    // 设置文件下载完成时的路径
    NSString *destinationPath = [NSHomeDirectory() stringByAppendingPathComponent:pathStr];
    
    request.downloadDestinationPath = destinationPath;
    
    // 支持断点下载
    request.allowResumeForFileDownloads = YES;
    
    // 获取下载进度的
    request.downloadProgressDelegate = self;
    
    [request startAsynchronous];
    [_queue addOperation:request];
    
    // 如果请求发出去之后但是数据没有过来,这时点击了返回按钮,同时还需要将未完成的那个请求取消掉并且清空代理.
  //      [request clearDelegatesAndCancel];
    
}
- (void)stopDownLoad
{
    NSArray*allKeys = [keyDictRe allKeys];
    for(int i = 0;i < allKeys.count;i++){
        ASIHTTPRequest *request = [keyDictRe objectForKey:allKeys[i]];
        if(request){
            [request cancelAuthentication];
        }
    }
    [keyDictRe removeAllObjects];
    
    //operations方法返回队列里的所有请求，但我们只有一个请求
  //  ASIHTTPRequest *request = [[_queue operations] objectAtIndex:0];
    //  [request clearDelegatesAndCancel];
}
//- (void)requestFinished:(ASIHTTPRequest *)request
//{
//    NSLog(@"123321");
//    [request clearDelegatesAndCancel];
//}
- (void)setProgress:(float)newProgress
{
//    NSLog(@"进度  %f",newProgress);
//    _progressView=[[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
//    _progressView.frame=CGRectMake(100, 100, 100, 10);
//    //进度条
//    _progressView.progressTintColor=[UIColor grayColor];
//    
//    _progressView.alpha = 1.0f;
//    _progressView.progress=0;//赋值为0
//    [_progressView setProgress:newProgress];
//    [self.view addSubview:_progressView];

}

- (BOOL)deleteBookInfo:(NSString *)moduleID
{
    BOOL execResultSuccess = NO;
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    NSString * dbPath = [self getDBPathOfHigh];
    if ([fileManager fileExistsAtPath:dbPath])
    {
        // open database
        sqlite3 * database;
        if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK)
        {
            sqlite3_close(database);
        }
        else
        {
            sqlite3_stmt * stmt;
            NSString * execDelete = @"delete from bookInfo where version = ?";
            if (sqlite3_prepare(database, [execDelete UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                sqlite3_bind_text(stmt, 1, [moduleID UTF8String], -1, NULL);
                
            }
            if (sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"delete from bookInfo table Failed");
            }
            else
            {
                execResultSuccess = YES;
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
	
	return execResultSuccess;
}
- (BOOL)deleteBookInfoOfInformation:(NSString *)moduleID
{
    BOOL execResultSuccess = NO;
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    NSString * dbPath = [self getDBPathOfHigh];
    if ([fileManager fileExistsAtPath:dbPath])
    {
        // open database
        sqlite3 * database;
        if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK)
        {
            sqlite3_close(database);
        }
        else
        {
            sqlite3_stmt * stmt;
            NSString * execDelete = @"delete from newsinfo where version = ?";
            if (sqlite3_prepare(database, [execDelete UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                sqlite3_bind_text(stmt, 1, [moduleID UTF8String], -1, NULL);
                
            }
            if (sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"delete from newsinfo table Failed");
            }
            else
            {
                execResultSuccess = YES;
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
	
	return execResultSuccess;
}
- (BOOL)deleteBookInfoOfEBook:(NSString *)moduleID
{
    BOOL execResultSuccess = NO;
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    NSString * dbPath = [self getDBPathOfEBook];
    if ([fileManager fileExistsAtPath:dbPath])
    {
        // open database
        sqlite3 * database;
        if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK)
        {
            sqlite3_close(database);
        }
        else
        {
            sqlite3_stmt * stmt;
            NSString * execDelete = @"delete from bookInfo where version = ?";
            if (sqlite3_prepare(database, [execDelete UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                sqlite3_bind_text(stmt, 1, [moduleID UTF8String], -1, NULL);
                
            }
            if (sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"delete from bookInfo table Failed");
            }
            else
            {
                execResultSuccess = YES;
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
	
	return execResultSuccess;
}
- (BOOL)deleteBookInfoOfProject:(NSString *)moduleID
{
    BOOL execResultSuccess = NO;
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    NSString * dbPath = [self getDBPathOfProject];
    if ([fileManager fileExistsAtPath:dbPath])
    {
        // open database
        sqlite3 * database;
        if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK)
        {
            sqlite3_close(database);
        }
        else
        {
            sqlite3_stmt * stmt;
            NSString * execDelete = @"delete from bookInfo where version = ?";
            if (sqlite3_prepare(database, [execDelete UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                sqlite3_bind_text(stmt, 1, [moduleID UTF8String], -1, NULL);
                
            }
            if (sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"delete from bookInfo table Failed");
            }
            else
            {
                execResultSuccess = YES;
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
	
	return execResultSuccess;
}


#pragma mark 创建文件夹
- (void)createDirectoryPath:(NSString *)upname withName:(NSString *)name
{
    NSArray * dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString * documentDirectory = [dir objectAtIndex:0];
    NSString * dirPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@/%@",upname,name]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dirPath])
    {
        [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    

}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    self.view.frame = CGRectMake(0, 0, 1024, 768);
    [UIView commitAnimations];
    
}


#pragma mark - creatSearchView
- (void)creatSearchView
{
    searchView = [[UIView alloc] initWithFrame:CGRectMake(50, 550, 1024, 104)];
    
    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"搜索无按钮.png"]];
    imageview.frame = CGRectMake(83, 0, 719, 60);
   // imageview.frame = CGRectMake(83, 0, 639-83, 60);
    [searchView addSubview:imageview];
    mybutton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    mybutton1.frame = CGRectMake(99, 10, 100, 43);
    mybutton1.tag = 1;
    [mybutton1 addTarget:self action:@selector(buttonChange:) forControlEvents:UIControlEventTouchUpInside];
    [mybutton1 setImage:[UIImage imageNamed:@"s-xmcxx_04.png"] forState:UIControlStateNormal];
    [searchView addSubview:mybutton1];
    mybutton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    mybutton2.frame = CGRectMake(199, 10, 102, 43);
    mybutton2.tag = 2;
    [mybutton2 addTarget:self action:@selector(buttonChange:) forControlEvents:UIControlEventTouchUpInside];
    [mybutton2 setImage:[UIImage imageNamed:@"建档按钮11_09.png"] forState:UIControlStateNormal];
    [searchView addSubview:mybutton2];
    
    searcktextField = [[UITextField alloc] initWithFrame:CGRectMake(320, 11, 370, 40)];
    //    searcktextField.backgroundColor = [UIColor redColor];
    searcktextField.delegate = self;
    searcktextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searcktextField.text = @"O";
#pragma mark 修改
    searcktextField.keyboardType=UIKeyboardTypeNumberPad;
    [searchView addSubview:searcktextField];
 //   [searchView resignFirstResponder];
    
    UIButton *touchButton = [UIButton buttonWithType:UIButtonTypeCustom];
   // touchButton.frame = CGRectMake(582, 11, 100, 40);
    touchButton.frame = CGRectMake(639, 11, 73, 40);
    [touchButton setImage:[UIImage imageNamed:@"查询按钮_点击前_08.png"] forState:UIControlStateNormal];
    [touchButton addTarget:self action:@selector(SearchbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:touchButton];
    
    UIButton *daButton = [UIButton buttonWithType:UIButtonTypeCustom];
   // daButton.frame = CGRectMake(690, 11, 60, 40);
     daButton.frame = CGRectMake(719, 11, 73, 40);
    [daButton setImage:[UIImage imageNamed:@"建档按钮_点击前_10.1.png"] forState:UIControlStateNormal];
    [daButton addTarget:self action:@selector(addDA) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:daButton];
    queryFlag = 1;
    [self.view addSubview:searchView];
    
    _searchView2=[[UIView alloc] initWithFrame:CGRectMake(50, 550, 1024, 104)];
    [_searchView2 setBackgroundColor:[UIColor clearColor]];
    _searchView2.hidden=YES;
    [self.view addSubview:_searchView2];
    //输入框image
     _kuangImageView=[[UIImageView alloc] initWithFrame:CGRectMake(83, 0, 719, 60)];
    [_kuangImageView setImage:[UIImage imageNamed:@"搜索无按钮.png"]];
    [_searchView2 addSubview:_kuangImageView];
    
    //切换Btn
  //  _swichBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [_swichBtn setFrame:CGRectMake(860, 561, 100, 40)];
//    [_swichBtn setImage:[UIImage imageNamed:@"精确查询.png"] forState:UIControlStateNormal];
//    [_swichBtn setImage:[UIImage imageNamed:@"普通查询.png"] forState:UIControlStateSelected];
//    [_swichBtn addTarget:self action:@selector(swichBtn) forControlEvents:UIControlEventTouchUpInside];
 //   [self.view addSubview:_swichBtn];
    
    //白线
    _lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(133, 510, 719, 2)];
    _lineLabel.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_lineLabel];
    
    //红线
    
    _hotLineLabel=[[UILabel alloc] initWithFrame:CGRectMake(1024/2-120, 510, 120, 2)];
    [_hotLineLabel setBackgroundColor:[UIColor colorWithRed:224/255.0 green:126/255.0 blue:163/255.0 alpha:1]];
    [self.view addSubview:_hotLineLabel];
    
    
    _putongBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_putongBtn setFrame:CGRectMake(1024/2-120, 450, 120, 50)];
    _putongBtn.backgroundColor=[UIColor clearColor];
    _putongBtn.tag=44;
    [_putongBtn setTitle:@"店内查询" forState:UIControlStateNormal];
    _putongBtn.titleLabel.font=[UIFont systemFontOfSize:20];
    [_putongBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_putongBtn addTarget:self action:@selector(swichBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_putongBtn];
    
    _jingqueBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_jingqueBtn setFrame:CGRectMake(1024/2+20, 450, 120, 50)];
    _jingqueBtn.backgroundColor=[UIColor clearColor];
    _jingqueBtn.tag=55;
    [_jingqueBtn setTitle:@"跨店查询" forState:UIControlStateNormal];
    _jingqueBtn.titleLabel.font=[UIFont systemFontOfSize:20];
    [_jingqueBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_jingqueBtn addTarget:self action:@selector(swichBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_jingqueBtn];
    
    _nameTextField=[[UITextField alloc] initWithFrame:CGRectMake(99, 10, 200, 43)];
    _nameTextField.placeholder=@" 请输入姓名";
    _nameTextField.delegate=self;
    _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_searchView2 addSubview:_nameTextField];
    
    _cardTextField=[[UITextField alloc] initWithFrame:CGRectMake(320, 11, 370, 43)];
    _cardTextField.text=@"O";
    _cardTextField.delegate = self;
    _cardTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _cardTextField.keyboardType=UIKeyboardTypeNumberPad;
  //  cardTextField.placeholder=@"请输入卡号";
    [_searchView2 addSubview:_cardTextField];
    
     _searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_searchBtn setFrame:CGRectMake(695, 11, 98, 43)];
    [_searchBtn addTarget:self action:@selector(jingqueSearchClick) forControlEvents:UIControlEventTouchUpInside];
    [_searchBtn setImage:[UIImage imageNamed:@"查--询.png"] forState:UIControlStateNormal];
    [_searchView2 addSubview:_searchBtn];
    
    
    
}
- (void)jingqueSearchClick
{
    if ([_nameTextField.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入姓名"];
        return;
    }else if ([_cardTextField.text isEqualToString:@"O"]){
        [SVProgressHUD showInfoWithStatus:@"请输入卡号"];
        return;
    }
    
    [self jingQueSearch];
    
    
}
- (void)swichBtn:(UIButton *)btn
{

  //  _swichBtn.selected=!_swichBtn.selected;
    
    if (btn.tag==44) {
        _hotLineLabel.frame=CGRectMake(1024/2-120, 510, 120, 2);
        searchView.hidden=NO;
        _searchView2.hidden=YES;
        selectState=0;
    }else{
        _hotLineLabel.frame=CGRectMake(1024/2+20, 510, 120, 2);
        searchView.hidden=YES;
        _searchView2.hidden=NO;
        selectState=1;
    }
    
//    if (_swichBtn.selected==YES) {
//        searchView.hidden=YES;
//        _searchView2.hidden=NO;
//    }else
//    {
//        searchView.hidden=NO;
//        _searchView2.hidden=YES;
//    }
    
    
}
//限定字数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (searcktextField == textField||_cardTextField==textField)
    {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"超过会员卡号11位，请确认" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] ;
            [alert show];
            [searcktextField resignFirstResponder];
            [_cardTextField resignFirstResponder];
            return NO;
        }
    }
    return YES;
}

- (IBAction)addDA
{
    if ([self isConnectionAvailable]==NO) {
        return;
    }else{
    SMArchivesController * order = [[SMArchivesController alloc] initWithNibName:@"SMArchivesController" bundle:nil];
    UINavigationController * popUpNavigationController = [[UINavigationController alloc] initWithRootViewController:order];
        popUpNavigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    popUpNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController presentViewController:popUpNavigationController animated:YES completion:nil];
    }
}

- (NSString *)getStoresID
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString * uName = [prefs objectForKey:@"name"];
    return uName;
}
//精确查询
- (void)jingQueSearch
{
    NSMutableArray * array =[NSMutableArray arrayWithArray:[[XMLmanage shardSingleton] getGuestInfoWithName2:_nameTextField.text  withUsername:@"sanmoon" withPwd:@"sm147369" cardNum:_cardTextField.text]];
    
    if ([array count] == 0)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"卡号与姓名不匹配" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [_cardTextField resignFirstResponder];
        [_nameTextField resignFirstResponder];
//        if (queryFlag == 0)
//        {
//            _cardTextField.text=@"";
//        }else{
            _cardTextField.text = @"O";
      //  }
        [SVProgressHUD dismiss];
        
        return;
    }
    //CustomersQuery * customer  = [array objectAtIndex:0];
    CustomerController * customervc  = [[CustomerController alloc] init];
    customervc.array = array;
    customervc.delegate=self;
    [self.navigationController pushViewController:customervc animated:YES];
    [SVProgressHUD dismiss];
   
}

#pragma mark 修改
- (void)searchTask
{
    
    // searcktextField.text = @"O0029000150";
    //    CateViewController * cate = [[CateViewController alloc] init];
    //    [self.navigationController pushViewController:cate animated:YES];
    // searcktextField.text = @"O0029000150";
   
    if ([self isConnectionAvailable]==NO) {
        return;
    }else{
        
    [SVProgressHUD showWithStatus:@"查询中，请稍后"];

    if (queryFlag == 1) {
        
        if ([searcktextField.text length]!=11) {
            [SVProgressHUD showInfoWithStatus:@"卡号输入有误，请核对"];
            return;
        }
        
        NSArray * array = [[XMLmanage shardSingleton] getGuestInfo:searcktextField.text withUsername:@"sanmoon" withPwd:@"sm147369"];
        if ([array count] == 0) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"该顾客还不是会员，没有信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            searcktextField.text = @"O";
            [SVProgressHUD dismiss];

            return;
        }
        CustomersQuery * customer  = [array objectAtIndex:0];
        NSString * cardState = customer.cardstate;
        NSLog(@"the uid is %@",customer.usid);
        NSLog(@"the unames is %@",[self getStoresID]);
        
        NSString * uid = [self getStoresID];
        if ([customer.usid isEqualToString:uid] == NO) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"不是该门店的客户，禁止查询" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            if (queryFlag == 0) {
                searcktextField.text=@"";
            }else{
            searcktextField.text = @"O";
            }
            [SVProgressHUD dismiss];

            return;
        }
        if ([cardState isEqualToString:@"1"]) {
            

            MemberController * member  = [[MemberController alloc] init];
            member.query = searcktextField.text;
            member.delegate=self;
            member.cardState=cardState;
            // member.query = @"O0029000150";
            [self.navigationController pushViewController:member animated:YES];
            [SVProgressHUD dismiss];
        }
        else if([cardState isEqualToString:@"0"])
        {
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"该卡处于已补卡状态" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//            if (queryFlag == 0) {
//                searcktextField.text=@"";
//            }else{
//                searcktextField.text = @"O";
//            }
//
//            [SVProgressHUD dismiss];
            MemberController * member  = [[MemberController alloc] init];
            member.query = searcktextField.text;
            member.delegate=self;
            member.cardState=cardState;
            // member.query = @"O0029000150";
            [self.navigationController pushViewController:member animated:YES];
            [SVProgressHUD dismiss];


        }else if ([cardState isEqualToString:@"2"])
        {
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"该卡处于未激活状态，请重新激活" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//            if (queryFlag == 0) {
//                searcktextField.text=@"";
//            }else{
//                searcktextField.text = @"O";
//            }
//
//            [SVProgressHUD dismiss];
            MemberController * member  = [[MemberController alloc] init];
            member.query = searcktextField.text;
            member.delegate=self;
            member.cardState=cardState;
            // member.query = @"O0029000150";
            [self.navigationController pushViewController:member animated:YES];
            [SVProgressHUD dismiss];
        }else if ([cardState isEqualToString:@"3"])
        {
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"该卡处于已转卡状态" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//            if (queryFlag == 0) {
//                searcktextField.text=@"";
//            }else{
//                searcktextField.text = @"O";
//            }
//
//            [SVProgressHUD dismiss];
            MemberController * member  = [[MemberController alloc] init];
            member.query = searcktextField.text;
            member.delegate=self;
            member.cardState=cardState;
            // member.query = @"O0029000150";
            [self.navigationController pushViewController:member animated:YES];
            [SVProgressHUD dismiss];
        }else if ([cardState isEqualToString:@"4"])
        {
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"该卡处于挂失状态" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//            if (queryFlag == 0) {
//                searcktextField.text=@"";
//            }else{
//                searcktextField.text = @"O";
//            }
//
//            [SVProgressHUD dismiss];
            MemberController * member  = [[MemberController alloc] init];
            member.query = searcktextField.text;
            member.delegate=self;
            member.cardState=cardState;
            // member.query = @"O0029000150";
            [self.navigationController pushViewController:member animated:YES];
            [SVProgressHUD dismiss];
        }else if ([cardState isEqualToString:@"5"])
        {
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"该卡处于已完成状态" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//            if (queryFlag == 0) {
//                searcktextField.text=@"";
//            }else{
//                searcktextField.text = @"O";
//            }
//
//            [SVProgressHUD dismiss];
            MemberController * member  = [[MemberController alloc] init];
            member.query = searcktextField.text;
            member.delegate=self;
            member.cardState=cardState;
            // member.query = @"O0029000150";
            [self.navigationController pushViewController:member animated:YES];
            [SVProgressHUD dismiss];
        }else if ([cardState isEqualToString:@"6"])
        {
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"该卡处于退卡状态" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//            if (queryFlag == 0) {
//                searcktextField.text=@"";
//            }else{
//                searcktextField.text = @"O";
//            }
//
//            [SVProgressHUD dismiss];
            MemberController * member  = [[MemberController alloc] init];
            member.query = searcktextField.text;
            member.delegate=self;
            member.cardState=cardState;
            // member.query = @"O0029000150";
            [self.navigationController pushViewController:member animated:YES];
            [SVProgressHUD dismiss];
        }else if ([cardState isEqualToString:@"7"])
        {
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"该卡处于冻结状态" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//            if (queryFlag == 0) {
//                searcktextField.text=@"";
//            }else{
//                searcktextField.text = @"O";
//            }
//
//            [SVProgressHUD dismiss];
            MemberController * member  = [[MemberController alloc] init];
            member.query = searcktextField.text;
            member.delegate=self;
            member.cardState=cardState;
            // member.query = @"O0029000150";
            [self.navigationController pushViewController:member animated:YES];
            [SVProgressHUD dismiss];
        }else if ([cardState isEqualToString:@"8"])
        {
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"该卡处于已合卡状态" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//            if (queryFlag == 0) {
//                searcktextField.text=@"";
//            }else{
//                searcktextField.text = @"O";
//            }
//
//            [SVProgressHUD dismiss];
            MemberController * member  = [[MemberController alloc] init];
            member.query = searcktextField.text;
            member.delegate=self;
            member.cardState=cardState;
            // member.query = @"O0029000150";
            [self.navigationController pushViewController:member animated:YES];
            [SVProgressHUD dismiss];
        }else if ([cardState isEqualToString:@"9"])
        {
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"该卡处于余零状态" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//            if (queryFlag == 0) {
//                searcktextField.text=@"";
//            }else{
//                searcktextField.text = @"O";
//            }
//
//            [SVProgressHUD dismiss];
            MemberController * member  = [[MemberController alloc] init];
            member.query = searcktextField.text;
            member.delegate=self;
            member.cardState=cardState;
            // member.query = @"O0029000150";
            [self.navigationController pushViewController:member animated:YES];
            [SVProgressHUD dismiss];
        }
        
    }
    else
    {
        if ([searcktextField.text isEqualToString:@""]) {
            [SVProgressHUD showInfoWithStatus:@"请输入顾客姓名"];
            return;
        }
        
        NSMutableArray * array =[NSMutableArray arrayWithArray:[[XMLmanage shardSingleton] getGuestInfoWithName:searcktextField.text  withUsername:@"sanmoon" withPwd:@"sm147369"]];
        
        if ([array count] == 0)
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"该顾客还不是会员，没有信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            if (queryFlag == 0) {
                searcktextField.text=@"";
            }else{
                searcktextField.text = @"O";
            }
            [SVProgressHUD dismiss];

            return;
        }
        CustomersQuery * customer  = [array objectAtIndex:0];
        NSString * cardState = customer.cardstate;
        NSString * uid = [self getStoresID];
        if ([customer.usid isEqualToString:uid] == NO) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"不是该门店的客户，禁止查询" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            if (queryFlag == 0) {
                searcktextField.text=@"";
            }else{
                searcktextField.text = @"O";
            }

            [SVProgressHUD dismiss];
            return;
        }
     //   if ([cardState isEqualToString:@"1"]) {
          //   searcktextField.text=@"";
            CustomerController * customervc  = [[CustomerController alloc] init];
            customervc.array = array;
            customervc.delegate=self;
         //   customervc.cardState=cardState;
          NSLog(@"customervc.cardState=%@",customervc.cardState);
            [self.navigationController pushViewController:customervc animated:YES];
            [SVProgressHUD dismiss];
        
    //    }
//        else
//        {
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"该卡已处于禁用状态，请重新激活" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//            searcktextField.text = @"";
//            [SVProgressHUD dismiss];
//
//        }
    }
    }
}
- (void)changeText2
{
    NSLog(@"响应代理2");
     searcktextField.text=@"O";
}
- (void)changeText
{
    NSLog(@"响应代理");
      searcktextField.text=@"";
}
- (void)SearchbuttonClick
{
    [searcktextField resignFirstResponder];
    [self searchTask];
//    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//	[self.navigationController.view addSubview:HUD];
//	
//    HUD.delegate = self;
//    HUD.labelText = @"查询中，请稍后";
//	
//    [HUD showWhileExecuting:@selector(searchTask) onTarget:self withObject:nil animated:YES];
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
	HUD = nil;
}

- (void)buttonChange:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    if (btn.tag == 1) {
        queryFlag = 0;
        NSLog(@"click 122222");
        [mybutton1 setImage:[UIImage imageNamed:@"建档按钮_08.png"] forState:UIControlStateNormal];
        [mybutton2 setImage:[UIImage imageNamed:@"建档按钮_09.png"] forState:UIControlStateNormal];
        searcktextField.text=@"";
        searcktextField.keyboardType=UIKeyboardTypeDefault;
        [searcktextField endEditing:YES];
    }
    else
    {
        queryFlag = 1;
        NSLog(@"click 33333");
        [mybutton1 setImage:[UIImage imageNamed:@"建档按钮_111_08.png"] forState:UIControlStateNormal];
        [mybutton2 setImage:[UIImage imageNamed:@"建档按钮11_09.png"] forState:UIControlStateNormal];
        searcktextField.text=@"O";
        searcktextField.keyboardType=UIKeyboardTypeNumberPad;
       [searcktextField endEditing:YES];
    }
    
    //    if (bt == YES) {
    //        bt = NO;
    //        queryFlag = 0;
    //        [mybutton1 setImage:[UIImage imageNamed:@"s-xmcx_04.png"] forState:UIControlStateNormal];
    //        [mybutton2 setImage:[UIImage imageNamed:@"s-khcx_03.png"] forState:UIControlStateNormal];
    //    }else
    //    {
    //        bt = YES;
    //        queryFlag = 1;
    //        [mybutton1 setImage:[UIImage imageNamed:@"s-xmcxx_04.png"] forState:UIControlStateNormal];
    //        [mybutton2 setImage:[UIImage imageNamed:@"s-khcxx_03.png"] forState:UIControlStateNormal];
    //    }
    
}

#pragma mark - button

- (void)creatButton
{
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(75, 290, 145, 145);
    button.tag = 10;
    [button setBackgroundImage:[UIImage imageNamed:@"index_hc.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    //    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    
    button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(265, 290, 145, 145);
    button1.tag = 11;
    [button1 setBackgroundImage:[UIImage imageNamed:@"index_zx.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    //    button1.backgroundColor = [UIColor redColor];
    [self.view addSubview:button1];
    
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(615, 290, 145, 145);
    button2.tag = 12;
    [button2 setBackgroundImage:[UIImage imageNamed:@"index_sc"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    //    button2.backgroundColor = [UIColor redColor];
    [self.view addSubview:button2];
    
    button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(805, 290, 145, 145);
    button3.tag = 13;
    [button3 setBackgroundImage:[UIImage imageNamed:@"index_gd"] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    //    button3.backgroundColor = [UIColor redColor];
    [self.view addSubview:button3];
    
//    _returnBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    _returnBtn.frame=CGRectMake(10, 290, 50, 50);
//    [_returnBtn addTarget:self action:@selector(returnBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_returnBtn setBackgroundImage:[UIImage imageNamed:@"返回副本.png"] forState:UIControlStateNormal];
//    [self.view addSubview:_returnBtn];
    
    
}

- (void)buttonClick:(id)sender
{
    UIButton *butt = (UIButton *)sender;
    [SVProgressHUD dismiss];
    switch (butt.tag) {
            
            
        case 10:
        {
            EbookViewController *ebookVC = [[EbookViewController alloc] init];
            [self.navigationController pushViewController:ebookVC animated:YES];
            
        }
            break;
            
        case 11:
        {
            
            InformationViewController *infoVC = [[InformationViewController alloc] init];
            [self.navigationController pushViewController:infoVC animated:YES];
            
            break;
            
        }
        case 12:
        {
            
            ProjectDescriptionViewController *projectVC = [[ProjectDescriptionViewController alloc] initWithNibName:@"ProjectDescriptionViewController" bundle:nil];
            [self.navigationController pushViewController:projectVC animated:YES];
            break;
            
        }
        case 13:
        {
            //
            ////            NSString *url = [NSString stringWithFormat:@"http://www.wowza.com/_h264/BigBuckBunny_115k.mov"];
            //
            //            NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"圣典视频 " ofType:@"mp4"];
            //            //取视频URl
            //            NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
            //            movPl = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
            //            [self presentMoviePlayerViewControllerAnimated:movPl];
            //            [movPl.moviePlayer play];
            
            HighequipmentViewController *highequipVC = [[HighequipmentViewController alloc] init];
            [self.navigationController pushViewController:highequipVC animated:YES];
            
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - DCPathButton delegate

- (void)button_0_action{
    NSLog(@"Button Press Tag 0!!");
    SMSelfServiceController * service = [[SMSelfServiceController alloc] init];
    [self.navigationController pushViewController:service animated:YES];
    
}

- (void)button_1_action{
    NSLog(@"Button Press Tag 1!!");
    NSString *str1 = [NSString stringWithFormat:@"http://www.sanmoon.com"];
    //    NSString *str1 = [NSString stringWithFormat:@"http://192.168.0.108:8080/Sanmoon1.0/view/preview.jsp?oid=1"];
    WebViewController *web = [[WebViewController alloc] initWithURL:[NSURL URLWithString:str1]];
    web.HideBack = NO;
    [self presentViewController:web animated:YES completion:nil];
}

- (void)button_2_action{
    NSLog(@"Button Press Tag 2!!");
   // [SVProgressHUD showInfoWithStatus:@"暂无数据"];
    InformationViewController *infoVC = [[InformationViewController alloc] init];
    [self.navigationController pushViewController:infoVC animated:YES];

//    CelebrationViewController *celebrationVC = [[CelebrationViewController alloc] init];
//    [self.navigationController pushViewController:celebrationVC animated:YES];
    
}

- (NSString *)getQuestionID
{
    NSString * result = @"";
    NSString * questionURL = [NSString stringWithFormat:@"%@findAllQuestionNaireToIpad",LocationIp];
    NSDictionary * dict = [[EBookManage shardSingleton] jsonParseWithURL:questionURL];
    if ([[dict objectForKey:@"result"] isEqualToString:@"success"]) {
        
        NSDictionary * resultDict = [dict objectForKey:@"resultMsg"];
        result = [[resultDict objectForKey:@"oid"] stringValue];
        return result;
    }
    else
    {
        return result;
    }
}

- (NSString *)getStoreID
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSLog(@"the store id is %@",[prefs objectForKey:@"storeID"]);
    return [prefs objectForKey:@"storeID"];
}

- (void)button_3_action{
    
    NSString * result = [self getQuestionID];
    
    if ([result length] == 0) {
        [SVProgressHUD showInfoWithStatus:@"目前没有调查问卷"];
        return;
    }
    NSLog(@"the result is %@",result);
    
    NSString *str1 = [NSString stringWithFormat:@"%@view/preview.jsp?oid=%@&shopcode=%@",LocationIp,result,[self getStoreID]];
    NSLog(@"===%@,---%@",result,[self getStoreID]);
    NSLog(@"the store string is %@",str1);
    WebViewController *web = [[WebViewController alloc] initWithURL:[NSURL URLWithString:str1]];
    web.HideBack = NO;
    [self presentViewController:web animated:YES completion:nil];
}

- (void)button_4_action{
    
    SetViewController *setVC = [[SetViewController alloc] init];
    [self.navigationController pushViewController:setVC animated:YES];
}

- (void)button_5_action{
    
    
    NSLog(@"Button Press Tag 5!!");
    MapViewController *mapView=[[MapViewController alloc] init];
//    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:mapView];
    [self.navigationController pushViewController:mapView animated:YES];
    
 
}

- (void)centreButton_show
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:10.f];

    if (_swichBtn.selected==YES) {
        
    }
//    mybutton1.hidden=YES;
//    mybutton2.hidden=YES;
    button.hidden = YES;
    button1.hidden = YES;
    button2.hidden = YES;
    button3.hidden = YES;
    searchView.hidden = YES;

    _swichBtn.hidden=YES;
    
    _nameTextField.hidden=YES;
    _cardTextField.hidden=YES;
    _searchBtn.hidden=YES;
    _kuangImageView.hidden=YES;
    
    _lineLabel.hidden=YES;
    _hotLineLabel.hidden=YES;
    _putongBtn.hidden=YES;
    _jingqueBtn.hidden=YES;
    
    
    [UIView commitAnimations];
}

- (void)centreButton_back
{
    [UIView beginAnimations:nil context:nil];
    //    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:10.f];
    if (selectState==1) {
        
    }else{
        searchView.hidden = NO;
    }
    
//    mybutton1.hidden=NO;
//    mybutton2.hidden=NO;
    button.hidden = NO;
    button1.hidden = NO;
    button2.hidden = NO;
    button3.hidden = NO;
    
  
    _swichBtn.hidden=NO;
    _nameTextField.hidden=NO;
    _cardTextField.hidden=NO;
    _searchBtn.hidden=NO;
    _kuangImageView.hidden=NO;
    
    _lineLabel.hidden=NO;
    _hotLineLabel.hidden=NO;
    _putongBtn.hidden=NO;
    _jingqueBtn.hidden=NO;
    
    [UIView commitAnimations];
}

#pragma mark - texteFiledDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    //    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3f];
    self.view.frame = CGRectMake(0, -300, 1024, 768);
    [UIView commitAnimations];
}

- (void)keyboardWasHidden:(NSNotification*)aNotification
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3f];
    self.view.frame = CGRectMake(0, 0, 1024, 768);
    [UIView commitAnimations];
}


//- (void)request
//{
//    NSError *error = nil;
//    NSURL *url = [NSURL URLWithString:@"http://192.168.0.108:8080/Sanmoon/findAllEbookToIpad"];
//    NSString *strJson = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
//    NSLog(@"%@",strJson);
//    if (strJson) {
//        SBJsonParser *parser = [[SBJsonParser alloc] init];
//
//        NSArray *arr = [[NSArray alloc] init];
//        arr = [parser objectWithString:strJson];
//        namearr = [[NSMutableArray alloc] init];
//        urlarr = [[NSMutableArray alloc] init];
//        NSDictionary *dic = [[NSDictionary alloc] init];
//
//        for (int i = 0; i < arr.count; i++) {
//            dic = [arr objectAtIndex:i];
//            [namearr addObject:[dic objectForKey:@"info"]];
//        }
//        NSLog(@"%@",namearr);
//    }
//
//}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return [[_selections objectAtIndex:index] boolValue];
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)queryMap:(id)sender
{
 

}
//- (void)returnBtn:(UIButton *)btn
//{
//    LogInViewController *logInVC = [[LogInViewController alloc] init];
//    self.view.window.rootViewController=logInVC;
//   
//}
@end
