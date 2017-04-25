//
//  ComparePotoController.h
//  SMProject
//
//  Created by arvin yan on 10/31/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComparePotoController : UIViewController
{
    NSInteger leftNum;
    NSInteger rightNum;
}
@property (nonatomic,retain) IBOutlet UIImageView * bServiceImage;
@property (nonatomic,retain) IBOutlet UIImageView * aServiceImage;

@property (nonatomic,retain) IBOutlet NSArray * cArray;


@property (strong, nonatomic) IBOutlet UIImageView *leftServiceImage;
@property (strong, nonatomic) IBOutlet UIImageView *rightServiceImage;

@property (nonatomic,retain) IBOutlet UILabel * p1State;
@property (nonatomic,retain) IBOutlet UILabel * p2State;

@property (nonatomic,retain) IBOutlet UILabel * p1Time;
@property (nonatomic,retain) IBOutlet UILabel * p2Time;

@property (strong, nonatomic) IBOutlet UIButton *leftRotateBtn;

@property (strong, nonatomic) IBOutlet UIButton *rightRatateBtn;
- (IBAction)leftRotateBtnClick:(id)sender;
- (IBAction)rightRotateBtnClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *leftView;
@property (strong, nonatomic) IBOutlet UIView *rightView;

//对比照片数组
@property (nonatomic,strong)NSMutableArray *compareImageArray;
@property(nonatomic) CGFloat leftLastRotation;
@property(nonatomic) CGFloat rightLastRotation;

@property(nonatomic, unsafe_unretained)CGFloat leftcurrentScale;
@property(nonatomic, unsafe_unretained)CGFloat rightcurrentScale;
@end
