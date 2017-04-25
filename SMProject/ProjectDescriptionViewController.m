//
//  ProjectDescriptionViewController.m
//  shengmeng
//
//  Created by 石榴花科技 on 14-4-1.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import "ProjectDescriptionViewController.h"
#import "SDImageCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ProjectManage.h"

#import "Reachability.h"
#import "MWPhotoBrowser.h"
#import "TCBlobDownload.h"
#import "TCBlobDownloadManager.h"
#import "SGInfoAlert.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "XMLmanage.h"
#import "InformationManage.h"
#import "SMOrderControllerViewController.h"

#define kAnimationDuration 0.1



@interface ProjectDescriptionViewController ()

{
    MPMoviePlayerViewController *movPl;
    NSMutableArray * backArray;
    UIBarButtonItem *buttonItem;
    NSMutableArray * singlearray;

}

@property (nonatomic, strong) NSMutableArray * coverImageArray;

@property (nonatomic, strong) NSMutableArray * coverVersionArray;
@property (nonatomic, strong) NSMutableArray * compArry;
@property (nonatomic, strong) NSMutableArray * subImages;
@property (nonatomic, strong) NSMutableArray * subIdArray;
//@property (nonatomic, strong) NSMutableArray * backArray;
//static NSMutableArray * backArray;

@property (nonatomic, strong) NSMutableArray * smallLinksArray;
@property (nonatomic, strong) NSMutableArray * linksPointArray;
@property (nonatomic, strong) NSMutableArray * detailRecordArray;
@property (nonatomic, strong) NSArray * photoArray;
@property (nonatomic, strong) NSMutableArray * idArray;
@property (nonatomic) int itemIndex;
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong)  MWPhotoBrowser * browser;


@end

int pointX;
int pointY;
int photoIndex;
NSString * bVersion;
int internetOnline;
int flag;
static NSString *backstr = @"-1";//记录返回compid
static NSString *backname = @"返回";

@implementation ProjectDescriptionViewController

@synthesize coverImageArray = _coverImageArray;
@synthesize idArray = _idArray;
@synthesize detailImageArray = _detailImageArray;
@synthesize smallLinksArray =_smallLinksArray;
@synthesize linksPointArray = _linksPointArray;
@synthesize detailRecordArray = _detailRecordArray;
@synthesize photoArray = _photoArray;
@synthesize itemIndex;
@synthesize indexPath =_indexPath;
@synthesize browser = _browser;
@synthesize coverVersionArray = _coverVersionArray;

#pragma mark Handle NotificationCenter Change
- (void)registerUpdateNotification {
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleTouchNotification:)
												 name:TOUCH_SCREEN_NOTIFICATION
											   object:nil];
}

- (void)unRegisterUpdateNotification{
	
	[[NSNotificationCenter defaultCenter] removeObserver:self  name:TOUCH_SCREEN_NOTIFICATION object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"项目手册", nil);
    self.photoArray = [NSArray array];
    [self registerUpdateNotification];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar"] forBarMetrics:UIBarMetricsDefault];
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    ProjectManage * manage = [ProjectManage shardSingleton];
    manage.redirectFlag = @"1";
//    buttonItem = [[UIBarButtonItem alloc] initWithTitle:backname style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
     buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
    buttonItem.tintColor = [UIColor whiteColor];
    buttonItem.tag = 100;
    self.navigationItem.leftBarButtonItem = buttonItem;
    self.navigationController.navigationBarHidden = NO;
    [self initCollectionView];
    
}

- (void)back:(id)sender
{
    NSLog(@"backstr is %@",backstr);
    if ([backstr isEqual:@"-1"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else
    {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:2];
        arr = [[ProjectManage shardSingleton] findbackBycompId:backstr];
        
        NSLog(@"arr is %@",arr);
        [self.collectionView removeFromSuperview];
        [self initviewBybookId:arr];
        //[backArray removeObjectAtIndex:backArray.count - 1];
        
        if ([self.compArry objectAtIndex:0]) {
            backstr = [self.compArry objectAtIndex:0];
        }
        
    }
    
//    [buttonItem setTitle:backname];
    
}

- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(140, 410);
    layout.sectionInset = UIEdgeInsetsMake(30, 30, 30, 50);
    //上下间隔
    layout.minimumLineSpacing = 30;
    //设置左右间距
    
    layout.minimumInteritemSpacing = 20;
      layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768) collectionViewLayout:layout];
    //    self.collectionV setb
    UIImageView *BgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    BgimageView.image = [UIImage imageNamed:@"smbg模糊bg"];
    //    [self.collectionV addSubview:BgimageView];
    [self.collectionView setBackgroundView:BgimageView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
//    [self.collectionView setUserInteractionEnabled:YES];
    [self.view addSubview:self.collectionView];
    UINib *cellNib = [UINib nibWithNibName:@"ProjectCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cell"];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLogPressCellToDelete:)];
    longPress.delegate = self;
    [self.collectionView addGestureRecognizer:longPress];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([self checkInternet])
    {
        internetOnline = 1;
        [self getCoverImage];
    }
    else
    {
        internetOnline = 0;
        [self getCoverImageWithOutInternet];
    }
    
    self.navigationController.navigationBarHidden = NO;
