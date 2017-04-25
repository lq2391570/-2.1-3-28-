//
//  FaceColourViewController.m
//  SMProject
//
//  Created by DAIjun on 14-12-31.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import "FaceColourViewController.h"


@interface FaceColourViewController ()

@end

@implementation FaceColourViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    self.imageUrl=[user objectForKey:@"imageUrl"];
    NSLog(@"%@",self.imageUrl);
//    [self choseNumOfColour];
//    NSLog(@"%d",self.choseNum);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     _faceProduct=[[FaceProductViewController alloc] init];
    
    _faceProduct.status=1;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)choseNumOfColour
{
    switch (self.choseNum) {
        case 1:
        {
            _pointView.center=CGPointMake(114, 262);
        }
            break;
        case 2:
           _pointView.center=CGPointMake(114+58, 262);
            break;
        case 3:
            _pointView.center=CGPointMake(114+58+58, 262);
            break;
        case 4:
            _pointView.center=CGPointMake(114+58+58+58, 262);
            break;
        case 5:
            _pointView.center=CGPointMake(114+58+58+58+58, 262);
            break;
        case 6:
            _pointView.center=CGPointMake(114+58+58+58+58+58, 262);
            break;
        case 7:
            _pointView.center=CGPointMake(114+58+58+58+58+58+58, 262);
            break;
        case 8:
            _pointView.center=CGPointMake(114+58+58+58+58+58+58+58, 262);
            break;
        case 9:
            _pointView.center=CGPointMake(114+58+58+58+58+58+58+58+58, 262);
            break;
            
        case 10:
            _pointView.center=CGPointMake(114+58+58+58+58+58+58+58+58+58, 262);
            break;
        case 11:
            _pointView.center=CGPointMake(114+58+58+58+58+58+58+58+58+58+58, 262);
            break;
        case 12:
            _pointView.center=CGPointMake(114+58+58+58+58+58+58+58+58+58+58+58, 262);
            break;
        case 13:
            _pointView.center=CGPointMake(114+58+58+58+58+58+58+58+58+58+58+58+58, 262);
            break;
        case 14:
            _pointView.center=CGPointMake(114+58+58+58+58+58+58+58+58+58+58+58+58+58, 262);
            break;
        default:
            break;
    }
}
- (IBAction)btnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:{
            [UIView beginAnimations:nil context:nil];
            _pointView.center=CGPointMake(114, 262);
            [UIView setAnimationDuration:0.5];
            [UIView commitAnimations];
            self.status=1;
            _faceProduct.status=self.status;
            self.choseNum=1;
        }
            break;
        case 2:{
            [UIView beginAnimations:nil context:nil];
           _pointView.center=CGPointMake(114+58, 262);
            [UIView setAnimationDuration:0.5];
            [UIView commitAnimations];
            self.status=1;
            _faceProduct.status=self.status;
            self.choseNum=2;
        }
            break;
        case 3:{
            [UIView beginAnimations:nil context:nil];
            _pointView.center=CGPointMake(114+58+58, 262);
            [UIView setAnimationDuration:0.5];
            [UIView commitAnimations];
            self.status=1;
            _faceProduct.status=self.status;
            self.choseNum=3;
        }
            break;
        case 4:{
            [UIView beginAnimations:nil context:nil];
            _pointView.center=CGPointMake(114+58+58+58, 262);
            [UIView setAnimationDuration:0.5];
            [UIView commitAnimations];
            self.status=1;
            _faceProduct.status=self.status;
            self.choseNum=4;
        }
            break;
        case 5:{
             [UIView beginAnimations:nil context:nil];
           _pointView.center=CGPointMake(114+58+58+58+58, 262);
            [UIView setAnimationDuration:0.5];
            [UIView commitAnimations];
            self.status=1;
            _faceProduct.status=self.status;
            self.choseNum=5;
        }
            break;
        case 6:
            
            [self getFaceColour:@"2" block:^(NSString *string) {
                NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
                [user setObject:string forKey:@"imageUrlMain"];
                [user synchronize];
            }];
            [UIView beginAnimations:nil context:nil];
            _pointView.center=CGPointMake(114+58+58+58+58+58, 262);
            [UIView setAnimationDuration:0.5];
            [UIView commitAnimations];
            self.status=2;
            _faceProduct.status=self.status;
            self.choseNum=6;
            
            break;
        case 7:
            [self getFaceColour:@"3" block:^(NSString *string) {
                NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
                [user setObject:string forKey:@"imageUrlMain"];
                [user synchronize];
            }];

            [UIView beginAnimations:nil context:nil];
            _pointView.center=CGPointMake(114+58+58+58+58+58+58, 262);
            [UIView setAnimationDuration:0.5];
            [UIView commitAnimations];
            self.status=2;
            _faceProduct.status=self.status;
            self.choseNum=7;
            break;
        case 8:
            [self getFaceColour:@"4" block:^(NSString *string) {
                NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
                [user setObject:string forKey:@"imageUrlMain"];
                [user synchronize];
            }];

            [UIView beginAnimations:nil context:nil];
             _pointView.center=CGPointMake(114+58+58+58+58+58+58+58, 262);
            [UIView setAnimationDuration:0.5];
            [UIView commitAnimations];
            self.status=2;
            _faceProduct.status=self.status;
            self.choseNum=8;
            break;
        case 9:
            [self getFaceColour:@"5" block:^(NSString *string) {
                NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
                [user setObject:string forKey:@"imageUrlMain"];
                [user synchronize];
            }];

            [UIView beginAnimations:nil context:nil];
            _pointView.center=CGPointMake(114+58+58+58+58+58+58+58+58, 262);
            [UIView setAnimationDuration:0.5];
            [UIView commitAnimations];
            self.status=2;
            _faceProduct.status=self.status;
            self.choseNum=9;
            break;
        case 10:
            [self getFaceColour:@"6" block:^(NSString *string) {
                NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
                [user setObject:string forKey:@"imageUrlMain"];
                [user synchronize];
            }];
            
            [UIView beginAnimations:nil context:nil];
             _pointView.center=CGPointMake(114+58+58+58+58+58+58+58+58+58, 262);
            [UIView setAnimationDuration:0.5];
            [UIView commitAnimations];
           self.status=2;
            _faceProduct.status=self.status;
            self.choseNum=10;
            break;
        case 11:
        {
            [UIView beginAnimations:nil context:nil];
             _pointView.center=CGPointMake(114+58+58+58+58+58+58+58+58+58+58, 262);
            [UIView setAnimationDuration:0.5];
            [UIView commitAnimations];
            self.status=1;
            _faceProduct.status=self.status;
            self.choseNum=11;
        }
            break;
        case 12:{
            [UIView beginAnimations:nil context:nil];
            _pointView.center=CGPointMake(114+58+58+58+58+58+58+58+58+58+58+58, 262);
            [UIView setAnimationDuration:0.5];
            [UIView commitAnimations];
            self.status=1;
            _faceProduct.status=self.status;
            self.choseNum=12;
        }
            break;
        case 13:{
            [UIView beginAnimations:nil context:nil];
            _pointView.center=CGPointMake(114+58+58+58+58+58+58+58+58+58+58+58+58, 262);
            [UIView setAnimationDuration:0.5];
            [UIView commitAnimations];
            self.status=1;
            _faceProduct.status=self.status;
            self.choseNum=13;
        }
            break;
        case 14:{
            [UIView beginAnimations:nil context:nil];
             _pointView.center=CGPointMake(114+58+58+58+58+58+58+58+58+58+58+58+58+58, 262);
            [UIView setAnimationDuration:0.5];
            [UIView commitAnimations];
            self.status=1;
            _faceProduct.status=self.status;
            self.choseNum=14;
        }
            break;
                default:
            break;
    }
    
    
    
}

