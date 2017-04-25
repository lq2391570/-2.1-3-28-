//
//  E-bookViewController.m
//  shengmeng
//
//  Created by 石榴花科技 on 14-4-1.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import "EbookViewController.h"
#import "SDImageCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import "EBookManage.h"
#import "Reachability.h"
#import "MWPhotoBrowser.h"
#import "TCBlobDownload.h"
#import "TCBlobDownloadManager.h"
#import "SGInfoAlert.h"
#import <UIKit/UIKit.h>
#import "XMLmanage.h"
#import "SMOrderControllerViewController.h"
#import "ProjectManage.h"

#define kAnimationDuration 0.1
#define BGCOLOR [UIColor colorWithRed:251.0/255 green:168.0/255 blue:196.0/255 alpha:1]//设置标题颜色
@interface EbookViewController ()
{
    MPMoviePlayerViewController * movPl;
    NSMutableArray * backArray;
    UITableView * tableViewFirst;//第一个表
    UITableView * tableViewSecond;//第二个表
    UIView * FirstView;
    UIView * SecondView;
    UIView * ThirdView;
NSMutableArray * singlearray;
    
}

@property (nonatomic, strong) NSMutableArray * coverImageArray;//封面图片的数组

@property (nonatomic, strong) NSMutableArray * coverVersionArray;//封面文件名数组
@property (nonatomic, strong) NSMutableArray * compArry;
@property (nonatomic, strong) NSMutableArray * subImages;
@property (nonatomic, strong) NSMutableArray * subIdArray;

@property (nonatomic, strong) NSMutableArray * smallLinksArray;
@property (nonatomic, strong) NSMutableArray * linksPointArray;
@property (nonatomic, strong) NSMutableArray * detailRecordArray;
@property (nonatomic, strong) NSArray * photoArray;
@property (nonatomic, strong) NSMutableArray * idArray;
@property (nonatomic) int itemIndex;
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong)  MWPhotoBrowser * browser;
@property (nonatomic, strong) NSMutableArray * datesource;//单件销售商品数据
@property (nonatomic, strong) NSMutableArray * mutabledate;//全部订单数
@property (nonatomic, strong) NSMutableArray * NumberArray;

@end

int pointX;
int pointY;
NSInteger photoIndex;
NSString * bVersion;
int internetOnline;
static NSString *backstr = @"-1";//记录返回compid
//int internetOnline;//判断网络
int flag;

@implementation EbookViewController

@synthesize coverImageArray = _coverImageArray;
@synthesize idArray = _idArray;
@synthesize detailImageArray = _detailImageArray;
@synthesize smallLinksArray = smallLinksArray_;
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
    self.title = NSLocalizedString(@"电子画册", nil);
    self.photoArray = [NSArray array];
    //注册通知
    [self registerUpdateNotification];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar"] forBarMetrics:UIBarMetricsDefault];

    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    buttonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = buttonItem;
    self.navigationController.navigationBarHidden = NO;
    [self initCollectionView];
   
    self.datesource = [NSMutableArray arrayWithCapacity:1];
    self.mutabledate = [NSMutableArray arrayWithCapacity:3];
   
}

- (void)back
{
    
    NSLog(@"backstr is %@",backstr);
    if ( [backstr isEqual:@"-1"]) {
         [self.navigationController popToRootViewControllerAnimated:YES];
    }else
    {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:2];
       arr = [[EBookManage shardSingleton] findbackBycompId:backstr];
       
        NSLog(@"arr is %@",arr);
        [self.collectionView removeFromSuperview];
       [self initviewBybookId:arr];
        //[backArray removeObjectAtIndex:backArray.count - 1];
        
        if ([self.compArry objectAtIndex:0]) {
            backstr = [self.compArry objectAtIndex:0];
        }

    }
    
