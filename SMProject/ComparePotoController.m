//
//  ComparePotoController.m
//  SMProject
//
//  Created by arvin yan on 10/31/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import "ComparePotoController.h"
#import "CateViewController.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "CompareModel.h"


@interface ComparePotoController ()

@end

@implementation ComparePotoController
@synthesize bServiceImage;
@synthesize aServiceImage;
@synthesize cArray;
@synthesize p1State;
@synthesize p2Time;
@synthesize p1Time;
@synthesize p2State;

#define ip LocationIp

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (UIImage *)getImageWithURL:(NSString *)imageName
{
   
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ip,imageName]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return [[UIImage alloc] initWithData:data];
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    self.title= @"照片比对";
    // Do any additional setup after loading the view from its nib.
    leftNum=90;
    rightNum=90;
    self.leftServiceImage.transform=CGAffineTransformMakeRotation(leftNum*M_PI/180);
    self.leftServiceImage.layer.anchorPoint=CGPointMake(0.5, 0.5);
    self.rightServiceImage.contentMode=UIViewContentModeScaleAspectFit;
    self.rightServiceImage.transform=CGAffineTransformMakeRotation(rightNum*M_PI/180);
    self.rightServiceImage.layer.anchorPoint=CGPointMake(0.5, 0.5);
    self.p1State.transform=CGAffineTransformMakeRotation(90*M_PI/180);
    
    self.p2State.transform=CGAffineTransformMakeRotation(90*M_PI/180);
   
    [self compareImage];
    [self addGestureRecognizer];
    
}
//对图片添加手势
- (void)addGestureRecognizer
{
    //捏合手势识别器，changeImageSize：方法实现图片的放大与缩小
    UIPinchGestureRecognizer *leftPinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(leftChangeImageSize:)];
    [self.leftServiceImage addGestureRecognizer:leftPinchRecognizer];
    
    UIPinchGestureRecognizer *rightPinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(rightChangeImageSize:)];
    [self.rightServiceImage addGestureRecognizer:rightPinchRecognizer];
    
    //旋转手势
    UIRotationGestureRecognizer *leftRotateRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateLeftImage:)];
    [self.leftServiceImage addGestureRecognizer:leftRotateRecognizer];
    
    UIRotationGestureRecognizer *rightRotateRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateRightImage:)];
    [self.rightServiceImage addGestureRecognizer:rightRotateRecognizer];
    
    //拖动手势
    UIPanGestureRecognizer *leftPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(leftPanImage:)];
    [self.leftServiceImage addGestureRecognizer:leftPanRecognizer];
    
    UIPanGestureRecognizer *rightPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rightPanImage:)];
    [self.rightServiceImage addGestureRecognizer:rightPanRecognizer];

}
//拖动手势
- (void)leftPanImage:(UIPanGestureRecognizer *)recognizer
{
    //返回在横坐标上、纵坐标上拖动了多少像素
    CGPoint point=[recognizer translationInView:self.leftView];
    NSLog(@"%f,%f",point.x,point.y);
    recognizer.view.center=CGPointMake(recognizer.view.center.x+point.x, recognizer.view.center.y+point.y);
    //拖动完之后，每次都要用setTranslation:方法制0这样才不至于不受控制般滑动出视图
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.leftView];
    
}
- (void)rightPanImage:(UIPanGestureRecognizer *)recognizer
{
    //返回在横坐标上、纵坐标上拖动了多少像素
    CGPoint point=[recognizer translationInView:self.rightView];
    NSLog(@"%f,%f",point.x,point.y);
    recognizer.view.center=CGPointMake(recognizer.view.center.x+point.x, recognizer.view.center.y+point.y);
    //拖动完之后，每次都要用setTranslation:方法制0这样才不至于不受控制般滑动出视图
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.rightView];
}

