//
//  FaceColourViewController.h
//  SMProject
//
//  Created by DAIjun on 14-12-31.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceProductViewController.h"
#import "SVProgressHUD.h"
#import "ASIFormDataRequest.h"

@interface FaceColourViewController : UIViewController
{
    
    IBOutlet UIImageView *_pointView;
    
    IBOutlet UIImageView *selectView1;
    
    IBOutlet UIImageView *selectImage2;
    
    IBOutlet UIImageView *selectImage3;
    
    IBOutlet UIImageView *selectImage4;
    FaceProductViewController *_faceProduct;
    
    
}

@property (nonatomic,strong)NSString *imageUrl;
@property (nonatomic,assign)int status;
@property (nonatomic,assign)int choseNum;

- (IBAction)btnClick:(UIButton *)sender;


- (IBAction)ageBtnClick:(UIButton *)sender;

- (IBAction)nextBtn:(UIButton *)sender;

@end
