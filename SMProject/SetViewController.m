//
//  SetViewController.m
//  SMProject
//
//  Created by 石榴花科技 on 14-4-20.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import "SetViewController.h"

UINavigationController *na1;
@interface SetViewController ()
{
    
    UIView *vie;
    NSArray *photo;
    NSUserDefaults *userDefaul;
   
}

@end

@implementation SetViewController
@synthesize allDownBtn=_allDownBtn;
@synthesize stopBtn=_stopBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"设置", nil);
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
//    NSUserDefaults *btnDefault=[NSUserDefaults standardUserDefaults];
//    [btnDefault objectForKey:@"btnType"];
   
}


- (void)viewDidLoad
{
    
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    buttonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = buttonItem;
    
    //    UIImageView *BgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 1024, 768-64)];
    //    BgimageView.image = [UIImage imageNamed:@"smbg模糊bg"];
    //    [self.view addSubview:BgimageView];
    
    [self initCollectionView];
    
    vie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    vie.backgroundColor = [UIColor redColor];
    
    userDefaul = [NSUserDefaults standardUserDefaults];
    
    photo = [[NSArray alloc] initWithObjects:@"smbg模糊原图 2",@"sm2",@"smbg模糊",@"smbg云",@"smbg年前",@"smbg清晰", nil];
    
    [userDefaul setObject:[photo objectAtIndex:0] forKey:@"bg"];
    _rootControl=[[RootViewController alloc] init];
    
//    _stopBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    _stopBtn.frame=CGRectMake(300, 75, 80, 45);
//    [_allDownBtn setBackgroundImage:[UIImage imageNamed:@"下载中_点击前.png"] forState:UIControlStateNormal];
//    //  [_stopBtn setBackgroundImage:[UIImage imageNamed:@"下载中_点击前.png"] forState:UIControlStateSelected];
//    [_stopBtn addTarget:self action:@selector(stopDownLoad) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_stopBtn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btnChange:) name:@"btnChange" object:nil];
    
    _allDownBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _allDownBtn.frame=CGRectMake(300, 75, 80, 45);
   
    [_allDownBtn setBackgroundImage:[UIImage imageNamed:@"一键下载_点击前(1).png"] forState:UIControlStateNormal];
    [_allDownBtn setBackgroundImage:[UIImage imageNamed:@"下载中_点击前.png"] forState:UIControlStateSelected];
    [_allDownBtn addTarget:self action:@selector(downLoad:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_allDownBtn];
    
    
    
    
    UIButton *updateBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    updateBtn.frame=CGRectMake(640, 75, 80, 45);
    [updateBtn setBackgroundImage:[UIImage imageNamed:@"版本更新_点击前.png"] forState:UIControlStateNormal];
    [updateBtn addTarget:self action:@selector(updataBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updateBtn];

    
    UIButton *cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
   // [cancelBtn setTitle:@"注销" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"注销_点击前.png"] forState:UIControlStateNormal];
    cancelBtn.frame=CGRectMake(50, 75, 80, 45);
    [self.view addSubview:cancelBtn];
    
    
    
    
    
    _progressView=[[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.frame=CGRectMake(400, 100, 150, 40);
    //进度条
     _progressView.backgroundColor = [UIColor redColor];
     _progressView.progressTintColor=[UIColor greenColor];
   // [[DownloadModel sharedDownloadModel] setP: _rootControl.progress];
   
    self.lhuilable = [[UILabel alloc]initWithFrame:CGRectMake(560, 85, 100, 30)];
    self.lhuilable.backgroundColor = [UIColor clearColor];
    self.lhuilable.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.lhuilable];
    self.lhuilable.hidden = YES;

}
- (void)btnChange:(NSNotification *)noti
{
    NSLog(@"收到通知");
    [self downLoad:_allDownBtn];
}
- (void)cancelBtnClick
{
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确定注销" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alert.tag=1;
       [alert show];
    
    
}
- (void)updataBtnClick
{
    [self updateVersion];
}
- (void)changeRootViewController
{
    
    _rootVC.storeName=_vc.nameTextfield.text;
    _rootVC.userName=_vc.UserNameTextField.text;
    _rootVC.ipadName=_vc.myIpadName;

    _window.rootViewController = na1;
}

- (void)downLoad:(UIButton *)btn
{
    
    
    btn.selected=!btn.selected;
    if (btn.selected==YES) {
        [_rootControl allDownLoad:_progressView uilable:self.lhuilable];
        
        [self.view bringSubviewToFront:_stopBtn];
        [self.view addSubview: _progressView];
        self.lhuilable.hidden = NO;
        self.lhuilable.text = @"00.00%";
        //   [self performSelector:@selector(netWorkUse) withObject:self afterDelay:10];
        NSLog(@"begin");
        
    }else{
        [SVProgressHUD dismiss];
        [self stopDownLoad];
    }
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"已下载完成" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
}
- (void)netWorkUse
{
//    if ([ASIHTTPRequest isNetworkInUse]) {
//        
//    }else{
//        [SVProgressHUD dismiss];
//    }
    
}
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self stopDownLoad];
//}
- (void)dismiss
{
    
}
- (void)stopDownLoad
{
    
    NSLog(@"stop");
    [_rootControl stopDownLoad];
//    [_stopBtn removeFromSuperview];
//    [self.view bringSubviewToFront:_allDownBtn];
    
//    [SVProgressHUD dismiss];
    
    
}
- (void)back
{
    
//    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//        [defaults setObject:_allDownBtn forKey:@"btnType"];
//        [defaults synchronize];
      [SVProgressHUD dismiss];
      [_rootControl stopDownLoad];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(300, 255);
    layout.sectionInset = UIEdgeInsetsMake(80, 20, 30, 20);
    //上下间隔
    layout.minimumLineSpacing = 50;
    //设置左右间距
    
    layout.minimumInteritemSpacing = 20;
    //    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768) collectionViewLayout:layout];
    //    self.collectionV setb
    UIImageView *BgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    BgimageView.image = [UIImage imageNamed:@"smbg模糊bg"];
    //    [self.collectionV addSubview:BgimageView];
    [self.collectionV setBackgroundView:BgimageView];
    
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionV];
//    UINib *cellNib = [UINib nibWithNibName:@"BgSetCell" bundle:nil];
    [self.collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

#pragma mark -------------
#pragma mark ---- collectionView datasource & delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return photo.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIde = @"cell";
    
     UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIde forIndexPath:indexPath];
    
    for (UIView * view in cell.contentView.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
        cell.alpha = 0.8;
    
    
    
    
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 225)];
    bgImage.image = [UIImage imageNamed:[photo objectAtIndex:indexPath.row]];
    NSLog(@"%@",[photo objectAtIndex:indexPath.row]);
    
    
   [cell.contentView addSubview:bgImage];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    [userDefaul setObject:[photo objectAtIndex:indexPath.row] forKey:@"bg"];
    [userDefaul synchronize];
    
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"当前选中第%ld张图片",indexPath.row + 1] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
    
    NSLog(@"%@",[userDefaul objectForKey:@"bg"]);
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