- (void)getFaceColour:(NSString *)num block:(void (^)(NSString *string))complete
{
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@findFacesInfoBySkinColorToIpad",LocationIp]]];
    [request setRequestMethod:@"post"];
    [request setTimeOutSeconds:30];
    [request addPostValue:num forKey:@"facesInfo.skinColor"];
    [request setCompletionBlock:^{
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dict2=[dic objectForKey:@"data"];
        NSString *solution=[dict2 objectForKey:@"solution"];
        NSString * imageId = [dict2 objectForKey:@"id"];
        NSLog(@"the imageId is %@",imageId);
        
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        [user setObject:imageId forKey:@"imageID"];
        [user synchronize];
        
        if (solution) {
            complete(solution);
        }
        }];
    [request setFailedBlock:^{
        NSLog(@"%@",request.error);
    }];
    [request startAsynchronous];
    
    
}
- (IBAction)ageBtnClick:(UIButton *)sender
{
    if (sender.selected==NO) {
        selectView1.image=NULL;
        selectImage2.image=NULL;
        selectImage3.image=NULL;
        selectImage4.image=NULL;
    }
    
    
    switch (sender.tag) {
        case 1:
            sender.selected=YES;
            selectView1.image=[UIImage imageNamed:@"圣梦_面部_对号_56.png"];
            sender.selected=NO;
            break;
         case 2:
            sender.selected=YES;
            selectImage2.image=[UIImage imageNamed:@"圣梦_面部_对号_56.png"];
            sender.selected=NO;
            break;
            case 3:
            sender.selected=YES;
            selectImage3.image=[UIImage imageNamed:@"圣梦_面部_对号_56.png"];
            sender.selected=NO;
            break;
            case 4:
            sender.selected=YES;
            selectImage4.image=[UIImage imageNamed:@"圣梦_面部_对号_56.png"];
            sender.selected=NO;
        default:
            break;
    }
}

- (IBAction)nextBtn:(UIButton *)sender
{
   [SVProgressHUD showWithStatus:@"图片正在努力加载中" maskType:SVProgressHUDMaskTypeClear];
   [self.navigationController pushViewController:_faceProduct animated:YES];
}
@end
