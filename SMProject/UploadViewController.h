//
//  UploadViewController.h
//  SMProject
//
//  Created by arvin yan on 10/29/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>



@class RadioButton;

@interface UploadViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>

@property (nonatomic,retain) IBOutlet UIImageView * photo;
@property (nonatomic,retain) IBOutlet UIButton * upload;
@property (nonatomic, retain) IBOutlet RadioButton* radioButton;
@property (nonatomic,retain) IBOutlet UIButton * takePhoto;
@property (nonatomic, retain) NSString * cardNo;
@property (nonatomic, retain) NSString * cid;

@property (strong, nonatomic) IBOutlet UIImageView *imageTakePhoto;
//服务档案时间
@property (nonatomic,strong)NSString *serverDate;
@property (nonatomic, strong) UIPopoverController *popOver;
@property (nonatomic,strong)NSArray *imageArray;

@end