//    UIBarButtonItem *buttonItem = (UIBarButtonItem *)[self.view viewWithTag:100];
//    [buttonItem setTitle:backname];
    
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

- (void)handleTouchNotification:(NSNotification *)notification {
	
    NSDictionary * dictionary = [notification userInfo];
	NSString * xy = [dictionary objectForKey:@"point"];
    NSArray * point;
    if (xy.length >1)
    {
        point = [xy componentsSeparatedByString:@","];
    }
    else
    {
        return;
    }
    pointX = [[point objectAtIndex:0] intValue];
    pointY = [[point objectAtIndex:1] intValue];
    NSLog(@"gaoduan th point x online is %d",pointX);
    NSLog(@"gaoduan th point y online is %d",pointY);
    [self getLinksWithOutInternet];
}

- (void)imageRedirectInBorwseWithFileName:(NSString *)fileName
{
    for (int i = 0; i < [self.detailImageArray count]; i++)
    {
        if ([fileName isEqualToString:[self.detailImageArray objectAtIndex:i]] == YES)
        {
            [self.browser jumpToPageAtIndex:i animated:NO];
           // [self.browser ]
            return;
        }
    }
}

- (void)popUpSellWindowWithInfo:(PImageInfo *)imageInfo
{
    NSLog(@"the detail record array count is %d",self.detailRecordArray.count);
    
    if ([self.detailRecordArray count] == 0 || [self.detailRecordArray count] < photoIndex)
    {
    
        return;
    }
    
    InformationInfo * bookInfo = [self.detailRecordArray objectAtIndex:photoIndex];
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    NSString * usid = [defaults stringForKey:@"name"];
    
    //    NSLog(@"photoindex is %d",photoIndex);
    //    NSLog(@"%@",self.detailRecordArray);
    //    NSLog(@"bookinfo is %@",bookInfo.link);
    for (NSDictionary * dict in bookInfo.link)
    {
        int startX = [[dict objectForKey:@"startX"] intValue];
        int startY = [[dict objectForKey:@"startY"] intValue];
        int endX = [[dict objectForKey:@"endX"] intValue];
        int endY = [[dict objectForKey:@"endY"] intValue];
        int type = [[dict objectForKey:@"type"] intValue];
        NSString *link = [dict objectForKey:@"link"];
        NSLog(@"wode startX %d",startX);
        NSLog(@"wode startY %d",startY);
        NSLog(@"wode endX %d",endX);
        NSLog(@"wode endY %d",endY);

        if (pointX > startX && pointY > startY && pointX < endX && pointY <endY) {
            
            NSLog(@"this can touch");
            NSLog(@" the link is %d",link);
            if (type == 6) {
            
                Information *info = [[XMLmanage shardSingleton] analysisXMLWithID:link withUSID:usid withtype:type];
                NSLog(@"the info is %@",info.name);
                if (info.name.length == 0) {
                    [SGInfoAlert showInfo:@"暂无项目库存，无法购买！"
                                  bgColor:[[UIColor blackColor] CGColor]
                                   inView:self.browser.view
                                 vertical:0.4];
                }
                else
                {
                    singlearray = [NSMutableArray arrayWithCapacity:3];
                    
                    //[singlearray addObject:info.produceDate];
                
                    [singlearray addObject:[NSString stringWithFormat:@"%d",type]];
                    
                    NSLog(@"this is itme %@",info.name);
                    [singlearray addObject:info.name];
                    [singlearray addObject:@"1"];
                    [singlearray addObject:info.price];
                    [singlearray addObject:info.rate];
                    [singlearray addObject:info.ID];
                    [singlearray addObject:info.times];
                    [self addFirstView];
                }
            }
            else
            {
                if (type == 7) {
                    
                    Information *info = [[XMLmanage shardSingleton] analysisXMLWithID:link withUSID:usid withtype:type];
                    NSLog(@"the info is %@",info.name);
                    if (info.name.length == 0) {
                        [SGInfoAlert showInfo:@"暂无商品库存，无法购买！"
                                      bgColor:[[UIColor blackColor] CGColor]
                                       inView:self.browser.view
                                     vertical:0.4];
                        // return;
                    }
                    else
                    {
                        singlearray = [NSMutableArray arrayWithCapacity:3];
                        
                        //                if (type == 6) {
                        //                    [singlearray addObject:info.times];
                        //                }
                        //                else
                        //                {
                        [singlearray addObject:info.produceDate];
                        NSLog(@"the produceDate is %@",info.produceDate);
                        //  }
                        [singlearray addObject:[NSString stringWithFormat:@"%d",type]];
                        
                        NSLog(@"this is itme %@",info.name);
                        [singlearray addObject:info.name];
                        [singlearray addObject:@"1"];
                        [singlearray addObject:info.price];
                        [singlearray addObject:info.rate];
                        [singlearray addObject:info.ID];
                        [singlearray addObject:info.skpmount];
                        [self addFirstView1];
                    }
                }
                
            }
        }
    }
    
}