//    if (backArray.count <=1) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }else {
//        [self.collectionView removeFromSuperview];
//        [self initviewBybookId:[backArray objectAtIndex:backArray.count - 2]];
//        [backArray removeObjectAtIndex:backArray.count - 1];
//    }

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
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768) collectionViewLayout:layout];
    //    self.collectionV setb
    UIImageView *BgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    BgimageView.image = [UIImage imageNamed:@"smbg模糊bg"];
    //    [self.collectionV addSubview:BgimageView];
    [self.collectionView setBackgroundView:BgimageView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    //    UINib *cellNib = [UINib nibWithNibName:@"ProjectCell" bundle:nil];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLogPressCellToDelete:)];
    longPress.delegate = self;
    [self.collectionView addGestureRecognizer:longPress];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    if ([self checkInternet])
    {
        internetOnline=1;
        [self getCoverImage];
    }
    else
    {
        internetOnline=0;
        [self getCoverImageWithOutInternet];
    }
    
    self.navigationController.navigationBarHidden = NO;
    
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
//触摸通知事件
- (void)handleTouchNotification:(NSNotification *)notification {
	
    NSLog(@"dsadafwqeqqewas");
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
    NSLog(@"th point x online is %d",pointX);
    NSLog(@"th point y online is %d",pointY);
    
    [self getLinksWithOutInternet];
 //   [self addFirstView];
    
   // [self sellMyGoods];
}
//添加第一个页面
//- (void)addFirstView
//{
//    self.datesource = [NSMutableArray arrayWithObjects:@"13", nil];
//    
//    FirstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
//    FirstView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
//    FirstView.userInteractionEnabled = YES;
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(260, 460, 200, 40);
//    button.backgroundColor = [UIColor redColor];
//    [button setTitle:@"返回并继续添加" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(buttonclick) forControlEvents:UIControlEventTouchUpInside];
//    [FirstView addSubview:button];
//    
//    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button2.frame = CGRectMake(540, 460, 200, 40);
//    button2.backgroundColor = [UIColor redColor];
//    [button2 setTitle:@"结账" forState:UIControlStateNormal];
//    [button2 addTarget:self action:@selector(Button2Click) forControlEvents:UIControlEventTouchUpInside];
//    [FirstView addSubview:button2];
//    
//    tableViewFirst = [[UITableView alloc] initWithFrame:CGRectMake(220, 280, 563, (self.datesource.count + 1)*50)];
//    tableViewFirst.dataSource = self;
//    tableViewFirst.delegate = self;
//   
//    tableViewFirst.alpha = 1;
//    tableViewFirst.rowHeight = 50;
//    [tableViewFirst setSeparatorColor:[UIColor blackColor]];
//    [FirstView addSubview:tableViewFirst];
//    
//    [self.browser.view addSubview:FirstView];
//}
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

//返回继续添加按钮
- (void)buttonclick
{
    UILabel *lable = (UILabel *)[self.browser.view viewWithTag:100];
    
    [lable removeFromSuperview];
    
    self.NumberArray = [NSMutableArray arrayWithCapacity:3];
    for (int i = 1; i< self.datesource.count +1; i++) {
         NSIndexPath *pathOne=[NSIndexPath indexPathForRow:i inSection:0];
        CustomCell *cellone = (CustomCell *)[tableViewFirst cellForRowAtIndexPath:pathOne];
        [self.NumberArray addObject: cellone.textfiled.text];
    }
    NSLog(@"this is numberArray value: %@",self.NumberArray);
    
    [FirstView removeFromSuperview];
}
//结账按钮
- (void)Button2Click
{
    [FirstView removeFromSuperview];
    
    [self.mutabledate addObject:[self.datesource objectAtIndex:0]];
    
    [self addSecondView];
}
//添加第二层页面
- (void)addSecondView
{
     [self.mutabledate addObject:[self.datesource objectAtIndex:0]];
    
    int a = (int)self.mutabledate.count;
    if (self.mutabledate.count > 2) {
        a = 2;
    }
    
    FirstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    FirstView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    FirstView.userInteractionEnabled = YES;

    tableViewSecond = [[UITableView alloc] initWithFrame:CGRectMake(220, 280, 650, (a + 1)*50)];
    tableViewSecond.dataSource = self;
    tableViewSecond.delegate = self;
    tableViewSecond.rowHeight = 50;
    [tableViewSecond setSeparatorColor:[UIColor blackColor]];
    [FirstView addSubview:tableViewSecond];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(260, 460, 200, 40);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonclickWithTwo) forControlEvents:UIControlEventTouchUpInside];
    [FirstView addSubview:button];
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(540, 460, 200, 40);
    button2.backgroundColor = [UIColor redColor];
    [button2 setTitle:@"下一步" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(Button2ClickWithTwo) forControlEvents:UIControlEventTouchUpInside];
    [FirstView addSubview:button2];

    [self.browser.view addSubview:FirstView];
}
//第二层页面返回按钮
- (void)buttonclickWithTwo
{
    [FirstView removeFromSuperview];
    [self addFirstView];
}
//下一步按钮
- (void)Button2ClickWithTwo
{
    [FirstView removeFromSuperview];
    
    [self addThirdView];
}
//添加卡号确认页面
- (void)addThirdView
{
    [self.mutabledate addObject:[self.datesource objectAtIndex:0]];
    
    FirstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    FirstView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    FirstView.userInteractionEnabled = YES;
    
    //添加卡号
    UILabel * cardNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(400, 300, 80, 40)];
    cardNumberLable.text = @"卡号：";
    [FirstView addSubview:cardNumberLable];
    
    //添加密码
    UILabel * passWordLable = [[UILabel alloc] initWithFrame:CGRectMake(400, 350, 80, 40)];
    passWordLable.text = @"密码：";
    [FirstView addSubview:passWordLable];
    
    //添加卡号输入框
    UITextField * cardNumbertextfiled = [[UITextField alloc] initWithFrame:CGRectMake(470, 300, 200, 40)];
    cardNumbertextfiled.backgroundColor = [UIColor redColor];
    [FirstView addSubview:cardNumbertextfiled];
    
    //添加密码输入框
    UITextField * passWordNumberTextfiled = [[UITextField alloc] initWithFrame:CGRectMake(470, 350, 200, 40)];
    passWordNumberTextfiled.backgroundColor = [UIColor redColor];
    [FirstView addSubview:passWordNumberTextfiled];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(260, 460, 200, 40);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonclickWithThree) forControlEvents:UIControlEventTouchUpInside];
    [FirstView addSubview:button];
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(540, 460, 200, 40);
    button2.backgroundColor = [UIColor redColor];
    [button2 setTitle:@"下一步" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(Button2ClickWithThree) forControlEvents:UIControlEventTouchUpInside];
    [FirstView addSubview:button2];
    
    [self.browser.view addSubview:FirstView];
}

