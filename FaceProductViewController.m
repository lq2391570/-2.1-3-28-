//
//  FaceProductViewController.m
//  SMProject
//
//  Created by DAIjun on 15-1-7.
//  Copyright (c) 2015年 石榴花科技. All rights reserved.
//

#import "FaceProductViewController.h"
#import "SVProgressHUD.h"
#import "HighManage.h"
#import "Reachability.h"

#import "InformationManage.h"
#import "SVProgressHUD.h"
#import "XMLmanage.h"
#import "ProjectManage.h"
#import "SMOrderControllerViewController.h"
#import "SGInfoAlert.h"

#define TOUCH_SCREEN_NOTIFICATION @"TOUCH_SCREEN_NOTIFICATION"

@interface FaceProductViewController ()
{
    NSMutableArray * singlearray;

}

@end

int pointX;
int pointY;
NSString *imageID;


@implementation FaceProductViewController
@synthesize detailRecordArray = detailRecordArray_;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)getDataFromJson:(NSString *)imageID
{
    NSMutableArray * array = [NSMutableArray  arrayWithCapacity:10];
    
    [[HighManage shardSingleton] getDetailRecordWithID:imageID returnList:&array];
    
    self.detailRecordArray = [NSMutableArray arrayWithArray:array];
//    [NSThread detachNewThreadSelector:@selector(getDetailImageFromArray:) toTarget:self withObject:array];
    NSLog(@"get data array...");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (HighInfo * book in array)
        {
            HImageInfo * imageInfo = [[HImageInfo alloc] init];
            imageInfo.imgUrl =  book.imgUrl;
            
            if ([book.link count] > 0)
            {
                NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
                NSString * usid = [defaults stringForKey:@"name"];
                
                for (NSDictionary * dict in book.link)
                {
                    imageInfo.startX = [[dict objectForKey:@"startX"] stringValue];
                    int startX = [imageInfo.startX intValue];
                    NSLog(@"this can touch x %d",startX);

                    imageInfo.startY = [[dict objectForKey:@"startY"] stringValue];
                    int startY = [imageInfo.startY intValue];
                    NSLog(@"this can touch startY %d",startY);


                    imageInfo.endX = [[dict objectForKey:@"endX"] stringValue];
                    int endX = [imageInfo.endX intValue];
                    NSLog(@"this can touch endX %d",endX);


                    imageInfo.endY = [[dict objectForKey:@"endY"] stringValue];
                    
                    int endY = [imageInfo.endY intValue];
                    NSLog(@"this can touch endY %d",endY);


                    imageInfo.type = [[dict objectForKey:@"type"] stringValue];
                    int type = [imageInfo.type intValue];

                    imageInfo.linkurl = [dict objectForKey:@"link"];
                    NSString * link = imageInfo.linkurl;
                    
                    if (pointX > startX && pointY > startY && pointX < endX && pointY <endY) {
                        
                        NSLog(@"this can touch");
                        NSLog(@" the type is %d",[imageInfo.type intValue]);
                        if ([imageInfo.type intValue] == 7) {
                            
                            Information *info = [[XMLmanage shardSingleton] analysisXMLWithID:link withUSID:usid withtype:type];
                            NSLog(@"the info is %@",info.name);
                            if (info.name.length == 0) {
                                [SGInfoAlert showInfo:@"暂无商品库存，无法购买！"
                                              bgColor:[[UIColor blackColor] CGColor]
                                               inView:self.view
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
                        
                        else if ([imageInfo.type intValue] == 6) {
                            
                            Information *info = [[XMLmanage shardSingleton] analysisXMLWithID:link withUSID:usid withtype:type];
                            NSLog(@"the info is %@",info.name);
                            if (info.name.length == 0) {
                                [SGInfoAlert showInfo:@"暂无项目库存，无法购买！"
                                              bgColor:[[UIColor blackColor] CGColor]
                                               inView:self.view
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
                        {}
                        
                    }

                    
//                    if (![[HighManage shardSingleton] isExistInFaceWithName:imageInfo.imgUrl withVersion:imageInfo.linkurl withType:0])
//                    {
//                        [[HighManage shardSingleton] insertFaceInfo:imageInfo];
//                    }
                }
            }
        }
    });
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self.view];
    NSLog(@"Touch x : %f y : %f", touchPoint.x, touchPoint.y);
    

    pointX = touchPoint.x * 2;
    pointY = touchPoint.y * 2;
    NSLog(@"the click point x online is %d",pointX);
    NSLog(@"the click point y online is %d",pointY);
    
    [self getDataFromJson:[NSString stringWithFormat:@"%@",imageID]];
   // [self getLinksWithOutInternet];
    
//    if ([touch view] == yourImageView)
//    {
//        //add your code for image touch here
//    }
    
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


//点击以后弹出销售页面。
- (void)sellMyGoods
{
    
    NSLog(@"bookinfo is ....");

    InformationInfo * bookInfo = [self.detailRecordArray objectAtIndex:0];
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    NSString * usid = [defaults stringForKey:@"name"];
    NSLog(@"bookinfo is ....");

    //    NSLog(@"photoindex is %d",photoIndex);
    //    NSLog(@"%@",self.detailRecordArray);
       NSLog(@"bookinfo is %@",bookInfo.link);
    for (NSDictionary * dict in bookInfo.link)
    {
        int startX = [[dict objectForKey:@"startX"] intValue];
        int startY = [[dict objectForKey:@"startY"] intValue];
        int endX = [[dict objectForKey:@"endX"] intValue];
        int endY = [[dict objectForKey:@"endY"] intValue];
        int type = [[dict objectForKey:@"type"] intValue];
        NSString *link = [dict objectForKey:@"link"];
        NSLog(@"wode app %d",type);
        
   }
    //[SVProgressHUD dismiss];
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
    
    //    NSLog(@"this is singlearray %lu",singlearray.count);
    //
    //
    //    if ([self.IDArray containsObject:[singlearray objectAtIndex:3]]) {
    ////        self.datesource = nil;
    //        NSLog(@"%ld",[self.nameArrray indexOfObject:[singlearray objectAtIndex:0]]);
    //
    //    }
    //    else
    //    {
    //        self.datesource = [NSMutableArray new];
    //       [self.datesource addObject:singlearray];
    //
    //        NSLog(@"%@",singlearray);
    //        NSLog(@"%@",self.datesource);
    //    }
    //
    //
    ////    [self.datesource replaceObjectAtIndex:1 withObject:<#(id)#>];
    //
    //    NSLog(@"this is self.datesource %@",self.datesource);
    //
    ////    FirstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    ////    FirstView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    //
    //    buttonview = [UIButton buttonWithType:UIButtonTypeCustom];
    //    buttonview.frame = CGRectMake(0, 0, 1024, 768);
    //    buttonview.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    //
    //
    //    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    button.frame = CGRectMake(260, 460, 200, 40);
    //    button.backgroundColor = [UIColor redColor];
    //    [button setTitle:@"返回并继续添加" forState:UIControlStateNormal];
    //    [button addTarget:self action:@selector(buttonclick) forControlEvents:UIControlEventTouchUpInside];
    //    [buttonview addSubview:button];
    //
    //    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    button2.frame = CGRectMake(540, 460, 200, 40);
    //    button2.backgroundColor = [UIColor redColor];
    //    [button2 setTitle:@"结账" forState:UIControlStateNormal];
    //    [button2 addTarget:self action:@selector(Button2Click) forControlEvents:UIControlEventTouchUpInside];
    //    [buttonview addSubview:button2];
    //
    //    tableViewFirst = [[UITableView alloc] initWithFrame:CGRectMake(220, 280, 563, 150)];
    //    tableViewFirst.dataSource = self;
    //    tableViewFirst.delegate = self;
    //
    //    tableViewFirst.alpha = 1;
    //    tableViewFirst.rowHeight = 50;
    //    [tableViewFirst setSeparatorColor:[UIColor blackColor]];
    //    [buttonview addSubview:tableViewFirst];
    //
    //    [self.browser.view addSubview:buttonview];
    //
}


- (void)getLinksWithOutInternet
{
    
    NSArray * array = [[HighManage shardSingleton] getFaceRecordByImageName:self.imageUrl];
    NSLog(@"the array counts is %d",[array count]);
    self.detailRecordArray = array;
    
    for (HImageInfo * imageInfo in array)
    {
        int startX = [[imageInfo startX] intValue];
        int startY = [[imageInfo startY] intValue];
        
        int endX = [[imageInfo endX] intValue];
        int endY = [[imageInfo endY] intValue];
        int type = [[imageInfo type] intValue];
        NSLog(@"the start x %d",startX);
        NSLog(@"the start y %d", startY);
        NSLog(@"the end x %d", endX);
        NSLog(@"the end y %d", endY);
        NSLog(@"the end type %d", type);
        
        
        if (type == 6 || type == 7) {
            
            if ([self checkInternet]) {
                NSLog(@"the end type %d", type);
                
                [self sellMyGoods];
            }else
            {
                if (pointX > startX && pointY > startY && pointX < endX && pointY <endY)
                {
                    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络异常请查证后再试。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alter show];
                }
            }
        }
        
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    imageID = [prefs objectForKey:@"imageID" ];
    NSLog(@"The selected image id is %@",imageID);

    //[self getDataFromJson:[NSString stringWithFormat:@"%@",imageID]];
    
    NSLog(@"%@",self.imageUrl);
   // [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://sm.shiliuflower.com/Sanmoon1.0/%@",self.imageUrl]]];
    if (self.status==1) {
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        self.imageUrl=[user objectForKey:@"imageUrl"];
    }else{
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        self.imageUrl=[user objectForKey:@"imageUrlMain"];
    }
    NSLog(@"the image url is %@",self.imageUrl);
    
//    
    [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LocationIp,self.imageUrl]] placeholderImage:[UIImage imageNamed:@"sm2.png"] options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        [SVProgressHUD dismiss];
    }];
   // [imageView setImageWithURL:<#(NSURL *)#> placeholderImage:<#(UIImage *)#> options:<#(SDWebImageOptions)#> completed:<#^(UIImage *image, NSError *error, SDImageCacheType cacheType)completedBlock#>
    
    
    NSLog(@"==%@",[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LocationIp,self.imageUrl]]);
[self performSelector:@selector(timeOut) withObject:nil afterDelay:30];
   // NSString *string= [NSString stringWithFormat:@"http://sm.shiliuflower.com/Sanmoon1.0/%@",self.imageUrl];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *leftbarButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(buttonClick)];
    self.navigationItem.leftBarButtonItem=leftbarButton;
    [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LocationIp,self.imageUrl]] placeholderImage:[UIImage imageNamed:@"sm2.png"] options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        [SVProgressHUD dismiss];
    }];

}

- (void)buttonClick
{
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
- (void)timeOut
{
    [SVProgressHUD dismiss];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