//添加第一个页面
- (void)addFirstView1
{
    ProjectManage * manage = [ProjectManage shardSingleton];
    //int counts = [manage isExistOrderWithID:[singlearray objectAtIndex:4]];
    OrderInfo * orders = [[OrderInfo alloc] init];
    
    //    if (counts > 0) {
    //        orders.counts = [NSString stringWithFormat:@"%d",counts +1];
    //        orders.ID = [singlearray objectAtIndex:4];
    //        [manage updateOrderInfo:orders];
    //    }
    //    else
    //    {
    orders.counts = @"1";
    NSLog(@"the inset....");
    NSString * produce = @"";
    NSArray * array = [singlearray objectAtIndex:0];
    
    for (int i = 0; i < [array count]; i++) {
        produce = [[produce stringByAppendingString:[array objectAtIndex:i]] stringByAppendingString:@";"];
    }
    
    orders.produce = produce;
    NSLog(@"the produce name is %@",orders.produce);
    
    orders.type = [singlearray objectAtIndex:1];
    orders.counts = @"1";
    orders.ID = [singlearray objectAtIndex:6];
    
    orders.name = [singlearray objectAtIndex:2];
    NSLog(@"the order name is %@",orders.name);
    orders.price = [singlearray objectAtIndex:4];
    orders.rate = [singlearray objectAtIndex:5];
    orders.skpmount = [singlearray objectAtIndex:7];
    
    //    orders.produce = produce;
    //    NSLog(@"the produce name is %@",orders.produce);
    //
    //    orders.type = [singlearray objectAtIndex:1];
    //    orders.counts = @"1";
    //    orders.ID = [singlearray objectAtIndex:5];
    //
    //    orders.name = [singlearray objectAtIndex:2];
    //    NSLog(@"the order name is %@",orders.name);
    //    orders.price = [singlearray objectAtIndex:4];
    //    orders.rate = [singlearray objectAtIndex:5];
    //    orders.skpmount = [singlearray objectAtIndex:6];
    
    [manage insertOrderInfo:orders];
    // }
    
    SMOrderControllerViewController * order = [[SMOrderControllerViewController alloc] initWithNibName:@"SMOrderControllerViewController" bundle:nil];
    UINavigationController * popUpNavigationController = [[UINavigationController alloc] initWithRootViewController:order];
    order.itemType = @"7";
    
    //order.orderArray = singlearray;
    //settingsController.parentController = self;
    // order.navigationController = self.popUpNavigationController;
    popUpNavigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    popUpNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //popUpNavigationController.navigationBar setTitleTextAttributes:[Aicent_Utility_iPad setTextAttributes];
    [self.navigationController presentViewController:popUpNavigationController animated:YES completion:nil];
}


//添加第一个页面
- (void)addFirstView
{
    ProjectManage * manage = [ProjectManage shardSingleton];
    OrderInfo * orders = [[OrderInfo alloc] init];
    
    orders.counts = @"1";
    NSLog(@"the inset....");
    
    orders.type = @"6";
    orders.counts = @"1";
    orders.ID = [singlearray objectAtIndex:5];
    
    orders.name = [singlearray objectAtIndex:1];
    NSLog(@"the order name is %@",orders.name);
    orders.price = [singlearray objectAtIndex:3];
    orders.rate = [singlearray objectAtIndex:4];
    orders.skpmount = [singlearray objectAtIndex:6];
    
    [manage insertOrderInfo:orders];
    
    SMOrderControllerViewController * order = [[SMOrderControllerViewController alloc] initWithNibName:@"SMOrderControllerViewController" bundle:nil];
    order.itemType = @"6";
    UINavigationController * popUpNavigationController = [[UINavigationController alloc] initWithRootViewController:order];
    
    popUpNavigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    popUpNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController presentViewController:popUpNavigationController animated:YES completion:nil];
    
}


