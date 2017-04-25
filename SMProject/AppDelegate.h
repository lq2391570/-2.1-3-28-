//
//  AppDelegate.h
//  Sheng123
//
//  Created by 石榴花科技 on 14-4-3.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogInViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "BMapKit.h"
#import "MapViewController.h"
#import "RootViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,LogInViewControllerDelegate,CLLocationManagerDelegate,BMKGeneralDelegate>
{
    BMKMapManager *_mapManager;
    RootViewController *_rootVC;
    LogInViewController *_logInVC;
    
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) CLLocationManager * locationManager;

@end