- (void)leftChangeImageSize:(UIPinchGestureRecognizer *)recognizer
{

//    if (recognizer.state == UIGestureRecognizerStateEnded) {
//        
//        self.leftcurrentScale = recognizer.scale;
//    }else if(recognizer.state == UIGestureRecognizerStateBegan && self.leftcurrentScale != 0.0f){
//        recognizer.scale = self.leftcurrentScale;
//    }
//    if (recognizer.scale != NAN && recognizer.scale > 1.0) {
//     //   recognizer.view.transform = CGAffineTransformMakeScale(recognizer.scale, recognizer.scale);
//        
//    }
    
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1.0;
    
}
- (void)rightChangeImageSize:(UIPinchGestureRecognizer *)recognizer
{
//    if (recognizer.state == UIGestureRecognizerStateEnded) {
//        self.rightcurrentScale = recognizer.scale;
//    }else if(recognizer.state == UIGestureRecognizerStateBegan && self.rightcurrentScale != 0.0f){
//        recognizer.scale = self.rightcurrentScale;
//    }
//    if (recognizer.scale !=NAN && recognizer.scale > 1.0) {
//        recognizer.view.transform = CGAffineTransformMakeScale(recognizer.scale, recognizer.scale);
//    }
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1.0;

}
-(void)rotateLeftImage:(UIRotationGestureRecognizer *)rotateRecognizer
{
    
    //改变imageView的角度，使图片旋转
    if ([rotateRecognizer state]==UIGestureRecognizerStateEnded) {
        self.leftLastRotation = 0.0;
        return;
    }
    CGAffineTransform currentTransform = self.leftServiceImage.transform;
    CGFloat rotation = 0.0 - (self.leftLastRotation - rotateRecognizer.rotation);
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    self.leftServiceImage.transform = newTransform;
    self.leftLastRotation = rotateRecognizer.rotation;
}
- (void)rotateRightImage:(UIRotationGestureRecognizer *)rotateRecognizer
{
    //改变imageView的角度，使图片旋转
    if ([rotateRecognizer state]==UIGestureRecognizerStateEnded) {
        self.rightLastRotation = 0.0;
        return;
    }
    CGAffineTransform currentTransform = self.rightServiceImage.transform;
    CGFloat rotation = 0.0 - (self.rightLastRotation - rotateRecognizer.rotation);
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    self.rightServiceImage.transform = newTransform;
    self.rightLastRotation = rotateRecognizer.rotation;
}


//得到的图片对比
- (void)compareImage
{
    [SVProgressHUD show];
    
    for (int i = 0; i<self.compareImageArray.count; i++) {
        if (i == 0) {
            CompareModel *model =self.compareImageArray[i];
            self.p1State.text = model.imageType;
            [self.leftServiceImage sd_setImageWithURL:[NSURL URLWithString:model.bigImageName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [SVProgressHUD dismiss];
            }];
        }else if (i == 1){
            CompareModel *model =self.compareImageArray[i];
            self.p2State.text = model.imageType;
            [self.rightServiceImage sd_setImageWithURL:[NSURL URLWithString:model.bigImageName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [SVProgressHUD dismiss];
            }];
            
        }
    }
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });

    
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    
//    
//    
////    self.bServiceImage.image = [self getImageWithURL:[self.cArray objectAtIndex:0]];
////    self.aServiceImage.image =  [self getImageWithURL:[self.cArray objectAtIndex:1]];
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    NSArray * p1 = (NSArray *)[prefs objectForKey:@"selectImage1"];
//    NSArray * p2 = (NSArray *)[prefs objectForKey:@"selectImage2"];
//    if (p1.count > 0) {
//        self.p1Time.text = [p1 objectAtIndex:0];
//        self.p1Time.hidden=YES;
//        self.p1Time.transform=CGAffineTransformMakeRotation(90*M_PI/180);
//        NSString * state = [NSString stringWithFormat:@"%@",[p1 objectAtIndex:0]];
//        if ([state isEqualToString:@"0"])
//        {
//            self.p1State.text = @"服务前";
//            self.p1State.transform=CGAffineTransformMakeRotation(90*M_PI/180);
//        }
//        else if ([state isEqualToString:@"1"])
//        {
//            self.p1State.text = @"服务后";
//            self.p1State.transform=CGAffineTransformMakeRotation(90*M_PI/180);
//        }else if ([state isEqualToString:@"2"]){
//            self.p1State.text = @"小票";
//            self.p1State.transform=CGAffineTransformMakeRotation(90*M_PI/180);
//        }
//#pragma mark 修改
////        self.bServiceImage.image = [self getImageWithURL:[p1 objectAtIndex:2]];
////        self.bServiceImage.transform=CGAffineTransformMakeRotation(90*M_PI/180);
//        
//       // self.leftServiceImage.image=[self getImageWithURL:[p1 objectAtIndex:2]];
//     //   [self.leftServiceImage sd_setImageWithURL:[NSURL URLWithString:p1[2]]];
//        [SVProgressHUD show];
//        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC));
//        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
//        });
//        
//       
//        
//        [self.leftServiceImage sd_setImageWithURL:[NSURL URLWithString:p1[2]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            [SVProgressHUD dismiss];
//        }];
//        
//        self.leftServiceImage.transform=CGAffineTransformMakeRotation(leftNum*M_PI/180);
//        self.leftServiceImage.layer.anchorPoint=CGPointMake(0.5, 0.5);
//        
//        
//    }
//    if (p2.count > 0) {
//        self.p2Time.text = [p2 objectAtIndex:0];
//        self.p2Time.hidden=YES;
//        self.p2Time.transform=CGAffineTransformMakeRotation(90*M_PI/180);
//        NSString * state = [NSString stringWithFormat:@"%@",[p2 objectAtIndex:0]];
//
//        if ([state isEqualToString:@"0"]) {
//            self.p2State.text = @"服务前";
//            self.p2State.transform=CGAffineTransformMakeRotation(90*M_PI/180);
//        }
//        else if([state isEqualToString:@"1"])
//        {
//            self.p2State.text = @"服务后";
//            self.p2State.transform=CGAffineTransformMakeRotation(90*M_PI/180);
//        }else if ([state isEqualToString:@"2"]){
//            self.p2State.text = @"小票";
//            self.p2State.transform=CGAffineTransformMakeRotation(90*M_PI/180);
//        }
////        self.aServiceImage.image =  [self getImageWithURL:[p2 objectAtIndex:2]];
////        self.aServiceImage.transform=CGAffineTransformMakeRotation(90*M_PI/180);
//    
//      //  self.rightServiceImage.image=[self getImageWithURL:[p2 objectAtIndex:2]];
//        [self.rightServiceImage sd_setImageWithURL:[NSURL URLWithString:p2[2]]];
//        
//        
//        self.rightServiceImage.contentMode=UIViewContentModeScaleAspectFit;
//        self.rightServiceImage.transform=CGAffineTransformMakeRotation(rightNum*M_PI/180);
//        self.rightServiceImage.layer.anchorPoint=CGPointMake(0.5, 0.5);
//      //  self.rightServiceImage.center=CGPointMake(0.5, 0.5);
//    }
//    
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender
{
//    CateViewController * cate = [[CateViewController alloc] init];
//    [cate.compareArray removeAllObjects];
   // [self resetDefaults];
    [self.navigationController popViewControllerAnimated:YES];

    //[self.navigationController dismissViewControllerAnimated:YES completion:nil];

}