- (void)getLinksWithOutInternet
{
    if ([self.detailImageArray count] == 0) {
        return;
    }
    NSArray * array = [[ProjectManage shardSingleton] getBookRecordByImageName:[self.detailImageArray objectAtIndex:photoIndex]];
    NSLog(@"the deatim image arry is %d",[array count]);

    NSArray * dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString * documentDirectory = [dir objectAtIndex:0];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * fileName;
    
    for (PImageInfo * imageInfo in array)
    {
        int startX = [[imageInfo startX] intValue];
        int startY = [[imageInfo startY] intValue];
        
        int endX = [[imageInfo endX] intValue];
        int endY = [[imageInfo endY] intValue];
      //  NSLog(@"the typs is %d",type);
        if (pointX > startX && pointY > startY && pointX < endX && pointY <endY)
        {
                [self popUpSellWindowWithInfo:(PImageInfo *)imageInfo];
                return;
        }
        
    }
}

- (void)getCoverImage
{
    NSArray * dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * documentDirectory = [dir objectAtIndex:0];
    NSString * dirPath = [documentDirectory stringByAppendingPathComponent:@"cover1"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    self.coverImageArray = [NSMutableArray arrayWithCapacity:10];
    self.idArray = [NSMutableArray arrayWithCapacity:10];
    self.coverVersionArray = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray * bookArray = [NSMutableArray arrayWithCapacity:10];
    self.compArry = [NSMutableArray arrayWithCapacity:10];
    self.subImages = [NSMutableArray arrayWithCapacity:10];
    self.subIdArray = [NSMutableArray arrayWithCapacity:10];
    backArray = [NSMutableArray arrayWithCapacity:10];
    [[ProjectManage shardSingleton] getBookRecordwithid:backstr retun:&bookArray];
    
    [backArray addObject:bookArray];
    NSString * path;
    NSString * fileName;
    
    for (ProjectInfo * book in bookArray)
    {
        NSArray * links = [book.imgUrl componentsSeparatedByString:@"/"];
        fileName = [links objectAtIndex:2];
        path = [NSString stringWithFormat:@"%@/%@/%@",dirPath,book.name,fileName];
        [self.idArray addObject:book.imagesIDs];
        [[ProjectManage shardSingleton] insertCompInDB:book];
        [self.coverVersionArray addObject:book.name];
        [self.compArry addObject:book.compId];
        [self.subImages addObject:book.imagesIDs];
        [self.subIdArray addObject:book.ID];
        
        if ([fileManager fileExistsAtPath:path])
        {
            UIImage * image = [[UIImage alloc] initWithContentsOfFile:path];
            //            [self.coverVersionArray addObject:book.name];
            [self.coverImageArray addObject:image];
        }
        else
        {
            path = [kWSPath stringByAppendingString:book.imgUrl];
            UIImage * image = [self getImageFromURL:path];
            [self.coverImageArray addObject:image];
            //            [self.coverVersionArray addObject:book.name];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [[ProjectManage shardSingleton] saveImage:image withURL:path withCoverName:book.name];
            });
            
        }
        
    }
}


- (void)getDetailImageFromArray:(NSArray *)array
{
    if ([self checkInternet] == NO)
    {
        return;
    }
    self.detailImageArray = [NSMutableArray arrayWithCapacity:10];
    NSString * path;
    self.photos = [NSMutableArray array];
    
    for (ProjectInfo * book in array)
    {
        path = [kWSPath stringByAppendingString:book.imgUrl];
        /**
         *  withName 必须带
         */
        [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString: path] withName:bVersion]];
      //  [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString: path]]];
    }
    if ([self.photos count] > 0) {
        [self performSelectorOnMainThread:@selector(displayPhoto) withObject:nil waitUntilDone:YES];
    }
}

- (UIImage *)getImageFromURL:(NSString *)fileURL
{
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    UIImage * result = [UIImage imageWithData:data];
    return result;
}

