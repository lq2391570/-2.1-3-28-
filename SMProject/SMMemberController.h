//
//  SMMemberController.h
//  SMProject
//
//  Created by arvin yan on 8/3/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMMemberController : UIViewController

@property (nonatomic,retain) IBOutlet UITextField * userNameTextField;
@property (nonatomic,retain) IBOutlet UITextField * pwdTextField;
@property (nonatomic,retain) IBOutlet UIButton * cancelBtn;
@property (nonatomic,retain) IBOutlet UIButton * loginBtn;
@property (nonatomic, retain) NSString * itemType;

@end