- (void)buttonclickWithThree
{
    [FirstView removeFromSuperview];
    [self addSecondView];
}

- (void)Button2ClickWithThree
{
    [FirstView removeFromSuperview];
    
    [self addFourView];
}

- (void)addFourView
{
    FirstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    FirstView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    FirstView.userInteractionEnabled = YES;
    
    tableViewSecond = [[UITableView alloc] initWithFrame:CGRectMake(220, 240, 650, 150)];
    tableViewSecond.dataSource = self;
    tableViewSecond.delegate = self;
    tableViewSecond.rowHeight = 50;
    [tableViewSecond setSeparatorColor:[UIColor blackColor]];
    [FirstView addSubview:tableViewSecond];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(260, 460, 200, 40);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonclickWithFour) forControlEvents:UIControlEventTouchUpInside];
    [FirstView addSubview:button];
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(540, 460, 200, 40);
    button2.backgroundColor = [UIColor redColor];
    [button2 setTitle:@"下一步" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(Button2ClickWithFour) forControlEvents:UIControlEventTouchUpInside];
    [FirstView addSubview:button2];

    
   [self.browser.view addSubview:FirstView];
}

- (void)buttonclickWithFour
{
    [FirstView removeFromSuperview];
    [self addThirdView];
}

- (void)Button2ClickWithFour
{
    [FirstView removeFromSuperview];
}

- (void)sellMyGoods
{
//    if ([self.detailRecordArray count] == 0 || [self.detailRecordArray count] < photoIndex)
//    {
//        return;
//    }
    
     EBookInfo * bookInfo = [self.detailRecordArray objectAtIndex:photoIndex];
    NSLog(@"photoIndex is %d",photoIndex);
    NSLog(@"self.detailRecordArray is %@",bookInfo.link);
    for (NSDictionary * dict in bookInfo.link)
    {
        int startX = [[dict objectForKey:@"startX"] intValue];
        int startY = [[dict objectForKey:@"startY"] intValue];
        int endX = [[dict objectForKey:@"endX"] intValue];
        int endY = [[dict objectForKey:@"endY"] intValue];
        int type = [[dict objectForKey:@"type"] intValue];
        NSLog(@"wode app %d",type);
        
       
        
//        NSString * path;
//        path = [kWSPath stringByAppendingString: [dict objectForKey:@"link"]];
//        if (pointX > startX && pointY > startY && pointX < endX && pointY <endY)
//        {
//            if ([[dict objectForKey:@"link"] rangeOfString:@".jpg"].location == NSNotFound)
//            {
//                // [self.smallLinksArray addObject:path];
//                if (pointX > startX && pointY > startY && pointX < endX && pointY <endY)
//                {
//                    [self playMovieWithPath:path];
//                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                        [self downloadWithURL:path];
//                    });
//                    
//                    return;
//                }
//            }
//            else
//            {
//                for (int i = 0; i < [self.detailRecordArray count]; i ++)
//                {
//                    NSArray * array = [path componentsSeparatedByString:@"resources/images/"];
//                    NSString * fileName = [array objectAtIndex:1];
//                    EBookInfo * info = [self.detailRecordArray objectAtIndex:i];
//                    if ([info.imgUrl rangeOfString:fileName].location != NSNotFound)
//                    {
//                        [self.browser jumpToPageAtIndex:i animated:NO];
//                        return;
                        
//                    }
                }


}