#pragma mark -------------
#pragma mark ---- collectionView datasource & delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.coverImageArray.count;
    
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
//    cell.layer.cornerRadius = 8;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[self.coverImageArray objectAtIndex:indexPath.row]];
    imageView.frame = CGRectMake(0, 250, 140, 160);
    
    [cell.contentView addSubview:imageView];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 30, 250)];
    lable.text = [self.coverVersionArray objectAtIndex:indexPath.row];
    NSLog(@"lable text is %@",[self.coverVersionArray objectAtIndex:indexPath.row]);
    //    lable.backgroundColor = [UIColor orangeColor];
    lable.font = [UIFont systemFontOfSize:25];
    lable.numberOfLines = [lable.text length];
    [cell.contentView addSubview:lable];
    
    if (indexPath.row %2 !=0) {
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:186.0/255 blue:204.0/255 alpha:0.8];
        lable.textColor = [UIColor whiteColor];
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
        lable.textColor = [UIColor colorWithRed:1.0 green:178.0/255 blue:212.0/255 alpha:1];
    }
    
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    if (self.idArray == nil || [self.idArray count] == 0)
    {
        NSLog(@"cell local file");
        label.text = [NSString stringWithFormat:@"%@",[self.coverVersionArray objectAtIndex:indexPath.row]];
        label.hidden = YES;
        [cell addSubview:label];
    }
    else
    {
        NSLog(@"cell online file");
        NSString * version = [NSString stringWithFormat:@";%@",[self.coverVersionArray objectAtIndex:indexPath.row]];
        label.text = [[self.idArray objectAtIndex:indexPath.row] stringByAppendingString:version];
        label.hidden = YES;
        [cell addSubview:label];
    }
    
    return cell;
}

- (void)displayPhoto
{
    self.browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // Set options
    self.browser.displayActionButton = NO; // Show action button to allow sharing, copying, etc (defaults to YES)
    self.browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    self.browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    self.browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    self.browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    self.browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    self.browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    self.browser.wantsFullScreenLayout = YES; // iOS 5 & 6 only: Decide if you want the photo browser full screen, i.e. whether the status bar is affected (defaults to YES)
    
    // Optionally set the current visible photo before displaying
    [self.browser setCurrentPhotoIndex:0];
    
    // Present
    [self.navigationController pushViewController:self.browser animated:NO];
    
    // Manipulate
    [self.browser showNextPhotoAnimated:NO];
    [self.browser showPreviousPhotoAnimated:NO];
    // [browser setCurrentPhotoIndex:10];
}

- (void)playMovie:(NSString *)url
{
    NSURL * playURL = [NSURL URLWithString:url];
    
    movPl =  [[MPMoviePlayerViewController alloc]
              initWithContentURL:playURL];
    [self presentMoviePlayerViewControllerAnimated:movPl];
}

- (void)playMovieWithPath:(NSString *)path
{
    //NSURL * playURL = [NSURL URLWithString:url];
    NSURL *playURL = [NSURL fileURLWithPath:path];
    movPl =  [[MPMoviePlayerViewController alloc]
              initWithContentURL:playURL];
    [self presentMoviePlayerViewControllerAnimated:movPl];
}
- (void)downloadWithURL:(NSString *)videoPath
{
    NSString * path;
    NSArray * dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString * documentDirectory = [dir objectAtIndex:0];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString * fileName;
    if ([videoPath rangeOfString:@"resources/videos"].location != NSNotFound ) {
        
        path = [documentDirectory stringByAppendingPathComponent:@"video"];
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


- (void)saveResourceByDownloadWithIDs:(NSString *)ids
{
    NSMutableArray * array = [NSMutableArray  arrayWithCapacity:10];
    [[ProjectManage shardSingleton] getDetailRecordWithID:ids returnList:&array];
    
    self.detailRecordArray = array;
    NSLog(@"the detail record array is %d",[array count]);
    [NSThread detachNewThreadSelector:@selector(getDetailImageFromArray:) toTarget:self withObject:array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (ProjectInfo * book in array)
        {
            PImageInfo * imageInfo = [[PImageInfo alloc] init];
            imageInfo.bookVersion = bVersion;
            imageInfo.imgUrl =  book.imgUrl;
            
            if ([book.link count] > 0)
            {
                for (NSDictionary * dict in book.link)
                {
                    imageInfo.startX = [[dict objectForKey:@"startX"] stringValue];
                    imageInfo.startY = [[dict objectForKey:@"startY"] stringValue];
                    imageInfo.endX = [[dict objectForKey:@"endX"] stringValue];
                    
                    imageInfo.endY = [[dict objectForKey:@"endY"] stringValue];
                    imageInfo.linkurl = [dict objectForKey:@"link"];
                    if (![[ProjectManage shardSingleton] isExistImageWithName:imageInfo.linkurl withVersion:imageInfo.bookVersion withType:1])
                    {
                        [[ProjectManage shardSingleton] insertBookInfo:imageInfo];
                    }
                }
            }
            else
            {
                if (![[ProjectManage shardSingleton] isExistImageWithName:imageInfo.imgUrl withVersion:imageInfo.bookVersion withType:0])
                {
                    [[ProjectManage shardSingleton] insertBookInfo:imageInfo];
                }
            }
        }
    });
    
}

- (void)getResourceByVersion:(NSString *)onLineID
{
    NSLog(@"the onlineID IS %@",onLineID);
    NSMutableArray * array = [NSMutableArray  arrayWithCapacity:10];
    
    if ([self checkInternet]) {
        [[ProjectManage shardSingleton] getDetailRecordWithID:onLineID returnList:&array];
        
        self.detailRecordArray = array;
        NSLog(@"this is self.detailRecordArray %@",self.detailRecordArray);
    }
    
    
    NSArray * dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString * documentDirectory = [dir objectAtIndex:0];
    NSString * dirPath = [documentDirectory stringByAppendingPathComponent:@"ephoto"];
    NSString * resourcePath = [NSString stringWithFormat:@"%@/%@",dirPath,bVersion];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:resourcePath])
    {
        if (![self checkInternet])
        {
            [SGInfoAlert showInfo:@"本地无存储数据文件，请连接网络后重试！"
                          bgColor:[[UIColor blackColor] CGColor]
                           inView:self.view
                         vertical:0.4];
            
            return;
        }else{
        
     //   if ([self checkInternet]) {
            [self saveResourceByDownloadWithIDs:onLineID];
            return;
    //    }
    }
    }
    
    NSArray * r = [[ProjectManage shardSingleton] getBookRecordByVersion:bVersion];
    
    NSMutableArray *resourceArray = [[NSMutableArray alloc]initWithArray:r];
    NSString * fileName;
    
