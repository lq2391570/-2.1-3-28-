//
//  MapViewController.m
//  SMProject
//
//  Created by DAIjun on 14-12-23.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize provinceName=_provinceName;
@synthesize cityName=_cityName;
@synthesize storeName=_storeName;
@synthesize longitude=_longitude;
@synthesize latitude=_latitude;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"地图", nil);
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    self.navigationController.navigationBarHidden = NO;
    _tempArray=[NSMutableArray arrayWithCapacity:0];
}
-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    buttonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = buttonItem;
    
    _mapView=[[BMKMapView alloc] initWithFrame:CGRectMake(0, 60, 1024, 708)];
    _mapView.compassPosition=CGPointMake(300, 300);
    _mapView.zoomLevel=13;
    _mapView.delegate=self;
    BMKMapStatus *status=[[BMKMapStatus alloc] init];
    status.targetGeoPt=CLLocationCoordinate2DMake(34.223, 108.952);
    status.fLevel=13;
    
#pragma mark 定位
//    [_mapView setShowsUserLocation:YES];
//    _locService = [[BMKLocationService alloc]init];
//    [_locService startUserLocationService];
    
    //status.targetScreenPt=CGPointMake(506, 1200);
   
    _userLocation=[[BMKUserLocation alloc] init];
    _locService = [[BMKLocationService alloc]init];
    
   // _mapView.centerCoordinate=CLLocationCoordinate2DMake(34.233, 108.952);
    [self.view addSubview:_mapView];
    _searchTest=[[UITextField alloc] initWithFrame:CGRectMake(10, 100, 200, 40)];
    _searchTest.placeholder=@"请输入关键字";
  //  _searchTest.
    
    _searchTest.keyboardType=UIKeyboardTypeDefault;
    UIColor *color = [UIColor blackColor];
    _searchTest.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入关键字" attributes:@{NSForegroundColorAttributeName: color}];
    
    _searchTest.backgroundColor=[UIColor colorWithRed:237/255.0 green:165/255.0 blue:193/255.0 alpha:0.8];
    _searchTest.layer.opacity=0.8;
    _searchTest.layer.cornerRadius=10;
    [self.view addSubview:_searchTest];
    _searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.frame=CGRectMake(10, 150, 60, 35);
    _searchBtn.titleLabel.text=@"确认搜索";
    [_searchBtn setBackgroundImage:[UIImage imageNamed:@"查询按钮_点击后_08.png"] forState:UIControlStateNormal];
    [_searchBtn addTarget:self action:@selector(searchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_searchBtn];
    BMKLocationViewDisplayParam *testParam=[[BMKLocationViewDisplayParam alloc] init];
    testParam.isRotateAngleValid=true;
    testParam.isAccuracyCircleShow=true;
    testParam.locationViewImgName=@"我的位置";
    [_mapView updateLocationViewWithParam:testParam];
    
    _locService.delegate=self;
    _localBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _localBtn.frame=CGRectMake(90, 150, 60, 35);
    _localBtn.titleLabel.text=@"定位";
    [_localBtn addTarget:self action:@selector(startLocation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_localBtn];
    
//测试
   
    _mapView.showsUserLocation = YES;
    [_mapView setMapStatus:status withAnimation:YES];
    [_mapView setMapStatus:status];
   //    [self startFollowing];
//    [self startLocationService];
//    if (_userLocation.location!=nil) {
//        NSLog(@"定位成功");
//       CLLocationCoordinate2D coor=[[_userLocation location] coordinate];
//        NSLog(@"%f",coor.latitude);
//        NSLog(@"%f",coor.longitude);
//    }
    
   //    CLLocationCoordinate2D coor=[[_userLocation location] coordinate];
//    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(coor, BMKCoordinateSpanMake(0.02f,0.02f));
//    BMKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
//    [_mapView setRegion:adjustedRegion animated:YES];
    
}
-(void)startLocation:(id)sender
{
    NSLog(@"进入普通定位态");
    
//测试
//    CLLocationManager *locationManager;//定义Manager
//    // 判断定位操作是否被允许
//    if([CLLocationManager locationServicesEnabled]) {
//        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
//        
//        locationManager.delegate = self;
//    }else {
//        //提示用户无法进行定位操作
//        NSLog(@"用户无法操作");
//    }
//    // 开始定位
//    [locationManager startUpdatingLocation];
#pragma mark 测试
    
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
//    [startBtn setEnabled:NO];
//    [startBtn setAlpha:0.6];
//    [stopBtn setEnabled:YES];
//    [stopBtn setAlpha:1.0];
//    [followHeadBtn setEnabled:YES];
//    [followHeadBtn setAlpha:1.0];
//    [followingBtn setEnabled:YES];
//    [followingBtn setAlpha:1.0];
}
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
//    CLLocation *currentLocation = [locations lastObject];
//    
//    CLLocationCoordinate2D coor = currentLocation.coordinate;
////    self.latitude =  coor.latitude;
////    self.longitude = coor.longitude;
//    _mapView.centerCoordinate=coor;
//    //[self.locationManager stopUpdatingLocation];
//    
//}
//- (void)locationManager:(CLLocationManager *)manager
//       didFailWithError:(NSError *)error {
//    
//    if (error.code == kCLErrorDenied) {
//        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
//        NSLog(@"失败");
//    }
//}
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

- (void)startFollowing
{
    NSLog(@"进入跟随态");
    _mapView.showsUserLocation=NO;
    _mapView.userTrackingMode=BMKUserTrackingModeFollow;
    _mapView.showsUserLocation=YES;
}
- (void)startLocationService
{
    [_locService startUserLocationService];
}
//定位时间监听
- (void)willStartLocatingUser
{
    NSLog(@"将要启动定位");
}
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"定位失败 ，%@",error);
}
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    _mapView.centerCoordinate=_userLocation.location.coordinate;
}
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
        NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    _mapView.centerCoordinate=_userLocation.location.coordinate;
}
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"调用了这个方法1");
    BMKCoordinateRegion region;
    region.center.latitude  = _userLocation.location.coordinate.latitude;
    region.center.longitude = _userLocation.location.coordinate.longitude;
    region.span.latitudeDelta  = 0.2;
    region.span.longitudeDelta = 0.2;
    if (mapView)
    {
        mapView.region = region;
        NSLog(@"当前的坐标是: %f,%f",_userLocation.location.coordinate.latitude,_userLocation.location.coordinate.longitude);
    }
}
- (void)searchBtn:(UIButton *)btn
{
    
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    
	[_mapView removeAnnotations:array];
    [_tempArray removeAllObjects];
    
    [self getMapData:^(NSArray *array) {
        for (NSDictionary *dic in array) {
            
            self.provinceName=[dic objectForKey:@"provinceName"];
            self.cityName=[dic objectForKey:@"cityName"];
            self.storeName=[dic objectForKey:@"storeName"];
            self.latitude=[dic objectForKey:@"latitude"] ;
            self.longitude=[dic objectForKey:@"longitude"];
            NSLog(@"%@",self.provinceName);
            NSLog(@"%@",self.cityName);
            NSLog(@"%@",self.storeName);
            NSLog(@"%@",self.latitude);
            NSLog(@"%@",self.longitude);
//            _label1.text=self.provinceName;
//            _label2.text=self.cityName;
//            _label3.text=self.storeName;
            _pointAnnotation=[[BMKPointAnnotation alloc] init];
            CLLocationCoordinate2D coordinate;
            coordinate.longitude=[self.latitude floatValue];
            coordinate.latitude=[self.longitude floatValue];
            _mapView.centerCoordinate=coordinate;
            [self addPointAnnotation:coordinate];
            
    
        }

    }];
    
    
}
//- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation{
//    CLLocationCoordinate2D coor;
//    coor.latitude                   = _mapView.userLocation.coordinate.latitude;
//    coor.longitude                 = _mapView.userLocation.coordinate.longitude;
//    [_mapView setCenterCoordinate:coor animated:YES];
//}