#pragma mark - tableView datasource & delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == tableViewFirst) {
        return self.datesource.count + 1;
    }
    else if(tableView == tableViewSecond)
    {
        return self.mutabledate.count + 1;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableViewFirst) {
        static NSString * ID = @"mycell";
        static NSString * ident = @"titlecell";
        
        if (indexPath.row == 0) {
            TitleCell *cell = (TitleCell *)[tableView dequeueReusableCellWithIdentifier:ident];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"TitleCell" owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            
            
            cell.lable1.backgroundColor = BGCOLOR;
            cell.lable2.backgroundColor = BGCOLOR;
            cell.lable3.backgroundColor = BGCOLOR;
            cell.lable4.backgroundColor = BGCOLOR;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.alpha = 1;
            
            return cell;
            
        }
        
        else
        {
            CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            
            if (self.NumberArray != nil) {
                cell.textfiled.text = [self.NumberArray objectAtIndex:indexPath.row-1];
            }
            
            cell.lable1.text = @"美体护肤";
            
            cell.lable3.text = @"60%";
            cell.lable4.text = @"200";
            cell.lable1.backgroundColor = [UIColor clearColor];
            
            cell.lable3.backgroundColor = [UIColor clearColor];
            cell.lable4.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.alpha = 1;
            
            return cell;
            
        }

    }
    
    else if (tableView == tableViewSecond)
    {
        static NSString * secondid = @"secondtitlecell";
        static NSString * ident = @"secondcell";
        
        if (indexPath.row == 0) {
            SecondCustomTitleCell *cell = (SecondCustomTitleCell *)[tableView dequeueReusableCellWithIdentifier:secondid];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"SecondCustomTitleCell" owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            
            cell.lable1.backgroundColor = BGCOLOR;
            cell.lable2.backgroundColor = BGCOLOR;
            cell.lable3.backgroundColor = BGCOLOR;
            cell.lable4.backgroundColor = BGCOLOR;
            cell.lable5.backgroundColor = BGCOLOR;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.alpha = 1;

            return cell;
        }
        
        else
        {
            SecondCustomCell *cell = (SecondCustomCell *)[tableView dequeueReusableCellWithIdentifier:ident];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"SecondCustomCell" owner:self options:nil];
                cell = [array objectAtIndex:0];

            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = CGRectMake(561, 0, 117, 30);
            button.tag = indexPath.row +100;
            button.backgroundColor = [UIColor redColor];
            [button addTarget:self action:@selector(deleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:button];
            
            return cell;
        }

    }
    return nil;
}
//删除事件
- (void)deleButtonClick:sender
{
    UIButton *button = (UIButton *)sender;
    [self.mutabledate removeObjectAtIndex:button.tag-101];
    [tableViewSecond reloadData];
    
}

- (void)imageRedirectInBorwseWithFileName:(NSString *)fileName
{
    for (int i = 0; i < [self.detailImageArray count]; i++)
    {
        if ([fileName isEqualToString:[self.detailImageArray objectAtIndex:i]] == YES)
        {
            [self.browser jumpToPageAtIndex:i animated:NO];
            return;
        }
    }
}