#pragma mark 修改
    NSMutableDictionary*d = [NSMutableDictionary dictionaryWithCapacity:10];
    int size = resourceArray.count;
    for (int i = 0; i < size; i++) {
        PImageInfo * imageInfo = resourceArray[i];
        if ([d objectForKey:imageInfo.imgUrl]) {
            [resourceArray removeObject:imageInfo];
            i--;
            size--;
        }else{
            [d setObject:@"www" forKey:imageInfo.imgUrl];
        }
    }
    
    self.photos = [NSMutableArray array];
    self.detailImageArray = [NSMutableArray arrayWithCapacity:10];
    
    for (PImageInfo * imageInfo in resourceArray)
    {
        NSArray * links = [imageInfo.imgUrl componentsSeparatedByString:@"/"];
        fileName = [links objectAtIndex:2];
        NSString * path = [NSString stringWithFormat:@"%@/%@/%@",dirPath,bVersion,fileName];
        NSLog(@"the path is %@",path);
        if ([fileManager fileExistsAtPath:path])
        {
            UIImage * image = [[UIImage alloc] initWithContentsOfFile:path];
            
            if (![self.detailImageArray containsObject:fileName])
            {
                NSLog(@"local file");
                [self.detailImageArray addObject:fileName];
                [self.photos addObject:[MWPhoto photoWithImage:image]];
                
            }else{
                if ([self checkInternet])
                {
                    NSLog(@"online file");
                    path = [kWSPath stringByAppendingString:imageInfo.imgUrl];
                    [self.detailImageArray addObject:fileName];
                 //   [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString: path] withName:bVersion]];
                    [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString: path]]];
                }

            }
//            if ([self checkInternet])
//            {
//                NSLog(@"online file");
//                path = [kWSPath stringByAppendingString:imageInfo.imgUrl];
//                [self.detailImageArray addObject:fileName];
//                [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString: path] withName:bVersion]];
//            }
        }
        else
        {
            
        }
        
    }

