//
//  FaceProblemViewController.h
//  SMProject
//
//  Created by DAIjun on 14-12-30.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceColourViewController.h"
#import "FacesInfo.h"
@interface FaceProblemViewController : UIViewController
{
    NSDictionary *_dic;
    NSMutableArray *_tempNameArray;
    UIImageView *_imageView;
    FaceColourViewController *_faceColorView;
}
@property (nonatomic,strong)NSMutableArray *labelArray;


@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIButton *btn1;

@property (strong, nonatomic) IBOutlet UILabel *label1;

@property (strong, nonatomic) IBOutlet UILabel *label2;

@property (strong,nonatomic)NSMutableArray *nameArray;

@property (strong,nonatomic)NSMutableArray *tempLabelArray;

@property (strong, nonatomic) IBOutlet UILabel *ressionLabel;

@property (strong, nonatomic) IBOutlet UILabel *questionLabel;

@property (strong, nonatomic) IBOutlet UILabel *adviseLabel;

@property (strong,nonatomic)NSString *imageUrl;


- (IBAction)nextbtnClick:(UIButton *)sender;


@end