- (NSString *)getVersion
{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString* version = [infoDict objectForKey:@"CFBundleVersion"];
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
    if (!versions) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"发现新版本,是否更新？" delegate:self cancelButtonTitle:@"不" otherButtonTitles:@"好的", nil];
        [alert setTag:12];
        [alert show];
        return;
    }
    float localVersion = [versions floatValue];
    if (version > localVersion) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"发现新版本,是否更新？" delegate:self cancelButtonTitle:@"不" otherButtonTitles:@"好的", nil];
        [alert setTag:12];
        [alert show];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"当前版本已是最新版本" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 12) {
        if (buttonIndex == 0) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
          //  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-services://?action=download-manifest&url=https://sm.shiliuflower.com/data/Sanmoon.plist"]];
            
          //  UIWebView *web=[[UIWebView alloc] initWithFrame:CGRectMake(300, 300, 400, 500)];
//            NSString *path = @"https://sm.shiliuflower.com/data/SMVersion.html";
//            NSURL *url = [NSURL URLWithString:path];
//            [web loadRequest:[NSURLRequest requestWithURL:url]];
//            NSBundle *bundle = [NSBundle mainBundle];
//            NSString *resPath = [bundle resourcePath];
//            NSString *filePath = [resPath stringByAppendingPathComponent:@"Home.html"];
//            [web loadHTMLString:[NSString stringWithContentsOfFile:filePath]
//                            baseURL:[NSURL fileURLWithPath:[bundle bundlePath]]];
            URLViewController *urlView=[[URLViewController alloc] init];
            urlView.modalPresentationStyle=UIModalPresentationFormSheet;
            [self presentViewController:urlView animated:YES completion:nil];
            
        //    [self.view addSubview:web];
            
          //   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://sm.shiliuflower.com/data/SMVersion.html"]];
        }
    }else if(alertView.tag==1)
    {
        if (buttonIndex==0) {
            NSUserDefaults *cancelUser=[NSUserDefaults standardUserDefaults];
            [cancelUser setObject:@"" forKey:@"name"];
            [cancelUser setObject:@"" forKey:@"username"];
            [cancelUser setObject:@"" forKey:@"userpwd"];
            [cancelUser synchronize];
            _vc=[[LogInViewController alloc] init];
            _rootVC=[[RootViewController alloc] init];
            
            
            na1 = [[UINavigationController alloc] initWithRootViewController:_rootVC];
            _vc.delegate=self;
            _window = [[[UIApplication sharedApplication] delegate] window];
            _window.rootViewController = _vc;
            [UIView beginAnimations:nil context:nil];
            
            [UIView setAnimationDuration:1];
            [UIView setAnimationTransition:5 forView:_window cache:YES];
            
            [UIView commitAnimations];
            
        }else{
            return;
        }

    }
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