//    
    if ([self.photos count] > 0)
    {
        [self performSelectorOnMainThread:@selector(displayPhoto) withObject:nil waitUntilDone:YES];
    }
    else
    {
        [SGInfoAlert showInfo:@"本地无存储数据文件，请连接网络后重试！"
                      bgColor:[[UIColor blackColor] CGColor]
                       inView:self.view
                     vertical:0.4];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 1)
    {
        if (buttonIndex == 1)
        {
            [self.coverImageArray removeObjectAtIndex:self.itemIndex];
            NSLog(@"the cover array count is %lu, the version array count is %lu", (unsigned long)[self.coverImageArray count],[self.coverVersionArray count]);
            NSString * coverName = [self.coverVersionArray objectAtIndex:self.itemIndex];
            if (coverName.length > 0) {
                NSArray * dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                NSString * documentDirectory = [dir objectAtIndex:0];
                NSString * dirPath = [documentDirectory stringByAppendingPathComponent:@"cover1"];
                NSFileManager *fileManager = [NSFileManager defaultManager];
                NSLog(@"the delete file name is %@",coverName);
                NSString * filePath = [dirPath stringByAppendingPathComponent:coverName];
                if ([fileManager fileExistsAtPath:filePath]) {
                    [fileManager removeItemAtPath:filePath error:NULL];
                    NSLog(@"remove file path is at %@",filePath);
                    dirPath = [documentDirectory stringByAppendingPathComponent:@"ephoto"];
                    filePath = [dirPath stringByAppendingPathComponent:coverName];
                    [fileManager removeItemAtPath:filePath error:NULL];
                    NSLog(@"remove file path is at %@",filePath);
                }
                if ([[ProjectManage shardSingleton] deleteBookInfo:coverName]) {
                    
                    NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];
                    [array addObject:[self.subIdArray objectAtIndex:self.itemIndex]];
                    [[ProjectManage shardSingleton] findcoverbycompid:[self.subIdArray objectAtIndex:self.itemIndex] andArray:array];
                    NSLog(@"%@",[self.subIdArray objectAtIndex:self.itemIndex]);
                    NSLog(@"%@",array);
                    if ([[ProjectManage shardSingleton] deletecover:array]) {
                        NSLog(@"success");
                    }else
                    {
                        NSLog(@"error");
                    }
                    
                    [self.coverVersionArray removeObjectAtIndex:self.itemIndex];
                    NSLog(@"delete record form bookInfo according to name,the name is %@",coverName);
                }
                
            }
            [self.collectionView reloadData];
            
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * recordID;
    
    if ( [[self.subImages objectAtIndex:indexPath.row] isEqualToString:@""]||[[self.subImages objectAtIndex:indexPath.row] isEqualToString:@"null"] || [self.subImages objectAtIndex:indexPath.row] == nil) {
        [self.collectionView removeFromSuperview];
        self.coverImageArray = nil;
        
        NSMutableArray * bookArray = [self getdatawithindexPath:indexPath.row];
        [backArray addObject:bookArray];
        // NSLog(@"backarray is %@",backArray);
        
        
        [self initviewBybookId:bookArray];
        
        NSLog(@"self.comparry is %lu",self.compArry.count);
        
        if (!self.compArry.count == 0) {
            backstr = [self.compArry objectAtIndex:0];
        }
        
        backname = bVersion;
        
        NSLog(@"backname is %@",backname);
//        [buttonItem setTitle:backname];
       return;
    }
    
    
    
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    for (UIView *view in cell.subviews)
    {
        if ([view isKindOfClass:[UILabel class]])
        {
            UILabel * label = (UILabel *)view;
            if ([label.text rangeOfString:@";"].location == NSNotFound)
            {
                bVersion = label.text;
                
            }
            else
            {
                NSArray * stringArray = [label.text componentsSeparatedByString:@";"];
                recordID = [stringArray objectAtIndex:0];
                bVersion = [stringArray objectAtIndex:1];
            }
        }
    }
    backname = bVersion;
    
    NSLog(@"backname is %@",backname);
    NSLog(@"record id is %@",recordID);
    [self getResourceByVersion:recordID];
//    [buttonItem setTitle:@"112"];
}
- (void) initviewBybookId:(NSMutableArray *)bookArray
{
    if (bookArray) {
        self.coverImageArray = [NSMutableArray arrayWithCapacity:10];
        self.idArray = [NSMutableArray arrayWithCapacity:10];
        self.coverVersionArray = [NSMutableArray arrayWithCapacity:10];
        self.compArry = [NSMutableArray arrayWithCapacity:10];
        self.subImages = [NSMutableArray arrayWithCapacity:10];
        self.subIdArray = [NSMutableArray arrayWithCapacity:10];
        
        
        NSString * path;
        NSString * fileName;
        
        NSLog(@"bookArray is %@",bookArray);
        for (ProjectInfo * book in bookArray)
        {
            [[ProjectManage shardSingleton] insertCompInDB:book];
            
            
            UIImage * image = nil;
            
            NSString *filePath = [self getcoverimagepath:book.name];
            //            [self.coverVersionArray addObject:book.name];
            NSLog(@"name is %@",book.name);
            if (filePath) {
                image = [UIImage imageWithContentsOfFile:filePath];
                
            }else{
                
                if ([self checkInternet]) {
                    path = [kWSPath stringByAppendingString:book.imgUrl];
                    image = [self getImageFromURL:path];
                }else{
                    
                }
                
            }
            
            if (image) {
                [self.coverImageArray addObject:image];
            }
            
            [self.coverVersionArray addObject:book.name];
            [self.compArry addObject:book.compId];
            [self.subImages addObject:book.imagesIDs];
            NSLog(@"%@",book.imagesIDs);
            
            
            [self.subIdArray addObject:book.ID];
            [self.idArray addObject:book.imagesIDs];
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [[ProjectManage shardSingleton] saveImage:image withURL:path withCoverName:book.name];
            });
            
        }
        
        [self initCollectionView];
        self.collectionView.frame = CGRectMake(0, 64, 1024, 768-64);
    }
}