- (void)getLinksWithOutInternet
{
    if ([self.detailImageArray count] == 0) {
        return;
    }
    NSArray * array = [[EBookManage shardSingleton] getBookRecordByImageName:[self.detailImageArray objectAtIndex:photoIndex]];
    NSArray * dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString * documentDirectory = [dir objectAtIndex:0];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * fileName;
    
    for (ImageInfo * imageInfo in array)
    {
        int startX = [[imageInfo startX] intValue];
        int startY = [[imageInfo startY] intValue];
        
        int endX = [[imageInfo endX] intValue];
        int endY = [[imageInfo endY] intValue];
        if (pointX > startX && pointY > startY && pointX < endX && pointY <endY)
        {
            [self popUpSellWindowWithInfo:(ImageInfo *)imageInfo];
            return;
        }

//        if (pointX > startX && pointY > startY && pointX < endX && pointY <endY)
//        {
//            if (imageInfo.linkurl.length > 0)
//            {
//                if ([imageInfo.linkurl rangeOfString:@"resources/images"].location != NSNotFound)
//                {
//                    NSArray * links = [imageInfo.linkurl componentsSeparatedByString:@"/"];
//                    fileName = [links objectAtIndex:2];
//                    
//                    NSString * dirPath = [documentDirectory stringByAppendingPathComponent:@"ephoto"];
//                    NSString * path = [NSString stringWithFormat:@"%@/%@/%@",dirPath,bVersion,fileName];
//                    
//                    if ([fileManager fileExistsAtPath:path])
//                        
//                    {
//                        [self imageRedirectInBorwseWithFileName:fileName];
//                    }
//                    else
//                    {
//                        if (![self checkInternet])
//                        {
//                            NSLog(@"image redirect failed because check internet failed");
//                            return;
//                        }
//                        NSLog(@"image redirect success");
//                        
//                        path = [kWSPath stringByAppendingString:imageInfo.linkurl];
//                        [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString: path] withName:bVersion]];
//                       // [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString: path]]];
//                        [self.detailImageArray addObject:fileName];
//                        [self imageRedirectInBorwseWithFileName:fileName];
//                    }
//                }
//                else
//                {
//                    NSArray * links = [imageInfo.linkurl componentsSeparatedByString:@"/"];
//                    fileName = [links objectAtIndex:2];
//                    
//                    NSString * dirPath = [documentDirectory stringByAppendingPathComponent:@"video"];
//                    NSString * path = [NSString stringWithFormat:@"%@/%@",dirPath,fileName];
//                    if ([fileManager fileExistsAtPath:path])
//                    {
//                        [self playMovieWithPath:path];
//                        
//                    }
//                    else
//                    {
//                        if (![self checkInternet])
//                        {
//                            NSLog(@"video redirect failed because check internet failed");
//                            return;
//                        }
//                        NSLog(@"video redirect success");
//                        path = [kWSPath stringByAppendingString:imageInfo.linkurl];
//                        [self playMovie:path];
//                        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                            [self downloadWithURL:path];
//                        });
//                    }
//                }
//                
//                
//            }
//            
//        }
        
    }
}
- (void)popUpSellWindowWithInfo:(ImageInfo *)imageInfo
{
    NSLog(@"the detail record array count is %d",self.detailRecordArray.count);
    
    if ([self.detailRecordArray count] == 0 || [self.detailRecordArray count] < photoIndex)
    {
        
        return;
    }
    
    EBookInfo * bookInfo = [self.detailRecordArray objectAtIndex:photoIndex];
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
            
            NSLog(@"type=%d",type);
            //type==2（跳转图片）
            if (type==2) {
                NSLog(@"imageUrl=%@",bookInfo.imgUrl);
                Information *info = [[XMLmanage shardSingleton] analysisXMLWithID:link withUSID:usid withtype:type];
                NSLog(@"self.photos=%@",self.detailImageArray);
                NSArray *imageStrArray=[info.ID componentsSeparatedByString:@"/"];
                NSString *imageStr=[imageStrArray lastObject];
                NSLog(@"imageStr=%@",imageStr);
                //遍历数组
                [self.detailImageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([imageStr isEqualToString:obj]) {
                       * stop=YES;
                        NSLog(@"idx=%ld",idx);
//                        photoIndex=idx;
                        [self.browser jumpToPageAtIndex:idx animated:NO];
                    }
                }];
            }
            /**
             *  type==0 播放视频
             */
            if (type==0) {
                 Information *info = [[XMLmanage shardSingleton] analysisXMLWithID:link withUSID:usid withtype:type];
                
                [self playMovie:[NSString stringWithFormat:@"%@%@",kWSPath,info.ID]];
                
            }
            
            
            
            
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