- (void)resetDefaults {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs removeObjectForKey:@"selectImage1"];
    [prefs removeObjectForKey:@"selectImage2"];
    
    [prefs synchronize];
//    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
//    NSDictionary * dict = [defs dictionaryRepresentation];
//    for (id key in dict) {
//        [defs removeObjectForKey:key];
//    }
//    [defs synchronize];
}

- (IBAction)leftRotateBtnClick:(id)sender
{
    self.leftServiceImage.center = CGPointMake(CGRectGetWidth(self.leftView.frame)/2, CGRectGetHeight(self.leftView.frame)/2);
    
   // NSLog(@" self.leftView.center =%i ",self.leftView.center);
    leftNum=leftNum-90;
    UIButton *btn=(UIButton *)sender;
    btn.selected=!btn.selected;
    if (btn.selected==YES) {
        self.leftServiceImage.layer.anchorPoint=CGPointMake(0.5, 0.5);
      //  btn.selected=NO;
    }else{
         self.leftServiceImage.layer.anchorPoint=CGPointMake(0.5, 0.5);
      //  btn.selected=YES;
    }
   
    [UIView animateWithDuration:0.3 animations:^{
       //  self.leftServiceImage.transform=CGAffineTransformMakeRotation(leftNum*M_PI/180);
       
        self.leftServiceImage.layer.transform=CATransform3DMakeRotation(leftNum*M_PI/180, 0, 0, 1);
    }];
   
  // self.leftServiceImage.layer.transform=CGAffineTransformMakeRotation(leftNum*M_PI/180);
}

- (IBAction)rightRotateBtnClick:(id)sender
{
     self.rightServiceImage.center = CGPointMake(CGRectGetWidth(self.rightView.frame)/2, CGRectGetHeight(self.rightView.frame)/2);
    rightNum=rightNum-90;
    UIButton *btn=(UIButton *)sender;
    btn.selected=!btn.selected;
    if (btn.selected==YES) {
        self.rightServiceImage.layer.anchorPoint=CGPointMake(0.5, 0.5);
        //  btn.selected=NO;
    }else{
        self.rightServiceImage.layer.anchorPoint=CGPointMake(0.5, 0.5);
        //  btn.selected=YES;
    }

    [UIView animateWithDuration:0.3 animations:^{
       //  self.rightServiceImage.transform=CGAffineTransformMakeRotation(rightNum*M_PI/180);
        self.rightServiceImage.layer.transform=CATransform3DMakeRotation(rightNum*M_PI/180, 0, 0, 1);
        
    }];
    
}
@end
