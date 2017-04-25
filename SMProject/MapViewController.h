//
//  MapViewController.h
//  SMProject
//
//  Created by DAIjun on 14-12-23.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "ASIFormDataRequest.h"
@interface MapViewController : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKMapView *_mapView;
    BMKPointAnnotation *_pointAnnotation;
    BMKAnnotationView *_newAnnotation;
    UITextField *_searchTest;
    UIButton *_searchBtn;
    UILabel *_label1;
     UILabel *_label2;
     UILabel *_label3;
    NSMutableArray *_tempArray;
    BMKLocationService *_locService;
    BMKUserLocation *_userLocation;
    UIButton *_localBtn;
    
}
@property (nonatomic,strong)NSString *provinceName;
@property (nonatomic,strong)NSString *cityName;
@property (nonatomic,strong)NSString *storeName;
@property (nonatomic,strong)NSString *longitude;
@property (nonatomic,strong)NSString *latitude;



@end
