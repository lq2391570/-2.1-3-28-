//
//  CelebrationViewController.m
//  shengmeng
//
//  Created by 石榴花科技 on 14-4-1.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import "CelebrationViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ProgressHUD.h"
#import "TCBlobDownloadManager.h"
#import "QDManage.h"
#import "Reachability.h"
#import "SGInfoAlert.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface CelebrationViewController ()
{
    NSArray *array;
    NSMutableArray *nameArray;
    NSMutableArray *imageUrlArray;
    NSDictionary *dic;
    
    NSArray *moveArray;
    NSMutableArray *MoveUrlArray;
    NSDictionary *moveDic;
    
}

@property (nonatomic,strong) NSMutableArray * IDArray;
@property (nonatomic,strong) NSMutableArray * recordArray;

@end

@implementation CelebrationViewController

@synthesize IDArray =_IDArray;
@synthesize recordArray = _recordArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"庆典活动", nil);
        [self Dorequest];
    }
    return self;
}

- (BOOL)checkInternet
{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus networkStatus = [r currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        return NO;
    }
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([self checkInternet])
    {
        [self Dorequest];
    }
    else
    {
       [self getQDImageWithOutInternet];
    }

    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad
{

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar"] forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    buttonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = buttonItem;
    
    
    [self initCollectionView];
    

    
}
- (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)Dorequest
{
    
    array = [NSArray new];
    
    NSError *error;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@findAllOtherToIpad",MAINURL]];
    NSString *strJson = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    self.IDArray = [NSMutableArray arrayWithCapacity:10];

    if (strJson) {
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        array = [parser objectWithString:strJson];
        nameArray = [[NSMutableArray alloc] init];
        imageUrlArray = [[NSMutableArray alloc] init];
        for (dic in array) {
            [nameArray addObject:[dic objectForKey:@"name"]];
            [imageUrlArray addObject:[dic objectForKey:@"imgUrl"]];
            
            [self.IDArray addObject:[dic objectForKey:@"imagesIds"]];
        }
    }
    if ([self.IDArray count] == 0 ) {
        return;
    }
    moveArray = [NSArray new];
    MoveUrlArray = [[NSMutableArray alloc] init];

    for (int i = 0; i< [self.IDArray count]; i++) {
        NSString * ID = [self.IDArray objectAtIndex:i];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GETURL,ID]];
        NSString *strJson = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
        if (strJson) {
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            moveArray = [parser objectWithString:strJson];
            for (moveDic in moveArray)
            {
                QDVideoInfo * qdInfo = [[QDVideoInfo alloc] init];
                qdInfo.imgUrl = [imageUrlArray objectAtIndex:i];
                qdInfo.name  = [nameArray objectAtIndex:i];
                qdInfo.videoUrl = [moveDic objectForKey:@"smallImgUrl"];
                
                if (![[QDManage shardSingleton] isExistImageWithName:[imageUrlArray objectAtIndex:i]])
                {
                    [[QDManage shardSingleton] insertQDInfo:qdInfo];
                }
               
                [MoveUrlArray addObject:[moveDic objectForKey:@"smallImgUrl"]];
            }
            
        }

    }
    
}

- (void)DoPlayRequest
{
    
}


- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(210, 300);
    layout.sectionInset = UIEdgeInsetsMake(30, 50, 30, 50);
    //上下间隔
    layout.minimumLineSpacing = 30;
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
//    UINib *cellNib = [UINib nibWithNibName:@"CelebrationCell" bundle:nil];
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
    return nameArray.count;
}

- (UIImage *)getImageFromURL:(NSString *)fileURL
{
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    UIImage * result = [UIImage imageWithData:data];
    return result;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIde = @"cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIde forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    
    cell.alpha = 0.8;
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 260, 210, 40)];
    lable.text = [nameArray objectAtIndex:indexPath.row];
    lable.font = [UIFont systemFontOfSize:17];
    lable.adjustsFontSizeToFitWidth = YES;
    //文字居中
    lable.textAlignment = NSTextAlignmentCenter;
    lable.backgroundColor = [UIColor colorWithRed:1 green:186.0/255 blue:204.0/255 alpha:1];
    lable.numberOfLines = [lable.text length];
    [cell.contentView addSubview:lable];
    
    NSArray * dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * documentDirectory = [dir objectAtIndex:0];
    NSString * dirPath = [documentDirectory stringByAppendingPathComponent:@"qdcover"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray * links = [[imageUrlArray objectAtIndex:indexPath.row] componentsSeparatedByString:@"/"];

    NSString * fileName = [links objectAtIndex:2];
    NSString * path = [NSString stringWithFormat:@"%@/%@",dirPath,fileName];
     UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 210, 260)];
    if ([fileManager fileExistsAtPath:path])
        {
            bgImage.image = [[UIImage alloc] initWithContentsOfFile:path];
            NSLog(@"get local file image");
        }
        else
        {
            NSLog(@"get online file image");
            NSURL *imUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",MAINURL,[imageUrlArray objectAtIndex:indexPath.row]]];
            NSData *data = [NSData dataWithContentsOfURL:imUrl];
            
                if (data!=NULL) {
                    bgImage.image = [UIImage imageWithData:data];
                    
                    [[QDManage shardSingleton] saveImage: [UIImage imageWithData:data] withURL:[imageUrlArray objectAtIndex:indexPath.row]];
                }
        }
    [cell.contentView addSubview:bgImage];

    return cell;
}