- (void)getMapData:(void (^) (NSArray *array))complete
{
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mapmanager_findAllMapManagerForKeyWordToIpad",LocationIp]]];
    [request addPostValue:_searchTest.text forKey:@"mapManager.keyword"];
   // [request setDelegate:self];
    
    [request setTimeOutSeconds:15];
    [request setCompletionBlock:^{
        NSArray *array=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
      //  NSLog(@"\\%@",request.responseData);
    if (array)
    {
            complete(array);
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"关键字不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
        
    }];
    [request setFailedBlock:^{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请查询网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        NSLog(@"失败");
    }];
    [request startAsynchronous];
}

- (void)addPointAnnotation:(CLLocationCoordinate2D)coordinate
{
   _pointAnnotation=[[BMKPointAnnotation alloc] init];
  //  CLLocationCoordinate2D coor;
//    coor.latitude=33.223;
//    coor.longitude=108.952;
    _pointAnnotation.coordinate=coordinate;
    _pointAnnotation.title=@"标记";
    _pointAnnotation.subtitle=@"此Annotation可拖拽";
  //  NSMutableArray *tempArray=[[NSMutableArray alloc] initWithCapacity:0];
    [_tempArray addObject:_pointAnnotation];
    NSArray *array=[NSArray arrayWithArray:_tempArray];
    [_mapView addAnnotations:array];
   // [_mapView addAnnotation:_pointAnnotation];
    
}
//根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    NSLog(@"点击");
    NSString *annotationViewID=@"renameMark";
    _newAnnotation = [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewID];

    if (_newAnnotation==nil) {
        _newAnnotation=[[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewID];
       
        //设置颜色
        ((BMKPinAnnotationView *)_newAnnotation).pinColor=BMKPinAnnotationColorPurple;
        //天上掉下的效果
        ((BMKPinAnnotationView *)_newAnnotation).animatesDrop=YES;
        //可拖拽
        ((BMKPinAnnotationView *)_newAnnotation).draggable=NO;
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 100)];
        UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo内阴影.png"]];
        image.frame=CGRectMake(12, 60, 130, 30);
        view.layer.cornerRadius=20;
        view.backgroundColor=[UIColor colorWithRed:237/255.0 green:165/255.0 blue:193/255.0 alpha:0.8];
        _label1=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 20)];
        _label1.text=self.provinceName;
        _label2=[[UILabel alloc] initWithFrame:CGRectMake(10, 20, 150, 20)];
        _label2.text=self.cityName;
        _label3=[[UILabel alloc] initWithFrame:CGRectMake(10, 40, 150, 20)];
        _label3.text=self.storeName;
        [view addSubview:image];
        [view addSubview:_label1];
        [view addSubview:_label2];
        [view addSubview:_label3];
        
        
        BMKActionPaopaoView *test=[[BMKActionPaopaoView alloc] initWithCustomView:view];
        
        ((BMKPinAnnotationView *)_newAnnotation).paopaoView=test;
    }
    return _newAnnotation;
}
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    
    NSLog(@"点击了地图");
    NSLog(@"%f,%f",coordinate.latitude,coordinate.longitude);
 //   [self addPointAnnotation:coordinate];
}
- (void)back
{
   
[self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
