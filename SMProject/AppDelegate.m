//
//  AppDelegate.m
//  Sheng123
//
//  Created by 石榴花科技 on 14-4-3.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import "AppDelegate.h"

#import "Reachability.h"//判断网络
#import "ApproveViewController.h"
#import "DataBaseTool.h"



@implementation AppDelegate

@synthesize locationManager = _locationManager;

BOOL *isChange;
UINavigationController *na1;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [DataBaseTool initDatabase];
  //  [SVProgressHUD setMinimumDismissTimeInterval:2];
  //  [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    _mapManager=[[BMKMapManager alloc] init];
    BOOL ret=[_mapManager start:@"BoveoTsn8j88NZ4R7A2fNy61" generalDelegate:self];
    if (!ret) {
        NSLog(@"地图授权失败");
    }
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    _rootVC = [[RootViewController alloc] init];
    
    
    
    _logInVC = [[LogInViewController alloc] init];
    
#pragma mark 认证修改
//    ApproveViewController *appVC=[[ApproveViewController alloc] init];
//    self.window.rootViewController = appVC;
//  //  appVC.delegate = self;
//    na1 = [[UINavigationController alloc] initWithRootViewController:appVC];
//    MapViewController *mapView=[[MapViewController alloc] init];
//    
//    self.window.rootViewController = mapView;
//    logInVC.delegate = self;
//    na1 = [[UINavigationController alloc] initWithRootViewController:mapView];
    
    
    self.window.rootViewController = _logInVC;
    _logInVC.delegate = self;
    na1 = [[UINavigationController alloc] initWithRootViewController:_rootVC];
//
    //UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:logInVC];
    
    
   // self.window.rootViewController = na1;
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
   // [self firstViewFrame:YES];
    
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];

    [self initLocationManager];
    [self copyDB];
    [self copyDB1];
    [self copyDB2];
 //   [self firstViewFrame:NO];

    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    NSString* versionNum =[infoDict objectForKey:@"CFBundleVersion"];
    NSString*appName =[infoDict objectForKey:@"CFBundleDisplayName"];
    NSString*text =[NSString stringWithFormat:@"%@ %@",appName,versionNum];
    NSLog(@"%@-=--=",text);
    
    
    
    
    
    
    return YES;
}

- (void)onGetNetworkState:(int)iError
{
    if (0==iError) {
        NSLog(@"联网成功");
    }else{
        NSLog(@"onGetNetworkState %d",iError);
    }
}
- (void)onGetPermissionState:(int)iError
{
    if (0==iError) {
        NSLog(@"授权成功");
    }else{
        NSLog(@"onGetPermissionState %d",iError);
    }
    
    
    
}
- (BOOL)shouldAutorotate
{
    NSLog(@"调用了状态");
    return YES;
    
}



- (NSUInteger)supportedInterfaceOrientations
{
     NSLog(@"调用了状态2");
    return UIInterfaceOrientationMaskAllButUpsideDown;
    
}

//-(void)checkVersion:(NSString* )appurl
//{
//    ASIFormDataRequest* request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"https://192.168.0.112:8443/resource/1.ipa"]];
//    [request setRequestMethod:@"POST"];
//    [request setDelegate:self];
//    [request startAsynchronous];
//    
//}
//- (void)requestFinished:(ASIHTTPRequest *)request
//{
//    NSDictionary* resultDic=[request.responseData JSONValue];
//    NSArray* infoArray = [resultDic objectForKey:@"results"];
//    if (infoArray.count>0) {
//        NSDictionary* releaseInfo =[infoArray objectAtIndex:0];
//        NSString* appStoreVersion = [releaseInfo objectForKey:@"version"];
//        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
//        NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
//        if (![appStoreVersion isEqualToString:currentVersion])
//        {
//            trackViewURL = [[NSString alloc] initWithString:[releaseInfo objectForKey:@"trackViewUrl"]];
//            NSString* msg =[releaseInfo objectForKey:@"releaseNotes"];
//            UIAlertView* alertview =[[UIAlertView alloc] initWithTitle:@"版本升级" message:[NSString stringWithFormat:@"%@%@%@", @"新版本特性:",msg, @"\n是否升级？"] delegate:self cancelButtonTitle:@"稍后升级" otherButtonTitles:@"马上升级", nil];
//            [alertview show];
//        }
//        
//    }
//}
//