- (void)getCoverImage
{
    NSArray * dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * documentDirectory = [dir objectAtIndex:0];
    NSString * dirPath = [documentDirectory stringByAppendingPathComponent:@"cover"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    self.coverImageArray = [NSMutableArray arrayWithCapacity:10];
    self.idArray = [NSMutableArray arrayWithCapacity:10];
    self.coverVersionArray = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray * bookArray = [NSMutableArray arrayWithCapacity:10];
    self.compArry = [NSMutableArray arrayWithCapacity:10];
    self.subImages = [NSMutableArray arrayWithCapacity:10];
    self.subIdArray = [NSMutableArray arrayWithCapacity:10];
    backArray = [NSMutableArray arrayWithCapacity:10];
    [[EBookManage shardSingleton] getBookRecordwithid:backstr retun:&bookArray];
    [backArray addObject:bookArray];
    NSString * path;
    NSString * fileName;
    
    for (EBookInfo * book in bookArray)
    {
        NSArray * links = [book.imgUrl componentsSeparatedByString:@"/"];
        fileName = [links objectAtIndex:2];
        path = [NSString stringWithFormat:@"%@/%@/%@",dirPath,book.name,fileName];
        [self.idArray addObject:book.imagesIDs];
        [[EBookManage shardSingleton] insertCompInDB:book];
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
                [[EBookManage shardSingleton] saveImage:image withURL:path withCoverName:book.name];
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
    
    for (EBookInfo * book in array)
    {
        path = [kWSPath stringByAppendingString:book.imgUrl];
        
        [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString: path] withName:bVersion]];
      //  [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:path]]]
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
     NSLog(@"%d",(int)self.coverImageArray.count);
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
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[self.coverImageArray objectAtIndex:indexPath.row]];
    imageView.frame = CGRectMake(0, 0, 210, 260);
    
    [cell.contentView addSubview:imageView];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 260, 210, 40)];
    lable.text = [self.coverVersionArray objectAtIndex:indexPath.row];
    //    lable.backgroundColor = [UIColor orangeColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:18];
    lable.numberOfLines = [lable.text length];
    [cell.contentView addSubview:lable];
    
    //    if (indexPath.row %2 !=0) {
    //        cell.backgroundColor = [UIColor colorWithRed:1.0 green:186.0/255 blue:204.0/255 alpha:0.8];
    //        lable.textColor = [UIColor whiteColor];
    //    }
    //    else
    //    {
    //        cell.backgroundColor = [UIColor whiteColor];
    //        lable.textColor = [UIColor colorWithRed:1.0 green:178.0/255 blue:212.0/255 alpha:1];
    //    }
    
    
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
    [self.browser showNextPhotoAnimated:YES];
    [self.browser showPreviousPhotoAnimated:YES];
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
    [[EBookManage shardSingleton] getDetailRecordWithID:ids returnList:&array];
    
    self.detailRecordArray = array;
    [NSThread detachNewThreadSelector:@selector(getDetailImageFromArray:) toTarget:self withObject:array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (EBookInfo * book in array)
        {
            ImageInfo * imageInfo = [[ImageInfo alloc] init];
            imageInfo.bookVersion = bVersion;
            imageInfo.imgUrl =  book.imgUrl;
           // NSLog(@"hhahahaahahhhahahahahahahahahahah isssss     %@" , imageInfo.linkurl);
            
            if ([book.link count] > 0)
            {
                for (NSDictionary * dict in book.link)
                {
                    imageInfo.startX = [[dict objectForKey:@"startX"] stringValue];
                    imageInfo.startY = [[dict objectForKey:@"startY"] stringValue];
                    imageInfo.endX = [[dict objectForKey:@"endX"] stringValue];
                    
                    imageInfo.endY = [[dict objectForKey:@"endY"] stringValue];
                    imageInfo.linkurl = [dict objectForKey:@"link"];
                    imageInfo.type = [dict objectForKey:@"type"];
                    if (![[EBookManage shardSingleton] isExistImageWithName:imageInfo.linkurl withVersion:imageInfo.bookVersion withType:1])
                    {
                        [[EBookManage shardSingleton] insertBookInfo:imageInfo];
                    }
                }
            }
            else
            {
                if (![[EBookManage shardSingleton] isExistImageWithName:imageInfo.imgUrl withVersion:imageInfo.bookVersion withType:0])
                {
                    [[EBookManage shardSingleton] insertBookInfo:imageInfo];
                }
            }
        }
    });
    
}