- (NSMutableArray *)getdatawithindexPath:(NSInteger )row
{
    NSLog(@"subarry is %@",[NSString stringWithFormat:@"%@",[self.subIdArray objectAtIndex:row] ]);
    
    NSMutableArray * bookArray = [NSMutableArray arrayWithCapacity:10];
    if ([self checkInternet]) {
        
        NSLog(@"bookarray is %@",[self.subIdArray objectAtIndex:row]);
        
        [[ProjectManage shardSingleton] getBookRecordwithid:[self.subIdArray objectAtIndex:row] retun:&bookArray];
        
    }else
    {
        [[ProjectManage shardSingleton] searchInDbBycompId:[self.subIdArray objectAtIndex:row] returnArray:&bookArray];
    }
    NSLog(@"bookarry is %@",bookArray);
    return bookArray;
}


- (void)didLogPressCellToDelete:(UILongPressGestureRecognizer*)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:tapLocation];
    if (indexPath && gesture.state == UIGestureRecognizerStateBegan)
    {
        self.itemIndex = indexPath.item;
        self.indexPath = indexPath;
        UIAlertView * deleteAlert = [[UIAlertView alloc]
                                     initWithTitle:@"删除?"
                                     message:@"确定要删除这张图片吗?"
                                     delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"确定", nil];
        [deleteAlert show];
        [deleteAlert setTag:1];
        
    }
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        NSLog(@"the phots index is %d",index);
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
    photoIndex = index;
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return [[_selections objectAtIndex:index] boolValue];
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
    photoIndex = index;
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)getCoverImageWithOutInternet
{
    self.coverImageArray = [NSMutableArray arrayWithCapacity:10];
    self.idArray = [NSMutableArray arrayWithCapacity:10];
    self.coverVersionArray = [NSMutableArray arrayWithCapacity:10];
    self.compArry = [NSMutableArray arrayWithCapacity:10];
    self.subImages = [NSMutableArray arrayWithCapacity:10];
    self.subIdArray = [NSMutableArray arrayWithCapacity:10];
    backArray = [NSMutableArray arrayWithCapacity:10];
    
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    [[ProjectManage shardSingleton] searchInDbBycompId:backstr returnArray:&array];
    [backArray addObject:array];
    for (ProjectInfo *projectinfo in array) {
        [self.subIdArray addObject:projectinfo.ID];
        [self.subImages addObject:projectinfo.imagesIDs];
        [self.compArry addObject:projectinfo.compId];
        NSString *filePath = [self getcoverimagepath:projectinfo.name];
        [self.coverVersionArray addObject:projectinfo.name];
        NSLog(@"name is %@",projectinfo.name);
        if (filePath) {
            UIImage * image = [UIImage imageWithContentsOfFile:filePath];
            [self.coverImageArray addObject:image];
        }else{
            
            
        }
        
        
    }
}

- (NSString *)getcoverimagepath:(NSString *)name
{
    NSString * docsDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * dirPath = [docsDir stringByAppendingPathComponent:@"cover1"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError * error;
    NSArray *fileList = [[NSArray alloc] init];
    
    //获得指定文件夹中的所有文件
    BOOL isDir = NO;
    fileList = [fileManager contentsOfDirectoryAtPath:dirPath error:&error];
    
    for (NSString *file in fileList) {
        
        //NSString * path = [dirPath stringByAppendingPathComponent:file];
        if ([file isEqualToString:name]) {
            NSString * path = [dirPath stringByAppendingPathComponent:file];
            [fileManager fileExistsAtPath:path isDirectory:(&isDir)];
            //            [self.coverVersionArray addObject:file];
            NSString * filePath;
            NSArray * file = [fileManager subpathsOfDirectoryAtPath:path error:nil];
            for (NSString * name1 in file)
            {
                //添加/号，使之变成一个完整的路径
                filePath = [path stringByAppendingPathComponent:name1];
                //                UIImage * image = [UIImage imageWithContentsOfFile:filePath];
                //                [self.coverImageArray addObject:image];
                return filePath;
            }
            
            break;
        }
        isDir = NO;
        
    }
    
    return nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