#pragma mark Init Location Manager
- (void)initLocationManager
{
    // init location manager and start to detect location change
    self.locationManager = [[CLLocationManager alloc] init];
	[self.locationManager setDelegate:self];
	[self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
	[self.locationManager setDistanceFilter:0.1f];
	if ([CLLocationManager locationServicesEnabled] == YES)
	{
        [self.locationManager startUpdatingLocation];
	}
}

- (void)copyDB1
{
    NSFileManager * localFileManager = [[NSFileManager alloc] init];
	NSString * originPath = [[NSBundle mainBundle] pathForResource:@"Project" ofType:@"dat"];
    
    
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString * dbPath = [documentPath stringByAppendingPathComponent:@"Project"];
    
	//should compare the version if the file already exist
	if (![localFileManager fileExistsAtPath:dbPath])
	{
		NSLog(@"the bookinfo file doesn't exist!");
		
		//copy the file direct
        NSError * err;
		if (![localFileManager copyItemAtPath:originPath toPath:dbPath error:&err]) {
			NSLog(@"Copy bookinfo to DB directory failed with error: %@", err);
		}
	}
    
    
}

- (void)copyDB2
{
    NSFileManager * localFileManager = [[NSFileManager alloc] init];
	NSString * originPath = [[NSBundle mainBundle] pathForResource:@"High" ofType:@"dat"];
    
    
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString * dbPath = [documentPath stringByAppendingPathComponent:@"High"];
    
	//should compare the version if the file already exist
	if (![localFileManager fileExistsAtPath:dbPath])
	{
		NSLog(@"the bookinfo file doesn't exist!");
		
		//copy the file direct
        NSError * err;
		if (![localFileManager copyItemAtPath:originPath toPath:dbPath error:&err]) {
			NSLog(@"Copy bookinfo to DB directory failed with error: %@", err);
		}
	}
}

- (void)copyDB
{
    NSFileManager * localFileManager = [[NSFileManager alloc] init];
	NSString * originPath = [[NSBundle mainBundle] pathForResource:@"EBook" ofType:@"dat"];
    
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString * dbPath = [documentPath stringByAppendingPathComponent:@"EBook"];
	
	//should compare the version if the file already exist
	if (![localFileManager fileExistsAtPath:dbPath])
	{
		NSLog(@"the bookinfo file doesn't exist!");
		//copy the file direct
        NSError * err;
		if (![localFileManager copyItemAtPath:originPath toPath:dbPath error:&err]) {
			NSLog(@"Copy bookinfo to DB directory failed with error: %@", err);
		}
	}
    
}
- (void)firstViewFrame:(BOOL)up
{
    int movementDistance = 160;
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
    {
    }
    else
    {
        movementDistance = 153;
    }
	const float movementDuration = 0.3f;
	int movement = (up ? -movementDistance : movementDistance);
    //	int movement = (up ? -movementDistance : movementDistance);
#pragma mark 修改
    
    UIDevice *device = [UIDevice currentDevice] ;
    if (device.orientation==UIDeviceOrientationLandscapeLeft){
        //        [UIView beginAnimations: @"anim" context: nil];
        //        [UIView setAnimationBeginsFromCurrentState: YES];
        //        [UIView setAnimationDuration: movementDuration];
        self.window.frame = CGRectOffset(self.window.frame, -movement, 0);
        // self.view.frame = CGRectMake(0, -300, 1024, 768);
        // [UIView commitAnimations];
        
    }else{
        //        [UIView beginAnimations: @"anim" context: nil];
        //        [UIView setAnimationBeginsFromCurrentState: YES];
        //        [UIView setAnimationDuration: movementDuration];
        self.window.frame = CGRectOffset(self.window.frame, movement, 0);
        // self.view.frame = CGRectMake(0, -300, 1024, 768);
        //    [UIView commitAnimations];
        
    }
    
    
}

#pragma mark Handle Location Update
//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//{
//    NSLog(@"The new location is %@, the old location is %@",newLocation,oldLocation);
//}
//
//- (void)locationManager: (CLLocationManager *)manager
//       didFailWithError: (NSError *)error
//{
//    if ([CLLocationManager locationServicesEnabled] == NO)
//    {
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示：" message:@"定位服务已被关闭，请前往设置页面打开!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//
//        [alert show];
//        [alert setTag:1];
//    }
//}
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//	if ([alertView tag] == 1)
//    {
//        [self.locationManager stopUpdatingLocation];
//        exit(0);
//    }
//}

#pragma mark - LoginViewControllerDelegate
- (void)changeRootViewController
{
    _rootVC.storeName=_logInVC.nameTextfield.text;
    _rootVC.userName=_logInVC.UserNameTextField.text;
    _rootVC.ipadName=_logInVC.myIpadName;
    NSUserDefaults *users=[NSUserDefaults standardUserDefaults];
    [users setObject:_logInVC.data_updata forKey:@"dataupdata"];
    NSLog(@"%@",[users objectForKey:@"dataupdata"]);
    _rootVC.data_updata=_logInVC.data_updata;
    _rootVC.ipadUDID=_logInVC.ipadUDID;
    self.window.rootViewController = na1;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // [self initLocationManager];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // [self initLocationManager];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
