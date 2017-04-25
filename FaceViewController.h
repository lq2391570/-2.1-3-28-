//
//  FaceViewController.h
//  SMProject
//
//  Created by DAIjun on 14-12-25.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPopViewController.h"
#import "FaceProblemViewController.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "FacesInfo.h"


@interface FaceViewController : UIViewController<SMPopViewDelegate>
{
    NSMutableArray *_faceArray;
    NSMutableArray *_eyeArray;
    NSMutableArray *_headArray;
    NSMutableArray *_noseArray;
    NSMutableArray *_mandibleArray;
    NSMutableArray *_tempIdArray;
    NSMutableArray *_tempNameArray;
    
}
- (void)postId:(void (^) (NSArray *array))complete;
- (IBAction)btnClick:(UIButton *)sender;

- (IBAction)nextBtnClick:(UIButton *)sender;


- (IBAction)deleteBtnClick:(UIButton *)sender;

@property (nonatomic, retain)  SMPopViewController * popViewController;
@property (nonatomic, retain) id popoverController;
@property ( nonatomic, retain)  UITextField * tel;
@property ( nonatomic, retain)  UITextField * src;
@property ( nonatomic, retain)  UITextField * name;
@property ( nonatomic, retain)  UITextField * people;

@property (strong, nonatomic) IBOutlet UILabel *faceLabel;
@property (strong, nonatomic) IBOutlet UILabel *faceLabel2;
@property (strong, nonatomic) IBOutlet UILabel *faceLabel3;

@property (strong, nonatomic) IBOutlet UILabel *eyeLabel;
@property (strong, nonatomic) IBOutlet UILabel *eyeLabel2;
@property (strong, nonatomic) IBOutlet UILabel *eyeLabel3;

@property (strong, nonatomic) IBOutlet UILabel *foreheadLabel;
@property (strong, nonatomic) IBOutlet UILabel *foreheadLabel2;
@property (strong, nonatomic) IBOutlet UILabel *foreheadLabel3;

@property (strong, nonatomic) IBOutlet UILabel *noseLabel;
@property (strong, nonatomic) IBOutlet UILabel *noseLabel2;
@property (strong, nonatomic) IBOutlet UILabel *noseLabel3;

@property (strong, nonatomic) IBOutlet UILabel *mandibleLabel;
@property (strong, nonatomic) IBOutlet UILabel *mandibleLabel2;
@property (strong, nonatomic) IBOutlet UILabel *mandibleLabel3;

@property (strong,nonatomic)NSMutableArray *bigArray;
@property (strong,nonatomic)NSMutableArray *idArray;



@end