- (void)downloadVideoWithURL:(NSString *)videoPath
{
    NSString * path;
    NSArray * dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString * documentDirectory = [dir objectAtIndex:0];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString * fileName;
    if ([videoPath rangeOfString:@"resources/videos"].location != NSNotFound ) {
        
        path = [documentDirectory stringByAppendingPathComponent:@"qdVideo"];
        NSArray * array = [videoPath componentsSeparatedByString:@"resources/videos"];
        fileName = [array objectAtIndex:1];
    }
    
    
    if (![fileManager fileExistsAtPath:path])
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
    }
    NSString * filePath = [path stringByAppendingPathComponent:fileName];
    if ([fileManager fileExistsAtPath:filePath])
    {
        return;
    }
    
    [[TCBlobDownloadManager sharedDownloadManager] startDownloadWithURL:[NSURL URLWithString:videoPath]
                                                             customPath:path
                                                          firstResponse:NULL
                                                               progress:NULL
                                                                  error:NULL
                                                               complete:NULL];
    
 

}

- (void)playMovieWithPath:(NSString *)path
{
    //NSURL * playURL = [NSURL URLWithString:url];
    NSURL * playURL = [NSURL fileURLWithPath:path];
    MPMoviePlayerViewController *movPl =  [[MPMoviePlayerViewController alloc]
              initWithContentURL:playURL];
    [self presentMoviePlayerViewControllerAnimated:movPl];
    
}

- (void)playMovieWithPathAV:(NSString *)path
{
    NSURL * playURL = [NSURL fileURLWithPath:path];
    AVPlayer *player=[AVPlayer playerWithURL:playURL];
    
    
    AVPlayerViewController *playerController=[[AVPlayerViewController alloc] init];
    playerController.player=player;
    [self presentViewController:playerController animated:YES completion:nil];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    NSArray * dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * documentDirectory = [dir objectAtIndex:0];
    NSString * dirPath = [documentDirectory stringByAppendingPathComponent:@"qdVideo"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray * links = [[MoveUrlArray objectAtIndex:[indexPath row]] componentsSeparatedByString:@"/"];
    NSString * fileName = [links objectAtIndex:2];
    NSString * path = [NSString stringWithFormat:@"%@/%@",dirPath,fileName];
    NSLog(@"the video local path is %@",path);
    if ([fileManager fileExistsAtPath:path])
    {
        NSLog(@"paly the local video");

        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0){
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               // [self playMovieWithPath:path];
            //    [self presentViewController:picker animated:YES completion:nil];
                [self playMovieWithPathAV:path];
            }];
        }else{
            [self playMovieWithPath:path];
           // [self presentViewController:picker animated:YES completion:nil];
        }

        
    //    [self playMovieWithPath:path];
        
        
    }
    else
    {
            if (MoveUrlArray)
            {
                NSLog(@"Enter the online download");
                if ([self checkInternet])
                {
                    NSURL *mUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",MAINURL,[MoveUrlArray objectAtIndex:[indexPath row]]]];
                    
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        
                        [self downloadVideoWithURL:[NSString stringWithFormat:@"%@%@",MAINURL,[MoveUrlArray objectAtIndex:[indexPath row]]]];
                    });
                    
                    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0){
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                         //   [self presentViewController:picker animated:YES completion:nil];
//                            MPMoviePlayerViewController *movPl = [[MPMoviePlayerViewController alloc] initWithContentURL:mUrl];
//                            [self shouldAutorotate];
//                            [self supportedInterfaceOrientations];
//                            [self presentMoviePlayerViewControllerAnimated:movPl];
                          //  NSURL * playURL = [NSURL fileURLWithPath:path];
                            AVPlayer *player=[AVPlayer playerWithURL:mUrl];
                            
                            
                            AVPlayerViewController *playerController=[[AVPlayerViewController alloc] init];
                            playerController.player=player;
                            [self presentViewController:playerController animated:YES completion:nil];
                            
                            
                            
                        }];
                    }else{
                        //[self presentViewController:picker animated:YES completion:nil];
                        MPMoviePlayerViewController *movPl = [[MPMoviePlayerViewController alloc] initWithContentURL:mUrl];
                        [self shouldAutorotate];
                        [self supportedInterfaceOrientations];
                        [self presentMoviePlayerViewControllerAnimated:movPl];
                    }

                    
//                    MPMoviePlayerViewController *movPl = [[MPMoviePlayerViewController alloc] initWithContentURL:mUrl];
//                    [self shouldAutorotate];
//                    [self supportedInterfaceOrientations];
//                    [self presentMoviePlayerViewControllerAnimated:movPl];
                }
                else
                {
                    [SGInfoAlert showInfo:@"没有可用的网络，请连接网络后重试！"
                   bgColor:[[UIColor blackColor] CGColor]
                   inView:self.view
                  vertical:0.4];
                }
                
            }
    }

}

- (void)getQDImageWithOutInternet
{
    self.recordArray = [NSMutableArray arrayWithArray:[[QDManage shardSingleton] getQDRecord]];

    if (self.recordArray == nil || [self.recordArray count] == 0) {
        return;
    }
    
    self.IDArray = [NSMutableArray arrayWithCapacity:10];
    nameArray = [[NSMutableArray alloc] init];
    imageUrlArray = [[NSMutableArray alloc] init];
    MoveUrlArray = [NSMutableArray arrayWithCapacity:2];
    QDVideoInfo * videoInfo;
    for (videoInfo in self.recordArray)
    {
        [nameArray addObject:videoInfo.name];
        [imageUrlArray addObject:videoInfo.imgUrl];
        [MoveUrlArray addObject:videoInfo.videoUrl];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