- (void)getResourceByVersion:(NSString *)onLineID
{
    NSLog(@"the onlineID IS %@",onLineID);
//    [self saveResourceByDownloadWithIDs:onLineID];
    
    NSLog(@"the onlineID IS %@",onLineID);
    NSMutableArray * array = [NSMutableArray  arrayWithCapacity:10];
    
    if ([self checkInternet]) {
        [[EBookManage shardSingleton] getDetailRecordWithID:onLineID returnList:&array];
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
        }
        
        if ([self checkInternet]) {
            [self saveResourceByDownloadWithIDs:onLineID];
            return;
        }
        
    }
    
   // NSArray * resourceArray = [[EBookManage shardSingleton] getBookRecordByVersion:bVersion];
    NSArray * r = [[EBookManage shardSingleton] getBookRecordByVersion:bVersion];
    
    NSMutableArray *resourceArray = [[NSMutableArray alloc]initWithArray:r];

    NSString * fileName;
    
#pragma mark 修改 (去重)
    NSMutableDictionary*d = [NSMutableDictionary dictionaryWithCapacity:10];
    int size = resourceArray.count;
    for (int i = 0; i < size; i++) {
        ImageInfo * imageInfo = resourceArray[i];
        if ([d objectForKey:imageInfo.imgUrl]) {
            [resourceArray removeObject:imageInfo];
            i--;
            size--;
            
        }else{
            [d setObject:@"qqq" forKey:imageInfo.imgUrl];
        }
    }

    self.photos = [NSMutableArray array];
    self.detailImageArray = [NSMutableArray arrayWithCapacity:10];
    
    for (EBookInfo * imageInfo in resourceArray)
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
                    [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString: path] withName:bVersion]];
                }

            }
        }
        else
        {
            if ([self checkInternet])
            {
                NSLog(@"online file");
                path = [kWSPath stringByAppendingString:imageInfo.imgUrl];
                [self.detailImageArray addObject:fileName];
                [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString: path] withName:bVersion]];
            }

        }
        
    }
    
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
                NSString * dirPath = [documentDirectory stringByAppendingPathComponent:@"cover"];
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
                if ([[EBookManage shardSingleton] deleteBookInfo:coverName]) {
                    
                    NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];
                    [array addObject:[self.subIdArray objectAtIndex:self.itemIndex]];
                    [[EBookManage shardSingleton] findcoverbycompid:[self.subIdArray objectAtIndex:self.itemIndex] andArray:array];
                    NSLog(@"%@",[self.subIdArray objectAtIndex:self.itemIndex]);
                    NSLog(@"%@",array);
                    if ([[EBookManage shardSingleton] deletecover:array]) {
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
        
        
        NSMutableArray * bookArray = [self getdatawithindexPath:indexPath.row];
        [backArray addObject:bookArray];
        // NSLog(@"backarray is %@",backArray);
        
        
        [self initviewBybookId:bookArray];
        
        if (!self.compArry.count == 0) {
            backstr = [self.compArry objectAtIndex:0];
        }
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
    [self getResourceByVersion:recordID];
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
        for (EBookInfo * book in bookArray)
        {
            [[EBookManage shardSingleton] insertCompInDB:book];
            
            
            UIImage * image = nil;
            
            NSString *filePath = [self getcoverimagepath:book.name];
            //            [self.coverVersionArray addObject:book.name];
            NSLog(@"name is %@",book.name);
            if (filePath) {
                image = [UIImage imageWithContentsOfFile:filePath];
                //[self.coverImageArray addObject:image];
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
                [[EBookManage shardSingleton] saveImage:image withURL:path withCoverName:book.name];
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
        
        [[EBookManage shardSingleton] getBookRecordwithid:[self.subIdArray objectAtIndex:row] retun:&bookArray];
        
    }else
    {
        [[EBookManage shardSingleton] searchInDbBycompId:[self.subIdArray objectAtIndex:row] returnArray:&bookArray];
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
        NSLog(@"the phots index is %lu",index);
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
     photoIndex = (int)index;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
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
    [[EBookManage shardSingleton] searchInDbBycompId:backstr returnArray:&array];
    [backArray addObject:array];
    for (EBookInfo *projectinfo in array) {
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
    NSString * dirPath = [docsDir stringByAppendingPathComponent:@"cover"];
    
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
    // Dispose of any resources that can be recreated.
}

@end
